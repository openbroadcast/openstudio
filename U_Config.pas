unit U_Config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Mask, Spin, BASS, IniFiles,
  MysqlComponent, ShellApi;

type
  TConfig = class(TForm)
    PgConfig: TPageControl;
    onglet_soundcard: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Fermer: TBitBtn;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    RadioGroup1: TRadioGroup;
    dsc1front: TRadioButton;
    dsc1rear: TRadioButton;
    dsc1center: TRadioButton;
    dsc1rear2: TRadioButton;
    GroupBox2: TGroupBox;
    ComboBox2: TComboBox;
    RadioGroup2: TRadioGroup;
    dsc2rear: TRadioButton;
    dsc2center: TRadioButton;
    dsc2rear2: TRadioButton;
    GroupBox3: TGroupBox;
    ComboBox3: TComboBox;
    RadioGroup3: TRadioGroup;
    jingle1front: TRadioButton;
    jingle1rear: TRadioButton;
    jingle1center: TRadioButton;
    jingle1rear2: TRadioButton;
    GroupBox4: TGroupBox;
    ComboBox4: TComboBox;
    RadioGroup4: TRadioGroup;
    jingle2front: TRadioButton;
    jingle2rear: TRadioButton;
    jingle2center: TRadioButton;
    jingle2rear2: TRadioButton;
    GroupBox5: TGroupBox;
    ComboBox5: TComboBox;
    RadioGroup5: TRadioGroup;
    cue1front: TRadioButton;
    cue1rear: TRadioButton;
    cue1center: TRadioButton;
    cue1rear2: TRadioButton;
    TabSheet1: TTabSheet;
    GroupBox6: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox7: TGroupBox;
    host: TEdit;
    login: TEdit;
    password: TMaskEdit;
    database: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox9: TGroupBox;
    startauto: TCheckBox;
    startlocked: TCheckBox;
    GroupBox10: TGroupBox;
    portdrc: TSpinEdit;
    Label8: TLabel;
    GroupBox12: TGroupBox;
    ComboBox7: TComboBox;
    RadioGroup8: TRadioGroup;
    pubfront: TRadioButton;
    pubrear: TRadioButton;
    pubcenter: TRadioButton;
    pubrear2: TRadioButton;
    AUTOSILENCE: TSpinEdit;
    AUTOOUT: TSpinEdit;
    AUTOFENETRE: TSpinEdit;
    AUTOFADEOUT: TSpinEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    enregistrer: TBitBtn;
    GroupBox14: TGroupBox;
    ComboBox8: TComboBox;
    RadioGroup7: TRadioGroup;
    padfront: TRadioButton;
    padrear: TRadioButton;
    padcenter: TRadioButton;
    padrear2: TRadioButton;
    GroupBox11: TGroupBox;
    ComboBox6: TComboBox;
    RadioGroup9: TRadioGroup;
    recordfront: TRadioButton;
    recordrear: TRadioButton;
    recordcenter: TRadioButton;
    recordrear2: TRadioButton;
    dsc2front: TRadioButton;
    Label9: TLabel;
    Label15: TLabel;
    TONEDETECTFREQ: TSpinEdit;
    TONEDETECTNIVEAU: TSpinEdit;
    Label16: TLabel;
    TestConnect: TButton;
    sql: TMysqlComponent;
    CreateDb: TButton;
    CreateTablesEssentials: TButton;
    CreateTablesDemo: TButton;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FermerClick(Sender: TObject);
    procedure enregistrerClick(Sender: TObject);
    procedure TestConnectClick(Sender: TObject);
    procedure CreateDbClick(Sender: TObject);
    procedure CreateTablesEssentialsClick(Sender: TObject);
    procedure CreateTablesDemoClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Config: TConfig;

implementation

uses U_Main, U_Splash;

{$R *.dfm}

procedure TConfig.FormCreate(Sender: TObject);
var
  j: integer;
  FichierIni: TIniFile;
  di : BASS_DEVICEINFO;
