unit U_About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TAbout = class(TForm)
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private

  public
    { Déclarations publiques }
  end;

var
  About: TAbout;

implementation

uses U_Splash;

{$R *.dfm}

function ApplicationVersion: string;
var
  VerInfoSize, VerValueSize, Dummy: DWord;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  {Deux solutions : }
  if VerInfoSize <> 0 then
  {- Les info de version sont inclues }
  begin
    {On alloue de la mémoire pour un pointeur sur les info de version : }
    GetMem(VerInfo, VerInfoSize);
    {On récupère ces informations : }
    GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
    VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
    {On traite les informations ainsi récupérées : }
    with VerValue^ do
    begin
      Result := IntTostr(dwFileVersionMS shr 16);
      Result := Result + '.' + IntTostr(dwFileVersionMS and $FFFF);
      Result := Result + '.' + IntTostr(dwFileVersionLS shr 16);
      Result := Result + '.' + IntTostr(dwFileVersionLS and $FFFF);
    end;

    {On libère la place précédemment allouée : }
    FreeMem(VerInfo, VerInfoSize);
  end

  else
    {- Les infos de version ne sont pas inclues }
    {On déclenche une exception dans le programme : }
    raise EAccessViolation.Create('0.0.0.0');
end;

procedure TAbout.FormCreate(Sender: TObject);
begin
  Label4.Caption := ApplicationVersion;
  Label6.Caption := Splash.Name_File;
end;

procedure TAbout.BitBtn1Click(Sender: TObject);
begin
  ModalResult := mrOk // Close
end;

end.
