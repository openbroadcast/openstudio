unit serverweb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ShellAPI, Dialogs, StdCtrls, ScktComp, ExtCtrls;

type TServerPage = class(TForm)
    ServerWeb: TServerSocket;
    MemoHistory: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure ServerWebClientRead(Sender: TObject; Socket: TCustomWinSocket);
  end;


var
  ServerPage: TServerPage;
  Html: string;

implementation

uses Unit1;
{$R *.dfm}

{ Initialisation : on active la socket }

procedure TServerPage.FormCreate(Sender: TObject);
begin
  ServerWeb.Port := 8585;
  ServerWeb.Active := True;
end;

{ Quand un client (IE par exemple) se connecte on execute le code suivant ( renvoi page HTML ) }

procedure TServerPage.ServerWebClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  Position: Integer;
  TxtRecu, Commande: string;
begin

    { Un client est connecté, on recupère ce qu'il nous envoi }
  TxtRecu := Socket.ReceiveText;

    { Petit bout de code pour récupérer les actions sur les boutons et effectuer l'action désiré !  }
  Position := Pos('commande=', TxtRecu) + 9;

  if Position > 9 then
  begin
    Commande := Copy(TxtRecu, Position, Pos(' ', Copy(TxtRecu, Position, Length(TxtRecu))));
    if (Trim(UpperCase(commande)) = 'P_A_NEXT') then Form1.fadem1.Click();
    if (Trim(UpperCase(commande)) = 'P_B_NEXT') then Form1.fadem2.Click();
  end;

    { Affiche dernière action effectué }
  MemoHistory.Clear;
  MemoHistory.Lines.Add('------------------------------------');
  MemoHistory.Lines.Add('Client : ' + Socket.RemoteAddress);
  MemoHistory.Lines.Add('A      : ' + DateTimeToStr(Now));
  MemoHistory.Lines.Add('------------------------------------');
  MemoHistory.Lines.Add(' Action  : ' + Commande);
  MemoHistory.Lines.Add('------------------------------------');

  Html := 'HTTP/1.0 200 OK' + #10#13 +
    'Server:  miniserver 1.0' + #10#13 +
    'X-Powered-By: Delphi7' + #10#13 +
    'Keep-Alive: timeout=15, max=99' + #10#13 +
    'Connection: Keep-Alive' + #10#13 +
    'Content-Type: text/html; charset=ISO-8859-1;' + #10#13 + #10#13 +
    '<?xml version="1.0" encoding="ISO-8859-1" ?>' + #10 +
    '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">' + #10 +
    '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">' + #10 +
    '<head>' + #10 +
    '<title>miniserv 1.0</title>' + #10 +
    '<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1;" />' + #10 +
    '<meta http-equiv="Content-Language" content="fr" />' + #10 +
    '</head>' + #10 +
    '<body>' + #10 +
    '<h1>Welcome to miniserver 1.0</h1>' + #10 +
    '<input type="submit" onclick="javascript:window.location=''/?commande=P_A_NEXT'';" name="commande" value="Player A Next">  ' + #10 +
    '<input type="submit" onclick="javascript:window.location=''/?commande=P_B_NEXT'';" name="commande" value="Player B Next">' + #10 +
    '</body>' + #10 +
    '</html>';

    { Envoi de la page au client }
  Socket.SendText(Html);
  Application.ProcessMessages;

    { Fin, on ferme tout jusqu'à la prochaine demande }
  Socket.Close;

end;


end.