begin

  // Construire les ComboBox des interfaces
  j := 1;
  while BASS_GetDeviceInfo(j, di) do
  begin
    ComboBox1.Items.Add(di.name);
    ComboBox2.Items.Add(di.name);
    ComboBox3.Items.Add(di.name);
    ComboBox4.Items.Add(di.name);
    ComboBox5.Items.Add(di.name);
    ComboBox6.Items.Add(di.name);
    ComboBox7.Items.Add(di.name);
    ComboBox8.Items.Add(di.name);
    j := j + 1;
  end;

  // -1 car les énumérations cartes dans BASS commencent à 1 et l'assignement d'ItemIndex à 0.

  FichierIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\config.ini');
     // LECTEURS CARTES
  ComboBox1.ItemIndex := (StrToInt(FichierIni.ReadString('Soundcard', 'DSC1', '1')) - 1);
  ComboBox2.ItemIndex := (StrToInt(FichierIni.ReadString('Soundcard', 'DSC2', '1')) - 1);

  case StrToInt(FichierIni.ReadString('Multichannel', 'DSC1', '0')) of
    0: begin
        dsc1front.Checked := True;
      end;
    1: begin
        dsc1rear.Checked := True;
      end;
    2: begin
        dsc1center.Checked := True;
      end;
    3: begin
        dsc1rear2.Checked := True;
      end;
  else begin
      ShowMessage('DSC1 Channel a renvoyé une valeur incorrecte!');
    end;
  end;

  case StrToInt(FichierIni.ReadString('Multichannel', 'DSC2', '0')) of
    0: begin
        dsc2front.Checked := True;
      end;
    1: begin
        dsc2rear.Checked := True;
      end;
    2: begin
        dsc2center.Checked := True;
      end;
    3: begin
        dsc2rear2.Checked := True;
      end;
  else begin
      ShowMessage('DSC2 Channel a renvoyé une valeur incorrecte!');
    end;
  end;

     // JINGLE/PAD/PUB/CUE CARTE
  ComboBox3.ItemIndex := (StrToInt(FichierIni.ReadString('Soundcard', 'JIN1', '1')) - 1);
  ComboBox4.ItemIndex := (StrToInt(FichierIni.ReadString('Soundcard', 'JIN2', '1')) - 1);
  ComboBox8.ItemIndex := (StrToInt(FichierIni.ReadString('Soundcard', 'PAD1', '1')) - 1);
  ComboBox7.ItemIndex := (StrToInt(FichierIni.ReadString('Soundcard', 'PUB1', '1')) - 1);
  ComboBox5.ItemIndex := (StrToInt(FichierIni.ReadString('Soundcard', 'CUE1', '1')) - 1);

     // JINGLE/PAD/PUB/CUE CHANNELS

  case StrToInt(FichierIni.ReadString('Multichannel', 'JIN1', '0')) of
    0: begin
        jingle1front.Checked := True;
      end;
    1: begin
        jingle1rear.Checked := True;
      end;
    2: begin
        jingle1center.Checked := True;
      end;
    3: begin
        jingle1rear2.Checked := True;
      end;
  else begin
      ShowMessage('Jingle 1 Channel a renvoyé une valeur incorrecte!');
    end;
  end;

  case StrToInt(FichierIni.ReadString('Multichannel', 'JIN2', '0')) of
    0: begin
        jingle2front.Checked := True;
      end;
    1: begin
        jingle2rear.Checked := True;
      end;
    2: begin
        jingle2center.Checked := True;
      end;
    3: begin
        jingle2rear2.Checked := True;
      end;
  else begin
      ShowMessage('Jingle 2 Channel a renvoyé une valeur incorrecte!');
    end;
  end;

  case StrToInt(FichierIni.ReadString('Multichannel', 'PAD1', '0')) of
    0: begin
        padfront.Checked := True;
      end;
    1: begin
        padrear.Checked := True;
      end;
    2: begin
        padcenter.Checked := True;
      end;
    3: begin
        padrear2.Checked := True;
      end;
  else begin
      ShowMessage('Pad Channel a renvoyé une valeur incorrecte!');
    end;
  end;

  case StrToInt(FichierIni.ReadString('Multichannel', 'PUB1', '0')) of
    0: begin
        pubfront.Checked := True;
      end;
    1: begin
        pubrear.Checked := True;
      end;
    2: begin
        pubcenter.Checked := True;
      end;
    3: begin
        pubrear2.Checked := True;
      end;
  else begin
      ShowMessage('Pub Channel a renvoyé une valeur incorrecte!');
    end;
  end;

  case StrToInt(FichierIni.ReadString('Multichannel', 'CUE1', '0')) of
    0: begin
        cue1front.Checked := True;
      end;
    1: begin
        cue1rear.Checked := True;
      end;
    2: begin
        cue1center.Checked := True;
      end;
    3: begin
        cue1rear2.Checked := True;
      end;
  else begin
      ShowMessage('Préécoute Channel a renvoyé une valeur incorrecte!');
    end;
  end;

  // RECORD OUT
  ComboBox6.ItemIndex := (StrToInt(FichierIni.ReadString('Soundcard', 'REC1', '1')) - 1);

  case StrToInt(FichierIni.ReadString('Multichannel', 'REC1', '0')) of
    0: begin
        recordfront.Checked := True;
      end;
    1: begin
        recordrear.Checked := True;
      end;
    2: begin
        recordcenter.Checked := True;
      end;
    3: begin
        recordrear2.Checked := True;
      end;
  else begin
      ShowMessage('Record Channel a renvoyé une valeur incorrecte!');
    end;
  end;

  // MySQL
  Host.Text := FichierIni.ReadString('MySQL', 'Host', 'NO VALUE');
  Login.Text := FichierIni.ReadString('MySQL', 'Login', 'NO VALUE');
  Password.Text := FichierIni.ReadString('MySQL', 'Password', 'NO VALUE');
  Database.Text := FichierIni.ReadString('MySQL', 'Base', 'NO VALUE');

  // Automation
  AUTOSILENCE.Value := StrToInt(FichierIni.ReadString('Automation', 'Silence', '8000'));
  AUTOOUT.Value := StrToInt(FichierIni.ReadString('Automation', 'Out', '10'));
  AUTOFADEOUT.Value := StrToInt(FichierIni.ReadString('Automation', 'Fade', '1200'));
  AUTOFENETRE.Value := StrToInt(FichierIni.ReadString('Automation', 'Fenetre', '800'));

  // Tones
  TONEDETECTNIVEAU.Value := StrToInt(FichierIni.ReadString('Tone', 'Niveau', '100'));
  TONEDETECTFREQ.Value := StrToInt(FichierIni.ReadString('Tone', 'Frequence', '20'));

  // DRC
  portdrc.Value := StrToInt(FichierIni.ReadString('DRC', 'Port', '0'));

  // Start
  case StrToInt(FichierIni.ReadString('Start', 'Launch', '0')) of
    0: begin
        startauto.Checked := False;
      end;
    1: begin
        startauto.Checked := True;
      end;
  else begin
      ShowMessage('AutoStart a renvoyé une valeur incorrecte!');
    end;
  end;

  case StrToInt(FichierIni.ReadString('Start', 'Locked', '0')) of
    0: begin
        startlocked.Checked := False;
      end;
    1: begin
        startlocked.Checked := True;
      end;
  else begin
      ShowMessage('AutoLock a renvoyé une valeur incorrecte!');
    end;
  end;

  FichierIni.Free;

