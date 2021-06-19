unit Editeur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Math, StdCtrls, Bass, ExtCtrls, ComCtrls, ToolWin, ImgList;

type
  TEditor = class(TForm)
    Timer1: TTimer;
    PB: TPaintBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ImageList1: TImageList;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PBPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolBar1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton13Click(Sender: TObject);
  private
    procedure ErrorPop(str: string);
    procedure SetLoopStart(position: qword);
    procedure SetLoopEnd(position: qword);
    procedure ScanPeaks2(decoder: HSTREAM);
    procedure DrawSpectrum;
    procedure DrawTime_Line(position: QWORD; x, y: integer; cl: TColor);
  public
    filename: string;
    function PlayFile: boolean;
  end;

type TScanThread = class(TThread)
  private
    Fdecoder: HSTREAM;
  protected
    procedure Execute; override;
  public
    constructor Create(decoder: HSTREAM);
  end;

procedure LoopSyncProc(handle: HSYNC; channel, data, user: DWORD); stdcall;

var
  Editor: TEditor;
  lsync: HSYNC; // looping synchronizer handle
  chan: HSTREAM; // sample stream handle
  chan2: HSTREAM;
  loop: array[0..1] of DWORD;
  killscan: boolean;
  bpp: dword; // stream bytes per pixel
  wavebufL: array of smallint;
  wavebufR: array of smallint;
  mousedwn: integer;
  Buffer: TBitmap;

implementation

uses Unit1;

{$R *.dfm}

//------------------------------------------------------------------------------

procedure TEditor.FormCreate(Sender: TObject);
begin

  Buffer := TBitmap.Create;
  Buffer.Width := PB.Width;
  Buffer.Height := PB.Height;
  PB.Parent.DoubleBuffered := true;

  //set array size
  setlength(wavebufL, ClientWidth);
  setlength(wavebufR, ClientWidth);

  //init vars
  loop[0] := 0;
  loop[1] := 0;

  //init timer for updating
  Timer1.Interval := 20; //ms

end;

function TEditor.PlayFile: boolean;
var
  data: array[0..2000] of SmallInt;
  i: integer;
begin

  BASS_SetDevice(StrToInt(Form1.CUE1CART));

    //creating stream
  chan := BASS_StreamCreateFile(FALSE, pchar(filename), 0, 0, 0);
  if chan = 0 then
  begin
    chan := BASS_MusicLoad(False, pchar(filename), 0, 0, BASS_MUSIC_RAMPS or BASS_MUSIC_POSRESET or BASS_MUSIC_PRESCAN, 0);
    if (chan = 0) then
    begin
      ErrorPop('Impossible d''ouvrir le fichier.');
    end;
  end;

    //playing stream and setting global vars
  for i := 0 to length(data) - 1 do data[0] := 0;
  bpp := BASS_ChannelGetLength(chan) div ClientWidth; // stream bytes per pixel
  if (bpp < BASS_ChannelSeconds2Bytes(chan, 0.02)) then // minimum 20ms per pixel (BASS_ChannelGetLevel scans 20ms)
    bpp := BASS_ChannelSeconds2Bytes(chan, 0.02);
  BASS_ChannelSetSync(chan, BASS_SYNC_END or BASS_SYNC_MIXTIME, 0, LoopSyncProc, 0); // set sync to loop at end
  BASS_ChannelPlay(chan, FALSE); // start playing
  Timer1.Enabled := true;

    //getting peak levels in seperate thread, stream handle as parameter
  chan2 := BASS_StreamCreateFile(FALSE, pchar(filename), 0, 0, BASS_STREAM_DECODE);
  if (chan2 = 0) then chan2 := BASS_MusicLoad(FALSE, pchar(filename), 0, 0, BASS_MUSIC_DECODE, 0);
  TScanThread.Create(chan2); // start scanning peaks in a new thread
  result := true;
end;

procedure TEditor.DrawSpectrum;
var
  i, ht: integer;
