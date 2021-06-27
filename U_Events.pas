unit U_Events;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, ExtCtrls, MysqlComponent, BASS, Midi;

type
  TEvents = class(TForm)
    diffuser: TBitBtn;
    StringGrid1: TStringGrid;
    pageclignote: TTimer;
    findevents: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    total: TLabel;
    fin: TLabel;
    compteur: TTimer;
    decompte: TTimer;
    findnextevents: TTimer;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure pageclignoteTimer(Sender: TObject);
    procedure findeventsTimer(Sender: TObject);
    procedure diffuserClick(Sender: TObject);
    procedure compteurTimer(Sender: TObject);
    procedure decompteTimer(Sender: TObject);
    procedure findnexteventsTimer(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    color: Integer;
    totalsec, totalsec2: Double;
    pagedepub, pagedepubPrior: Boolean;
    NextEvent, NextEventDateTime: string;
    { Déclarations publiques }
  end;

var
  Events: TEvents;

implementation

uses Unit1, U_Clock, U_Main, sysop;

{$R *.dfm}

procedure TEvents.FormCreate(Sender: TObject);
begin
  color := 1;
  totalsec := 0;
  pagedepub := False;
  EnableMenuItem(GetSystemMenu(handle, False), SC_CLOSE, MF_BYCOMMAND or MF_GRAYED);
end;


procedure TEvents.pageclignoteTimer(Sender: TObject);
begin
  if (color = 1) then
  begin
    StringGrid1.Color := $0080FFFF;
    color := 2;
    //Events.BringToFront;
  end
  else
  begin
    StringGrid1.Color := clWhite;
    color := 1;
  end;
end;

procedure TEvents.findeventsTimer(Sender: TObject);
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  i, j, k: integer;
  Duree: Double;
  RequestSQL: string;
begin

  if (FormatDateTime('hh:mm:ss', Time) = NextEvent) then
  begin
    findevents.Enabled := False; // je me coupe si non je me relance!
    // Ci dessous, expérimental, attendre que le findevends sont à Enabled := False avant d'éxécuter..
    if Main.sql.Connected and findevents.Enabled = False then
    begin
      try

        RequestSQL := 'SELECT timer.Id, artistes.Name, playlist.Titre, playlist.Annee, playlist.Duree, timer.Frequence, ';
        RequestSQL := RequestSQL + 'timer.Tempo, timer.Intro, timer.Prior, timer.FadeIn, timer.FadeOut, playlist.Path, playlist.Categorie, ';
        RequestSQL := RequestSQL + 'playlist.ssCategorie, timer.FadeOut ';
        RequestSQL := RequestSQL + 'FROM timer ';
        RequestSQL := RequestSQL + 'LEFT JOIN playlist ON (playlist.id=timer.PlaylistID) ';
        RequestSQL := RequestSQL + 'LEFT JOIN artistes ON (artistes.id=playlist.Artiste) ';
        RequestSQL := RequestSQL + 'WHERE timer.Date_Play=''' + NextEventDateTime + ''' ';
        RequestSQL := RequestSQL + 'ORDER by timer.Date_Play, timer.id ASC;';

        Res := Main.sql.Query(RequestSQL);
        Main.sql.query('UPDATE timer SET Joue=1, Date_Joue=NOW() WHERE Date_Play=''' + NextEventDateTime + ''';');

        if Main.sql.num_rows(Res) <> 0 then
        try

          totalsec := 0;

          for k := 0 to StringGrid1.RowCount - 1 do
          begin
            StringGrid1.Rows[k].Clear;
          end;

          StringGrid1.Show;
          StringGrid1.ColCount := 15;
          StringGrid1.RowCount := Main.sql.num_rows(Res);

          StringGrid1.ColWidths[0] := 0; // ID
          StringGrid1.ColWidths[1] := 190; // Artiste
          StringGrid1.ColWidths[2] := 190; // Titre
          StringGrid1.ColWidths[3] := 0; // Annee
          StringGrid1.ColWidths[4] := 45; // Duree
          StringGrid1.ColWidths[5] := 0; // Freq
          StringGrid1.ColWidths[6] := 0; // Tempo
          StringGrid1.ColWidths[7] := 0; // Into
          StringGrid1.ColWidths[8] := 0; // Prior
          StringGrid1.ColWidths[9] := 0; // FadeIn
          StringGrid1.ColWidths[10] := 0; // FadeOut
          StringGrid1.ColWidths[11] := 0; // Path
          StringGrid1.ColWidths[12] := 0; // Cat
          StringGrid1.ColWidths[13] := 0; // SSCat
          StringGrid1.ColWidths[14] := 0; // FadeOut

          j := 0;
          Row := Main.sql.fetch_row(Res);
          while Row <> nil do
          begin
            for i := 0 to StringGrid1.ColCount do
            begin

              if (i = 8) then
              begin
                if (Row[i] = '1') then
                begin
                  pagedepubPrior := True;
                end;
              end
              else if (i = 10) then
              begin
                Duree := StrToFloat(StringReplace(Row[i], '.', ',', [rfReplaceAll]));
                StringGrid1.Cells[i, j] := format('%2.2d:%2.2d', [trunc(Duree) div 60, trunc(Duree) mod 60]);
              end
              else if (i = 14) then
              begin
                totalsec := totalsec + StrToFloat(StringReplace(Row[i], '.', ',', [rfReplaceAll]));
                StringGrid1.Cells[i, j] := Row[i];
              end
              else
              begin
                StringGrid1.Cells[i, j] := Row[i];
              end;
            end;
            Row := Main.sql.fetch_row(Res);
            j := j + 1;
          end;
        finally
          if (main.ButtonAuto.Enabled = True) then Events.Show; pageclignote.Enabled := True; // Je m'affiche seulement si on est en mode DJ
          total.Caption := format('%2.2d:%2.2d:%2.2d', [0, trunc(totalsec) div 60, trunc(totalsec) mod 60]);
          Clock.decompte.Caption := format('%2.2d:%2.2d:%2.2d', [0, trunc(totalsec) div 60, trunc(totalsec) mod 60]);
          totalsec2 := totalsec;
          compteur.Enabled := True;
          pagedepub := True; // Page à diffuser
        end;

        Main.sql.free_result(Res);
      except;
      end;
      findevents.Enabled := True; // On rallume
    end;
  end;
end;

procedure TEvents.diffuserClick(Sender: TObject);
var
  i, j: Integer;
begin

  if ((StringGrid1.Rowcount) <> 0) then
  begin
  // Vider la liste pub à lire
    for j := 0 to Form1.StringGrid4.Rowcount - 1 do
    begin
      Form1.StringGrid4.Rows[j].clear;
    end;
    Form1.StringGrid4.rowcount := 1;
    Form1.isg4 := 0;

  // La remplire de notre waitlist
    for i := 0 to StringGrid1.RowCount - 1 do
    begin
      Form1.StringGrid4.Cells[0, Form1.isg4] := StringGrid1.cells[0, i];
      Form1.StringGrid4.Cells[1, Form1.isg4] := StringGrid1.cells[1, i];
      Form1.StringGrid4.Cells[2, Form1.isg4] := StringGrid1.cells[2, i];
      Form1.StringGrid4.Cells[3, Form1.isg4] := StringGrid1.cells[4, i];
      Form1.StringGrid4.Cells[4, Form1.isg4] := StringGrid1.cells[14, i]; //Fadeout
      Form1.StringGrid4.Cells[5, Form1.isg4] := StringGrid1.cells[11, i]; //Path
      Form1.isg4 := (Form1.isg4 + 1);
      Form1.StringGrid4.RowCount := Form1.isg4;
      StringGrid1.Rows[i].Clear;
    end;
    StringGrid1.RowCount := 1;

   // Activer
    Events.Hide;
    pageclignote.Enabled := False;
    compteur.Enabled := False;
    Form1.pubplay.Click(); // Play

   // Automation
    pagedepub := False; // Plus rien à passer
    pagedepubPrior := False; // Plus rien à passer (Prior)
    Main.automix.Enabled := False;
    Main.protection.Enabled := False;

   // Bloquer l'entrée et la sortie
    Main.ButtonDJ.Enabled := False;
    Main.ButtonAuto.Enabled := False;

   // Reseter les variables d'automation (Preload)
    Main.Player1PreLoad := False;
    Main.Player2PreLoad := False;

   // Log
    Main.log('Lancement plage pub', True);

  // Protection!
    if(false) then
    begin
      MidiOutput.Send(0, $E0, $00, $00);
      MidiOutput.Send(0, $E1, $00, $00);
      MidiOutput.Send(0, $E2, $00, $00);
      MidiOutput.Send(0, $E3, $00, $00);
      MidiOutput.Send(0, $E4, $00, $00);
      MidiOutput.Send(0, $E5, $00, $00);
    end;

  end;
end;

procedure TEvents.compteurTimer(Sender: TObject);
begin
  fin.caption := FormatDateTime('hh:mm:ss', Now + (totalsec2 / 86400));
end;

procedure TEvents.decompteTimer(Sender: TObject);
var
  MS: TMemoryStatus;
begin

  // Horloge
  clock.heure.Caption := FormatDateTime('hh:mm:ss', Time);
  clock.date.Caption := FormatDateTime('dddd dd mmmm YYYY', Date);

  GlobalMemoryStatus(MS);
  Main.Memory1.Caption := FormatFloat('"Mémoire: "#,#" Ko"', (Ms.dwAvailPhys / 1024)) + FormatFloat('"/"#,###" Ko"', (MS.dwTotalPhys / 1024)) + Format(' (%d %%)', [MS.dwMemoryLoad]);

  // Si le player pub tourne, on active le décompte
  if ((BASS_ChannelIsActive(Form1.pub1) = 1)) then
  begin
    totalsec2 := totalsec2 - 1;
    clock.decompte.Caption := format('%2.2d:%2.2d:%2.2d', [0, trunc(totalsec2) div 60, trunc(totalsec2) mod 60]);

    if (totalsec2 < 0) then
    begin
      clock.decompte.Caption := '00:00:00';
    end;

  end
  else
  begin

  // Protection, si la prochaine pub est passé, on réactive.
    if (FormatDateTime('hh:mm:ss', Time) >= NextEvent) then
    begin
      findevents.Enabled := True;
      findnextevents.Enabled := True;
    end;
  end;

end;

procedure TEvents.findnexteventsTimer(Sender: TObject);
var
  Res, Res2: PMYSQL_RES;
  Row, Row2: PMYSQL_ROW;
  i: Integer;
begin

  if Main.sql.Connected = true then
  begin

    Res := Main.sql.Query('SELECT id, DATE_FORMAT(Date_Play, ''%H:%i:%s'') AS debut_heure_fr, Date_Play FROM timer WHERE Date_Play > NOW() AND Joue=0 ORDER by Date_Play ASC;');
    Row := Main.sql.fetch_row(Res);

    if Row = nil then
    begin
      clock.timer.Caption := '00:00:00';
      Main.timer.Caption := '';
    end
    else
    begin
      clock.timer.Caption := Row[1];
      Main.timer.Caption := 'Timer: ' + Row[1];
      NextEvent := Row[1];
      NextEventDateTime := Row[2];
      findnextevents.Enabled := False; // Timer désactivé!

      // Nombre de sec de la plage
      totalsec := 0;

      Res2 := Main.sql.Query('SELECT playlist.Duree FROM timer LEFT JOIN playlist ON (playlist.id=timer.PlaylistID) WHERE timer.Date_Play=''' + NextEventDateTime + ''' ORDER by timer.Date_Play ASC;');
      Row2 := Main.sql.fetch_row(Res2);
      while Row2 <> nil do
      begin
        for i := 0 to 0 do
        begin
          totalsec := totalsec + StrToFloat(StringReplace(Row2[i], '.', ',', [rfReplaceAll]));
        end;
        Row2 := Main.sql.fetch_row(Res2);
      end;

      Clock.decompte.Caption := format('%2.2d:%2.2d:%2.2d', [0, trunc(totalsec) div 60, trunc(totalsec) mod 60]);

   // Log
      Main.log('Page de pub trouvée. Heure: ' + Row[1], True);

      // Nombre de sec de la plage
    end;

    Main.sql.free_result(Res); // Libère la mémoire
  end;
end;

procedure TEvents.BitBtn2Click(Sender: TObject);
var
  i: Integer;
begin

  for i := 0 to StringGrid1.RowCount - 1 do
  begin
    StringGrid1.Rows[i].Clear;
  end;

  pagedepub := False; // Plus rien à passer
  Events.Hide;
  pageclignote.Enabled := False;
  compteur.Enabled := False;
end;

end.