end;

procedure TConfig.FermerClick(Sender: TObject);
begin
  Config.Close;
end;

procedure TConfig.enregistrerClick(Sender: TObject);
var
  FichierIni: TIniFile;
  Conf: integer;
begin

  FichierIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\config.ini');

  // LECTEURS CARTES
  FichierIni.WriteString('Soundcard', 'DSC1', IntToStr(ComboBox1.ItemIndex + 1));
  FichierIni.WriteString('Soundcard', 'DSC2', IntToStr(ComboBox1.ItemIndex + 1));

  if (dsc1front.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'DSC1', '0');
  end
  else if (dsc1rear.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'DSC1', '1');
  end
  else if (dsc1center.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'DSC1', '2');
  end
  else if (dsc1rear2.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'DSC1', '3');
  end;

  if (dsc2front.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'DSC2', '0');
  end
  else if (dsc2rear.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'DSC2', '1');
  end
  else if (dsc2center.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'DSC2', '2');
  end
  else if (dsc2rear2.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'DSC2', '3');
  end;

  FichierIni.WriteString('Soundcard', 'JIN1', IntToStr(ComboBox3.ItemIndex + 1));
  FichierIni.WriteString('Soundcard', 'JIN2', IntToStr(ComboBox4.ItemIndex + 1));
  FichierIni.WriteString('Soundcard', 'PAD1', IntToStr(ComboBox8.ItemIndex + 1));
  FichierIni.WriteString('Soundcard', 'PUB1', IntToStr(ComboBox7.ItemIndex + 1));
  FichierIni.WriteString('Soundcard', 'CUE1', IntToStr(ComboBox5.ItemIndex + 1));

  if (jingle1front.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'JIN1', '0');
  end
  else if (jingle1rear.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'JIN1', '1');
  end
  else if (jingle1center.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'JIN1', '2');
  end
  else if (jingle1rear2.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'JIN1', '3');
  end;

  if (jingle2front.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'JIN2', '0');
  end
  else if (jingle2rear.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'JIN2', '1');
  end
  else if (jingle2center.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'JIN2', '2');
  end
  else if (jingle2rear2.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'JIN2', '3');
  end;

  if (padfront.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'PAD1', '0');
  end
  else if (padrear.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'PAD1', '1');
  end
  else if (padcenter.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'PAD1', '2');
  end
  else if (padrear2.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'PAD1', '3');
  end;

  if (pubfront.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'PUB1', '0');
  end
  else if (pubrear.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'PUB1', '1');
  end
  else if (pubcenter.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'PUB1', '2');
  end
  else if (pubrear2.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'PUB1', '3');
  end;

  if (cue1front.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'CUE1', '0');
  end
  else if (cue1rear.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'CUE1', '1');
  end
  else if (cue1center.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'CUE1', '2');
  end
  else if (cue1rear2.Checked) then
  begin
    FichierIni.WriteString('Multichannel', 'CUE1', '3');
  end;

  // MySQL
  FichierIni.WriteString('MySQL', 'Host', Host.Text);
  FichierIni.WriteString('MySQL', 'Login', Login.Text);
  FichierIni.WriteString('MySQL', 'Password', Password.Text);
  FichierIni.WriteString('MySQL', 'Base', Database.Text);

  // Automation
  FichierIni.WriteString('Automation', 'Silence', IntToStr(AUTOSILENCE.Value));
  FichierIni.WriteString('Automation', 'Out', IntToStr(AUTOOUT.Value));
  FichierIni.WriteString('Automation', 'Fade', IntToStr(AUTOFADEOUT.Value));
  FichierIni.WriteString('Automation', 'Fenetre', IntToStr(AUTOFENETRE.Value));

  // Tones
  FichierIni.WriteString('Tone', 'Niveau', IntToStr(TONEDETECTNIVEAU.Value));
  FichierIni.WriteString('Tone', 'Frequence', IntToStr(TONEDETECTFREQ.Value));

  // DRC
  FichierIni.WriteString('DRC', 'Port', IntToStr(portdrc.Value));

  if (startauto.Checked) then
  begin
    FichierIni.WriteString('Start', 'Launch', '1');
  end
  else
  begin
    FichierIni.WriteString('Start', 'Launch', '0');
  end;

  if (startlocked.Checked) then
  begin
    FichierIni.WriteString('Start', 'Locked', '1');
  end
  else
  begin
    FichierIni.WriteString('Start', 'Locked', '0');
  end;

  Conf := MessageDlg(('Vous devez redémarrer pour que les modifications soient prises en compte. Redémarrer?'), mtInformation, mbOkCancel, 0);
  case Conf of

    idOK:
      begin
        MessageBoxA(Handle, PChar('Attention. Le logiciel va redémarrer.'), PChar('Ok'), MB_ICONINFORMATION);
        Application.Terminate;
      end;

    idCancel:
      begin
        Config.Close;
      end;

  end;
