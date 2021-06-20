unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InfoMP3, Menus, ExtCtrls, ComCtrls, Grids, JvExComCtrls, MysqlComponent,
  JvComCtrls, StdCtrls, Buttons, Spin, RLed, Gauges, BASS, BASSmix, BASS_FX, IniFiles,
  AppEvnts, Math, JvExButtons, JvButtons, JvExStdCtrls,
  JvButton, JvCtrls, ImgList, Midi, SyncObjs;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Timer2: TTimer;
    Timer4: TTimer;
    Gauge1: TGauge;
    Timer5: TTimer;
    Label8: TLabel;
    Label9: TLabel;
    Timer6: TTimer;
    Timer7: TTimer;
    Label13: TLabel;
    Timer8: TTimer;
    TrackBar2: TTrackBar;
    StringGrid2: TStringGrid;
    Gauge2: TGauge;
    JingleChoice: TPageControl;
    Panel1: TPanel;
    Label14: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Panel2: TPanel;
    Panel4: TPanel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Gauge3: TGauge;
    Gauge4: TGauge;
    TrackBar3: TTrackBar;
    Timer3: TTimer;
    Timer10: TTimer;
    Panel5: TPanel;
    Panel6: TPanel;
    padactuel: TEdit;
    TrackBar4: TTrackBar;
    Panel8: TPanel;
    StringGrid1: TStringGrid;
    Panel9: TPanel;
    Timer1: TTimer;
    Timer11: TTimer;
    Gauge14: TGauge;
    Panel11: TPanel;
    Label6: TLabel;
    Panel12: TPanel;
    Label10: TLabel;
    Panel13: TPanel;
    Label11: TLabel;
    Panel14: TPanel;
    Label12: TLabel;
    RLed2: TRLed;
    RLed1: TRLed;
    RLed3: TRLed;
    RLed4: TRLed;
    RLed5: TRLed;
    RLed6: TRLed;
    Panel7: TPanel;
    RLed7: TRLed;
    RLed8: TRLed;
    StringGrid3: TStringGrid;
    PopupMenu1: TPopupMenu;
    Ajouteraupav1: TMenuItem;
    Ajoutau1: TMenuItem;
    OpenDialog1: TOpenDialog;
    cue1: TEdit;
    InfoMP31: TInfoMP3;
    Label5: TLabel;
    TrackBar5: TTrackBar;
    Panel10: TPanel;
    Label39: TLabel;
    Panel17: TPanel;
    RLed9: TRLed;
    RLed10: TRLed;
    Timer9: TTimer;
    Timer12: TTimer;
    Panel18: TPanel;
    Label40: TLabel;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    status1: TJvTrackBar;
    StringGrid4: TStringGrid;
    pubplay: TBitBtn;
    Timer13: TTimer;
    pubcurdelete: TButton;
    status2: TJvTrackBar;
    timerpflm1: TTimer;
    timerpflm2: TTimer;
    ApplicationEvents1: TApplicationEvents;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    Pointdecue1: TMenuItem;
    Pointdecue2: TMenuItem;
    TrackBar1: TTrackBar;
    Panel3: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Bar: TLabel;
    Panel23: TPanel;
    Panel24: TPanel;
    cue2: TEdit;
    fadem1: TJvImgBtn;
    brakem1: TJvImgBtn;
    Stop1: TJvImgBtn;
    Play1: TJvImgBtn;
    Pause1: TJvImgBtn;
    Playlist1: TJvImgBtn;
    Waitlist1: TJvImgBtn;
    pflm1: TJvImgBtn;
    cutm1: TJvImgBtn;
    pflj1: TJvImgBtn;
    Stopj1: TJvImgBtn;
    Playj1: TJvImgBtn;
    Pausej1: TJvImgBtn;
    retourpub: TJvImgBtn;
    fadem2: TJvImgBtn;
    brakem2: TJvImgBtn;
    Stop2: TJvImgBtn;
    Play2: TJvImgBtn;
    Pausem2: TJvImgBtn;
    Playlist2: TJvImgBtn;
    Waitlist2: TJvImgBtn;
    pflm2: TJvImgBtn;
    cutm2: TJvImgBtn;
    pflpad1: TJvImgBtn;
    Stoppad1: TJvImgBtn;
    Restaurer: TJvImgBtn;
    Sauver: TJvImgBtn;
    Load: TJvImgBtn;
    Playj2: TJvImgBtn;
    Stopj2: TJvImgBtn;
    PadUP: TJvImgBtn;
    PadDelete: TJvImgBtn;
    PadDown: TJvImgBtn;
    ImageList1: TImageList;
    Intro1: TLabel;
    Intro2: TLabel;
    PopupMenu4: TPopupMenu;
    Effacer1: TMenuItem;
    Tempo1: TLabel;
    BPM1: TLabel;
    Tempo2: TLabel;
    BPM2: TLabel;
    SampleRate2: TLabel;
    SampleRate1: TLabel;
    Ajouterlenchaneur1: TMenuItem;
    Proteger1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Timer6Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Timer7Timer(Sender: TObject);
    procedure Timer8Timer(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure test1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer10Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer11Timer(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure JingleChoiceChange(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure Ajoutau1Click(Sender: TObject);
    procedure Ajouteraupav1Click(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure Timer9Timer(Sender: TObject);
    procedure Timer12Timer(Sender: TObject);
    procedure status1Changed(Sender: TObject);
    procedure status2Changed(Sender: TObject);
    procedure pubplayClick(Sender: TObject);
    procedure Timer13Timer(Sender: TObject);
    procedure pubcurdeleteClick(Sender: TObject);
    procedure timerpflm1Timer(Sender: TObject);
    procedure timerpflm2Timer(Sender: TObject);
    procedure ApplicationEvents1ShortCut(var Msg: TWMKey;
      var Handled: Boolean);
    procedure Pointdecue1Click(Sender: TObject);
    procedure Pointdecue2Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Play1Click(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure fadem1Click(Sender: TObject);
    procedure brakem1Click(Sender: TObject);
    procedure Playlist1Click(Sender: TObject);
    procedure Waitlist1Click(Sender: TObject);
    procedure pflm1Click(Sender: TObject);
    procedure cutm1Click(Sender: TObject);
    procedure fadem2Click(Sender: TObject);
    procedure brakem2Click(Sender: TObject);
    procedure Stop2Click(Sender: TObject);
    procedure Play2Click(Sender: TObject);
    procedure Pause2Click(Sender: TObject);
    procedure pflm2Click(Sender: TObject);
    procedure cutm2Click(Sender: TObject);
    procedure Stopj1Click(Sender: TObject);
    procedure Playj1Click(Sender: TObject);
    procedure Pausej1Click(Sender: TObject);
    procedure pflj1Click(Sender: TObject);
    procedure Stoppad1Click(Sender: TObject);
    procedure pflpad1Click(Sender: TObject);
    procedure RestaurerClick(Sender: TObject);
    procedure SauverClick(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure stopj2Click(Sender: TObject);
    procedure Playj2Click(Sender: TObject);
    procedure PadUpClick(Sender: TObject);
    procedure PadDeleteClick(Sender: TObject);
    procedure PadDownClick(Sender: TObject);
    procedure retourpubClick(Sender: TObject);
    procedure StringGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure StringGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure StringGrid2DblClick(Sender: TObject);
    procedure StringGrid2EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure StringGrid1EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure Effacer1Click(Sender: TObject);
    procedure Ajouterlenchaneur1Click(Sender: TObject);
    procedure Proteger1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fCriticalSection: TCriticalSection;
    procedure Error(msg: string);
  public
    // LIVE
    m1: Integer; // Music 1
    j1: Integer; // Jingle 1
    m2: Integer; // Music 2
    j2: Integer; // Jingle 2
    pad1: Integer; // Jingle 2
    pub1: Integer; // Pub
    // PFL
    pfl_m1: Integer;
    pfl_m2: Integer;
    pfl_j1: Integer;
    pfl_j2: Integer;
    pfl_pad1: Integer;
    // PAUSE
    p1: Integer; // pause d1
    p2: Integer; // pause d2
    p3: Integer; // pause j1
    p4: Integer; // pause j2
    p5: Integer; // pause pub
    // OTHERS
    InfoIntro: Integer;
    // DSP
    dsp: Integer; // Load DLL
    winampDSP: Integer; // DSP
    mixer: Integer;
    // OTHERS
    isg3: Integer; // Répère StringGrid3
    isg4: Integer; // Répère StringGrid4
    DSC1CART: string; // Carte son DSC1
    DSC2CART: string; // Carte son DSC2
    JIN1CART: string; // Carte son Jingle 1
    JIN2CART: string; // Carte son Jingle 2
    PAD1CART: string; // Carte son Pad 1
    REC1CART: string; // Carte son Record 1
    PUB1CART: string; // Cartre son Pub (invisible)
    CUE1CART: string; // Cartre son Préécoute
    DSC1CHAN: string; // Sortie carte son DSC1
    DSC2CHAN: string; // Sortie carte son DSC2
    JIN1CHAN: string; // Sortie carte son Jingle 1
    JIN2CHAN: string; // Sortie carte son Jingle 2
    PAD1CHAN: string; // Sortie carte son Pad 1
    REC1CHAN: string; // Sortie carte son Record 1
    PUB1CHAN: string; // Sortie carte son Pub (invisible)
    CUE1CHAN: string; // Sortie carte son Préécoute
    RECORD1CART: string; // Sortie carte son Record 1
    AUTOSILENCE: Integer; // Automation
    AUTOOUT: Integer; // Automation
    AUTOFADEOUT: Integer; // Automation
    AUTOFENETRE: Integer; // Automation
    FadeOutm1: Single;
    FadeOutm2: Single;
    FadeOutPub: Single;
    TONEDETECTNIVEAU: Integer; // Tone
    TONEDETECTFREQ: Integer; // Tone
    SKIPPREV: Integer; // Skip <<
    SKIPNEXT: Integer; // Skip >>
    player1: array[1..14] of string;
    player2: array[1..14] of string;
    CurrentCat: string;
    chunk: Integer; // while, bytes ( record )
    CardAddr: longint;
    WaveStream: TMemoryStream; // Tampon
    ModeSoundSolution: Boolean;
    Player1Filename, Player2Filename: string;
    ModeDebug: Boolean;
    SyncEndHandle: HSYNC;
    MessageHandle: Pointer;
    procedure m1_pfl_stop();
    procedure m2_pfl_stop();
    procedure j1_pfl_stop();
    procedure pad1_pfl_stop();
    procedure DoMidiInData( const aDeviceIndex: integer; const aStatus, aData1, aData2: byte );
    function LoadPlayer1(id: string): Boolean;
    function LoadPlayer2(id: string): Boolean;
    function Pad(Filename: string): Boolean;
    function Padpfl(Filename: string): Boolean;
    function InitDevice(): Boolean;
    function KillDevice(): Boolean;
    { Déclarations publiques }
  end;

  TStringGridX = class(TStringGrid)
  public
    procedure MoveColumn(FromIndex, ToIndex: Longint);
    procedure MoveRow(FromIndex, ToIndex: Longint);
  end;

var
  Form1: TForm1;
  flags: array[0..3] of DWORD = (BASS_SPEAKER_FRONT, BASS_SPEAKER_REAR, BASS_SPEAKER_CENLFE, BASS_SPEAKER_REAR2);

implementation

uses U_About, U_bibliotheque, U_Clock, U_Splash, U_Waitlist, U_Main,
  U_Events, sysop; //Editeur;

{$R *.dfm}

// Renvoie la première sous-chaîne de S délimitée par Token
// (si Token n'est pas dans S, renvoie S)

function GetFirstToken(S: string; Token: Char): string;
var I: integer;
begin
  I := 1;
  // On parcourt la chaîne jusqu'à trouver un caractère Token
  while (I <= Length(S)) and (S[I] <> Token) do inc(I);
  // On copie la chaîne depuis le début jusqu'au caractère avant Token
  Result := Copy(S, 1, I - 1);
end;

// Renvoie la dernière sous-chaîne de S délimitée par Token
// (si Token n'est pas dans S, renvoie S)

function GetLastToken(S: string; Token: Char): string;
var I: integer;
begin
  I := Length(S);
  // On parcourt la chaîne à l'envers jusqu'à trouver un caractère Token
  while (I > 0) and (S[I] <> Token) do dec(I);
  // On copie la chaîne depuis le caractère après Token jusqu'à la fin
  Result := Copy(S, I + 1, Length(S));
end;


// CONTROLE EXTERNE

function OpenDevice(CardAddress: Longint): Longint; stdcall; external 'drc.dll';
procedure CloseDevice; stdcall; external 'drc.dll';
function ReadAnalogChannel(Channel: Longint): Longint; stdcall; external 'drc.dll';
procedure ReadAllAnalog(var Data1, Data2: Longint); stdcall; external 'drc.dll';
procedure OutputAnalogChannel(Channel: Longint; Data: Longint); stdcall; external 'drc.dll';
procedure OutputAllAnalog(Data1: Longint; Data2: Longint); stdcall; external 'drc.dll';
procedure ClearAnalogChannel(Channel: Longint); stdcall; external 'drc.dll';
procedure ClearAllAnalog; stdcall; external 'drc.dll';
procedure SetAnalogChannel(Channel: Longint); stdcall; external 'drc.dll';
procedure SetAllAnalog; stdcall; external 'drc.dll';
procedure WriteAllDigital(Data: Longint); stdcall; external 'drc.dll';
procedure ClearDigitalChannel(Channel: Longint); stdcall; external 'drc.dll';
procedure ClearAllDigital; stdcall; external 'drc.dll';
procedure SetDigitalChannel(Channel: Longint); stdcall; external 'drc.dll';
procedure SetAllDigital; stdcall; external 'drc.dll';
function ReadDigitalChannel(Channel: Longint): Boolean; stdcall; external 'drc.dll';
function ReadAllDigital: Longint; stdcall; external 'drc.dll';
function ReadCounter(CounterNr: Longint): Longint; stdcall; external 'drc.dll';
procedure ResetCounter(CounterNr: Longint); stdcall; external 'drc.dll';
procedure SetCounterDebounceTime(CounterNr, DebounceTime: Longint); stdcall; external 'drc.dll';

// END CONTROLE EXTERNE


procedure TForm1.DoMidiInData(const aDeviceIndex: integer; const aStatus,
  aData1, aData2: byte);
begin
  if aStatus = $FE then Exit;

  fCriticalSection.Acquire;
  try
      MidiOutput.Send(0, aStatus, aData1, aData2 );

      // Faders
      if(aStatus = $E0) then
      begin
          TrackBar1.Position:= 31 - aData2 div 4;
      end;

      if(aStatus = $E1) then
      begin
          TrackBar3.Position:= 31 - aData2 div 4;
      end;

      if(aStatus = $E2) then
      begin
          TrackBar2.Position:= 31 - aData2 div 4;
      end;

      if(aStatus = $E3) then
      begin
          TrackBar5.Position:= 31 - aData2 div 4;
      end;

      if(aStatus = $E4) then
      begin
          TrackBar4.Position:= 31 - aData2 div 4;
      end;

      // Starts
      if((aStatus = $90) AND (aData1 = $18)) then
      begin
          if (BASS_ChannelIsActive(Form1.m1) = 0) then Play1.Click();
      end;

      if((aStatus = $90) AND (aData1 = $19)) then
      begin
          if (BASS_ChannelIsActive(Form1.m2) = 0) then Play2.Click();
      end;

      if((aStatus = $90) AND (aData1 = $1A)) then
      begin
          if (BASS_ChannelIsActive(Form1.j1) = 0) then Playj1.Click();
      end;

      if((aStatus = $90) AND (aData1 = $1C)) then
      begin
          if ((BASS_ChannelIsActive(Form1.j2) = 0) OR
            (BASS_ChannelBytes2Seconds(Form1.j2, BASS_ChannelGetPosition(Form1.j2, BASS_POS_BYTE))>1)) then Playj2.Click();
      end;

      //PFL Player 1

      if((aStatus = $B0) AND (aData1 = $10) AND (aData2 = $01)) then
      begin
         BASS_ChannelSetPosition(pfl_m1, BASS_ChannelSeconds2Bytes(pfl_m1, BASS_ChannelBytes2Seconds(pfl_m1, BASS_ChannelGetPosition(pfl_m1, BASS_POS_BYTE)) + SKIPNEXT), BASS_POS_BYTE);
      end;

      if((aStatus = $B0) AND (aData1 = $10) AND (aData2 = $41)) then
      begin
         BASS_ChannelSetPosition(pfl_m1, BASS_ChannelSeconds2Bytes(pfl_m1, BASS_ChannelBytes2Seconds(pfl_m1, BASS_ChannelGetPosition(pfl_m1, BASS_POS_BYTE)) - SKIPPREV), BASS_POS_BYTE);
      end;

      if((aStatus = $90) AND (aData1 = $10) AND (aData2 = $7F)) then
      begin
        pflm1.Click();
      end;

      if((aStatus = $90) AND (aData1 = $20) AND (aData2 = $7F)) then
      begin
         cutm1.Click();
      end;

      //PFL Player 2

      if((aStatus = $B0) AND (aData1 = $11) AND (aData2 = $01)) then
      begin
         BASS_ChannelSetPosition(pfl_m2, BASS_ChannelSeconds2Bytes(pfl_m2, BASS_ChannelBytes2Seconds(pfl_m2, BASS_ChannelGetPosition(pfl_m2, BASS_POS_BYTE)) + SKIPNEXT), BASS_POS_BYTE);
      end;

      if((aStatus = $B0) AND (aData1 = $11) AND (aData2 = $41)) then
      begin
         BASS_ChannelSetPosition(pfl_m2, BASS_ChannelSeconds2Bytes(pfl_m2, BASS_ChannelBytes2Seconds(pfl_m2, BASS_ChannelGetPosition(pfl_m2, BASS_POS_BYTE)) - SKIPPREV), BASS_POS_BYTE);
      end;

      if((aStatus = $90) AND (aData1 = $11) AND (aData2 = $7F)) then
      begin
        pflm2.Click();
      end;

      if((aStatus = $90) AND (aData1 = $21) AND (aData2 = $7F)) then
      begin
         cutm2.Click();
      end;

      // PUB
      if((aStatus = $90) AND (aData1 = $1F) AND (aData2 = $7F)) then
      begin
         Events.diffuser.Click();
      end;


  finally
    fCriticalSection.Leave;
  end;
end;

procedure TForm1.m1_pfl_stop();
begin
    pflm1.Tag := 0;
    pflm1.ImageIndex := 106;
    pflm1.Caption := 'Préécoute';
    BASS_ChannelStop(pfl_m1);
    timerpflm1.Enabled := False;
    status1.Position := 0;
end;

procedure TForm1.m2_pfl_stop();
begin
    pflm2.Tag := 0;
    pflm2.ImageIndex := 106;
    pflm2.Caption := 'Préécoute';
    BASS_ChannelStop(pfl_m2);
    timerpflm2.Enabled := False;
    status2.Position := 0;
end;

procedure TForm1.j1_pfl_stop();
begin
    pflj1.Tag := 0;
    pflj1.ImageIndex := 106;
    pflj1.Caption := 'Préécoute';
    BASS_ChannelStop(pfl_j1);
    BASS_StreamFree(pfl_j1);
end;

procedure TForm1.pad1_pfl_stop();
begin
    pflpad1.Tag := 0;
    pflpad1.ImageIndex := 106;
    pflpad1.Caption := 'Préécoute';
    BASS_ChannelStop(pfl_pad1);
    BASS_StreamFree(pfl_pad1);
end;

procedure m1_sync(SyncHandle: HSYNC; Channel, data, user: DWORD); stdcall;
begin
  Form1.Stop1.Click;
end;

procedure m2_sync(SyncHandle: HSYNC; Channel, data, user: DWORD); stdcall;
begin
  Form1.Stop2.Click;
end;

procedure j1_sync(SyncHandle: HSYNC; Channel, data, user: DWORD); stdcall;
begin
  Form1.Stopj1.Click;
end;

procedure j2_sync(SyncHandle: HSYNC; Channel, data, user: DWORD); stdcall;
begin
    if (Form1.isg3 = 0) then
    begin
      Form1.Stopj2.Click; //Stop
    end
    else
    begin
      Form1.Playj2.Click; //Next
    end;
end;

procedure pad1_sync(SyncHandle: HSYNC; Channel, data, user: DWORD); stdcall;
begin
  if(Form1.Proteger1.Checked) then Form1.Stoppad1.Click;
end;

procedure m1_pfl_sync(SyncHandle: HSYNC; Channel, data, user: DWORD); stdcall;
begin
  Form1.m1_pfl_stop();
end;

procedure m2_pfl_sync(SyncHandle: HSYNC; Channel, data, user: DWORD); stdcall;
begin
  Form1.m2_pfl_stop();
end;

procedure j1_pfl_sync(SyncHandle: HSYNC; Channel, data, user: DWORD); stdcall;
begin
  Form1.j1_pfl_stop();
end;

procedure pad1_pfl_sync(SyncHandle: HSYNC; Channel, data, user: DWORD); stdcall;
begin
  Form1.pad1_pfl_stop();
end;

procedure pub1_sync(SyncHandle: HSYNC; Channel, data, user: DWORD); stdcall;
begin
  //Form1.pubcurdelete.Click();
end;

procedure GridDeleteRow(RowNumber: Integer; Grid: TstringGrid);
var
  i: Integer;
begin
  Grid.Row := RowNumber;
  if (Grid.Row = Grid.RowCount - 1) then
    { On the last row}
    Grid.RowCount := Grid.RowCount - 1
  else
  begin
    { Not the last row}
    for i := RowNumber to Grid.RowCount - 1 do
      Grid.Rows[i] := Grid.Rows[i + 1];
    Grid.RowCount := Grid.RowCount - 1;
  end;
end;

procedure TStringGridX.MoveColumn(FromIndex, ToIndex: Integer);
begin
  inherited;
end;

procedure TStringGridX.MoveRow(FromIndex, ToIndex: Integer);
begin
  inherited;
end;

function TForm1.KillDevice(): Boolean;
begin
  CloseDevice();
  Result := True;
end;

function TForm1.InitDevice(): Boolean;
var h: longint;
begin
  h := OpenDevice(CardAddr);
  case h of
    0..3: begin
        Timer2.Enabled := True;
      end;
    -1: begin
    end;
  end;
  Result:=True;
end;

function TForm1.LoadPlayer1(id: string): Boolean;
var
  StartPosBytes: Integer;
  Temps, TempsLu, TempsRestant, DecompteRestant: Single;
  Gauge: Extended;
begin
  Label21.Caption := Form1.player1[1]; // ID
  Label1.Caption := Form1.player1[2]; // ARTISTE
  Label2.Caption := Form1.player1[3]; // TITRE
  Label9.Caption := Form1.player1[4]; // Année
  Player1Filename := Form1.player1[11];
  CurrentCat := Form1.player1[12];
  status1.Position := 0;

  // 1: Id, 2:Artiste, 3:Titre, 4:Annee, 5:Duree, 6:Frequence, 7:Tempo, 8:Intro, 9:FadeIn, 10:FadeOut, 11:Path

  // Libère l'ancien flux
  BASS_StreamFree(m1);
  BASS_StreamFree(pfl_m1);

  // arrête les timers
  Timer5.Enabled := False;
  Timer6.Enabled := False;

  // Active la gauge
  if (player1[8] <> '0') then
  begin
    Gauge1.visible := true;
  end;

  // Ici nous décodons le fichier directement car pour SoundSolution
  // aussi bien que pour le Tempo, nous devons le faire au même niveau.
  BASS_SetDevice(StrToInt(DSC1CART));
  m1 := BASS_StreamCreateFile(False, Pchar(player1[11]), 0, 0, BASS_STREAM_DECODE);

  // Préécoute
  if (BASS_ChannelIsActive(pfl_m1) = 1) then pflm1.Click();

  BASS_StreamFree(pfl_m1);
  BASS_SetDevice(StrToInt(CUE1CART));
  pfl_m1 := BASS_StreamCreateFile(False, Pchar(player1[11]), 0, 0, flags[StrToInt(CUE1CHAN)]);

  if (m1 = 0) then
  begin
    Error('Player 1 : Impossible de loader le fichier ' + player1[11]);
  end
  else
  begin

  // Fade Out
    if (player1[12] = 'INTERVENTION') then
    begin
      FadeOutm1 := Round(BASS_ChannelBytes2Seconds(m1, BASS_ChannelGetLength(m1, BASS_POS_BYTE)));
      Main.log('Voice Track 1: Fade:' + IntToStr(Round(FadeOutm1)), True);
    end
    else
    begin
      FadeOutm1 := StrToFloat(StringReplace(player1[10], '.', ',', [rfReplaceAll]));
    end;

  // FX seulement si c'est en mode normal
    if (ModeSoundSolution = False) then
    begin
      BASS_SetDevice(StrToInt(DSC1CART));
      m1 := BASS_FX_TempoCreate(m1, flags[StrToInt(DSC1CHAN)] or BASS_FX_FREESOURCE);
    end;

  // Auto Tempo
    cue1.Text := Form1.player1[9];
    //BASS_FX_TempoSet(m1, StrToInt(player1[7]), StrToInt(player1[6]), -100); // Frequence

  // Position Start
    if player1[9] <> '0' then
    begin
      StartPosBytes := BASS_ChannelSeconds2Bytes(m1, strtofloat(StringReplace(player1[9], '.', ',', [rfReplaceAll])));
      BASS_ChannelSetPosition(m1, StartPosBytes, BASS_POS_BYTE);
    end;

  // Décomptes

    Temps := BASS_ChannelBytes2Seconds(m1, BASS_ChannelGetLength(m1, BASS_POS_BYTE));
    TempsLu := BASS_ChannelBytes2Seconds(m1, BASS_ChannelGetPosition(m1, BASS_POS_BYTE));
    Gauge := StrToFloat(StringReplace(player1[8], '.', ',', [rfReplaceAll]));
    TempsRestant := (Temps - TempsLu);
    DecompteRestant := (Gauge - TempsLu);

    Label3.Caption := format('%2.2d:%2.2d', [trunc(Temps) div 60, trunc(Temps) mod 60]);
    Label4.Caption := format('%2.2d:%2.2d', [trunc(TempsLu) div 60, trunc(TempsLu) mod 60]);
    Label8.Caption := format('%2.2d:%2.2d', [trunc(TempsRestant) div 60, trunc(TempsRestant) mod 60]);
    Intro1.Caption := format('%2.2d:%2.2d', [trunc(DecompteRestant) div 60, trunc(DecompteRestant) mod 60]);

  end;

  result := True;
end;

function TForm1.LoadPlayer2(id: string): Boolean;
var
  StartPosBytes: Integer;
  Temps, TempsLu, TempsRestant, DecompteRestant: Single;
  Gauge: Extended;
begin
  Form1.Label35.Caption := Form1.player2[1]; // ID
  Form1.Label22.Caption := Form1.player2[2]; // ARTISTE
  Form1.Label23.Caption := Form1.player2[3]; // TITRE
  Form1.Label27.Caption := Form1.player2[4]; // Année
  Player2Filename := Form1.player2[11];
  CurrentCat := Form1.player2[12];
  status2.Position := 0;

  // 1: Id, 2:Artiste, 3:Titre, 4:Annee, 5:Duree, 6:Frequence, 7:Tempo, 8:Intro, 9:FadeIn, 10:FadeOut, 11:Path

  // Libère l'ancien flux
  BASS_StreamFree(m2);
  BASS_StreamFree(pfl_m2);

  // arrête les timers
  Timer3.Enabled := False;
  Timer10.Enabled := False;

  // Active la gauge
  if (player2[8] <> '0') then
  begin
    Gauge3.visible := true;
  end;

  // Ici nous décodons le fichier directement car pour SounSolution
  // aussi bien que pour le Tempo, nous devons le faire au même niveau.
  BASS_SetDevice(StrToInt(DSC2CART));
  m2 := BASS_StreamCreateFile(False, Pchar(player2[11]), 0, 0, BASS_STREAM_DECODE); // Mode SS

  // Préécoute
  if (BASS_ChannelIsActive(pfl_m2) = 1) then pflm2.Click();

  BASS_StreamFree(pfl_m2);
  BASS_SetDevice(StrToInt(CUE1CART));
  pfl_m2 := BASS_StreamCreateFile(False, Pchar(player2[11]), 0, 0, flags[StrToInt(CUE1CHAN)]);

  if (m2 = 0) then
  begin
    Error('Player 2: Impossible de loader le fichier ' + player2[11]);
  end
  else
  begin

  // Fade Out
    if (player2[12] = 'INTERVENTION') then
    begin
      FadeOutm2 := Round(BASS_ChannelBytes2Seconds(m2, BASS_ChannelGetLength(m2, BASS_POS_BYTE)));
      Main.log('Voice Track 2: Fade:' + IntToStr(Round(FadeOutm2)), True);
    end
    else
    begin
      FadeOutm2 := StrToFloat(StringReplace(player2[10], '.', ',', [rfReplaceAll]));
    end;

  // FX seulement si c'est en mode normal
    if (ModeSoundSolution = False) then
    begin
      BASS_SetDevice(StrToInt(DSC2CART));
      m2 := BASS_FX_TempoCreate(m2, flags[StrToInt(DSC2CHAN)] or BASS_FX_FREESOURCE);
    end;

  // Auto Tempo
    cue2.Text := Form1.player2[9];
    //BASS_FX_TempoSet(m2, StrToInt(player2[7]), StrToInt(player2[6]), -100); // Frequence

  // Position Start

    if player2[9] <> '0' then
    begin
      StartPosBytes := BASS_ChannelSeconds2Bytes(m1, strtofloat(StringReplace(player2[9], '.', ',', [rfReplaceAll])));
      BASS_ChannelSetPosition(m2, StartPosBytes, BASS_POS_BYTE);
    end;

    Temps := BASS_ChannelBytes2Seconds(m2, BASS_ChannelGetLength(m2, BASS_POS_BYTE));
    TempsLu := BASS_ChannelBytes2Seconds(m2, BASS_ChannelGetPosition(m2, BASS_POS_BYTE));
    Gauge := StrToFloat(StringReplace(player2[8], '.', ',', [rfReplaceAll]));
    TempsRestant := (Temps - TempsLu);
    DecompteRestant := (Gauge - TempsLu);

    Label26.Caption := format('%2.2d:%2.2d', [trunc(Temps) div 60, trunc(Temps) mod 60]);
    Label24.Caption := format('%2.2d:%2.2d', [trunc(TempsLu) div 60, trunc(TempsLu) mod 60]);
    Label25.Caption := format('%2.2d:%2.2d', [trunc(TempsRestant) div 60, trunc(TempsRestant) mod 60]);
    Intro2.Caption := format('%2.2d:%2.2d', [trunc(DecompteRestant) div 60, trunc(DecompteRestant) mod 60]);


  end;

  result := True;
end;

function TForm1.Pad(Filename: string): Boolean;
begin

  if(Proteger1.Checked) then stoppad1.Click(); // STOP
  BASS_SetDevice(StrToInt(PAD1CART));
  pad1 := BASS_StreamCreateFile(False, Pchar(Filename), 0, 0, flags[StrToInt(PAD1CHAN)]); // Mode normal

  BASS_ChannelSetAttribute(pad1, BASS_ATTRIB_VOL, 1 - (TrackBar3.position / 256));

  if BASS_ChannelPlay(pad1, False) then
  begin
  // FICHIER LU
    SyncEndHandle := BASS_ChannelSetSync(pad1, BASS_SYNC_END, 0, @pad1_sync, MessageHandle);
    Timer9.Enabled := True; // vumètre
    Timer12.Enabled := True; // compteurs
  end
  else
  begin
    // FICHIER PAS LU
    Error('Cartouchier: error : ' + Filename);
    //Error(IntToStr(BASS_ErrorGetCode()));
  end;

  result := True;

end;

function TForm1.Padpfl(Filename: string): Boolean;
begin

  BASS_ChannelStop(pfl_pad1);
  BASS_StreamFree(pfl_pad1);
  BASS_SetDevice(StrToInt(CUE1CART));
  pfl_pad1 := BASS_StreamCreateFile(False, Pchar(Filename), 0, 0, flags[StrToInt(CUE1CHAN)]);
  BASS_ChannelPlay(pfl_pad1, False);
  SyncEndHandle := BASS_ChannelSetSync(pfl_pad1, BASS_SYNC_END, 0, @pad1_pfl_sync, MessageHandle);
  pflpad1.Tag := 1;
  pflpad1.ImageIndex := 161;
  pflpad1.Caption := 'Stop';
  result := True;

end;

procedure TForm1.Error(msg: string);
begin
  Main.Log(msg, True);
  Bar.Caption := msg;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  FichierIni: TIniFile;
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
begin


  FichierIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\config.ini');

     // LECTEURS CARTES
  DSC1CART := FichierIni.ReadString('Soundcard', 'DSC1', '1');
  DSC2CART := FichierIni.ReadString('Soundcard', 'DSC2', '1');

     // LECTEURS CHANNELS
  DSC1CHAN := FichierIni.ReadString('Multichannel', 'DSC1', '0');
  DSC2CHAN := FichierIni.ReadString('Multichannel', 'DSC2', '0');

     // JINGLE/PAD/PUB/CUE CARTE
  JIN1CART := FichierIni.ReadString('Soundcard', 'JIN1', '1');
  JIN2CART := FichierIni.ReadString('Soundcard', 'JIN2', '1');
  PAD1CART := FichierIni.ReadString('Soundcard', 'PAD1', '1');
  PUB1CART := FichierIni.ReadString('Soundcard', 'PUB1', '1');
  CUE1CART := FichierIni.ReadString('Soundcard', 'CUE1', '1');

     // JINGLE/PAD/PUB/CUE CHANNELS
  JIN1CHAN := FichierIni.ReadString('Multichannel', 'JIN1', '0');
  JIN2CHAN := FichierIni.ReadString('Multichannel', 'JIN2', '0');
  PAD1CHAN := FichierIni.ReadString('Multichannel', 'PAD1', '0');
  PUB1CHAN := FichierIni.ReadString('Multichannel', 'PUB1', '0');
  CUE1CHAN := FichierIni.ReadString('Multichannel', 'CUE1', '0');

     // RECORD OUT
  REC1CART := FichierIni.ReadString('Soundcard', 'REC1', '1');
  REC1CHAN := FichierIni.ReadString('Multichannel', 'REC1', '0');
    // RECORD IN
  RECORD1CART := FichierIni.ReadString('Record', 'REC1', '0');

     // AUTOMATION
  AUTOSILENCE := StrToInt(FichierIni.ReadString('Automation', 'Silence', '8000'));
  AUTOOUT := StrToInt(FichierIni.ReadString('Automation', 'Out', '10'));
  AUTOFADEOUT := StrToInt(FichierIni.ReadString('Automation', 'Fade', '1200'));
  AUTOFENETRE := StrToInt(FichierIni.ReadString('Automation', 'Fenetre', '800'));

     // TONE DET
  TONEDETECTNIVEAU := StrToInt(FichierIni.ReadString('Tone', 'Niveau', '100'));
  TONEDETECTFREQ := StrToInt(FichierIni.ReadString('Tone', 'Frequence', '20'));

     // SKIP
  SKIPPREV := StrToInt(FichierIni.ReadString('Skip', 'Previous', '1'));
  SKIPNEXT := StrToInt(FichierIni.ReadString('Skip', 'Next', '1'));

  FichierIni.Free;

  // Ajout des categories Jingles dans les Onglets

  if (Main.sql.Connected) then
  begin

    Res := Main.sql.Query('SELECT id, nom FROM sscategories WHERE categorie = 1 AND hide=0;');

    Row := Main.sql.fetch_row(Res);
    while Row <> nil do
    begin
      with JingleChoice do
        with TTabSheet.Create(Self) do
        begin
          PageControl := JingleChoice;
          Highlighted := true;
          TabVisible := true;
          Caption := Row[1];
          Tag := StrToInt(Row[0]);
        end;

      Row := Main.sql.fetch_row(Res);
    end;
    Main.sql.free_result(Res);
  end;
  JingleChoiceChange(Sender);

  // ID repère Pavé + repère pub (isg3 et isg4)
  isg3 := 0;
  isg4 := 0;
  // Pavé

  StringGrid3.ColCount := 5;
  StringGrid3.ColWidths[0] := 0;
  StringGrid3.ColWidths[1] := 0;
  StringGrid3.ColWidths[2] := 150;
  StringGrid3.ColWidths[3] := 40;
  StringGrid3.ColWidths[4] := 0;


  StringGrid4.ColCount := 6;
  StringGrid4.ColWidths[0] := 0;
  StringGrid4.ColWidths[1] := 0;
  StringGrid4.ColWidths[2] := 100;
  StringGrid4.ColWidths[3] := 100;
  StringGrid4.ColWidths[4] := 200;
  StringGrid4.ColWidths[5] := 30;

  StringGrid1.ColCount := 6;
  StringGrid1.ColWidths[0] := 0;
  StringGrid1.ColWidths[1] := 0;
  StringGrid1.Cells[2, 0] := 'N°';
  StringGrid1.ColWidths[2] := 15;
  StringGrid1.Cells[3, 0] := 'Nom';
  StringGrid1.ColWidths[3] := 130;
  StringGrid1.Cells[4, 0] := 'Durée';
  StringGrid1.ColWidths[4] := 40;
  StringGrid1.ColWidths[5] := 0;

  StringGrid1.Cells[2, 1] := '1';
  StringGrid1.Cells[2, 2] := '2';
  StringGrid1.Cells[2, 3] := '3';
  StringGrid1.Cells[2, 4] := '4';
  StringGrid1.Cells[2, 5] := '5';
  StringGrid1.Cells[2, 6] := '6';
  StringGrid1.Cells[2, 7] := '7';
  StringGrid1.Cells[2, 8] := '8';
  StringGrid1.Cells[2, 9] := '9';

	if (HIWORD(BASS_GetVersion) <> BASSVERSION) then
	begin
		MessageBox(0,'An incorrect version of BASS.DLL was loaded',0,MB_ICONERROR);
		Halt;
	end;

  if not BASS_Init(StrToInt(DSC1CART), 44100, BASS_DEVICE_SPEAKERS, Handle, nil) then
    Error('Lecteur1: Initalisation échouée ou déjà initalisée');

  if not BASS_Init(StrToInt(DSC2CART), 44100, BASS_DEVICE_SPEAKERS, Handle, nil) then
    Error('Lecteur2: Initalisation échouée ou déjà initalisée');

  if not BASS_Init(StrToInt(JIN1CART), 44100, BASS_DEVICE_SPEAKERS, Handle, nil) then
    Error('Jingle: Initalisation échouée ou déjà initalisée');

  if not BASS_Init(StrToInt(JIN2CART), 44100, BASS_DEVICE_SPEAKERS, Handle, nil) then
    Error('Enchaineur: Initalisation échouée ou déjà initalisée');

  if not BASS_Init(StrToInt(PAD1CART), 44100, BASS_DEVICE_SPEAKERS, Handle, nil) then
    Error('Pad: Initalisation échouée ou déjà initalisée');

  if not BASS_Init(StrToInt(PUB1CART), 44100, BASS_DEVICE_SPEAKERS, Handle, nil) then
    Error('Pub: Initalisation échouée ou déjà initalisée');

  if not BASS_Init(StrToInt(CUE1CART), 44100, BASS_DEVICE_SPEAKERS, Handle, nil) then
    Error('Pré écoute: Initalisation échouée ou déjà initalisée');

  if not BASS_Init(StrToInt(REC1CART), 44100, BASS_DEVICE_SPEAKERS, Handle, nil) then
    Error('Rec1: Initalisation échouée ou déjà initalisée');

  if (not BASS_RecordInit(StrToInt(RECORD1CART))) then
    Error('Record: Initalisation échouée ou déjà initalisée');

  WaveStream := TMemoryStream.Create; // Tampon

  // Debug Mode
  if (ParamStr(1) = '/debug') then
  begin
    StringGrid4.Visible := True;
    PubPlay.Visible := True;
    pubcurdelete.Visible := True;
    formsysop.Visible := True;
    ModeDebug := True;
    Form1.Height:=745;
    StringGrid4.Visible:=True;
    pubplay.Visible:=True;
    pubcurdelete.Visible:=True;
  end
  else
  begin
    ModeDebug := False;
  end;

  //EnableMenuItem(GetSystemMenu(Handle, FALSE), SC_CLOSE, MF_GRAYED);
  EnableMenuItem(GetSystemMenu(Application.Handle, FALSE), SC_CLOSE, MF_GRAYED);
  Form1.Left := 0;
  Form1.Top := 75;
  //SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS);

  // MIDI BCF
  if(false) then
  begin
    fCriticalSection := TCriticalSection.Create;
    MidiInput.OnMidiData := DoMidiInData;
    MidiInput.Open(0);
    MidiOutput.Open(0);
  end
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  BASS_SetDevice(StrToInt(DSC1CART));
  BASS_StreamFree(m1);
  BASS_SetDevice(StrToInt(DSC1CART));
  BASS_StreamFree(m2);
  BASS_SetDevice(StrToInt(JIN1CART));
  BASS_StreamFree(j1);
  BASS_SetDevice(StrToInt(JIN2CART));
  BASS_StreamFree(j2);
  BASS_SetDevice(StrToInt(PAD1CART));
  BASS_StreamFree(pad1);
  BASS_SetDevice(StrToInt(PUB1CART));
  BASS_StreamFree(pub1);
  BASS_SetDevice(StrToInt(REC1CART));
  BASS_StreamFree(pfl_m1);
  BASS_StreamFree(pfl_m2);
  BASS_StreamFree(pfl_j1);
  BASS_StreamFree(pfl_j2);
  BASS_StreamFree(pfl_pad1);
  BASS_Free();
  Main.sql.Close;
  CloseDevice;
  Application.Terminate;

end;

// TIMER EXTERNE

procedure TForm1.Timer2Timer(Sender: TObject);
var i, Data1, Data2: longint;
begin

  i := ReadAllDigital;
  ReadAllAnalog(Data1, Data2);

  TrackBar1.Position := (Data1 div 10);
  TrackBar3.Position := (Data2 div 10);

  // Ici on détecte les impulsions du DRC
  if ((i and 1) > 0) then begin
   // DSC1-1
    timer2.enabled := false; // désactive le Timer (ici)
    Timer4.enabled := true; // demande de ré enclenchement après x ms
    if (BASS_ChannelIsActive(Form1.m1) = 0) then Play1.Click()
  end;

  if ((i and 2) > 0) then begin
   // DSC1-2
    timer2.enabled := false; // désactive le Timer (ici)
    Timer4.enabled := true; // demande de ré enclenchement après x ms
    if (BASS_ChannelIsActive(Form1.m2) = 0) then Play2.Click();
  end;

  if ((i and 4) > 0) then begin
    timer2.enabled := false; // désactive le Timer (ici)
    Timer4.enabled := true; // demande de ré enclenchement après x ms
    if (BASS_ChannelIsActive(Form1.j1) = 0) then playj1.Click();
  end;

  if ((i and 8) > 0) then begin
    timer2.enabled := false; // désactive le Timer (ici)
    Timer4.enabled := true; // demande de ré enclenchement après x ms
    Playj2.Click();
  end;

  if ((i and 16) > 0) then begin
    timer2.enabled := false; // désactive le Timer (ici)
    Timer4.enabled := true; // demande de ré enclenchement après x ms
    Events.diffuser.Click();
  end;

end;

// TIMER EXTERNE

// RéActivation du DRC   (si timer appelé) ex: pas pour le DSC2,3..

procedure TForm1.Timer4Timer(Sender: TObject);
begin
  Timer2.enabled := true; // Je réactive la lecture digitale
  Timer4.enabled := false; // Je me désactive.
end;

procedure TForm1.Timer5Timer(Sender: TObject);
var
  Temps, TempsLu, TempsRestant, DecompteRestant, Gauge : Integer;
begin

  Temps := trunc(BASS_ChannelBytes2Seconds(m1, BASS_ChannelGetLength(m1, BASS_POS_BYTE)));
  TempsLu := trunc(BASS_ChannelBytes2Seconds(m1, BASS_ChannelGetPosition(m1, BASS_POS_BYTE)));
  Gauge := trunc(StrToFloat(StringReplace(player1[8], '.', ',', [rfReplaceAll])));
  TempsRestant := trunc(Temps - TempsLu);
  DecompteRestant := trunc(Gauge - TempsLu);

  Label3.Caption := format('%2.2d:%2.2d', [Temps div 60, Temps mod 60]);
  Label4.Caption := format('%2.2d:%2.2d', [TempsLu div 60, TempsLu mod 60]);
  Label8.Caption := format('%2.2d:%2.2d', [TempsRestant div 60, TempsRestant mod 60]);

  if ((TempsLu <= Gauge) AND (Gauge <> 0)) then
  begin
    Gauge1.MaxValue := Gauge - 1;
    Gauge1.Progress := TempsLu;
    Gauge1.visible := true;
    Intro1.Caption := format('%2.2d:%2.2d', [DecompteRestant div 60, DecompteRestant mod 60]);
  end
  else
  begin
    Gauge1.Progress := 0;
    Gauge1.visible := false;
    Intro1.Caption := '00:00';
  end;

  Gauge2.MaxValue := Temps;
  Gauge2.Progress := TempsLu;

  Timer5.Interval := 1000;

end;

procedure TForm1.Timer6Timer(Sender: TObject);
var level: Cardinal;
var left: Cardinal;
var right: Cardinal;
begin

  if BASS_ChannelIsActive(m1) = 1 then
  begin
      // Timer vumètre musical 1
    level := BASS_ChannelGetLevel(m1);
    left := LOWORD(level); // the left level
    right := HIWORD(level); // the right level

    RLed1.Position := left;
    RLed2.Position := right;
  end
  else
  begin
    RLed1.Position := 0;
    RLed2.Position := 0;
  end;

end;

procedure TForm1.TrackBar1Change(Sender: TObject);
var level: Double;
begin
  level:=(TrackBar1.position / 256);
  BASS_ChannelSetAttribute(m1, BASS_ATTRIB_VOL, 1 - level);
  label11.Caption := FormatFloat('#.##',  100 - (level * 100));
end;


procedure TForm1.Timer7Timer(Sender: TObject);
var level: Cardinal;
var left: Cardinal;
var right: Cardinal;
begin

  if BASS_ChannelIsActive(j1) = 1 then
  begin
      // Timer vumètre musical 1
    level := BASS_ChannelGetLevel(j1);
    left := LOWORD(level); // the left level
    right := HIWORD(level); // the right level

    RLed5.Position := left;
    RLed6.Position := right;
  end
  else
  begin
    RLed5.Position := 0;
    RLed6.Position := 0;
  end;
end;



procedure TForm1.Timer8Timer(Sender: TObject);
var
  Temps: Single;
  TempsLu: Single;
  TempsRestant: Single;
begin

  Temps := BASS_ChannelBytes2Seconds(j1, BASS_ChannelGetLength(j1, BASS_POS_BYTE));
  TempsLu := BASS_ChannelBytes2Seconds(j1, BASS_ChannelGetPosition(j1, BASS_POS_BYTE));
  TempsRestant := (Temps - TempsLu);

  Label13.Caption := format('%.2f', [TempsRestant]);

  Timer8.Interval := 10; // les tours suivants de sera 1000ms

end;


procedure TForm1.TrackBar2Change(Sender: TObject);
var level: Double;
begin
  level:=(TrackBar2.position / 256);
  BASS_ChannelSetAttribute(j1, BASS_ATTRIB_VOL, 1 - level);
  label10.Caption := FormatFloat('#.##',  100 - (level * 100));
end;

procedure TForm1.test1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  About.ShowModal;
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
var level: Double;
begin
  level:=(TrackBar3.position / 256);
  BASS_ChannelSetAttribute(m2, BASS_ATTRIB_VOL, 1 - level);
  label12.Caption := FormatFloat('#.##',  100 - (level * 100));
end;

procedure TForm1.Timer3Timer(Sender: TObject);
var
  Temps, TempsLu, TempsRestant, DecompteRestant, Gauge : Integer;
begin

  Temps := trunc(BASS_ChannelBytes2Seconds(m2, BASS_ChannelGetLength(m2, BASS_POS_BYTE)));
  TempsLu := trunc(BASS_ChannelBytes2Seconds(m2, BASS_ChannelGetPosition(m2, BASS_POS_BYTE)));
  Gauge := trunc(StrToFloat(StringReplace(player2[8], '.', ',', [rfReplaceAll])));
  TempsRestant := trunc(Temps - TempsLu);
  DecompteRestant := trunc(Gauge - TempsLu);

  Label26.Caption := format('%2.2d:%2.2d', [Temps div 60, Temps mod 60]);
  Label24.Caption := format('%2.2d:%2.2d', [TempsLu div 60, TempsLu mod 60]);
  Label25.Caption := format('%2.2d:%2.2d', [TempsRestant div 60, TempsRestant mod 60]);

  if ((TempsLu <= Gauge) AND (Gauge <> 0)) then
  begin
    Gauge3.MaxValue := Gauge - 1;
    Gauge3.Progress := TempsLu;
    Gauge3.visible := true;
    Intro2.Caption := format('%2.2d:%2.2d', [DecompteRestant div 60, DecompteRestant mod 60]);
  end
  else
  begin
    Gauge3.Progress := 0;
    Gauge3.visible := false;
    Intro2.Caption := '00:00';
  end;

  Gauge4.MaxValue := Temps;
  Gauge4.Progress := TempsLu;

  Timer3.Interval := 1000;
end;



procedure TForm1.Timer10Timer(Sender: TObject);
var level: Cardinal;
var left: Cardinal;
var right: Cardinal;
begin

  if BASS_ChannelIsActive(m2) = 1 then
  begin
      // Timer vumètre musical 1
    level := BASS_ChannelGetLevel(m2);
    left := LOWORD(level); // the left level
    right := HIWORD(level); // the right level

    RLed3.Position := left;
    RLed4.Position := right;
  end
  else
  begin
    RLed3.Position := 0;
    RLed4.Position := 0;
  end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var level: Cardinal;
var left: Cardinal;
var right: Cardinal;
begin

  if BASS_ChannelIsActive(j2) = 1 then
  begin
      // Timer vumètre musical 1
    level := BASS_ChannelGetLevel(j2);
    left := LOWORD(level); // the left level
    right := HIWORD(level); // the right level

    RLed7.Position := left;
    RLed8.Position := right;
  end
  else
  begin
    RLed7.Position := 0;
    RLed8.Position := 0;
  end;


end;

procedure TForm1.Timer11Timer(Sender: TObject);
var
  Temps: Single;
  TempsLu: Single;
  TempsRestant: Single;
begin

  Temps := BASS_ChannelBytes2Seconds(j2, BASS_ChannelGetLength(j2, BASS_POS_BYTE));
  TempsLu := BASS_ChannelBytes2Seconds(j2, BASS_ChannelGetPosition(j2, BASS_POS_BYTE));
  TempsRestant := (Temps - TempsLu);

  Label5.Caption := format('%.2f', [TempsRestant]);

  Timer11.Interval := 10;
end;

procedure TForm1.TrackBar4Change(Sender: TObject);
var level: double;
begin
  level:=(TrackBar4.position / 256);
  BASS_ChannelSetAttribute(j2, BASS_ATTRIB_VOL, 1 - level);
  label6.Caption := FormatFloat('#.##',  100 - (level * 100));
end;

procedure TForm1.JingleChoiceChange(Sender: TObject);
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  i, j, k: integer;
  RequestSQL: string;
  Duree: Double;
begin

  for k := 0 to StringGrid2.Rowcount - 1 do
  begin
    StringGrid2.Rows[k].clear;
  end;

  RequestSQL := 'SELECT playlist.Id, artistes.Name AS artiste, playlist.Titre, playlist.Duree, playlist.Path FROM playlist LEFT JOIN artistes ON (artistes.ID = playlist.Artiste) WHERE playlist.Categorie=1 AND playlist.SSCategorie=''' + IntToStr(JingleChoice.ActivePage.Tag) + '''  ORDER by playlist.Id ASC;';
  Res := Main.sql.Query(RequestSQL);

  if Res = nil then Error('SQL: Aucun resultat' + RequestSQL)
  else
  try

    StringGrid2.ColCount := 5;
    StringGrid2.RowCount := Main.sql.num_rows(Res);

    StringGrid2.ColWidths[0] := 0;
    StringGrid2.ColWidths[1] := 160;
    StringGrid2.ColWidths[2] := 190;
    StringGrid2.ColWidths[3] := 50;
    StringGrid2.ColWidths[4] := 0;

    j := 0;
    Row := Main.sql.fetch_row(Res);
    while Row <> nil do
    begin
      for i := 0 to StringGrid2.ColCount do
      begin
        if (i = 3) then
        begin
          Duree := StrToFloat(StringReplace(Row[i], '.', ',', [rfReplaceAll]));
          StringGrid2.Cells[i, j] := format('%2.2d:%2.2d', [trunc(Duree) div 60, trunc(Duree) mod 60]);
        end
        else
        begin
          StringGrid2.Cells[i, j] := UpperCase(Row[i]); // La cellule en MAJ.
        end;
      end;
      Row := Main.sql.fetch_row(Res);
      j := j + 1;
    end;
  finally
    Main.sql.free_result(Res);
  end;

end;

procedure TForm1.SpinButton1UpClick(Sender: TObject);
var
  TempoTemp, FrequenceTemp, PitchTemp: Double;
begin
  //BASS_FX_TempoGet(m1, TempoTemp, FrequenceTemp, PitchTemp); //  On récupère
  FrequenceTemp := FrequenceTemp + 100;
  //BASS_FX_TempoSet(m1, TempoTemp, FrequenceTemp, PitchTemp); // Frequence

  //SpinButton1.Tag := SpinButton1.Tag + 1;
  //Label36.Caption := IntToStr(SpinButton1.Tag);

end;

procedure TForm1.SpinButton2UpClick(Sender: TObject);
var
  TempoTemp, FrequenceTemp, PitchTemp: Double;
begin
  //BASS_FX_TempoGet(m2, TempoTemp, FrequenceTemp, PitchTemp); //  On récupère
  FrequenceTemp := FrequenceTemp + 100;
  //BASS_FX_TempoSet(m2, TempoTemp, FrequenceTemp, PitchTemp); // Frequence

  //SpinButton2.Tag := SpinButton2.Tag + 1;
  //Label37.Caption := IntToStr(SpinButton2.Tag);
end;

procedure TForm1.SpinButton2DownClick(Sender: TObject);
var
  TempoTemp, FrequenceTemp, PitchTemp: Double;
begin
  //BASS_FX_TempoGet(m2, TempoTemp, FrequenceTemp, PitchTemp); //  On récupère
  FrequenceTemp := FrequenceTemp - 100;
  //BASS_FX_TempoSet(m2, TempoTemp, FrequenceTemp, PitchTemp); // Frequence

  //SpinButton2.Tag := SpinButton2.Tag - 1;
  //Label37.Caption := IntToStr(SpinButton2.Tag);

end;

procedure TForm1.StringGrid1DblClick(Sender: TObject);
begin
  Pad(StringGrid1.cells[5, StringGrid1.Row]);
end;

procedure TForm1.Ajoutau1Click(Sender: TObject);
begin
  StringGrid3.Cells[0, isg3] := StringGrid2.cells[0, StringGrid2.Row];
  StringGrid3.Cells[1, isg3] := StringGrid2.cells[1, StringGrid2.Row];
  StringGrid3.Cells[2, isg3] := StringGrid2.cells[2, StringGrid2.Row];
  StringGrid3.Cells[3, isg3] := StringGrid2.cells[3, StringGrid2.Row];
  StringGrid3.Cells[4, isg3] := StringGrid2.cells[4, StringGrid2.Row];
  isg3 := (isg3 + 1);
  StringGrid3.RowCount := isg3;
end;

procedure TForm1.Ajouteraupav1Click(Sender: TObject);
begin
  StringGrid1.Cells[3, StringGrid1.Row] := StringGrid2.cells[2, StringGrid2.Row];
  StringGrid1.Cells[4, StringGrid1.Row] := StringGrid2.cells[3, StringGrid2.Row];
  StringGrid1.Cells[5, StringGrid1.Row] := StringGrid2.cells[4, StringGrid2.Row];
end;

procedure TForm1.Ajouterlenchaneur1Click(Sender: TObject);
begin
  StringGrid3.Cells[2, isg3] := StringGrid1.cells[3, StringGrid1.Row];  // title
  StringGrid3.Cells[3, isg3] := StringGrid1.cells[4, StringGrid1.Row];  // duration
  StringGrid3.Cells[4, isg3] := StringGrid1.cells[5, StringGrid1.Row];  // filename
  isg3 := (isg3 + 1);
  StringGrid3.RowCount := isg3;
end;

procedure TForm1.TrackBar5Change(Sender: TObject);
var level: double;
begin
  level:=(TrackBar5.position / 256);
  BASS_ChannelSetAttribute(pad1, BASS_ATTRIB_VOL, 1 - level);
  label39.Caption := FormatFloat('#.##',  100 - (level * 100));
end;

procedure TForm1.Timer9Timer(Sender: TObject);
var level: Cardinal;
var left: Cardinal;
var right: Cardinal;
begin

  if BASS_ChannelIsActive(pad1) = 1 then
  begin
      // Timer vumètre musical 1
    level := BASS_ChannelGetLevel(pad1);
    left := LOWORD(level); // the left level
    right := HIWORD(level); // the right level

    RLed9.Position := left;
    RLed10.Position := right;

  end
  else
  begin
    RLed9.Position := 0;
    RLed10.Position := 0;
  end;
end;

procedure TForm1.Timer12Timer(Sender: TObject);
var
  Temps: Single;
  TempsLu: Single;
  TempsRestant: Single;
begin

  Temps := BASS_ChannelBytes2Seconds(pad1, BASS_ChannelGetLength(pad1, BASS_POS_BYTE));
  TempsLu := BASS_ChannelBytes2Seconds(pad1, BASS_ChannelGetPosition(pad1, BASS_POS_BYTE));
  TempsRestant := (Temps - TempsLu);

  Label40.Caption := format('%.2f', [TempsRestant]);

  Timer12.Interval := 10; // les tours suivants de sera 1000ms

end;

procedure TForm1.status1Changed(Sender: TObject);
begin
  if (BASS_ChannelIsActive(pfl_m1) = 0) then pflm1.OnClick(sender);
  BASS_ChannelSetPosition(pfl_m1, status1.Position * 100000, BASS_POS_BYTE);
end;

procedure TForm1.status2Changed(Sender: TObject);
begin
  if (BASS_ChannelIsActive(pfl_m2) = 0) then pflm2.OnClick(sender);
  BASS_ChannelSetPosition(pfl_m2, status2.Position * 100000, BASS_POS_BYTE);
end;

procedure TForm1.pubplayClick(Sender: TObject);
var Path: string;
begin

  if(StringGrid4.RowCount > 0) then
  begin
  BASS_ChannelStop(pub1); // Stop
  BASS_StreamFree(pub1); // Test libération mémoire
  Timer13.Enabled := False; // Stop compteurs

  Path := StringGrid4.cells[5, 0]; // File

  FadeOutPub := StrToFloat(StringReplace(StringGrid4.cells[4, 0], '.', ',', [rfReplaceAll])); // Fade Out Pub ?
  BASS_SetDevice(StrToInt(PUB1CART));

  pub1 := BASS_StreamCreateFile(False, Pchar(Path), 0, 0, flags[StrToInt(PUB1CHAN)]); // pub start

  // Si c'est le mode SS
  BASS_Mixer_StreamAddChannel(mixer, pub1, 0);

  if BASS_ChannelPlay(pub1, False) then
  begin
  // FICHIER LU

    Timer13.Enabled := True; // compteurs

  // Couper les autres en fade
    //if BASS_ChannelIsActive(m1) = 1 then BASS_ChannelSlideAttributes(m1, -1, -2, -101, 250);
    //if BASS_ChannelIsActive(m2) = 1 then BASS_ChannelSlideAttributes(m2, -1, -2, -101, 250);
    //if BASS_ChannelIsActive(j1) = 1 then BASS_ChannelSlideAttributes(j1, -1, -2, -101, 250);
    //if BASS_ChannelIsActive(j2) = 1 then BASS_ChannelSlideAttributes(j2, -1, -2, -101, 250);
    //if BASS_ChannelIsActive(pad1) = 1 then BASS_ChannelSlideAttributes(pad1, -1, -2, -101, 250);

    SyncEndHandle := BASS_ChannelSetSync(pub1, BASS_SYNC_END, 0, @pub1_sync, MessageHandle);
    
    Main.log('PUB: ' + StringGrid4.cells[2, StringGrid4.Row], True);

    if (StringGrid4.RowCount <> 1) then
    begin
      GridDeleteRow(0, StringGrid4);
      isg4 := (isg4 - 1);
    end
    else
    begin
      StringGrid4.Rows[0].Clear;
      isg4 := 0;
    end;

  end
  else
  begin
  // FICHIER PAS LU
    Error('Pub: ' + StringGrid4.cells[5, StringGrid4.Row]);
  // Delete du rows current (si non la queue reste bloquée eternellement)
    pubcurdelete.Click();

  // Réactiver le silence timer (si on est en mode Auto..)
    if (main.ModeAuto = True) then begin
      main.silence.Enabled := True;
      main.protection.Enabled := True;
      events.findevents.Enabled := True;
    end;
  end;
  end
  else
  begin
     Main.log('[PRESS PUB] Pas de pub a lire!', True);
  end;
end;

procedure TForm1.Timer13Timer(Sender: TObject);
var
  Temps2: Single;
  TempsLu1, TempsLu2: Single;
begin

  // Temps de la pub en cours
  TempsLu1 := BASS_ChannelBytes2Seconds(pub1, BASS_ChannelGetPosition(pub1, BASS_POS_BYTE));
  Temps2 := BASS_ChannelGetLength(pub1, BASS_POS_BYTE);
  TempsLu2 := BASS_ChannelGetPosition(pub1, BASS_POS_BYTE);

  // PROTECTION - Si pas de fadeoutpub, valeur infinie..
  if (FadeOutPub = 0) then begin FadeOutPub := 999999; end;

  // Prechargement
  if (isg4 = 0) then
  begin
    if (((FadeOutPub - 2) <= TempsLu1) and (Main.isLoad1 = False) and (main.ModeAuto = True)) then
    begin
      Main.log('Preload Player 1 (depuis TIMER)', True);
      Main.isLoad1 := True;
      Main.Player1PreLoad := True;
      Main.load1(True, False);
    end;
  end;

  // OK
  if (FadeOutPub <= TempsLu1) or (Temps2 = TempsLu2) then
  begin
    // Plus de pub à passer
    if (isg4 = 0) then
    begin
      // Lancer le retour pub
      if (retourpub.Tag = 1) then
      begin
        playj1.Click; // Jingle
      end;

    // Réactiver le silence timer (si on est en mode Auto..)
      if (main.ModeAuto = True) then begin

        // Lancement auto
        if (Main.Player1PreLoad = True) then
        begin
          Form1.Play1.Click();
      //Main.EnCours := 1;
          Main.log('Play Player 1 (Morceau chargé)', True);
        end
        else
        begin
          Main.load1(True, True);
          Main.log('Play Player 1 (Chargement en cours)', True);
        end;

        main.protection.Interval := 1000;
        main.protection.Enabled := True;
        main.silence.Enabled := True;

      // Ré Activer l'entrée et la sortie
        Main.ButtonDJ.Enabled := True;
        Main.ButtonAuto.Enabled := False;
      // Réactiver le timer
        Events.findnextevents.Enabled := True;
        Events.findevents.Enabled := True;
      end
      else
      begin
      // Ré Activer l'entrée et la sortie
        Main.ButtonDJ.Enabled := False;
        Main.ButtonAuto.Enabled := True;
      // Réactiver le timer
        Events.findnextevents.Enabled := True;
        Events.findevents.Enabled := True;
      end;

    // Stop
      if (FadeOutPub <> 0) then
      begin
        // Fade Out 3sec
        BASS_ChannelSlideAttribute(pub1, BASS_ATTRIB_VOL, 0, 3000);
      end
      else
      begin
        // Stop net !
        BASS_ChannelStop(pub1);
        BASS_StreamFree(pub1);
      end;

      Timer13.Enabled := False; // compteurs

   // Log
      Main.log('Fin de la page pub (' + FloatToStr(FadeOutPub) + ') ', True);

    end
    else
    begin
      // Suivant
      pubplay.OnClick(sender); // Play
    end;
  end;
end;

procedure TForm1.pubcurdeleteClick(Sender: TObject);
var
  PubDelete: string;
begin

  PubDelete := StringGrid4.cells[2, StringGrid4.Row];

  if (StringGrid4.RowCount <> 1) then
  begin
    GridDeleteRow(StringGrid4.Row, StringGrid4);
    isg4 := (isg4 - 1);
  end
  else
  begin
    StringGrid4.Rows[StringGrid4.Row].Clear;
    isg4 := 0;
  end;

   // Log
  Main.log('Suppression PUB: ' + PubDelete, True);

end;

procedure TForm1.timerpflm1Timer(Sender: TObject);
begin
  status1.Position := BASS_ChannelGetPosition(pfl_m1, BASS_POS_BYTE) div 100000;
end;

procedure TForm1.timerpflm2Timer(Sender: TObject);
begin
  status2.Position := BASS_ChannelGetPosition(pfl_m2, BASS_POS_BYTE) div 100000;
end;

procedure TForm1.ApplicationEvents1ShortCut(var Msg: TWMKey;
  var Handled: Boolean);
var
Key: Word;
Tempo, Samplerate, Pitch : Double;
begin
  Key := Msg.CharCode;

  if (Key = VK_F1) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    pflm1.Click;
    exit;
  end;

  if (Key = VK_F1) then
  begin
    Stop1.Click;
    exit;
  end;

  if (Key = VK_F2) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    pflm1.Click;
    exit;
  end;

  if (Key = VK_F2) then
  begin
    if (BASS_ChannelIsActive(Form1.m1) = 0) then Play1.Click;
    exit;
  end;

  if (Key = (VK_F3)) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    BASS_ChannelSetPosition(m1, BASS_ChannelGetPosition(m1, BASS_POS_BYTE)-1000, BASS_POS_BYTE);
    exit;
  end
  else if Key = (VK_F3) then
  begin
    BASS_ChannelSetPosition(m1, BASS_ChannelSeconds2Bytes(m1, BASS_ChannelBytes2Seconds(m1, BASS_ChannelGetPosition(m1, BASS_POS_BYTE)) - SKIPPREV), BASS_POS_BYTE);
    exit;
  end;

  if (Key = (VK_F4)) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    BASS_ChannelSetPosition(m1, BASS_ChannelGetPosition(m1, BASS_POS_BYTE)+1000, BASS_POS_BYTE);
    exit;
  end
  else if Key = (VK_F4) then
  begin
    BASS_ChannelSetPosition(m1, BASS_ChannelSeconds2Bytes(m1, BASS_ChannelBytes2Seconds(m1, BASS_ChannelGetPosition(m1, BASS_POS_BYTE)) + SKIPNEXT), BASS_POS_BYTE);
    exit;
  end;

  if (Key = ord('1')) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    fadem1.Click;
    exit;
  end;

  if (Key = ord('2')) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    brakem1.Click;
    exit;
  end;

  if (Key = ord('3')) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    BASS_ChannelSetPosition(pfl_m1, BASS_ChannelSeconds2Bytes(pfl_m1, BASS_ChannelBytes2Seconds(pfl_m1, BASS_ChannelGetPosition(pfl_m1, BASS_POS_BYTE)) - SKIPPREV), BASS_POS_BYTE);
    exit;
  end;

  if (Key = ord('4')) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    BASS_ChannelSetPosition(pfl_m1, BASS_ChannelSeconds2Bytes(pfl_m1, BASS_ChannelBytes2Seconds(pfl_m1, BASS_ChannelGetPosition(pfl_m1, BASS_POS_BYTE)) + SKIPNEXT), BASS_POS_BYTE);
    exit;
  end;

  if (Key = VK_PRIOR) then
  begin
    cutm1.Click;
    exit;
  end;

  if (Key = VK_F5) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    pflm2.Click;
    exit;
  end;

  if Key = (VK_F5) then
  begin
    Stop2.Click();
    exit;
  end;

  if (Key = VK_F6) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    pflm2.Click;
    exit;
  end;

  if Key = (VK_F6) then
  begin
    if (BASS_ChannelIsActive(Form1.m2) = 0) then Play2.Click();
    exit;
  end;

  if (Key = (VK_F7)) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    BASS_ChannelSetPosition(m2, BASS_ChannelGetPosition(m2, BASS_POS_BYTE)-1000, BASS_POS_BYTE);
    exit;
  end
  else if Key = (VK_F7) then
  begin
    BASS_ChannelSetPosition(m2, BASS_ChannelSeconds2Bytes(m2, BASS_ChannelBytes2Seconds(m2, BASS_ChannelGetPosition(m2, BASS_POS_BYTE)) - SKIPPREV), BASS_POS_BYTE);
    exit;
  end;

  if (Key = (VK_F8)) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    BASS_ChannelSetPosition(m2, BASS_ChannelGetPosition(m2, BASS_POS_BYTE)+1000, BASS_POS_BYTE);
    exit;
  end
  else if Key = (VK_F8) then
  begin
    BASS_ChannelSetPosition(m2, BASS_ChannelSeconds2Bytes(m2, BASS_ChannelBytes2Seconds(m2, BASS_ChannelGetPosition(m2, BASS_POS_BYTE)) + SKIPNEXT), BASS_POS_BYTE);
    exit;
  end;

  if (Key = ord('5')) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    fadem2.Click;
    exit;
  end;

  if (Key = ord('6')) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    brakem2.Click;
    exit;
  end;

  if (Key = ord('7')) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    BASS_ChannelSetPosition(pfl_m2, BASS_ChannelSeconds2Bytes(pfl_m2, BASS_ChannelBytes2Seconds(pfl_m2, BASS_ChannelGetPosition(pfl_m2, BASS_POS_BYTE)) - SKIPPREV), BASS_POS_BYTE);
    exit;
  end;

  if (Key = ord('8')) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    BASS_ChannelSetPosition(pfl_m2, BASS_ChannelSeconds2Bytes(pfl_m2, BASS_ChannelBytes2Seconds(pfl_m2, BASS_ChannelGetPosition(pfl_m2, BASS_POS_BYTE)) + SKIPNEXT), BASS_POS_BYTE);
    exit;
  end;

  if (Key = VK_NEXT) then
  begin
    cutm2.Click;
    exit;
  end;

  if (Key = VK_LEFT) then
  begin
    if(JingleChoice.ActivePageIndex<>0) then JingleChoice.ActivePageIndex := JingleChoice.ActivePageIndex - 1;
    JingleChoiceChange(nil);
    Handled := True;
    exit;
  end;

  if (Key = VK_RIGHT) then
  begin
    if((JingleChoice.PageCount-1)<>JingleChoice.ActivePageIndex) then JingleChoice.ActivePageIndex := JingleChoice.ActivePageIndex + 1;
    JingleChoiceChange(nil);
    Handled := True;
    exit;
  end;

  if (Key = VK_F9) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    pflj1.Click;
    exit;
  end;

  if Key = (VK_F9) then
  begin
    stopj1.Click();
    exit;
  end;

  if (Key = ord('9')) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    pausej1.Click;
    exit;
  end;

  if (Key = VK_F10) and
    (GetKeyState(VK_CONTROL) < 0) then
  begin
    pflj1.Click;
    exit;
  end;

  if Key = (VK_F10) then
  begin
    if (BASS_ChannelIsActive(Form1.j1) = 0) then playj1.Click();
    exit;
  end;

  if Key = (VK_F11) then
  begin
    Stopj2.Click();
    exit;
  end;

  if Key = (VK_F12) then
  begin
    Playj2.Click();
    exit;
  end;

  if (Form1.Active = True) then
  begin

    if (Key = VK_Numpad0) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      pflpad1.Click;
    end
    else if (Key = VK_Numpad0) then
    begin
      stoppad1.Click();
    end;

    if (Key = VK_Numpad1) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      Padpfl(StringGrid1.cells[5, 1]);
    end
    else if Key = (VK_Numpad1) then
    begin
      Pad(StringGrid1.cells[5, 1]);
    end;

    if (Key = VK_Numpad2) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      Padpfl(StringGrid1.cells[5, 2]);
    end
    else if Key = (VK_Numpad2) then
    begin
      Pad(StringGrid1.cells[5, 2]);
    end;

    if (Key = VK_Numpad3) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      Padpfl(StringGrid1.cells[5, 3]);
    end
    else if Key = (VK_Numpad3) then
    begin
      Pad(StringGrid1.cells[5, 3]);
    end;

    if (Key = VK_Numpad4) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      Padpfl(StringGrid1.cells[5, 4]);
    end
    else if Key = (VK_Numpad4) then
    begin
      Pad(StringGrid1.cells[5, 4]);
    end;

    if (Key = VK_Numpad5) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      Padpfl(StringGrid1.cells[5, 5]);
    end
    else if Key = (VK_Numpad5) then
    begin
      Pad(StringGrid1.cells[5, 5]);
    end;

    if (Key = VK_Numpad6) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      Padpfl(StringGrid1.cells[5, 6]);
    end
    else if Key = (VK_Numpad6) then
    begin
      Pad(StringGrid1.cells[5, 6]);
    end;

    if (Key = VK_Numpad7) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      Padpfl(StringGrid1.cells[5, 7]);
    end
    else if Key = (VK_Numpad7) then
    begin
      Pad(StringGrid1.cells[5, 7]);
    end;

    if (Key = VK_Numpad8) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      Padpfl(StringGrid1.cells[5, 8]);
    end
    else if Key = (VK_Numpad8) then
    begin
      Pad(StringGrid1.cells[5, 8]);
    end;

    if (Key = VK_Numpad9) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      Padpfl(StringGrid1.cells[5, 9]);
    end
    else if Key = (VK_Numpad9) then
    begin
      Pad(StringGrid1.cells[5, 9]);
    end;

    if (Key = Word('A')) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      //BASS_FX_TempoGet(Form1.m1, Tempo, Samplerate, Pitch);
      //Tempo := Tempo-1;
      //BASS_FX_TempoSet(Form1.m1, Tempo, Samplerate, Pitch);
      //Tempo1.Caption := FloatToStr(Tempo);
    end;

    if (Key = Word('Z')) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      //BASS_FX_TempoGet(Form1.m1, Tempo, Samplerate, Pitch);
      //Tempo := Tempo+1;
      //BASS_FX_TempoSet(Form1.m1, Tempo+1, Samplerate, Pitch);
      //Tempo1.Caption := FloatToStr(Tempo);
    end;

    if (Key = Word('Q')) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      //BASS_FX_TempoGet(Form1.m1, Tempo, Samplerate, Pitch);
      //Samplerate := Samplerate-100;
      //BASS_FX_TempoSet(Form1.m1, Tempo, Samplerate, Pitch);
      //SampleRate1.Caption := FloatToStr(Samplerate);
    end;

    if (Key = Word('S')) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      //BASS_FX_TempoGet(Form1.m1, Tempo, Samplerate, Pitch);
      //Samplerate := Samplerate+100;
      //BASS_FX_TempoSet(Form1.m1, Tempo, Samplerate, Pitch);
      //SampleRate1.Caption := FloatToStr(Samplerate);
    end;

    if (Key = Word('I')) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      //BASS_FX_TempoGet(Form1.m2, Tempo, Samplerate, Pitch);
      //Tempo := Tempo-1;
      //BASS_FX_TempoSet(Form1.m2, Tempo-1, Samplerate, Pitch);
      //Tempo2.Caption := FloatToStr(Tempo);
    end;

    if (Key = Word('O')) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      //BASS_FX_TempoGet(Form1.m2, Tempo, Samplerate, Pitch);
      //Tempo := Tempo+1;
      //BASS_FX_TempoSet(Form1.m2, Tempo+1, Samplerate, Pitch);
      //Tempo2.Caption := FloatToStr(Tempo);
    end;

    if (Key = Word('K')) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      //BASS_FX_TempoGet(Form1.m2, Tempo, Samplerate, Pitch);
      //Samplerate := Samplerate-100;
      //BASS_FX_TempoSet(Form1.m2, Tempo, Samplerate, Pitch);
      //SampleRate2.Caption := FloatToStr(Samplerate);
    end;

    if (Key = Word('L')) and
      (GetKeyState(VK_CONTROL) < 0) then
    begin
      //BASS_FX_TempoGet(Form1.m2, Tempo, Samplerate, Pitch);
      //Samplerate := Samplerate+100;
      //BASS_FX_TempoSet(Form1.m2, Tempo, Samplerate, Pitch);
      //SampleRate2.Caption := FloatToStr(Samplerate);
    end;

  end;

  if Key = (VK_Pause) then
  begin
    Events.diffuser.Click();
    exit;
  end;

  if Key = (VK_Delete) then
  begin
    BASS_ChannelStop(pub1); // Stop
    BASS_StreamFree(pub1); // Test libération mémoire
    Clock.decompte.Caption := '00:00:00';

    if (retourpub.Tag = 1) then
    begin
      playj1.Click(); // Jingle
    end;

    //Handled := True;
    exit;

  end;


end;

procedure TForm1.Pointdecue1Click(Sender: TObject);
begin
  if (Player1Filename <> '') then
  begin
    //Editor.Tag := 1;
    //Editor.filename := Player1Filename;
    //Editor.Show;
    //Editor.PlayFile;
  end;
end;

procedure TForm1.Pointdecue2Click(Sender: TObject);
begin
  if (Player2Filename <> '') then
  begin
    //Editor.Tag := 2;
    //Editor.filename := Player2Filename;
    //Editor.Show;
    //Editor.PlayFile;
  end;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, SC_MOVE or HTCAPTION, 0);
end;

procedure TForm1.Play1Click(Sender: TObject);
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  DateWaitlist: string;
begin
  if p1 = 1 then
  begin
  // Reprise de Pause (p)
    BASS_SetDevice(StrToInt(DSC1CART));
    BASS_ChannelPlay(m1, False);
    Play1.Enabled := False;
    p1 := 0; // remise à zéro
  end
  else
  begin
  // Play Classique

    BASS_ChannelSetPosition(m1, BASS_ChannelSeconds2Bytes(m1, strtofloat(StringReplace(cue1.Text, '.', ',', [rfReplaceAll]))), BASS_POS_BYTE);
    BASS_Mixer_StreamAddChannel(mixer, m1, 0);
    BASS_SetDevice(StrToInt(DSC1CART));
    //BASS_ChannelSetAttributes(m1, -1, (100 - TrackBar1.position * (9 div 2)), -101);

    if BASS_ChannelPlay(m1, False) then
    begin
    // FICHIER LU
      SyncEndHandle := BASS_ChannelSetSync(m1, BASS_SYNC_END, 0, @m1_sync, MessageHandle);
      Timer6.Enabled := True; // vumètre
      Timer5.Enabled := True; // compteurs
      Playlist1.Enabled := False; // Playlist
      Waitlist1.Enabled := False; // Waitlist
      Play1.Enabled := False;
      Panel1.Color := $0000FE;

    end
    else
    begin
    // FICHIER PAS LU
      Error('Player 1 : Play error');
    end;

    Main.sql.Query('UPDATE waitlist SET Joue=1 WHERE id=' + player1[14] + ';');
    Main.sql.query('INSERT INTO log SET PlaylistID=' + player1[1] + ', Date_Joue=NOW();');

    Main.IsLoad1 := False;

{
//  VOICE TRACK
}

    if (player1[12] = 'INTERVENTION') then
    begin

  // Sélectionner l'intro du prochain titre

      if (Main.sql.Connected) then
      begin

        DateWaitlist := FormatDateTime('yyyy-mm-dd hh:00:00', Now);
        Res := Main.sql.Query('SELECT Id, Artiste, Titre, Annee, Duree, Frequence, Tempo, Intro, FadeIn, FadeOut, Path, Categorie, ssCategorie FROM waitlist WHERE Date_Play=''' + DateWaitlist + ''' AND Joue=''0'' ORDER by Id ASC LIMIT 0,1;');
        Row := Main.sql.fetch_row(Res);

        if Row = nil then
        begin
          Error('Pas de titre après le voicetrack ' + DateWaitlist);
        end
        else
        begin
          Main.IntroNextTitle := StrToFloat(StringReplace(Row[7], '.', ',', [rfReplaceAll]));
          Main.sql.free_result(Res);
        end;
      end;
    end
    else
    begin
      Main.IntroNextTitle := 0;
    end;

{
//  VOICE TRACK
}

  end;
end;

procedure TForm1.Stop1Click(Sender: TObject);
var
  StartPosBytes: Integer;
begin

    // Stop
  BASS_ChannelStop(m1);
    // Remettre le pointeur

  if 1 = 1 then
  begin
    if cue1.Text <> '0' then
    begin
      StartPosBytes := BASS_ChannelSeconds2Bytes(m1, strtofloat(StringReplace(cue1.Text, '.', ',', [rfReplaceAll])));
      BASS_ChannelSetPosition(m1, StartPosBytes, BASS_POS_BYTE);
    end;
  end;

  Timer5.enabled := False; // compteurs off
  Timer6.Enabled := False; // vumètres off

  Gauge1.Progress := 0; // Intro stop
  Gauge1.visible := false; // Désactiver intro

  RLed1.Position := 0; // stop vumetre left
  RLed2.Position := 0; // stop vumetre right

  Gauge2.Progress := 0; // Avancement stop
  status1.Position := 0; // Avancement stop

  Playlist1.Enabled := True; // Playlist
  Waitlist1.Enabled := True; // Waitlist

  Play1.Enabled := True;
  Panel1.Color := $00FF8081;

  Timer5.Interval := 1; // reset du timer5 (infos longueur.)

  // Re Activation de la Gauge
  if (player1[8] <> '0') then
  begin
    Gauge1.visible := true;
  end;
end;

procedure TForm1.Pause1Click(Sender: TObject);
begin
  if BASS_ChannelIsActive(m1) = 1 then
  begin
    p1 := 1;
    BASS_ChannelPause(m1); // Pause
    Play1.Enabled := True;
  end;
end;

procedure TForm1.fadem1Click(Sender: TObject);
begin
// FADE MUSIC1 (TESTING)
  BASS_ChannelSlideAttribute(m1, BASS_ATTRIB_VOL, 0, 3000);
end;

procedure TForm1.brakem1Click(Sender: TObject);
begin
// FADE MUSIC1 (TESTING)
  //BASS_ChannelSlideAttributes(m1, 100, -2, -101, 3000);
end;

procedure TForm1.Playlist1Click(Sender: TObject);
var
  Verif: Cardinal;
begin
  if ((Sender as TJvImgBtn).Tag = 1) then
  begin
    Verif := m1;
  end
  else
    Verif := m2;
  begin
  end;


  if BASS_ChannelIsActive(Verif) = 1 then
  begin
    ShowMessage('Ce player est en cours d''execution...');
  end
  else
  begin
    bibliotheque.SenderBib := (Sender as TJvImgBtn).Tag;
    bibliotheque.ShowModal;
  end;
end;

procedure TForm1.Waitlist1Click(Sender: TObject);
var
  Verif: Cardinal;
begin
  if ((Sender as TJvImgBtn).Tag = 1) then
  begin
    Verif := m1;
  end
  else
    Verif := m2;
  begin
  end;


  if BASS_ChannelIsActive(Verif) = 1 then
  begin
    ShowMessage('Ce player est en cours d''execution...');
  end
  else
  begin
    Waitlist.SenderBib := (Sender as TJvImgBtn).Tag;
    Waitlist.ShowModal;
  end;
end;

procedure TForm1.pflm1Click(Sender: TObject);
begin
  if (pflm1.Tag = 0) then
  begin
    pflm1.Tag := 1;
    pflm1.ImageIndex := 161;
    pflm1.Caption := 'Stop';
    BASS_ChannelSetPosition(pfl_m1, BASS_ChannelSeconds2Bytes(pfl_m1, strtofloat(StringReplace(cue1.Text, '.', ',', [rfReplaceAll]))), BASS_POS_BYTE);
    BASS_SetDevice(StrToInt(CUE1CART));
    BASS_ChannelPlay(pfl_m1, False);
    SyncEndHandle := BASS_ChannelSetSync(pfl_m1, BASS_SYNC_END, 0, @m1_pfl_sync, MessageHandle);
    status1.Max := BASS_ChannelGetLength(pfl_m1, BASS_POS_BYTE) div 100000;
    timerpflm1.Enabled := True;
  end
  else
  begin
    m1_pfl_stop();
  end;
end;

procedure TForm1.cutm1Click(Sender: TObject);
var
  Temps: Single;
begin
  Temps := BASS_ChannelBytes2Seconds(pfl_m1, BASS_ChannelGetPosition(pfl_m1, BASS_POS_BYTE));
  cue1.Text := format('%.2f', [Temps]);
end;

procedure TForm1.fadem2Click(Sender: TObject);
begin
// FADE MUSIC1 (TESTING)
  BASS_ChannelSlideAttribute(m2, BASS_ATTRIB_VOL, 0, 3000);
end;

procedure TForm1.brakem2Click(Sender: TObject);
begin
// FADE MUSIC1 (TESTING)
  //BASS_ChannelSlideAttributes(m2, 100, -2, -101, 3000);
end;

procedure TForm1.Stop2Click(Sender: TObject);
var
  StartPosBytes: Integer;
begin

    // Stop
  BASS_ChannelStop(m2);
    // Remettre le pointeur

  if 1 = 1 then
  begin
    if cue2.Text <> '0' then
    begin
      StartPosBytes := BASS_ChannelSeconds2Bytes(m1, strtofloat(StringReplace(cue2.Text, '.', ',', [rfReplaceAll])));
      BASS_ChannelSetPosition(m2, StartPosBytes, BASS_POS_BYTE);
    end;
  end;

  Timer3.enabled := False; // compteurs off
  Timer10.Enabled := False; // vumètres off

  Gauge3.Progress := 0; // Intro stop
  Gauge3.visible := false; // Désactiver intro

  Gauge4.Progress := 0; // Avancement stop
  status2.Position := 0; // Avancement stop

  RLed3.Position := 0; // stop vumetre left
  RLed4.Position := 0; // stop vumetre right

  Playlist2.Enabled := True; // Playlist
  Waitlist2.Enabled := True; // Waitlist

  Play2.Enabled := True;
  Panel21.Color := $00FF8081;

  Timer3.Interval := 1; // reset du timer5 (infos longueur.)

  // Re Activation de la Gauge
  if (player2[8] <> '0') then
  begin
    Gauge3.visible := true;
  end;
end;

procedure TForm1.Play2Click(Sender: TObject);
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  DateWaitlist: string;
begin
  if p2 = 1 then
  begin
  // Reprise de Pause (p)
    BASS_SetDevice(StrToInt(DSC2CART));
    BASS_ChannelPlay(m2, False);
    Play2.Enabled := False;
    p2 := 0; // remise à zéro
  end
  else
  begin
  // Play Classique

    BASS_ChannelSetPosition(m2, BASS_ChannelSeconds2Bytes(m2, strtofloat(StringReplace(cue2.Text, '.', ',', [rfReplaceAll]))), BASS_POS_BYTE);
    BASS_SetDevice(StrToInt(DSC2CART));
    BASS_Mixer_StreamAddChannel(mixer, m2, 0);
    //BASS_ChannelSetAttributes(m1, -1, (100 - TrackBar1.position * (9 div 2)), -101);

    if BASS_ChannelPlay(m2, False) then
    begin
    // FICHIER LU
      SyncEndHandle := BASS_ChannelSetSync(m2, BASS_SYNC_END, 0, @m2_sync, MessageHandle);
      Timer3.Enabled := True; // vumètre
      Timer10.Enabled := True; // compteurs
      Playlist2.Enabled := False; // Playlist
      Waitlist2.Enabled := False; // Waitlist
      Play2.Enabled := False;
      Panel21.Color := $0000FE;

    end
    else
    begin
    // FICHIER PAS LU
      Error('Player 2 : Play error');
    end;

    Main.sql.Query('UPDATE waitlist SET Joue=1 WHERE id=' + player2[14] + ';');
    Main.sql.query('INSERT INTO log SET PlaylistID=' + player2[1] + ', Date_Joue=NOW();');
    Main.IsLoad2 := False;

{
//  VOICE TRACK
}

    if (player1[12] = 'INTERVENTION') then
    begin

  // Sélectionner l'intro du prochain titre

      if (Main.sql.Connected) then
      begin

        DateWaitlist := FormatDateTime('yyyy-mm-dd hh:00:00', Now);
        Res := Main.sql.Query('SELECT Id, Artiste, Titre, Annee, Duree, Frequence, Tempo, Intro, FadeIn, FadeOut, Path, Categorie, ssCategorie FROM waitlist WHERE Date_Play=''' + DateWaitlist + ''' AND Joue=''0'' ORDER by Id ASC LIMIT 0,1;');
        Row := Main.sql.fetch_row(Res);

        if Row = nil then
        begin
          Error('Pas de titre après le voicetrack ' + DateWaitlist);
        end
        else
        begin
          Main.IntroNextTitle := StrToFloat(StringReplace(Row[7], '.', ',', [rfReplaceAll]));
          Main.sql.free_result(Res);
        end;
      end;
    end
    else
    begin
      Main.IntroNextTitle := 0;
    end;

{
//  VOICE TRACK
}


  end;
end;

procedure TForm1.Pause2Click(Sender: TObject);
begin
  if BASS_ChannelIsActive(m2) = 1 then
  begin
    p2 := 1;
    BASS_ChannelPause(m2); // Pause
    Play2.Enabled := True;
  end;
end;

procedure TForm1.pflm2Click(Sender: TObject);
begin
  if (pflm2.Tag = 0) then
  begin
    pflm2.Tag := 1;
    pflm2.ImageIndex := 161;
    pflm2.Caption := 'Stop';
    BASS_ChannelSetPosition(pfl_m2, BASS_ChannelSeconds2Bytes(pfl_m2, strtofloat(StringReplace(cue2.Text, '.', ',', [rfReplaceAll]))), BASS_POS_BYTE);
    BASS_SetDevice(StrToInt(CUE1CART));
    BASS_ChannelPlay(pfl_m2, False);
    SyncEndHandle := BASS_ChannelSetSync(pfl_m2, BASS_SYNC_END, 0, @m2_pfl_sync, MessageHandle);
    status2.Max := BASS_ChannelGetLength(pfl_m2, BASS_POS_BYTE) div 100000;
    timerpflm2.Enabled := True;
  end
  else
  begin
    m2_pfl_stop();
  end;
end;

procedure TForm1.cutm2Click(Sender: TObject);
var
  Temps: Single;
begin
  Temps := BASS_ChannelBytes2Seconds(pfl_m2, BASS_ChannelGetPosition(pfl_m2, BASS_POS_BYTE));
  cue2.Text := format('%.2f', [Temps]);
end;

procedure TForm1.Stopj1Click(Sender: TObject);
begin
  BASS_ChannelStop(j1); // Stop
  BASS_StreamFree(j1); // Libération mémoire

  Timer8.enabled := False; // compteurs off
  Timer7.Enabled := False; // vumètres off

  RLed5.Position := 0; // stop vumetre left
  RLed6.Position := 0; // stop vumetre right

  Timer8.Interval := 1; // reset du timer5 (infos longueur.)
  Label13.Caption := '0,00';

  playj1.Enabled := True;

  if (retourpub.Tag = 1) then retourpub.Click;
end;

procedure TForm1.Playj1Click(Sender: TObject);
var Path: string;
begin

  if p3 = 1 then
  begin
  // Reprise de Pause (j)
    BASS_SetDevice(StrToInt(JIN1CART));
    BASS_ChannelPlay(j1, False);
    playj1.Enabled := False;
    p3 := 0; // remise à zéro
  end
  else
  begin
  // Play Classique

    stopj1.OnClick(sender); // STOP

    Path := StringGrid2.cells[4, StringGrid2.Row]; // FICHIER ?

    BASS_SetDevice(StrToInt(JIN1CART));
    j1 := BASS_StreamCreateFile(False, Pchar(Path), 0, 0, flags[StrToInt(JIN1CHAN)]); // Mode normal

    if BASS_ChannelPlay(j1, False) then
    begin
  // FICHIER LU
      SyncEndHandle := BASS_ChannelSetSync(j1, BASS_SYNC_END, 0, @j1_sync, MessageHandle);
      playj1.Enabled := False;
      //BASS_ChannelSetAttributes(j1, -1, (100 - TrackBar2.position * (9 div 2)), -101);
      Timer7.Enabled := True; // vumètre
      Timer8.Enabled := True; // compteurs

    end
    else
    begin
  // FICHIER PAS LU
      Error('Jingle : ' + StringGrid2.cells[4, StringGrid2.Row]);

    end;

  end;
end;

procedure TForm1.Pausej1Click(Sender: TObject);
begin
  if BASS_ChannelIsActive(j1) = 1 then
  begin
    p3 := 1;
    BASS_ChannelPause(j1); // Pause
    playj1.Enabled := True;
  end;
end;

procedure TForm1.pflj1Click(Sender: TObject);
begin

  if (pflj1.Tag = 0) then
  begin
    pflj1.Tag := 1;
    pflj1.ImageIndex := 161;
    pflj1.Caption := 'Stop';
    BASS_ChannelStop(pfl_j1);
    BASS_StreamFree(pfl_j1);
    BASS_SetDevice(StrToInt(CUE1CART));
    pfl_j1 := BASS_StreamCreateFile(False, Pchar(StringGrid2.cells[4, StringGrid2.Row]), 0, 0, flags[StrToInt(CUE1CHAN)]);
    BASS_ChannelPlay(pfl_j1, False);
    SyncEndHandle := BASS_ChannelSetSync(pfl_j1, BASS_SYNC_END, 0, @j1_pfl_sync, MessageHandle);
  end
  else
  begin
    j1_pfl_stop();
  end;

end;

procedure TForm1.Stoppad1Click(Sender: TObject);
begin
  BASS_ChannelStop(pad1);
  BASS_StreamFree(pad1);

  Timer9.enabled := False; // compteurs off
  Timer12.Enabled := False; // vumètres off

  RLed9.Position := 0; // stop vumetre left
  RLed10.Position := 0; // stop vumetre right

  Timer12.Interval := 1; // reset du timer5 (infos longueur.)
  Label40.Caption := '0,00';
end;

procedure TForm1.pflpad1Click(Sender: TObject);
begin
  if (pflpad1.Tag = 0) then
  begin
    Padpfl(StringGrid1.cells[5, StringGrid1.Row]);
  end
  else
  begin
    pad1_pfl_stop();
  end;
end;

procedure TForm1.RestaurerClick(Sender: TObject);
var
  FichierIni: TIniFile;
begin
  if (not OpenDialog2.Execute) then
    Exit;

  FichierIni := TIniFile.Create(OpenDialog2.FileName);

  StringGrid1.Cells[3, 1] := FichierIni.ReadString('Numpad1', 'Artiste', '');
  StringGrid1.Cells[4, 1] := FichierIni.ReadString('Numpad1', 'Duree', '');
  StringGrid1.Cells[5, 1] := FichierIni.ReadString('Numpad1', 'Filepath', '');

  StringGrid1.Cells[3, 2] := FichierIni.ReadString('Numpad2', 'Artiste', '');
  StringGrid1.Cells[4, 2] := FichierIni.ReadString('Numpad2', 'Duree', '');
  StringGrid1.Cells[5, 2] := FichierIni.ReadString('Numpad2', 'Filepath', '');

  StringGrid1.Cells[3, 3] := FichierIni.ReadString('Numpad3', 'Artiste', '');
  StringGrid1.Cells[4, 3] := FichierIni.ReadString('Numpad3', 'Duree', '');
  StringGrid1.Cells[5, 3] := FichierIni.ReadString('Numpad3', 'Filepath', '');

  StringGrid1.Cells[3, 4] := FichierIni.ReadString('Numpad4', 'Artiste', '');
  StringGrid1.Cells[4, 4] := FichierIni.ReadString('Numpad4', 'Duree', '');
  StringGrid1.Cells[5, 4] := FichierIni.ReadString('Numpad4', 'Filepath', '');

  StringGrid1.Cells[3, 5] := FichierIni.ReadString('Numpad5', 'Artiste', '');
  StringGrid1.Cells[4, 5] := FichierIni.ReadString('Numpad5', 'Duree', '');
  StringGrid1.Cells[5, 5] := FichierIni.ReadString('Numpad5', 'Filepath', '');

  StringGrid1.Cells[3, 6] := FichierIni.ReadString('Numpad6', 'Artiste', '');
  StringGrid1.Cells[4, 6] := FichierIni.ReadString('Numpad6', 'Duree', '');
  StringGrid1.Cells[5, 6] := FichierIni.ReadString('Numpad6', 'Filepath', '');

  StringGrid1.Cells[3, 7] := FichierIni.ReadString('Numpad7', 'Artiste', '');
  StringGrid1.Cells[4, 7] := FichierIni.ReadString('Numpad7', 'Duree', '');
  StringGrid1.Cells[5, 7] := FichierIni.ReadString('Numpad7', 'Filepath', '');

  StringGrid1.Cells[3, 8] := FichierIni.ReadString('Numpad8', 'Artiste', '');
  StringGrid1.Cells[4, 8] := FichierIni.ReadString('Numpad8', 'Duree', '');
  StringGrid1.Cells[5, 8] := FichierIni.ReadString('Numpad8', 'Filepath', '');

  StringGrid1.Cells[3, 9] := FichierIni.ReadString('Numpad9', 'Artiste', '');
  StringGrid1.Cells[4, 9] := FichierIni.ReadString('Numpad9', 'Duree', '');
  StringGrid1.Cells[5, 9] := FichierIni.ReadString('Numpad9', 'Filepath', '');

  FichierIni.Free;
end;

procedure TForm1.SauverClick(Sender: TObject);
var
  FichierIni: TIniFile;
begin
  if (not SaveDialog1.Execute) then
    Exit;

  FichierIni := TIniFile.Create(SaveDialog1.FileName);

  FichierIni.WriteString('Numpad1', 'Artiste', StringGrid1.cells[3, 1]);
  FichierIni.WriteString('Numpad1', 'Duree', StringGrid1.cells[4, 1]);
  FichierIni.WriteString('Numpad1', 'Filepath', StringGrid1.cells[5, 1]);

  FichierIni.WriteString('Numpad2', 'Artiste', StringGrid1.cells[3, 2]);
  FichierIni.WriteString('Numpad2', 'Duree', StringGrid1.cells[4, 2]);
  FichierIni.WriteString('Numpad2', 'Filepath', StringGrid1.cells[5, 2]);

  FichierIni.WriteString('Numpad3', 'Artiste', StringGrid1.cells[3, 3]);
  FichierIni.WriteString('Numpad3', 'Duree', StringGrid1.cells[4, 3]);
  FichierIni.WriteString('Numpad3', 'Filepath', StringGrid1.cells[5, 3]);

  FichierIni.WriteString('Numpad4', 'Artiste', StringGrid1.cells[3, 4]);
  FichierIni.WriteString('Numpad4', 'Duree', StringGrid1.cells[4, 4]);
  FichierIni.WriteString('Numpad4', 'Filepath', StringGrid1.cells[5, 4]);

  FichierIni.WriteString('Numpad5', 'Artiste', StringGrid1.cells[3, 5]);
  FichierIni.WriteString('Numpad5', 'Duree', StringGrid1.cells[4, 5]);
  FichierIni.WriteString('Numpad5', 'Filepath', StringGrid1.cells[5, 5]);

  FichierIni.WriteString('Numpad6', 'Artiste', StringGrid1.cells[3, 6]);
  FichierIni.WriteString('Numpad6', 'Duree', StringGrid1.cells[4, 6]);
  FichierIni.WriteString('Numpad6', 'Filepath', StringGrid1.cells[5, 6]);

  FichierIni.WriteString('Numpad7', 'Artiste', StringGrid1.cells[3, 7]);
  FichierIni.WriteString('Numpad7', 'Duree', StringGrid1.cells[4, 7]);
  FichierIni.WriteString('Numpad7', 'Filepath', StringGrid1.cells[5, 7]);

  FichierIni.WriteString('Numpad8', 'Artiste', StringGrid1.cells[3, 8]);
  FichierIni.WriteString('Numpad8', 'Duree', StringGrid1.cells[4, 8]);
  FichierIni.WriteString('Numpad8', 'Filepath', StringGrid1.cells[5, 8]);

  FichierIni.WriteString('Numpad9', 'Artiste', StringGrid1.cells[3, 9]);
  FichierIni.WriteString('Numpad9', 'Duree', StringGrid1.cells[4, 9]);
  FichierIni.WriteString('Numpad9', 'Filepath', StringGrid1.cells[5, 9]);

  FichierIni.Free;
end;

procedure TForm1.LoadClick(Sender: TObject);

var
  Titre, Path, Extension: string;
  DureeFull: Single;
begin
  if (not OpenDialog1.Execute) then
    Exit;

  Extension := ExtractFileExt(OpenDialog1.FileName);
  if ((Extension = '.mp3') or (Extension = '.MP3')) then
  begin
    InfoMP31.GetMP3Info(OpenDialog1.FileName);
    Titre := trim(InfoMP31.Titre);
    //DureeFull := InfoMP31.duree.full;
  end;

  if (pflpad1.Tag = 1) then pflpad1.Click();

  pfl_pad1 := BASS_StreamCreateFile(False, PChar(OpenDialog1.FileName), 0, 0, 0);
  DureeFull := BASS_ChannelBytes2Seconds(pfl_pad1, BASS_ChannelGetLength(pfl_pad1, BASS_POS_BYTE));

    // Protection tags vides..

  if (Titre = '') then // un coup de trim ici aussi si non.. :)
  begin
    path := GetFirstToken(GetLastToken(OpenDialog1.FileName, '\'), '.');
    //Artiste := Trim(GetFirstToken(path, '-'));
    Titre := Trim(GetLastToken(path, '-'));
  end;

  StringGrid1.Cells[3, StringGrid1.Row] := Titre;
  StringGrid1.Cells[4, StringGrid1.Row] := format('%2.2d:%2.2d', [trunc(DureeFull) div 60, trunc(DureeFull) mod 60]);
  StringGrid1.Cells[5, StringGrid1.Row] := OpenDialog1.FileName;

  BASS_StreamFree(pfl_pad1); // Test libération mémoire

end;

procedure TForm1.stopj2Click(Sender: TObject);
begin
  BASS_ChannelStop(j2); // Stop
  BASS_StreamFree(j2); // Test libération mémoire

  Timer1.enabled := False; // compteurs off
  Timer11.Enabled := False; // vumètres off

  RLed7.Position := 0; // stop vumetre left
  RLed8.Position := 0; // stop vumetre right

  Gauge14.Progress := 0; // Avancement stop
  Timer1.Interval := 1; // reset du timer5 (infos longueur.)
  Label5.Caption := '0,00';

  Padactuel.Text := '';
end;

procedure TForm1.Playj2Click(Sender: TObject);
var Path: string;
begin

  if p4 = 1 then
  begin
  // Reprise de Pause (j)
    BASS_SetDevice(StrToInt(JIN2CART));
    BASS_ChannelPlay(j2, False);
    p4 := 0; // remise à zéro
  end
  else
  begin
  // Play Classique

    Trackbar4.Position := 0;
    Stopj2.OnClick(sender); // STOP
    Path := StringGrid3.cells[4, 0]; // FICHIER ?

    BASS_SetDevice(StrToInt(JIN2CART));
    j2 := BASS_StreamCreateFile(False, Pchar(Path), 0, 0, flags[StrToInt(JIN2CHAN)]); // Mode normal
    //BASS_ChannelSetAttributes(j2, -1, (100 - TrackBar4.position * (9 div 2)), -101);

    if BASS_ChannelPlay(j2, False) then
    begin
  // FICHIER LU
      SyncEndHandle := BASS_ChannelSetSync(j2, BASS_SYNC_END, 0, @j2_sync, MessageHandle);
      Timer1.Enabled := True; // vumètre
      Timer11.Enabled := True; // compteurs
      Padactuel.Text := StringGrid3.cells[2, 0];

      if (StringGrid3.RowCount <> 1) then
      begin
        GridDeleteRow(0, StringGrid3);
        isg3 := (isg3 - 1);
      end
      else
      begin
        StringGrid3.Rows[0].Clear;
        isg3 := 0;
      end;
    end
    else
    begin
  // FICHIER PAS LU
      Error('Sampler : ' + StringGrid3.cells[4, StringGrid3.Row]);
    end;
  end;
end;

procedure TForm1.PadUpClick(Sender: TObject);
begin
  if(StringGrid3.Row<>0) then TStringGridX(StringGrid3).MoveRow(StringGrid3.Row, StringGrid3.Row - 1);
end;

procedure TForm1.PadDeleteClick(Sender: TObject);
begin
  if (StringGrid3.RowCount <> 1) then
  begin
    GridDeleteRow(StringGrid3.Row, StringGrid3);
    isg3 := (isg3 - 1);
  end
  else
  begin
    StringGrid3.Rows[StringGrid3.Row].Clear;
    isg3 := 0;
  end;
end;

procedure TForm1.PadDownClick(Sender: TObject);
begin
  if((StringGrid3.RowCount-1)<>StringGrid3.Row) then TStringGridX(StringGrid3).MoveRow(StringGrid3.Row, StringGrid3.Row + 1);
end;

procedure TForm1.retourpubClick(Sender: TObject);
begin
  if (retourpub.Tag = 0) then
  begin
    retourpub.Tag := 1;
    retourpub.ImageIndex := 103;
  end
  else
  begin
    retourpub.Tag := 0;
    retourpub.ImageIndex := 104;
  end;
end;

procedure TForm1.StringGrid1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = StringGrid2);
end;

procedure TForm1.StringGrid1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  ShowMessage(Sender.ClassName);
end;

procedure TForm1.StringGrid2DblClick(Sender: TObject);
begin
  StringGrid2.DragMode := dmAutomatic;
end;

procedure TForm1.StringGrid2EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (Sender <> Target) then StringGrid2.DragMode := dmManual;
end;

procedure TForm1.StringGrid1EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  StringGrid2.DragMode := dmManual;
end;

procedure TForm1.Effacer1Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 3 to StringGrid1.ColCount - 1 do
  begin
    StringGrid1.Cells[i, StringGrid1.Row] := '';
  end;
end;


procedure TForm1.Proteger1Click(Sender: TObject);
begin
if(Proteger1.Checked)  then
begin
Proteger1.Checked:=False;
end
else
begin
Proteger1.Checked:=True;
end
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil( fCriticalSection );
end;

end.

