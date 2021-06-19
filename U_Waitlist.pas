unit U_Waitlist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, MysqlComponent, BASS, ComCtrls,
  ExtCtrls, JvExComCtrls, JvComCtrls;

type
  TWaitlist = class(TForm)
    Waitlist: TBitBtn;
    StringGrid1: TStringGrid;
    Play: TBitBtn;
    Stop: TBitBtn;
    StatusBar1: TStatusBar;
    WaitlistFromHour: TBitBtn;
    status1: TJvTrackBar;
    TimerPFL: TTimer;
    titre: TLabel;
    procedure WaitlistClick(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure PlayClick(Sender: TObject);
    procedure StopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WaitlistFromHourClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure TimerPFLTimer(Sender: TObject);
    procedure status1Changed(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    SenderBib: Integer;
    Preecoute: Integer;
  end;

var
  Waitlist: TWaitlist;

implementation

uses U_Splash, Unit1, U_Main;

{$R *.dfm}

procedure TWaitlist.WaitlistClick(Sender: TObject);
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  i, j: integer;
  DateWaitlist, RequestSQL: string;
  Duree : Double;
begin

  for i := 0 to StringGrid1.Rowcount - 1 do
  begin
    StringGrid1.Rows[i].clear;
  end;
  StringGrid1.rowcount := 1;

  if (Main.sql.Connected) then
  begin
    DateWaitlist := FormatDateTime('yyyy-mm-dd', Now);

    RequestSQL:='SELECT playlist.Id, DATE_FORMAT(waitlist.Date_Play, ''%Y-%m-%d'') AS Day, DATE_FORMAT(waitlist.Date_Play, ''%H'') AS Hour, artistes.Name, playlist.Titre, playlist.Annee, playlist.Duree, waitlist.Frequence, ';
    RequestSQL:=RequestSQL+'waitlist.Tempo, waitlist.Intro, waitlist.FadeIn, waitlist.FadeOut, playlist.Path, playlist.Categorie, ';
    RequestSQL:=RequestSQL+'playlist.ssCategorie, playlist.Duree ';
    RequestSQL:=RequestSQL+'FROM waitlist ';
    RequestSQL:=RequestSQL+'LEFT JOIN playlist ON (playlist.id=waitlist.PlaylistID) ';
    RequestSQL:=RequestSQL+'LEFT JOIN artistes ON (artistes.id=playlist.Artiste) ';
    RequestSQL:=RequestSQL+'WHERE waitlist.Date_Play LIKE ''' + DateWaitlist + '%'' AND waitlist.Joue=0 ORDER by waitlist.Id, waitlist.Date_Play ASC;';

    Res := Main.sql.Query(RequestSQL);

    if Res = nil then StatusBar1.Panels[0].Text := 'Pas de programmation'
    else
    try

      StringGrid1.Show;
      StringGrid1.ColCount := 16;
      StringGrid1.RowCount := Main.sql.num_rows(Res);

      StringGrid1.ColWidths[0] := 0;
      StringGrid1.ColWidths[1] := 70;
      StringGrid1.ColWidths[2] := 20;
      StringGrid1.ColWidths[3] := 360;
      StringGrid1.ColWidths[4] := 360;
      StringGrid1.ColWidths[5] := 45;
      StringGrid1.ColWidths[6] := 40;
      StringGrid1.ColWidths[7] := 0;
      StringGrid1.ColWidths[8] := 0;
      StringGrid1.ColWidths[9] := 0;
      StringGrid1.ColWidths[10] := 0;
      StringGrid1.ColWidths[11] := 0;
      StringGrid1.ColWidths[12] := 0;
      StringGrid1.ColWidths[13] := 0;
      StringGrid1.ColWidths[14] := 0;
      StringGrid1.ColWidths[15] := 0;

      j := 0;
      Row := Main.sql.fetch_row(Res);
      while Row <> nil do
      begin
        for i := 0 to StringGrid1.ColCount do
        begin
          if ((i = 6) and (Row[i] <> '0')) then
          begin
            Duree := StrToFloat(StringReplace(Row[i], '.', ',', [rfReplaceAll]));
            StringGrid1.Cells[i, j] := format('%2.2d:%2.2d', [trunc(Duree) div 60, trunc(Duree) mod 60]);
          end
          else
          begin
            StringGrid1.Cells[i, j] := Row[i]; // La cellule en MAJ.
          end;
        end;
        Row := Main.sql.fetch_row(Res);
        j := j + 1;
      end;
    finally
      Main.sql.free_result(Res);
    end;
  end;
end;

procedure TWaitlist.StringGrid1DblClick(Sender: TObject);
begin
  // Id, Artiste, Titre, Annee, Duree, Frequence, Tempo, Intro, FadeIn, FadeOut, Path

  case SenderBib of
    1: begin
        Form1.player1[1] := StringGrid1.cells[0, StringGrid1.Row]; // ID
        Form1.player1[2] := StringGrid1.cells[3, StringGrid1.Row]; // ARTISTE
        Form1.player1[3] := StringGrid1.cells[4, StringGrid1.Row]; // TITRE
        Form1.player1[4] := StringGrid1.cells[5, StringGrid1.Row]; // Année
        Form1.player1[5] := StringGrid1.cells[15, StringGrid1.Row]; // Duree
        Form1.player1[6] := StringGrid1.cells[7, StringGrid1.Row]; // Frequence ?
        Form1.player1[7] := StringGrid1.cells[8, StringGrid1.Row]; // Tempo ?
        Form1.player1[8] := StringGrid1.cells[9, StringGrid1.Row]; // Intro
        Form1.player1[9] := StringGrid1.cells[10, StringGrid1.Row]; // Fade IN ?
        Form1.player1[10] := StringGrid1.cells[11, StringGrid1.Row]; // Fade Out
        Form1.player1[11] := StringGrid1.cells[12, StringGrid1.Row]; // Fichier ?
        Form1.player1[12] := StringGrid1.cells[13, StringGrid1.Row]; // Cat ?
        Form1.player1[13] := StringGrid1.cells[14, StringGrid1.Row]; // ssCat ?
        Form1.LoadPlayer1(StringGrid1.cells[0, StringGrid1.Row]);
      end;

    2: begin
        Form1.player2[1] := StringGrid1.cells[0, StringGrid1.Row]; // ID
        Form1.player2[2] := StringGrid1.cells[3, StringGrid1.Row]; // ARTISTE
        Form1.player2[3] := StringGrid1.cells[4, StringGrid1.Row]; // TITRE
        Form1.player2[4] := StringGrid1.cells[5, StringGrid1.Row]; // Année
        Form1.player2[5] := StringGrid1.cells[15, StringGrid1.Row]; // Duree
        Form1.player2[6] := StringGrid1.cells[7, StringGrid1.Row]; // Frequence ?
        Form1.player2[7] := StringGrid1.cells[8, StringGrid1.Row]; // Tempo ?
        Form1.player2[8] := StringGrid1.cells[9, StringGrid1.Row]; // Intro
        Form1.player2[9] := StringGrid1.cells[10, StringGrid1.Row]; // Fade IN ?
        Form1.player2[10] := StringGrid1.cells[11, StringGrid1.Row]; // Fade Out
        Form1.player2[11] := StringGrid1.cells[12, StringGrid1.Row]; // Fichier ?
        Form1.player2[12] := StringGrid1.cells[13, StringGrid1.Row]; // Cat ?
        Form1.player2[13] := StringGrid1.cells[14, StringGrid1.Row]; // ssCat ?
        Form1.LoadPlayer2(StringGrid1.cells[0, StringGrid1.Row]);
      end;
  else ShowMessage('Le sender n''est pas correct!');
  end;

  ModalResult := mrOk;


end;

procedure TWaitlist.PlayClick(Sender: TObject);
var
  StartPosBytes: Integer;
begin
  BASS_ChannelStop(Preecoute);
  BASS_StreamFree(Preecoute);
  BASS_SetDevice(StrToInt(Form1.CUE1CART));
  Preecoute := BASS_StreamCreateFile(False, Pchar(StringGrid1.cells[12, StringGrid1.Row]), 0, 0, flags[StrToInt(Form1.CUE1CHAN)]);

  if StringGrid1.cells[10, StringGrid1.Row] <> '0' then
  begin
    StartPosBytes := BASS_ChannelSeconds2Bytes(Preecoute, strtofloat(StringReplace(StringGrid1.cells[10, StringGrid1.Row], '.', ',', [rfReplaceAll])));
    BASS_ChannelSetPosition(Preecoute, StartPosBytes, BASS_POS_BYTE);
  end;

  BASS_ChannelPlay(Preecoute, False);
  status1.Max := BASS_ChannelGetLength(Preecoute, BASS_POS_BYTE);
  TimerPFL.Enabled:=True;
  titre.Caption := StringGrid1.cells[3, StringGrid1.Row] + ' ' + StringGrid1.cells[4, StringGrid1.Row];
  
end;

procedure TWaitlist.StopClick(Sender: TObject);
begin
  BASS_ChannelStop(Preecoute);
  status1.Position:=0;
  timerPFL.Enabled:=False;
end;

procedure TWaitlist.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StopClick(sender);
end;

procedure TWaitlist.WaitlistFromHourClick(Sender: TObject);
var
  i: Integer;
  Heure: string;
begin
  StringGrid1.Row:=0;
  Heure := FormatDateTime('hh', Time);
  for i := 0 to StringGrid1.RowCount - 1 do
  begin
    if (Heure = StringGrid1.cells[2, i]) then
    begin
      StringGrid1.Row := i;
      Break;
    end;
  end;
end;

procedure TWaitlist.FormCreate(Sender: TObject);
begin
  Waitlist.Click();
end;

procedure TWaitlist.StringGrid1Click(Sender: TObject);
begin
  Play.Click;
end;

procedure TWaitlist.TimerPFLTimer(Sender: TObject);
begin
  status1.Position := BASS_ChannelGetPosition(Preecoute, BASS_POS_BYTE);
end;

procedure TWaitlist.status1Changed(Sender: TObject);
begin
  if (BASS_ChannelIsActive(Preecoute) = 0) then play.OnClick(sender);
  BASS_ChannelSetPosition(Preecoute, status1.Position, BASS_POS_BYTE);
end;

end.