begin
  //clear background
  Buffer.Canvas.Brush.Color := clBlack;
  Buffer.Canvas.FillRect(Rect(0, 0, Buffer.Width, Buffer.Height));

  //draw peaks
  ht := ClientHeight div 2;
  for i := 0 to length(wavebufL) - 1 do
  begin
    Buffer.Canvas.MoveTo(i, ht);
    Buffer.Canvas.Pen.Color := clLime;
    Buffer.Canvas.LineTo(i, ht - trunc((wavebufL[i] / 32768) * ht));
    Buffer.Canvas.Pen.Color := clLime;
    Buffer.Canvas.MoveTo(i, ht + 2);
    Buffer.Canvas.LineTo(i, ht + 2 + trunc((wavebufR[i] / 32768) * ht));
  end;
end;

procedure TEditor.DrawTime_Line(position: QWORD; x, y: integer; cl: TColor);
var
  sectime: integer;
  str: string;
begin
  sectime := trunc(BASS_ChannelBytes2Seconds(chan, position));

  //format time
  str := '';
  if (sectime mod 60 < 10) then str := '0';
  str := str + inttostr(sectime mod 60);
  str := inttostr(sectime div 60) + ':' + str;

  //drawline
  Buffer.Canvas.Pen.Color := cl;
  Buffer.Canvas.MoveTo(x, 0);
  Buffer.Canvas.LineTo(x, ClientHeight);

  //drawtext
  Buffer.Canvas.Font.Color := cl;
  Buffer.Canvas.Font.Style := [fsBold];
  if x > ClientWidth - 20 then
    dec(x, 40);
  SetBkMode(Buffer.Canvas.Handle, TRANSPARENT);
  Buffer.Canvas.TextOut(x + 2, y, str);
end;

procedure TEditor.ErrorPop(str: string);
begin
  //show last BASS errorcode when no argument is given, else show given text.
  if str = '' then
    Showmessage('Error code: ' + inttostr(BASS_ErrorGetCode()))
  else
    Showmessage(str);
end;

procedure TEditor.SetLoopStart(position: qword);
begin
  loop[0] := position;
end;

procedure TEditor.SetLoopEnd(position: qword);
begin
  loop[1] := position;
  BASS_ChannelRemoveSync(chan, lsync); // remove old sync
  lsync := BASS_ChannelSetSync(chan, BASS_SYNC_POS or BASS_SYNC_MIXTIME, loop[1], LoopSyncProc, 0); // set new sync
end;

procedure LoopSyncProc(handle: HSYNC; channel, data, user: DWORD); stdcall;
begin
  if not BASS_ChannelSetPosition(channel, loop[0]) then // try seeking to loop start
    BASS_ChannelSetPosition(channel, 0); // failed, go to start of file instead
end;

procedure TEditor.ScanPeaks2(decoder: HSTREAM);
var
  cpos, level: DWord;
  peak: array[0..1] of DWORD;
  position: DWORD;
  counter: integer;
begin
  cpos := 0;
  peak[0] := 0;
  peak[1] := 0;
  counter := 0;

  while not killscan do
  begin
    level := BASS_ChannelGetLevel(decoder); // scan peaks
    if (peak[0] < LOWORD(level)) then
      peak[0] := LOWORD(level); // set left peak
    if (peak[1] < HIWORD(level)) then
      peak[1] := HIWORD(level); // set right peak
    if BASS_ChannelIsActive(decoder) <> BASS_ACTIVE_PLAYING then
    begin
      position := cardinal(-1); // reached the end
    end else
      position := BASS_ChannelGetPosition(decoder) div bpp;

    if position > cpos then
    begin
      inc(counter);
      if counter <= length(wavebufL) - 1 then
      begin
        wavebufL[counter] := peak[0];
        wavebufR[counter] := peak[1];
      end;

      if (position >= dword(ClientWidth)) then
        break;
      cpos := position;
    end;


    peak[0] := 0;
    peak[1] := 0;
  end;
  BASS_StreamFree(decoder); // free the decoder
end;

//------------------------------------------------------------------------------

{ TScanThread }

constructor TScanThread.Create(decoder: HSTREAM);
begin
  inherited create(false);
  Priority := tpNormal;
  FreeOnTerminate := true;
  FDecoder := decoder;
end;

procedure TScanThread.Execute;
begin
  inherited;
  FreeOnTerminate := True;
  Editor.ScanPeaks2(FDecoder);
  Terminate;
