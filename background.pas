unit background;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls;

type
  TMyBackground = class(TForm)
    Logo: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  MyBackground: TMyBackground;

implementation

uses U_Clock, U_Main, Unit1; //Editeur

{$R *.dfm}

procedure TMyBackground.FormCreate(Sender: TObject);
begin
  MyBackground.Height := GetSystemMetrics(SM_CYSCREEN);
  MyBackground.Width := GetSystemMetrics(SM_CXSCREEN);
  MyBackground.Top := 0;
  MyBackground.Left := 0;
  MyBackground.SendToBack;
  Logo.Top := (GetSystemMetrics(SM_CYSCREEN) div 2) - (Logo.Height div 2);
  Logo.Left := (GetSystemMetrics(SM_CXSCREEN) div 2) - (Logo.Width div 2);
end;

procedure TMyBackground.FormActivate(Sender: TObject);
begin
  MyBackground.SendToBack;
  if (Clock.Visible) then Clock.BringToFront;
  if (Main.Visible) then Main.BringToFront;
  if (Form1.Visible) then Form1.BringToFront;
  //if (Editor.Visible) then Editor.BringToFront;
end;

end.
