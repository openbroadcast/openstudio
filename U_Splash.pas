unit U_Splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles, jpeg;

type
  TSplash = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Label3: TLabel;
    User: TLabel;
    Memo1: TMemo;
    Degrade: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DegradeTimer(Sender: TObject);
  private
    i, j: Integer;
  public
    hdlDLL: HWND; { Public declarations }
    Name_File: string;
    Serial: function(Nom, SerialDonne: PChar): Boolean; { Public declarations }
  end;

var
  Splash: TSplash;

implementation

uses Unit1, U_VerifSerial, U_Bibliotheque, U_Clock, U_About, U_Main,
  U_Cartouche, U_Waitlist, U_Events, serverweb, background, Session,
  U_Config, sysop;  //Editeur

{$R *.dfm}

procedure TSplash.FormCreate(Sender: TObject);
var
  Inifile: TIniFile;
  Serial_File: string;
begin

  // Installation mode
  if (ParamStr(1) = '/setup') then
  begin
    Application.CreateForm(TConfig, Config);
    Config.Show;
    Config.Fermer.Visible := False;
    Config.PgConfig.ActivePage := Config.TabSheet3;
  end
  else
  begin

// Variable pour le AlphaBlend (affichage progressif)
    j := 0;

// Load de la librairie License

    if FileExists(ExtractFilePath(Application.ExeName) + '\lic.dll') then
    begin

      hdlDLL := LoadLibrary(PChar(ExtractFilePath(Application.ExeName) + '\lic.dll'));

      if hdlDLL = 0 then
      begin
        MessageDlg('Librairie lic non satisfaite. Le programme va s''arrêter.', mtError, [mbOK], 0);
        Application.Terminate;
      end;

    end

    else
    begin
      MessageDlg('Une DLL nécessaire au fonctionnement du logiciel est manquante.', mtError, [mbOK], 0);
      Application.Terminate;
    end;

// Vérification de la présence du "fichier license"

    if FileExists(ExtractFilePath(Application.ExeName) + '\user.reg') and FileExists(ExtractFilePath(Application.ExeName) + '\lic.dll') then
    begin
      IniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\user.reg');
      Name_File := IniFile.ReadString('Registration', 'Name', 'NO_USER');
      Serial_File := IniFile.ReadString('Registration', 'Serial', '000000');
      User.Caption := Name_File;
      IniFile.Free;

      Serial := GetProcAddress(hdlDLL, PChar('Serial'));

      if Serial(PChar(Name_File), PChar(Serial_File)) then
      begin
        Timer1.Enabled := True;
        i := 1;
      end
      else
      begin
        MessageDlg('Votre license est incorrecte !', mtError, [mbOK], 0);
        DeleteFile(ExtractFilePath(Application.ExeName) + '\user.reg');
        Application.Terminate;
      end;

      // License OFF

    end
    else
    begin
      Label3.Font.Color := clRed; // Couleur rouge
      Label3.Caption := 'Version non enregistrée'; // Non enregistré
      Timer1.Enabled := True;
      i := 0;

    end;
  end;

end;

procedure TSplash.Timer1Timer(Sender: TObject);
begin

  Timer1.Enabled := False;
  Memo1.Visible := True;

  if i <> 1 then   //inverse la condition pour open source
  begin

    Application.CreateForm(TOpenSessionForm, OpenSessionForm);
    Application.CreateForm(TAbout, About);
    Application.CreateForm(Tclock, clock);
    Application.CreateForm(TConfig, Config);
    Application.CreateForm(Tformsysop, formsysop);
    //Application.CreateForm(TEditor, Editor);
    Clock.Show;

    Memo1.Lines.Add('Loading Main...');
    Application.CreateForm(TMain, Main);
    Main.Show;
    Memo1.Lines.Add('Loading Timer...');
    Application.CreateForm(TEvents, Events);
    Memo1.Lines.Add('Loading WebServer...');
    Application.CreateForm(TServerPage, ServerPage);
    Memo1.Lines.Add('Loading DJ Interface...');
    Application.CreateForm(TForm1, Form1);
    Memo1.Lines.Add('Loading Playlist...');
    Application.CreateForm(TBibliotheque, Bibliotheque);
    Memo1.Lines.Add('Loading Waitlist...');
    Application.CreateForm(TWaitlist, Waitlist);

    Application.CreateForm(TMyBackground, MyBackground);
    MyBackground.Show;

    Hide;
  end
  else
  begin
    Hide;
    VerifSerial.Show;
  end;

end;

procedure TSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if hdlDLL <> 0 then FreeLibrary(hdlDLL);
end;

procedure TSplash.DegradeTimer(Sender: TObject);
begin
  Inc(j, 5);
  with Splash do begin
    if AlphaBlendValue < 255
      then AlphaBlendValue := j
    else Degrade.Enabled := False;
  end;
end;

end.

