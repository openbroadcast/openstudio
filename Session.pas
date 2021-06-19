unit Session;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, MysqlComponent;

type
  TOpenSessionForm = class(TForm)
    login: TEdit;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    password: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure loginKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    { Déclarations publiques }
  end;

var
  OpenSessionForm: TOpenSessionForm;

implementation

uses Unit1, U_Main;

{$R *.dfm}

procedure TOpenSessionForm.BitBtn1Click(Sender: TObject);
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
begin

  if Main.sql.Connected = true then
  begin

    Res := Main.sql.Query('SELECT droits FROM utilisateurs WHERE login=''' + login.text + ''' AND password=''' + password.text + ''' AND valide;');
    Row := Main.sql.fetch_row(Res);

    if Row = nil then
    begin
      MessageDlg('Login ou mot de passe incorrect !', mtError, [mbOK], 0);
      password.Text := '';
      OpenSessionForm.ActiveControl := Login;
    end
    else
    begin
      password.Text := '';
      login.Text := '';

      if (Main.ModeAuto = True) then
      begin
        Main.ButtonDJ.Enabled := True;
      end
      else
      begin
        Main.ButtonDJ.Enabled := True;
        Main.ButtonAuto.Enabled := True;
      end;

      Main.ModeLocked := False;
      ModalResult := mrOk;
    end;

  end;

end;

procedure TOpenSessionForm.BitBtn2Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TOpenSessionForm.loginKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then // ENTER
    BitBtn1Click(sender);
end;


procedure TOpenSessionForm.FormShow(Sender: TObject);
begin
  OpenSessionForm.ActiveControl := Login;
end;

end.
