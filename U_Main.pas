unit U_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, IniFiles, ToolWin, Menus, mysqlcomp, MysqlComponent, ExtCtrls, BASS,
  RLed, ShellAPI, StrUtils, StdCtrls, Midi;

type
  TMain = class(TForm)
    ImageList1: TImageList;
    silence: TTimer;
    reactsilence: TTimer;
    protection: TTimer;
    retardfadem2: TTimer;
    retardfadem1: TTimer;
    sql: TMysqlComponent;
    ToolBar1: TToolBar;
    spacer2: TToolButton;
    ButtonDJ: TToolButton;
    ButtonAuto: TToolButton;
    spacer3: TToolButton;
    spacer1: TToolButton;
    info: TLabel;
    timer: TLabel;
    ToolButton1: TToolButton;
    ButtonLocked: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    Memory1: TLabel;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    function load1(Load : Boolean; Start: Boolean): Boolean;
    function load2(Load : Boolean; Start: Boolean): Boolean;
    procedure FormCreate(Sender: TObject);
    procedure ButtonAutoClick(Sender: TObject);
    procedure ButtonDJClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure silenceTimer(Sender: TObject);
    procedure reactsilenceTimer(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Siteconstructeur1Click(Sender: TObject);
    procedure ConfigLocaleClick(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure protectionTimer(Sender: TObject);
    procedure retardfadem1Timer(Sender: TObject);
    procedure retardfadem2Timer(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ButtonLockedClick(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
  private
    EnCours: Integer;
    { Déclarations privées }
  public
    AutoLaunch, AutoLocked: Integer;
    ModeAuto, ModeLocked, IsLoad1, IsLoad2, Player1PreLoad, Player2PreLoad: Boolean;
    IntroNextTitle: Extended;
    procedure Log(Chaine: string; LogDate: Boolean);
    { Déclarations publiques }
  end;

var
  Main: TMain;
  CurrentWordList: TStringList;
  CurrentSongIndex: integer;

implementation

uses U_Clock, Unit1, U_Cartouche, U_About, U_Config, U_Events,
  U_Splash, Session, sysop;

{$R *.dfm}

procedure TMain.Log(Chaine: string; LogDate: Boolean);
var F: Textfile;
  S: string;
begin
  Assignfile(F, ExtractFilePath(Application.ExeName) + '\log\' + FormatDateTime('DDMMYY', Now) + '.txt');
{$IFOPT I+} // Si la directive I est activée
{$DEFINE I_Plus} // Alors défini le symbole (local)
{$I-} // Et désactive la directive
{$ENDIF}
  Append(F); //Section de code concerné
{$IFDEF I_Plus} // Si la directive I était précédemment activée
{$I+} // Alors on réactive la directive
{$ENDIF}
{$UNDEF I_Plus} //On supprime le symbole précédemment défini

  if IOresult <> 0
    then Rewrite(F);
  try
    if LogDate
      then S := FormatDateTime('DDDD DD MMMM YYYY HH:NN:SS,ZZZ', Now)
    else S := '';

    Writeln(F, S + ' ' + Chaine);
  finally
    Closefile(F);
  end;

  if (Form1.ModeDebug = True) then begin formsysop.debug.Lines.Add(S + ' ' + Chaine); end;

end;

procedure CloseSession(isStart: Boolean);
begin
  Main.ButtonDJ.Enabled := False;
  Main.ButtonAuto.Enabled := False;
  Main.ModeLocked := True;
  if (isStart = True) then Form1.Hide;
end;

procedure ModeDJActivate(isStart: Boolean);
begin

  Main.protection.Enabled := False;
  Main.silence.Enabled := False;
  Main.retardfadem1.Enabled := False;
  Main.retardfadem2.Enabled := False;
  Main.reactsilence.Enabled := False;

  Main.ButtonDJ.Enabled := False;
  Main.ButtonAuto.Enabled := True;

  Main.ModeAuto := False;
  Main.info.Caption := 'Mode DJ';

  if (isStart = True) then
  begin
    Form1.Show;
    if(not Form1.InitDevice()) then Main.log('Impossible d''initialiser la carte DRC', True);
  end;
end;

procedure ModeAutoActivate(isStart: Boolean);
begin

  Main.ButtonDJ.Enabled := True;
  Main.ButtonAuto.Enabled := False;

  Main.protection.Interval := 100;
  Main.protection.Enabled := True;
  Main.silence.Enabled := True;

  Main.ModeAuto := True;
  Main.info.Caption := 'Mode Auto';

  if (isStart = True) then
  begin
    if (Form1.retourpub.Tag = 1) then Form1.retourpub.Click;
    Form1.Hide;
    Form1.KillDevice();
  end;

  // Protection!
  MidiOutput.Send(0, $E0, $70, $7F );
  MidiOutput.Send(0, $E1, $70, $7F );
  MidiOutput.Send(0, $E2, $70, $7F );
  MidiOutput.Send(0, $E3, $70, $7F );
  MidiOutput.Send(0, $E4, $70, $7F );
  MidiOutput.Send(0, $E5, $70, $7F );

end;

function TMain.load1(Load : Boolean; Start: Boolean): Boolean;
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  DateWaitlist,RequestSQL: string;
begin

  if (sql.Connected) then
  begin

    if(Load=True) then
    begin

    DateWaitlist := FormatDateTime('yyyy-mm-dd hh:00:00', Now);

    RequestSQL:='SELECT playlist.ID, artistes.Name, playlist.Titre, playlist.Annee, playlist.Duree, waitlist.Frequence, ';
    RequestSQL:=RequestSQL+'waitlist.Tempo, waitlist.Intro, waitlist.FadeIn, waitlist.FadeOut, playlist.Path, playlist.Categorie, ';
    RequestSQL:=RequestSQL+'playlist.Categorie, waitlist.ID ';
    RequestSQL:=RequestSQL+'FROM waitlist ';
    RequestSQL:=RequestSQL+'LEFT JOIN playlist ON (playlist.id=waitlist.PlaylistID) ';
    RequestSQL:=RequestSQL+'LEFT JOIN artistes ON (artistes.id=playlist.Artiste) ';
    RequestSQL:=RequestSQL+'WHERE waitlist.Date_Play=''' + DateWaitlist + ''' AND waitlist.Joue=0 ORDER by waitlist.Id ASC LIMIT 1;';

    Res := sql.Query(RequestSQL);
    Row := sql.fetch_row(Res);

    if Row = nil then
    begin
      info.Caption := 'Pas de programmation';
    end
    else
    begin
      Form1.player1[1] := Row[0]; // Id Playlist
      Form1.player1[2] := Uppercase(Row[1]); // ARTISTE
      Form1.player1[3] := Uppercase(Row[2]); // TITRE
      Form1.player1[4] := Row[3]; // Année
      Form1.player1[5] := Row[4]; // Duree
      Form1.player1[6] := Row[5]; // Frequence ?
      Form1.player1[7] := Row[6]; // Tempo ?
      Form1.player1[8] := Row[7]; // Intro
      Form1.player1[9] := Row[8]; // Fade IN ?
      Form1.player1[10] := Row[9]; // Fade Out
      Form1.player1[11] := Row[10]; // Fichier ?
      Form1.player1[12] := Row[11]; // Cat
      Form1.player1[13] := Row[12]; // SsCat
      Form1.player1[14] := Row[13]; // Id Waitlist
      Form1.LoadPlayer1(Row[0]);
      sql.free_result(Res);
    end;
  end;

  if (Start = True) then
  begin
  Form1.Play1.Click;
  EnCours := 1;
  end;

  end;
  Result := True;
end;

function TMain.load2(Load : Boolean; Start: Boolean): Boolean;
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  DateWaitlist, RequestSQL: string;
begin

  if (sql.Connected) then
  begin

  if(Load=True) then
  begin


    DateWaitlist := FormatDateTime('yyyy-mm-dd hh:00:00', Now);

    RequestSQL:='SELECT playlist.ID, artistes.Name, playlist.Titre, playlist.Annee, playlist.Duree, waitlist.Frequence, ';
    RequestSQL:=RequestSQL+'waitlist.Tempo, waitlist.Intro, waitlist.FadeIn, waitlist.FadeOut, playlist.Path, playlist.Categorie, ';
    RequestSQL:=RequestSQL+'playlist.Categorie, waitlist.ID ';
    RequestSQL:=RequestSQL+'FROM waitlist ';
    RequestSQL:=RequestSQL+'LEFT JOIN playlist ON (playlist.id=waitlist.PlaylistID) ';
    RequestSQL:=RequestSQL+'LEFT JOIN artistes ON (artistes.id=playlist.Artiste) ';
    RequestSQL:=RequestSQL+'WHERE waitlist.Date_Play=''' + DateWaitlist + ''' AND waitlist.Joue=0 ORDER by waitlist.Id ASC LIMIT 1;';

    Res := sql.Query(RequestSQL);
    Row := sql.fetch_row(Res);

    if Row = nil then
    begin
      info.Caption := 'Pas de programmation';
    end
    else
    begin

      Form1.player2[1] := Row[0]; // Id Playlist
      Form1.player2[2] := Uppercase(Row[1]); // ARTISTE
      Form1.player2[3] := Uppercase(Row[2]); // TITRE
      Form1.player2[4] := Row[3]; // Année
      Form1.player2[5] := Row[4]; // Duree
      Form1.player2[6] := Row[5]; // Frequence ?
      Form1.player2[7] := Row[6]; // Tempo ?
      Form1.player2[8] := Row[7]; // Intro
      Form1.player2[9] := Row[8]; // Fade IN ?
      Form1.player2[10] := Row[9]; // Fade Out
      Form1.player2[11] := Row[10]; // Fichier ?
      Form1.player2[12] := Row[11]; // Category
      Form1.player2[13] := Row[12]; // SSCategory ?
      Form1.player2[14] := Row[13]; // Id Waitlist
      Form1.LoadPlayer2(Row[0]);

      sql.free_result(Res);
    end;

  end;

  if (Start = True) then
  begin
  Form1.Play2.Click;
  EnCours := 2;
  end;

  end;

  Result := True;
end;


procedure TMain.FormCreate(Sender: TObject);
var
  FichierIni: TIniFile;
begin
// StringList
  CurrentWordList := TStringList.create;
  CurrentSongIndex := 0;

// Griser

  //EnableMenuItem(GetSystemMenu(Handle, FALSE), SC_CLOSE, MF_GRAYED);

// Largeur max

  Main.Width := GetSystemMetrics(SM_CXSCREEN);
  Main.Left := 0;
  Main.Height := 90;
  Main.Top := GetSystemMetrics(SM_CYSCREEN) - 90;

 // MYSQL COMPOSANT _ CONNECT + DB

  if (not sql.Selected) and (not sql.Connected) then
  begin

    sql.Close;
    FichierIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\config.ini');
    Main.sql.Host := FichierIni.ReadString('MySQL', 'Host', 'NO VALUE');
    Main.sql.Login := FichierIni.ReadString('MySQL', 'Login', 'NO VALUE');
    Main.sql.Password := FichierIni.ReadString('MySQL', 'Password', 'NO VALUE');
    Main.sql.Database := FichierIni.ReadString('MySQL', 'Base', 'NO VALUE');
    AutoLaunch := FichierIni.ReadInteger('Start', 'Launch', 0);
    AutoLocked := FichierIni.ReadInteger('Start', 'Locked', 0);

    FichierIni.Free;

    splash.Memo1.Lines.Add('Connecting to MySQL');
    sql.Connect;

    if (sql.Connected = false) or (sql.Selected = false) then
    begin
      MessageDlg('Impossible d''ouvrir la connexion MySQL', mtError, [mbOK], 0);
      Config.Show;
      Config.Fermer.Visible := False;
      Config.PgConfig.ActivePage := Config.TabSheet3;
    end
    else
    begin
      if AutoLaunch = 1 then
      begin
    // Mode Auto
        ModeAutoActivate(False);
      end
      else
      begin
        ModeDJActivate(False);
      end;

      if AutoLocked = 1 then
      begin
    // Bloqué
        CloseSession(False);
      end
      else
      begin
        ModeLocked := False;
        ButtonDJ.Enabled := True;
        ButtonAuto.Enabled := True;
      end;
    end;

  end;

end;

procedure TMain.ButtonAutoClick(Sender: TObject);
begin
// Auto
  ModeAutoActivate(True);
end;

procedure TMain.ButtonDJClick(Sender: TObject);
begin
// DJ
  ModeDJActivate(True);
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

// Détection du silence en vue de SKIP la chanson.

procedure TMain.silenceTimer(Sender: TObject);
var
  Temps1: Single;
  TempsLu1: Single;
  TempsRestant1: Single;
  Temps2: Single;
  TempsLu2: Single;
  TempsRestant2: Single;
  Level1: Cardinal;
  Left1: Single;
  Level2: Cardinal;
  Left2: Single;
begin

// Events PRIOR. (Crash comme Contact :-D)
  if (Events.pagedepubPrior = True) then Events.diffuser.OnClick(sender);

  if BASS_ChannelIsActive(Form1.m1) = 1 then
  begin

    Temps1 := BASS_ChannelBytes2Seconds(Form1.m1, BASS_ChannelGetLength(Form1.m1, BASS_POS_BYTE));
    TempsLu1 := BASS_ChannelBytes2Seconds(Form1.m1, BASS_ChannelGetPosition(Form1.m1, BASS_POS_BYTE));
    TempsRestant1 := (Temps1 - TempsLu1);

    // Y'a t'il une valeur au Fadeout?
    if (Form1.FadeOutm1 <> 0) then
    begin

    // Préchargement (si pas de pub)
      if ((Events.pagedepub = False) and ((Form1.FadeOutm1 - 2) <= TempsLu1) and (isLoad2 = False)) then
      begin
        log('Preload Player 2', True);
        isLoad2 := True;
        Main.Player2PreLoad := True;
        load2(True, False);
      end;

    // Si oui, on skip quand il faut.
      if (Form1.FadeOutm1 <= TempsLu1) then
      begin
        //log('Player A : Point de mix: ' + FloatToStr(Form1.FadeOutm1) + ' Valeur: ' + FloatToStr(TempsLu1), True);
        retardfadem1.Interval := 10;
        retardfadem1.Enabled := True;
      end;

    end
    else
    begin

      Level1 := BASS_ChannelGetLevel(Form1.m1);
      Left1 := LOWORD(Level1);

  // Si non, en fonction du vumètre et du décompte.
      if (TempsRestant1 <= Form1.AUTOOUT) and (Left1 <= Form1.AUTOSILENCE) then
      begin
        retardfadem1.Interval := Form1.AUTOFENETRE;
        retardfadem1.Enabled := True;
        Main.Player1PreLoad := False;
      end
      else
      begin
        retardfadem1.Enabled := False;
      end;

    end;
  end;


  if BASS_ChannelIsActive(Form1.m2) = 1 then
  begin

    Temps2 := BASS_ChannelBytes2Seconds(Form1.m2, BASS_ChannelGetLength(Form1.m2, BASS_POS_BYTE));
    TempsLu2 := BASS_ChannelBytes2Seconds(Form1.m2, BASS_ChannelGetPosition(Form1.m2, BASS_POS_BYTE));
    TempsRestant2 := (Temps2 - TempsLu2);

    if (Form1.FadeOutm2 <> 0) then
    begin

    // Préchargement (si pas de pub)
      if ((Events.pagedepub = False) and ((Form1.FadeOutm2 - 4) <= TempsLu2) and (isLoad1 = False)) then
      begin
        log('Preload Player 1', True);
        isLoad1 := True;
        Main.Player1PreLoad := True;
        load1(True, False);
      end;

      if (Form1.FadeOutm2 <= TempsLu2) then
      begin
        //log('Player B : Point de mix: ' + FloatToStr(Form1.FadeOutm2) + ' Valeur: ' + FloatToStr(TempsLu2), True);
        retardfadem2.Interval := 10;
        retardfadem2.Enabled := True;
      end;

    end
    else
    begin

      Level2 := BASS_ChannelGetLevel(Form1.m2);
      Left2 := LOWORD(Level2);

    // Next en fonction du vumètre et du décompte.
      if (TempsRestant2 <= Form1.AUTOOUT) and (Left2 <= Form1.AUTOSILENCE) then
      begin
        retardfadem2.Interval := Form1.AUTOFENETRE;
        retardfadem2.Enabled := True;
        Main.Player2PreLoad := False;
      end
      else
      begin
        retardfadem2.Enabled := False;
      end;
    end;
  end;


// fin
end;

procedure TMain.reactsilenceTimer(Sender: TObject);
begin
  silence.Enabled := True; // Retour de silence timer
  reactsilence.Enabled := False; // Je me coupe
end;

procedure TMain.About1Click(Sender: TObject);
begin
  About.ShowModal;
end;

procedure TMain.Siteconstructeur1Click(Sender: TObject);
var Conf: integer;
begin

  Conf := MessageDlg(('Vous allez être dirigé vers le site du constructeur'), mtInformation, mbOkCancel, 0);
  case Conf of

    idOK:
      begin
        ShellExecute(Handle, nil, 'http://www.openstudio.be', nil, nil, SW_SHOWNORMAL);
      end;

    idCancel:
      begin
        Abort;
      end;

  end;
end;

procedure TMain.ConfigLocaleClick(Sender: TObject);
begin
  Config.ShowModal;
end;

procedure TMain.ToolButton11Click(Sender: TObject);
begin
  Events.Show;
end;

procedure TMain.protectionTimer(Sender: TObject);
begin
  if ((BASS_ChannelIsActive(Form1.m1) = 0) and (BASS_ChannelIsActive(Form1.m2) = 0)) then
  begin
    load1(True, True);
    log('Activation mode automatique - Lancement Player 1', True);
  end;
  protection.Interval := 1500;
end;

procedure TMain.retardfadem1Timer(Sender: TObject);
begin

  // and (Form1.CurrentCat = 'MUSIQUES')
  if ((Events.pagedepub = True)) then
  begin
    silence.Enabled := False; // Plus de détection silence
    BASS_ChannelSlideAttribute(Form1.m1, BASS_ATTRIB_VOL, 0, Form1.AUTOFADEOUT);
      // Event
    Events.diffuser.OnClick(sender);

    reactsilence.Interval := Form1.AUTOFADEOUT + 2500;
    reactsilence.Enabled := True; // Détection silence, mais quelques ms après.
    retardfadem1.Enabled := False; // Me coupe!
  end
  else
  begin
    silence.Enabled := False; // Plus de détection silence
    BASS_ChannelSlideAttribute(Form1.m1, BASS_ATTRIB_VOL, 0, Form1.AUTOFADEOUT);
      // Lecteur suivant (on passe de m1 à m2 ici)

    if (Player2PreLoad = True) then
    begin
      load2(False, True);
      log('Play Player 2 (Morceau chargé)', True);
    end
    else
    begin
      load2(True, True);
      log('Play Player 2 (Chargement en cours)', True);
    end;

    reactsilence.Interval := Form1.AUTOFADEOUT + 2500;
    reactsilence.Enabled := True; // Détection silence, mais quelques ms après.
    retardfadem1.Enabled := False; // Me coupe!
  end;

end;

procedure TMain.retardfadem2Timer(Sender: TObject);
begin
  //  BUG
  // and (Form1.CurrentCat = 'MUSIQUES')
  if ((Events.pagedepub = True)) then
  begin
    silence.Enabled := False; // Plus de détection silence
    BASS_ChannelSlideAttribute(Form1.m2, BASS_ATTRIB_VOL, 0, Form1.AUTOFADEOUT);
      // Event
    Events.diffuser.OnClick(sender);

    reactsilence.Interval := Form1.AUTOFADEOUT + 2500;
    reactsilence.Enabled := True; // Détection silence, mais quelques ms après.
    retardfadem2.Enabled := False; // Me coupe!
  end
  else
  begin
    silence.Enabled := False; // Plus de détection silence
    BASS_ChannelSlideAttribute(Form1.m2, BASS_ATTRIB_VOL, 0, Form1.AUTOFADEOUT);
      // Lecteur suivant (on passe de m2 à m1 ici)

    if (Player1PreLoad = True) then
    begin
      load1(False, True);
      log('Play Player 1 (Morceau chargé)', True);
    end
    else
    begin
      load1(True, True);
      log('Play Player 1 (Chargement en cours)', True);
    end;

    reactsilence.Interval := Form1.AUTOFADEOUT + 2500;
    reactsilence.Enabled := True; // Détection silence, mais quelques ms après.
    retardfadem2.Enabled := False; // Me coupe!

  end;
end;

procedure TMain.ToolButton1Click(Sender: TObject);
var Conf: integer;
begin

  Conf := MessageDlg(('Voulez vous vraiment quitter le programme?'), mtInformation, mbOkCancel, 0);
  case Conf of

    idOK:
      begin
        Application.Terminate();
      end;

    idCancel:
      begin
        Abort;
      end;

  end;
end;

procedure TMain.ButtonLockedClick(Sender: TObject);
begin
  CloseSession(True);
end;

procedure TMain.ToolButton3Click(Sender: TObject);
begin
  OpenSessionForm.ShowModal;
end;

procedure TMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, SC_MOVE or HTCAPTION, 0);
end;

procedure TMain.ToolButton4Click(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TMain.ToolButton5Click(Sender: TObject);
begin
  Config.ShowModal;
end;

procedure TMain.ToolButton6Click(Sender: TObject);
begin
  About.ShowModal;
end;

end.

