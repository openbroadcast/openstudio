unit U_VerifSerial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles;

type
  TVerifSerial = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  VerifSerial: TVerifSerial;

implementation

{$R *.dfm}

procedure TVerifSerial.BitBtn2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TVerifSerial.BitBtn1Click(Sender: TObject);
var Inifile: TInifile;
begin

  if (Edit1.Text = '') or (Edit2.Text = '') then
  begin
    MessageDlg('Veuillez entrer vos informations !', mtError, [mbOK], 0);
  end
  else
  begin

    IniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\user.reg');
    IniFile.WriteString('Registration', 'Name', Edit1.Text);
    IniFile.WriteString('Registration', 'Serial', Edit2.Text);
    Inifile.Free;

    MessageDlg(('Vos informations ont été ajoutées au fichier de License.' + #13 + 'Veuillez redémarrer le logiciel pour prendre ces informations en compte.'), mtCustom, [MbOK], 0);

    Application.Terminate;

  end;

end;

procedure TVerifSerial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.Terminate;
end;

end.
