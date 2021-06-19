unit U_Clock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg;

type
  Tclock = class(TForm)
    heure: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    timer: TLabel;
    decompte: TLabel;
    panel: TPanel;
    date: TLabel;
    Image1: TImage;
    procedure panelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  clock: Tclock;

implementation

uses U_About;

{$R *.dfm}

procedure Tclock.panelMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, SC_MOVE or HTCAPTION, 0);
end;

procedure Tclock.FormCreate(Sender: TObject);
begin
  clock.Width := GetSystemMetrics(SM_CXSCREEN);
  clock.Top := 0;
  clock.Left := 0;
end;

procedure Tclock.Image1DblClick(Sender: TObject);
begin
  About.ShowModal;
end;

end.
