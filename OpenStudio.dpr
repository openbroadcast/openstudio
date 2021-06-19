program OpenStudio;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Bass in 'Bass.pas',
  U_About in 'U_About.pas' {About},
  U_Splash in 'U_Splash.pas' {Splash},
  U_VerifSerial in 'U_VerifSerial.pas' {VerifSerial},
  U_Waitlist in 'U_Waitlist.pas' {Waitlist},
  U_Clock in 'U_Clock.pas' {clock},
  U_Main in 'U_Main.pas' {Main},
  U_Bibliotheque in 'U_Bibliotheque.pas' {Bibliotheque},
  U_Config in 'U_Config.pas' {Config},
  U_Events in 'U_Events.pas' {Events},
  serverweb in 'serverweb.pas' {ServerPage},
  sysop in 'sysop.pas' {formsysop},
  background in 'background.pas' {MyBackground},
  Session in 'Session.pas' {OpenSessionForm},
  //Editeur in 'Editeur.pas' {Editor},
  mysql in 'mysql.pas',
  mysqlcomp in 'mysqlcomp.pas',
  Midi in 'Midi.pas';

{$E .exe}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'OpenStudio';
  Application.CreateForm(TSplash, Splash);
  Application.CreateForm(TVerifSerial, VerifSerial);
  Application.Run;
end.

