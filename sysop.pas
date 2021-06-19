unit sysop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ImgList;

type
  Tformsysop = class(TForm)
    debug: TMemo;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ImageList1: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  formsysop: Tformsysop;

implementation

uses Unit1;

{$R *.dfm}

procedure Tformsysop.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure Tformsysop.ToolButton1Click(Sender: TObject);
begin
  Form1.Show;
end;

procedure Tformsysop.ToolButton2Click(Sender: TObject);
begin
  Form1.Hide;
end;

end.
