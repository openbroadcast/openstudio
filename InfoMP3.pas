{InfoMP3 V1.0

Ce composant est un freeware écrit par ZeuS-[SFX] du groupe SFX TeAm.Visiter notre
site www.sfxteam.fr.st et tester nos applications entierement freeware :)
Si vous éffectué des modifications veuillez m'en informer et me les envoyés pour mettre le
composant à jour

Soyez indulgent je ne suis pas un expert en programation donc si vous trouvez des améliorations
à faire prévenez moi

écrivez moi pour tout bug ou autre : zeusfx@free.fr

InfoMP3 est un composant qui permet de récupérer les informations d'un MP3

Récupération de la Version Audio ,Version du Layer,Protection,Bitrate,SampleRate,Tailledeframe
nombre de frame,durée,Channelmode,ExtensionChannelMode,Copyright,OriginalVersion,Emphasis


Récupération de l'ID3 version 1.0
Titre
Artiste
Album
Commentaire
Genre
Annee


La récupération de la version 2 de l'ID3 est en cours
ainsi qu'un correctif du temps et du bitrate variable

je compte aussi permettre l'écriture de l'ID3
}



unit InfoMP3;

interface
uses
  Windows, SysUtils, Classes,StdCtrls;

{------------------------------------------------------------------------------}
{                                CONSTANTES                                    }
{------------------------------------------------------------------------------}
Const
 Tgenre: array [0..125] of string=('Blues','Classic Rock','Country','Dance','Disco','Funk','Grunge','Hip-Hop','Jazz','Metal','New Age','Oldies','Other','Pop','R&B','Rap','Reggae','Rock','Techno','Industrial',{20}
'Alternative','Ska','Death Metal','Pranks','Soundtrack','Euro-Techno','Ambient','Trip-Hop','Vocal','Jazz+Funk','Fusion','Trance','Classical','Instrumental','Acid','House','Game','Sound Clip','Gospel','Noise',{20}
'AlternRock','Bass','Soul','Punk','Space','Meditative','Instrumental Pop','Instrumental Rock','Ethnic','Gothic','Darkwave','Techno-Industrial','Electronic','Pop-Folk','Eurodance','Dream','Southern Rock','Comedy','Cult','Gangsta',{20}
'Top 40','Christian Rap','Pop/Funk','Jungle','Native American','Cabaret','New Wave','Psychadelic','Rave','Showtunes','Trailer','Lo-Fi','Tribal','Acid Punk','Acid Jazz','Polka','Retro','Musical','Rock & Roll','Hard Rock', {20}
'Folk','Folk-Rock','National Folk','Swing','Fast Fusion','Bebob','Latin','Revival','Celtic','Bluegrass','Avantgarde','Gothic Rock','Progressive Rock','Psychedelic Rock','Symphonic Rock','Slow Rock','Big Band',
'Chorus','Easy Listening','Acoustic','Humour','Speech','Chanson','Opera','Chamber Music','Sonata','Symphony','Booty Brass','Primus','Porn Groove','Satire','Slow Jam','Club','Tango','Samba','Folklore','Ballad',
'Poweer Ballad','Rhytmic Soul','Freestyle','Duet','Punk Rock','Drum Solo','A Capela','Euro-House','Dance Hall');

 TaudioVersion: array [0..3] of string=('MPEG Version 2.5','Reserved','MPEG Version 2 (ISO/IEC 13818-3)','MPEG Version 1 (ISO/IEC 11172-3)');

 Tlayer:array [0..3] of string=('reserved','Layer III','Layer II','Layer I');

Tbitrate:array [0..15,1..5] of integer=
(
(0,0,0,0,0),
(32,32,32,32,8),
(64,48,40,48,16),
(96,56,48,56,24),
(128,64,56,64,32),
(160,80,64,80,40),
(192,96,80,96,48),
(224,112,96,112,56),
(256,128,112,128,64),
(288,160,128,144,80),
(320,192,160,160,96),
(352,224,192,176,112),
(384,256,224,192,128),
(416,320,256,224,144),
(448,384,320,256,160),
(0,0,0,0,0)
);


