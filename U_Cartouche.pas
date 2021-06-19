unit U_Cartouche;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvGIF, StdCtrls;

type
  Tcartoucheur = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  cartoucheur: Tcartoucheur;

implementation

{$R *.dfm}

procedure Tcartoucheur.Image1Click(Sender: TObject);
begin
ShowMessage('Play');
end;

procedure Tcartoucheur.Image2Click(Sender: TObject);
begin
ShowMessage('Stop');
end;

procedure Tcartoucheur.Image3Click(Sender: TObject);
begin
ShowMessage('Load');
end;

procedure Tcartoucheur.Panel1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  ReleaseCapture;
  Perform (WM_SYSCOMMAND, SC_MOVE or HTCAPTION, 0);
end;

end.
