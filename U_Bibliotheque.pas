unit U_Bibliotheque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, MysqlComponent, BASS, ComCtrls, Menus,
  JvExButtons, JvBitBtn, JvExComCtrls, JvComCtrls, ExtCtrls;

type
  TBibliotheque = class(TForm)
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Artists: TBitBtn;
    play: TBitBtn;
    Stop: TBitBtn;
    StatusBar1: TStatusBar;
    titre: TLabel;
    PopupMenu1: TPopupMenu;
    Recherche1: TMenuItem;
    JvBitBtn1: TJvBitBtn;
    Rcents1: TMenuItem;
    status1: TJvTrackBar;
    TimerPFL: TTimer;
    procedure StringGrid1DblClick(Sender: TObject);
    procedure ArtistsClick(Sender: TObject);
    procedure playClick(Sender: TObject);
    procedure StopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Recherche1Click(Sender: TObject);
    procedure Rcents1Click(Sender: TObject);
    procedure StringGrid2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure status1Changed(Sender: TObject);
    procedure TimerPFLTimer(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    SenderBib: Integer;
    Preecoute: Integer;
    procedure RequestSQL(Request : String);
  end;

var
  Bibliotheque: TBibliotheque;

implementation

uses U_Splash, Unit1, U_Main;

{$R *.dfm}

procedure TBibliotheque.RequestSQL(Request : String);
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  i, j: integer;
  Duree : Double;
  Select : String;
begin

  Select := 'SELECT playlist.Id, artistes.Name AS Artiste, playlist.Titre, playlist.Annee, playlist.Duree, playlist.Frequence, ';
  Select := Select+'playlist.Tempo, playlist.Intro, playlist.FadeIn, playlist.FadeOut, playlist.Path, playlist.Categorie, playlist.ssCategorie, ';
  Select := Select+'playlist.Duree FROM playlist LEFT JOIN artistes ON (artistes.ID=playlist.Artiste) WHERE ';

  Res := Main.Sql.Query(Select + Request);

  if Res = nil then StatusBar1.Panels[0].Text := 'Aucun résultat'
  else
  try

    StringGrid1.Show;
    StringGrid1.ColCount := 14;
    StringGrid1.RowCount := Main.sql.num_rows(Res);

    StringGrid1.ColWidths[0] := 0;
    StringGrid1.ColWidths[1] := 280;
    StringGrid1.ColWidths[2] := 380;
    StringGrid1.ColWidths[3] := 45;
    StringGrid1.ColWidths[4] := 40;
    StringGrid1.ColWidths[5] := 0;
    StringGrid1.ColWidths[6] := 0;
    StringGrid1.ColWidths[7] := 0;
    StringGrid1.ColWidths[8] := 0;
    StringGrid1.ColWidths[9] := 0;
    StringGrid1.ColWidths[10] := 0;
    StringGrid1.ColWidths[11] := 0;
    StringGrid1.ColWidths[12] := 0;
    StringGrid1.ColWidths[13] := 0;

    j := 0;
    Row := Main.sql.fetch_row(Res);
    while Row <> nil do
    begin
      for i := 0 to StringGrid1.ColCount do
      begin
        if (i = 4) then
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

procedure TBibliotheque.StringGrid1DblClick(Sender: TObject);
begin

  // Id, Artiste, Titre, Annee, Duree, Frequence, Tempo, Intro, FadeIn, FadeOut, Path

  case SenderBib of
    1: begin
        Form1.player1[1] := StringGrid1.cells[0, StringGrid1.Row]; // ID
        Form1.player1[2] := StringGrid1.cells[1, StringGrid1.Row]; // ARTISTE
        Form1.player1[3] := StringGrid1.cells[2, StringGrid1.Row]; // TITRE
        Form1.player1[4] := StringGrid1.cells[3, StringGrid1.Row]; // Année
        Form1.player1[5] := StringGrid1.cells[13, StringGrid1.Row]; // Duree
        Form1.player1[6] := StringGrid1.cells[5, StringGrid1.Row]; // Frequence ?
        Form1.player1[7] := StringGrid1.cells[6, StringGrid1.Row]; // Tempo ?
        Form1.player1[8] := StringGrid1.cells[7, StringGrid1.Row]; // Intro
        Form1.player1[9] := StringGrid1.cells[8, StringGrid1.Row]; // Fade IN ?
        Form1.player1[10] := StringGrid1.cells[9, StringGrid1.Row]; // Fade Out
        Form1.player1[11] := StringGrid1.cells[10, StringGrid1.Row]; // Fichier ?
        Form1.player1[12] := StringGrid1.cells[11, StringGrid1.Row]; // Cat ?
        Form1.player1[13] := StringGrid1.cells[12, StringGrid1.Row]; // ssCat ?
        Form1.LoadPlayer1(StringGrid1.cells[0, StringGrid1.Row]);
      end;

    2: begin
        Form1.player2[1] := StringGrid1.cells[0, StringGrid1.Row]; // ID
        Form1.player2[2] := StringGrid1.cells[1, StringGrid1.Row]; // ARTISTE
        Form1.player2[3] := StringGrid1.cells[2, StringGrid1.Row]; // TITRE
        Form1.player2[4] := StringGrid1.cells[3, StringGrid1.Row]; // Année
        Form1.player2[5] := StringGrid1.cells[13, StringGrid1.Row]; // Duree
        Form1.player2[6] := StringGrid1.cells[5, StringGrid1.Row]; // Frequence ?
        Form1.player2[7] := StringGrid1.cells[6, StringGrid1.Row]; // Tempo ?
        Form1.player2[8] := StringGrid1.cells[7, StringGrid1.Row]; // Intro
        Form1.player2[9] := StringGrid1.cells[8, StringGrid1.Row]; // Fade IN ?
        Form1.player2[10] := StringGrid1.cells[9, StringGrid1.Row]; // Fade Out
        Form1.player2[11] := StringGrid1.cells[10, StringGrid1.Row]; // Fichier ?
        Form1.player2[12] := StringGrid1.cells[11, StringGrid1.Row]; // Cat ?
        Form1.player2[13] := StringGrid1.cells[12, StringGrid1.Row]; // ssCat ?
        Form1.LoadPlayer2(StringGrid1.cells[0, StringGrid1.Row]);
      end;
  else ShowMessage('Le sender n''est pas correct!');
  end;

  ModalResult := mrOk;

end;

procedure TBibliotheque.ArtistsClick(Sender: TObject);

var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  i, j: integer;
begin

  for i := 0 to StringGrid2.Rowcount - 1 do
  begin
    StringGrid2.Rows[i].clear;
  end;
  StringGrid2.rowcount := 1;

  if (Main.sql.Connected) then
  begin

    Res := Main.Sql.Query('SELECT ID, Name FROM artistes ORDER by Name ASC;');

    if Res = nil then StatusBar1.Panels[0].Text := 'Aucun résultat'
    else
    try

      StringGrid2.Show;
      StringGrid2.ColCount := 2;
      StringGrid2.RowCount := Main.sql.num_rows(Res);

      StringGrid2.ColWidths[0] := 0;
      StringGrid2.ColWidths[1] := 500;

      j := 0;
      Row := Main.sql.fetch_row(Res);
      while Row <> nil do
      begin
        for i := 0 to StringGrid2.ColCount do
        begin
          StringGrid2.Cells[i, j] := Row[i];
        end;
        Row := Main.sql.fetch_row(Res);
        j := j + 1;
      end;
    finally
      Main.sql.free_result(Res);
    end;
  end;

end;

procedure TBibliotheque.playClick(Sender: TObject);
var
  StartPosBytes: Integer;
begin
  BASS_ChannelStop(Preecoute);
  BASS_StreamFree(Preecoute);
  BASS_SetDevice(StrToInt(Form1.CUE1CART));
  Preecoute := BASS_StreamCreateFile(False, Pchar(StringGrid1.cells[10, StringGrid1.Row]), 0, 0, flags[StrToInt(Form1.CUE1CHAN)]);

  if StringGrid1.cells[8, StringGrid1.Row] <> '0' then
  begin
    StartPosBytes := BASS_ChannelSeconds2Bytes(Preecoute, strtofloat(StringReplace(StringGrid1.cells[8, StringGrid1.Row], '.', ',', [rfReplaceAll])));
    BASS_ChannelSetPosition(Preecoute, StartPosBytes, BASS_POS_BYTE);
  end;

  BASS_ChannelPlay(Preecoute, False);
  status1.Max := BASS_ChannelGetLength(Preecoute, BASS_POS_BYTE);
  timerPFL.Enabled:=True;
  titre.Caption := StringGrid1.cells[1, StringGrid1.Row] + ' ' + StringGrid1.cells[2, StringGrid1.Row];

end;

procedure TBibliotheque.StopClick(Sender: TObject);
begin
  BASS_ChannelStop(Preecoute);
  status1.Position:=0;
  timerPFL.Enabled:=False;
end;

procedure TBibliotheque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    StopClick(sender);
end;

procedure TBibliotheque.Recherche1Click(Sender: TObject);
var
  Reponse: string;
begin
  Reponse := InputBox('Rechercher', 'Tappez ci dessous la chanson que vous recherchez:', '');

  if Reponse = '' then
  begin
    StatusBar1.Panels[0].Text := 'Entrez un mot clef !';
  end
  else
  begin
    RequestSQL('artistes.Name LIKE ''%' + Reponse + '%'' OR playlist.Titre LIKE ''%' + Reponse + '%'' OR playlist.Album LIKE ''%' + Reponse + '%'' OR playlist.Annee LIKE ''%' + Reponse + '%'' ORDER by artistes.Name ASC;');
  end;

end;

procedure TBibliotheque.Rcents1Click(Sender: TObject);
begin
    RequestSQL('playlist.Categorie=2 ORDER by playlist.Id DESC LIMIT 100;');
end;

procedure TBibliotheque.StringGrid2Click(Sender: TObject);
begin
  RequestSQL('artistes.ID=' + StringGrid2.cells[0, StringGrid2.Row] + ' ORDER by playlist.Id ASC;');
end;

procedure TBibliotheque.FormCreate(Sender: TObject);
begin
  if(Main.sql.Connected=True) then Artists.Click;
end;

procedure TBibliotheque.TimerPFLTimer(Sender: TObject);
begin
  status1.Position := BASS_ChannelGetPosition(Preecoute, BASS_POS_BYTE);
end;

procedure TBibliotheque.status1Changed(Sender: TObject);
begin
  if (BASS_ChannelIsActive(Preecoute) = 0) then play.OnClick(sender);
  BASS_ChannelSetPosition(Preecoute, status1.Position, BASS_POS_BYTE);
end;


end.