Tsamplerate:array [0..3,1..3] of integer=
(
(44100,22050,11025),
(48000,24000,12000),
(32000,16000,8000),
(0,0,0)
);

Tchannel:array [0..3]of string =('Stereo','Joint stereo (Stereo)','Dual channel (Stereo)','Single channel (Mono)');

Tchannelextension:array [0..3,1..2] of string=
(
('bande 4 à 31','intensité stéréo: OFF , MS Stéréo: OFF'),
('bande 8 à 31','intensité stéréo: ON , MS Stéréo: OFF'),
('bande 12 à 31','intensité stéréo: OFF , MS Stéréo: ON'),
('bande 16 à 31','intensité stéréo: ON , MS Stéréo: ON')
);

Temphasis:array [0..3] of string=('aucun','50/15 ms','reservé','CCIT J.17');
{------------------------------------------------------------------------------}
{                                RECORD                                        }
{------------------------------------------------------------------------------}
Type
    tagID3=record                       {TAG ID3 V1.0 C'est à dire les informations personnel sur la music}
    Tagheader: array [1..3] of char;    {Le header du TAG doit etre 'TAG'}
    Titre: array [1..30] of char;       {Le Titre de la music, 30 caractère}
    Artiste: array [1..30] of char;     {L'artiste de la music, 30 caractère}
    Album: array [1..30] of char;       {Le nom de l'album, 30 caractère}
    annee: array [1..4] of char;        {l'annee de la music, forme AAAA}
    commentaire:array [1..30] of char;  {Commentaire sur la music, 30 caractère}
    Genre:byte;                         {Le type de Music 1 octect correspond à 255 type de music voir la liste}
end;
Type
   header=record
   header: byte;
   header1:byte;
   header2:byte;
   header3:byte;
end;

type
    temps=record
    heures:integer;
    minutes:integer;
    secondes:integer;
    full:integer;
end;
Type
    TInfoMP3 = class(TComponent)
   private
    entete:header;
    id3:tagID3;

    MAudioversion:string;
    Mlayertype:string;
    Mprotected:string;
    Mbitrate:integer;
    msamplingrate:integer;
    mpaddingbit:string;
    mtailleframe:integer;
    mchannelmode:string;
    mextendedchannel:string;
    mcopyright:string;
    moriginal:string;
    memphasis:string;
    mduree:temps;
    full:temps;
    mtaille:integer;
    mnbr_de_frame:integer;
    MTitre:string;
    Martiste:string;
    Malbum:string;
    Mcommentaire:string;
    Mgenre:byte;
    Mannee:string;
    procedure init;
    function Getgenre:string;
    function recupereID3(fichier:string):boolean;
    function recuperheader(fichier:string):boolean;
   public
    function GetMP3Info(Filename:string):boolean;


    property AudioVersion:string read MAudioversion;
    property LayerVersion:string read Mlayertype;
    property Protection:string read Mprotected;
    property Bitrate:integer read Mbitrate;
    property SampleRate:integer read msamplingrate;
    property Tailledeframe:integer read mtailleframe;
    property Channelmode:string read mchannelmode;
    property ExtensionChannelMode:string read mextendedchannel;
    property Copyright:string read mcopyright;
    property OriginalVersion:string read moriginal;
    property Emphasis:string read memphasis;
    property tailledufichier:integer read mtaille;
    property nbr_de_frame:integer read mnbr_de_frame;
    property duree:temps read mduree;


    property Titre:string read MTitre;
    property Artiste:string read Martiste;
    property Album:string read MAlbum;
    property Commentaire:string read Mcommentaire;
    property Genre:string read Getgenre;
    property Annee:string read Mannee;

    Constructor Create(Aowner:TComponent);override;

end;
procedure Register;


implementation
{------------------------------------------------------------------------------}
{                               CONSTRUCTOR                                    }
{------------------------------------------------------------------------------}
Constructor TinfoMP3.Create(Aowner:TComponent);
begin
   inherited Create(Aowner);
end;



{------------------------------------------------------------------------------}
{                         Enregistrement du composant                          }
{------------------------------------------------------------------------------}
procedure Register;
begin
  RegisterComponents('SFX TeAm', [TInfoMP3]);
end;

{------------------------------------------------------------------------------}
{                         initialisation des property                          }
{------------------------------------------------------------------------------}
procedure TInfoMP3.init;
begin
MAudioversion:='';
Mlayertype:='';
Mprotected:='';
Mbitrate:=0;
MTitre:='';
Martiste:='';
MAlbum:='';
Mcommentaire:='';
Mannee:='';
Mbitrate:=0;
msamplingrate:=0;
mpaddingbit:='';
mtailleframe:=0;
mchannelmode:='';
mextendedchannel:='';
mcopyright:='';
moriginal:='';
memphasis:='';
end;

{------------------------------------------------------------------------------}
{                      Recuperation des Info MP3                               }
{------------------------------------------------------------------------------}
function TInfoMP3.GetMP3Info(Filename:string):boolean;
var
verfientete,audiover,temp,layert,bitrate,sample,frame,channelm,extenchannel,copyrightt,originalt,emphasist:integer;
begin
init;
if recuperheader(Filename) then
begin
        {Audio Version--------------------------------------------}
        audiover:=(entete.header1 and $18)shr 3;
        MAudioversion:=Taudioversion[audiover];
        {Layer Version--------------------------------------------}
        layert:=(entete.header1 and 2) shr 1;
        Mlayertype:=Tlayer[layert];

        {Recuperation du bitrate----------------------------------}
        bitrate:=(entete.header2 and $F0) shr 4;
        case audiover of
        0,2 : case layert of     {mpeg v2 & v2.5}
              0: Mbitrate:=0;
              1,2: Mbitrate:=Tbitrate[bitrate,5];   {layer 2 et 3}
              3:Mbitrate:=Tbitrate[bitrate,4];      {layer 1}
              end;

        3:    case layert of     {mpeg v1}
              0: Mbitrate:=0;
              1: Mbitrate:=Tbitrate[bitrate,3];     {layer 3}
              2: Mbitrate:=Tbitrate[bitrate,2];     {layer 2}
              3: Mbitrate:=Tbitrate[bitrate,1];     {layer 1}
              end;
        end;

        {protection par CRC oui ou non ---------------------------}
        if (entete.header1 and 1)=1 then Mprotected:='Non protégé par CRC' else Mprotected:='Protégé par CRC';

        {Recuperation du sample rate------------------------------}
        sample:=(entete.header2 and 12) shr 2;
        case sample of
        0: case audiover of
           0:msamplingrate:=Tsamplerate[sample,3];
           2:msamplingrate:=Tsamplerate[sample,2];
           3:msamplingrate:=Tsamplerate[sample,1];
           end;
        1: case audiover of
           0:msamplingrate:=Tsamplerate[sample,3];
           2:msamplingrate:=Tsamplerate[sample,2];
           3:msamplingrate:=Tsamplerate[sample,1];
           end;
        2: case audiover of
           0:msamplingrate:=Tsamplerate[sample,3];
           2:msamplingrate:=Tsamplerate[sample,2];
           3:msamplingrate:=Tsamplerate[sample,1];
           end;
        3:  msamplingrate:=0;
        end;
        {pading bit et calcul de la taille d'une frame------------}

        // protection
        if(msamplingrate = 0) then
        begin
          msamplingrate := 1;
        end;
        
        frame:=entete.header2 and 1;
          case layert of
          0: mtailleframe:=0;
          1,2:mtailleframe:=144*Mbitrate*1000 div msamplingrate + frame;
          3:mtailleframe:=((12*Mbitrate*1000 div msamplingrate) + frame)*4;
          end;
        {détermination du nombre de frame------------------------}
        if(mtailleframe = 0) then begin mtailleframe := 1; end;
        if(mtaille = 0) then begin mtaille := 1; end;
        mnbr_de_frame:=mtaille div mtailleframe;

        {recuperation du mode: stereo mono etc...----------------}
        channelm:=(entete.header3 and $C0)shr 6;
        mchannelmode:=Tchannel[Channelm];

        {extension du mode seulement pour le joint stereo--------}
        if channelm=1 then
        begin
                extenchannel:=(entete.header3 and $30)shr 4;
                if layert=1 then mextendedchannel:=Tchannelextension[extenchannel,2]
                else mextendedchannel:=Tchannelextension[extenchannel,1];
        end
        else  mextendedchannel:='Pas d''extension pour ce mode';


        {détermination d'un copyright----------------------------}
        copyrightt:=(entete.header3 and $8)shr 3;
        if copyrightt=1 then mcopyright:='Le media a un Copyright'
        else mcopyright:='Le media n''a pas de copyright';
        {music original ?----------------------------------------}
        originalt:=(entete.header3 and $4) shr 2;
        if originalt=1 then moriginal:='Media original'
        else moriginal:='Copie du media original';

        {détermination de l'emphasis-----------------------------}
        emphasist:=entete.header3 and 3;
        memphasis:=Temphasis[emphasist];

        {détermination du temps----------------------------------}
        case audiover of
        0,2 : case layert of     {mpeg v2 & v2.5}
              3:temp:=mnbr_de_frame*24*8 div msamplingrate;    {layer 1}
              else
               temp:=mnbr_de_frame*72*8 div msamplingrate;
              end;

        3:    case layert of     {mpeg v1}
              3:temp:=mnbr_de_frame*48*8 div msamplingrate;     {layer 1}
              else
               temp:=mnbr_de_frame*144*8 div msamplingrate;
              end;
        end;
		
		mduree.full:=temp;
        mduree.secondes:=temp mod 60;
        temp:=temp div 60;
        mduree.minutes:=temp mod 60;
        mduree.heures:=temp div 60;


        if  recupereID3(Filename) then
                begin
                        if id3.Tagheader='TAG' then
                        begin
                        Martiste:=id3.Artiste;
                        MTitre:=id3.Titre;
                        Malbum:=id3.Album;
                        mgenre:=id3.Genre;
                        Mcommentaire:=id3.commentaire;
                        Mannee:=id3.annee;
                        end
                        else
                        begin
                        mgenre:=250;
                        end;
                end;


        result:=true;
end
else
result:=false;
end;




{------------------------------------------------------------------------------}
{                      Recupere le header du MP3                               }
{------------------------------------------------------------------------------}

function TInfoMP3.recuperheader(fichier:string):boolean;
var
taillefichier,resultat:integer;
nomfichier:file;
SearchRec:TSearchRec;
i :integer;
begin
  try
    Resultat:=FindFirst(fichier, FaAnyFile, SearchRec);
    if Resultat=0 then taillefichier:=SearchRec.Size;
    mtaille:=taillefichier;
    FindClose(SearchRec);
    Result := true;
    AssignFile(nomfichier,fichier);
    FileMode := 0;
    Reset(nomfichier, 1);
    BlockRead(nomfichier,entete,4);
    i:=0;
   // while ($E0<>(entete.header1 and $E0)) and (entete.header<>$FF) do
   while entete.header<>$FF do
    begin
       inc(i);
       Seek(nomfichier,i);
       BlockRead(nomfichier,entete,4);
    end;
    CloseFile(nomfichier);
  except
     Result := false;
  end;
end;


{------------------------------------------------------------------------------}
{                      Recupere les infos de l'ID3 V1                          }
{------------------------------------------------------------------------------}

function TInfoMP3.recupereID3(fichier:string):boolean;
var
taillefichier,resultat:integer;
nomfichier:file;
SearchRec:TSearchRec;
begin
  try
    Resultat:=FindFirst(fichier, FaAnyFile, SearchRec);
    if Resultat=0 then taillefichier:=SearchRec.Size;
    FindClose(SearchRec);
    Result := true;
    AssignFile(nomfichier,fichier);
    FileMode := 0;
    Reset(nomfichier, 1);
    Seek(nomfichier,taillefichier-128);
    BlockRead(nomfichier,id3,128);
    CloseFile(nomfichier);
  except
     Result := false;
  end;
end;



{------------------------------------------------------------------------------}
{                        Recupere le genre de la music                         }
{------------------------------------------------------------------------------}
function TInfoMP3.Getgenre:string;
begin
if (Mgenre<126)then
   Result:=Tgenre[Mgenre]
else
   Result:='';
end;
end.