end;

//------------------------------------------------------------------------------

procedure TEditor.Timer1Timer(Sender: TObject);
begin
  if bpp = 0 then exit;
  DrawSpectrum; // draw peak waveform
  DrawTime_Line(loop[0], (loop[0] div bpp), 12, TColor($00FFFF)); // loop start
  DrawTime_Line(loop[1], (loop[1] div bpp), 24, TColor($FFFF00)); // loop end
  DrawTime_Line(BASS_ChannelGetPosition(chan), (BASS_ChannelGetPosition(chan) div bpp), 0, TColor($FFFFFF)); // current pos
  PB.Refresh;
end;

procedure TEditor.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    mousedwn := 1;
    SetLoopStart(dword(x) * bpp)
  end
  else if Button = mbRight then
  begin
    mousedwn := 2;
    SetLoopEnd(dword(x) * bpp);
  end;
end;

procedure TEditor.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if mousedwn = 0 then
    exit;
  if mousedwn = 1 then
    SetLoopStart(dword(x) * bpp)
  else if mousedwn = 2 then
    SetLoopEnd(dword(x) * bpp);
end;

procedure TEditor.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mousedwn := 0;
end;

procedure TEditor.PBPaint(Sender: TObject);
begin
  if bpp = 0 then exit;
  PB.Canvas.Draw(0, 0, Buffer);
end;

procedure TEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := false;
  bpp := 0;

  BASS_ChannelStop(chan);
  BASS_StreamFree(chan);
  BASS_ChannelStop(chan2);
  BASS_StreamFree(chan2);
  Editor.Hide;
end;


procedure TEditor.ToolBar1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, SC_MOVE or HTCAPTION, 0);
end;

procedure TEditor.ToolButton1Click(Sender: TObject);
begin
  BASS_ChannelStop(chan);
  Editor.Close;
end;

procedure TEditor.ToolButton2Click(Sender: TObject);
begin
  BASS_ChannelStop(chan);
  PlayFile();
end;

procedure TEditor.ToolButton3Click(Sender: TObject);
begin
  BASS_ChannelStop(chan);
  Timer1.Enabled := False;
end;

procedure TEditor.ToolButton4Click(Sender: TObject);
begin
  BASS_ChannelSetPosition(chan, loop[0]);
end;

procedure TEditor.ToolButton5Click(Sender: TObject);
begin
  BASS_ChannelSetPosition(chan, loop[1]);
end;

procedure TEditor.ToolButton10Click(Sender: TObject);
begin
  BASS_ChannelSetPosition(chan, BASS_ChannelSeconds2Bytes(chan, BASS_ChannelBytes2Seconds(chan, BASS_ChannelGetPosition(chan)) - Form1.SKIPPREV));
end;

procedure TEditor.ToolButton6Click(Sender: TObject);
begin
  BASS_ChannelSetPosition(chan, BASS_ChannelSeconds2Bytes(chan, BASS_ChannelBytes2Seconds(chan, BASS_ChannelGetPosition(chan)) + Form1.SKIPPREV));
end;

procedure TEditor.ToolButton12Click(Sender: TObject);
var
  Cue: Single;
begin
  Cue := BASS_ChannelBytes2Seconds(chan, loop[0]);
  if (Editor.Tag = 1) then Form1.cue1.Text := format('%.2f', [Cue]) else Form1.cue2.Text := format('%.2f', [Cue]);
end;

procedure TEditor.ToolButton10MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BASS_ChannelSetPosition(chan, BASS_ChannelSeconds2Bytes(chan, BASS_ChannelBytes2Seconds(chan, BASS_ChannelGetPosition(chan)) - Form1.SKIPPREV));
end;

procedure TEditor.ToolButton6MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BASS_ChannelSetPosition(chan, BASS_ChannelSeconds2Bytes(chan, BASS_ChannelBytes2Seconds(chan, BASS_ChannelGetPosition(chan)) + Form1.SKIPPREV));
end;

procedure TEditor.ToolButton13Click(Sender: TObject);
begin
  SetLoopStart(BASS_ChannelGetPosition(chan));
end;

end.