end;

procedure TConfig.TestConnectClick(Sender: TObject);
begin

  CreateDb.Enabled := False;
  CreateTablesEssentials.Enabled := False;
  CreateTablesDemo.Enabled := False;

  sql.Close;
  sql.Host := host.Text;
  sql.Login := login.Text;
  sql.Password := password.Text;
  sql.Connect;

  if sql.Connected then
  begin
    MessageDlg('Connexion réussie', mtInformation, [mbOK], 0);
    CreateDb.Enabled := True;
  end
  else
  begin
    MessageDlg('Connexion impossible', mtError, [mbOK], 0);
    sql.Close;
  end;

end;

procedure TConfig.CreateDbClick(Sender: TObject);
begin
  Sql.Query('CREATE DATABASE ' + database.Text + ';');
  MessageDlg('Database crée.', mtInformation, [mbOK], 0);
  CreateTablesEssentials.Enabled := True;
  CreateTablesDemo.Enabled := True;
end;

procedure TConfig.CreateTablesEssentialsClick(Sender: TObject);
var
  Conf: Integer;
begin

  Conf := MessageDlg(('Etes vous bien sur? Vous allez créer les tables. (si une database existe déjà, elle sera supprimée!!)'), mtWarning, mbOKCancel, 0);
  case Conf of

    idOK:
      begin

        sql.Close;
        sql.Host := host.Text;
        sql.Login := login.Text;
        sql.Password := password.Text;
        sql.Database := database.Text;
        sql.Connect;

        if sql.Connected and sql.Selected then
        begin

          Sql.Query('CREATE TABLE utilisateurs ( id int(11) NOT NULL auto_increment, login varchar(32) NOT NULL, password varchar(32) NOT NULL, valide int(1) NOT NULL, droits int(1) NOT NULL, PRIMARY KEY  (id) ) ENGINE=MyISAM  AUTO_INCREMENT=2;');
          Sql.Query('INSERT INTO utilisateurs (id, login, password, valide, droits) VALUES (1, ''sysop'', ''openstudio'', 1, 1);');

          MessageDlg('La database est opérationnelle. Installation terminée.', mtConfirmation, [mbOk], 0);
        end
        else
        begin
          MessageDlg('Connexion impossible', mtError, [mbOK], 0);
          sql.Close;
        end;

      end;

    idCancel:
      begin
        Abort;
      end;

  end;
end;

procedure TConfig.CreateTablesDemoClick(Sender: TObject);
var
  Conf: Integer;
begin

  Conf := MessageDlg(('Etes vous bien sur?'), mtWarning, mbOKCancel, 0);
  case Conf of

    idOK:
      begin

        sql.Close;
        sql.Host := host.Text;
        sql.Login := login.Text;
        sql.Password := password.Text;
        sql.Database := database.Text;
        sql.Connect;

        if sql.Connected and sql.Selected then
        begin

          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (1, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''POWERPLAY'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (2, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (3, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TUBE80'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (4, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (5, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TUBE90'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (6, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (7, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TOP2000'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (8, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (9, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TUBE80'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (10, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (11, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''POWERPLAY'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (12, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (13, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TUBE90'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (14, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (15, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TOP2000'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (16, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (17, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TUBE90'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (18, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (19, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''POWERPLAY'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (20, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (21, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TUBE80'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (22, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (23, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TOP2000'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (24, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (25, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TUBE90'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (26, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (27, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''POWERPLAY'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (28, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (29, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TOP2000'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (30, ''PROGRAMESEMAINE'', ''JINGLES'', ''JINGLES'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (31, ''PROGRAMESEMAINE'', ''MUSIQUES'', ''TOP2000'');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (32, ''PUB'', ''PUBIN'', '''');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (33, ''PUB'', ''COMBLAGE'', '''');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (34, ''TOPHORAIRE'', ''PUBIN'', '''');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (35, ''TOPHORAIRE'', ''COMBLAGE'', '''');');
          Sql.Query('INSERT INTO canvas (id, format, Categorie, ssCategorie) VALUES (36, ''TOPHORAIRE'', ''TOP HORAIRE'', '''');');


          Sql.Query('INSERT INTO categories (id, nom) VALUES (1, ''Jingles'');');
          Sql.Query('INSERT INTO categories (id, nom) VALUES (2, ''Musiques'');');
          Sql.Query('INSERT INTO categories (id, nom) VALUES (3, ''Intro titre'');');
          Sql.Query('INSERT INTO categories (id, nom) VALUES (4, ''PubIn'');');
          Sql.Query('INSERT INTO categories (id, nom) VALUES (5, ''Mixage fin de titre'');');
          Sql.Query('INSERT INTO categories (id, nom) VALUES (6, ''Comblage'');');
          Sql.Query('INSERT INTO categories (id, nom) VALUES (7, ''Top Horaire'');');
          Sql.Query('INSERT INTO categories (id, nom) VALUES (8, ''Pub'');');
          Sql.Query('INSERT INTO categories (id, nom) VALUES (9, ''PubLocale'');');
          Sql.Query('INSERT INTO categories (id, nom) VALUES (10, ''PubNationale'');');
          Sql.Query('INSERT INTO categories (id, nom) VALUES (11, ''PubPromo'');');
          Sql.Query('INSERT INTO categories (id, nom) VALUES (12, ''Système'');');

          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (1, 0, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (2, 1, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (3, 2, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (4, 3, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (5, 4, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (6, 5, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (7, 6, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (8, 7, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (9, 8, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (10, 9, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (11, 10, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (12, 11, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (13, 12, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (14, 13, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (15, 14, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (16, 15, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (17, 16, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (18, 17, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (19, 18, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (20, 19, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (21, 20, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (22, 21, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (23, 22, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (24, 23, 59, 46, ''TOPHORAIRE'', 1, 10);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (25, 0, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (26, 0, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (28, 0, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (29, 1, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (30, 1, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (32, 1, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (33, 2, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (34, 2, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (36, 2, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (37, 3, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (38, 3, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (40, 3, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (41, 4, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (42, 4, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (44, 4, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (45, 5, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (46, 5, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (48, 5, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (49, 6, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (50, 6, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (52, 6, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (53, 7, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (54, 7, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (56, 7, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (57, 8, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (58, 8, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (60, 8, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (61, 9, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (62, 9, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (64, 9, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (65, 10, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (66, 10, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (68, 10, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (69, 11, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (70, 11, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (72, 11, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (73, 12, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (74, 12, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (76, 12, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (77, 13, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (78, 13, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (80, 13, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (81, 14, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (82, 14, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (84, 14, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (85, 15, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (86, 15, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (88, 15, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (89, 16, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (90, 16, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (92, 16, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (93, 17, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (94, 17, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (96, 17, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (97, 18, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (98, 18, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (100, 18, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (101, 19, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (102, 19, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (104, 19, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (105, 20, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (106, 20, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (108, 20, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (109, 21, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (110, 21, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (112, 21, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (113, 22, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (114, 22, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (116, 22, 47, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (117, 23, 7, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (118, 23, 27, 0, ''PUB'', 0, 180);');
          Sql.Query('INSERT INTO grillepub (id, heure, minute, seconde, canvas, prior, duree) VALUES (120, 23, 47, 0, ''PUB'', 0, 180);');


          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (1, ''Musiques'', ''2000'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (2, ''Musiques'', ''1990'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (3, ''Musiques'', ''1980'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (4, ''Musiques'', ''1970'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (5, ''Musiques'', ''1960'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (6, ''Musiques'', ''1950'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (7, ''Musiques'', ''Dance'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (8, ''Musiques'', ''Funk'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (9, ''Musiques'', ''House'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (10, ''Musiques'', ''Techno'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (11, ''Musiques'', ''Soul'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (12, ''Musiques'', ''Rap'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (13, ''Musiques'', ''Ete'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (14, ''Musiques'', ''Noel'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (15, ''Musiques'', ''Reggae'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (16, ''Musiques'', ''Pop'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (17, ''Musiques'', ''Variété'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (18, ''Musiques'', ''NewWave'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (19, ''Musiques'', ''Disco'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (21, ''Musiques'', ''Tube60'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (22, ''Musiques'', ''Tube70'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (23, ''Musiques'', ''Tube80'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (24, ''Musiques'', ''Tube90'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (25, ''Musiques'', ''RNB'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (26, ''Musiques'', ''Country'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (27, ''Musiques'', ''Rock'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (28, ''Musiques'', ''Swing'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (29, ''Musiques'', ''Charleston'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (30, ''Musiques'', ''Oldies'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (31, ''Musiques'', ''Slow'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (32, ''Musiques'', ''Commercial'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (33, ''Musiques'', ''Blues'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (34, ''Musiques'', ''Ska'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (35, ''Musiques'', ''Top2000'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (36, ''Musiques'', ''PowerPlay'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (37, ''Jingles'', ''Jingles'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (38, ''Jingles'', ''Liners'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (39, ''Jingles'', ''Station ID'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (40, ''Jingles'', ''Accaps'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (41, ''Jingles'', ''Effets'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (42, ''Jingles'', ''Promos'');');
          Sql.Query('INSERT INTO sscategories (id, categorie, nom) VALUES (43, ''Jingles'', ''Hitmix'');');


          MessageDlg('La database est opérationnelle. Installation terminée.', mtConfirmation, [mbOk], 0);
        end
        else
        begin
          MessageDlg('Connexion impossible', mtError, [mbOK], 0);
          sql.Close;
        end;

      end;

    idCancel:
      begin
        Abort;
      end;

  end;
end;

end.
