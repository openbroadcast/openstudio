unit mysqlcomp;

interface

uses
  Windows, Messages, SysUtils, Classes, IniFiles, mysql, StdCtrls;

const {Attention confusion entre Blob et Text dû a la librairie mysql}
  STRING_FIELD_TYPE_DECIMAL = 'Chiffre décimal';
  STRING_FIELD_TYPE_TINY = 'Chiffre Entier (tout petit)';
  STRING_FIELD_TYPE_SHORT = 'Chiffre Entier (petit)';
  STRING_FIELD_TYPE_LONG = 'Chiffre Entier (grand)';
  STRING_FIELD_TYPE_FLOAT = 'Chiffre réel';
  STRING_FIELD_TYPE_DOUBLE = 'Chiffre double';
  STRING_FIELD_TYPE_NULL = 'Nulle';
  STRING_FIELD_TYPE_TIMESTAMP = 'Tampon de Temps';
  STRING_FIELD_TYPE_LONGLONG = 'Chiffre Entier (trés grand)';
  STRING_FIELD_TYPE_INT24 = 'Chiffre Eniter sur 24 bits';
  STRING_FIELD_TYPE_DATE = 'Date';
  STRING_FIELD_TYPE_TIME = 'Heure minute seconde';
  STRING_FIELD_TYPE_DATETIME = 'Date et H.M.S.';
  STRING_FIELD_TYPE_YEAR = 'Année';
  STRING_FIELD_TYPE_NEWDATE = 'Nouvelle date';
  STRING_FIELD_TYPE_ENUM = 'Enum';
  STRING_FIELD_TYPE_SET = 'Set';
  STRING_FIELD_TYPE_TINY_BLOB = 'Blob (petit)';
  STRING_FIELD_TYPE_MEDIUM_BLOB = 'Blob (moyen)';
  STRING_FIELD_TYPE_LONG_BLOB = 'Blob (grand)';
  STRING_FIELD_TYPE_BLOB = 'Texte';
  STRING_FIELD_TYPE_VAR_STRING = 'Texte variable';
  STRING_FIELD_TYPE_STRING = 'Texte';

  STRING1_FIELD_TYPE_DECIMAL = 'DECIMAL';
  STRING1_FIELD_TYPE_TINY = 'TINYINT';
  STRING1_FIELD_TYPE_SHORT = 'SHORTINT';
  STRING1_FIELD_TYPE_LONG = 'LONGINT';
  STRING1_FIELD_TYPE_FLOAT = 'FLOAT';
  STRING1_FIELD_TYPE_DOUBLE = 'DOUBLE';
  STRING1_FIELD_TYPE_NULL = 'NULL';
  STRING1_FIELD_TYPE_TIMESTAMP = 'TIMESTAMP';
  STRING1_FIELD_TYPE_LONGLONG = 'LONG?????';
  STRING1_FIELD_TYPE_INT24 = 'BIGINT';
  STRING1_FIELD_TYPE_DATE = 'DATE';
  STRING1_FIELD_TYPE_TIME = 'TIME';
  STRING1_FIELD_TYPE_DATETIME = 'DATETIME';
  STRING1_FIELD_TYPE_YEAR = 'YEAR';
  STRING1_FIELD_TYPE_NEWDATE = 'NEWDATE';
  STRING1_FIELD_TYPE_ENUM = 'ENUM';
  STRING1_FIELD_TYPE_SET = 'SET';
  STRING1_FIELD_TYPE_TINY_BLOB = 'BLOB';
  STRING1_FIELD_TYPE_MEDIUM_BLOB = 'MEDIUMBLOB';
  STRING1_FIELD_TYPE_LONG_BLOB = 'LONGBLOB';
  STRING1_FIELD_TYPE_BLOB = 'TEXT';
  STRING1_FIELD_TYPE_VAR_STRING = 'VARCHAR';
  STRING1_FIELD_TYPE_STRING = 'TEXT';

type
  TDynamicStringArray = array of string;
  TDynamicIntegerArray = array of Integer;
  TMySQLComponent = class(Tcomponent)
  private
    { Private declarations }
  protected
    { Protected declarations }
    Hostp: string;
    Loginp: string;
    Passwordp: string;
    Databasep: string;
    procedure SetHost(Value: string);
    procedure SetLogin(Value: string);
    procedure SetPassword(Value: string);
    procedure SetDatabase(Value: string);


  public
    { Public declarations }
    Linkp: PMYSQL;
    Connected: boolean;
    Selected: boolean;
    function affected_rows(): my_ulonglong;
    function change_user(user, passwd, db: string): my_bool;
    function character_set_name(): pChar;
    function create_db(db: string): longint;
    procedure data_seek(result: PMYSQL_RES; offset: my_ulonglong);
    function drop_db(db: string): longint;
    function dump_debug_info(): longint;
    function eof(res: PMYSQL_RES): my_bool;
    function errno(): longword;
    function error(): pChar;
    function escape_string(_to, from: string): longword;
    function fetch_field_direct(res: PMYSQL_RES; fieldnr: longword): PMYSQL_FIELD;
    function fetch_field(res: PMYSQL_RES): PMYSQL_FIELD;
    function fetch_fields(res: PMYSQL_RES): PMYSQL_FIELDS;
    function fetch_lengths(res: PMYSQL_RES): PMYSQL_LENGTHS;
    function fetch_row(res: PMYSQL_RES): PMYSQL_ROW;
    function field_seek(res: PMYSQL_RES; offset: MYSQL_FIELD_OFFSET): MYSQL_FIELD_OFFSET;
    function field_count(): longword;
    function field_tell(res: PMYSQL_RES): longword;
    function info(): pChar;
    function insert_id(): my_ulonglong;
    function kill(pid: longword): longint;
    function list_dbs(wild: string): PMYSQL_RES;
    function list_fields(table, wild: string): PMYSQL_RES;
    function list_tables(wild: string): PMYSQL_RES;
    function num_fields(res: PMYSQL_RES): longword;
    function num_rows(res: PMYSQL_RES): my_ulonglong;
    function ping(): longint;
    function real_escape_string(_to, from: string; length: longword): longword;
    function real_query(q: string; length: longword): longint;
    function reload(): longint;
    function row_seek(res: PMYSQL_RES; offset: MYSQL_ROW_OFFSET): MYSQL_ROW_OFFSET;
    function row_tell(res: PMYSQL_RES): PMYSQL_ROWS;
    function Select_Db(): boolean;
    function Select_Database(Database: string): boolean;
    function shutdown(): longint;
    function use_result(): PMYSQL_RES;

    function Connect(): boolean;
    function Query(s: string): PMYSQL_RES;
    procedure Free_Result(Res: PMYSQL_RES);
    procedure Close();

    procedure LoadFromIni(Filename: string);
    procedure SaveToIni(Filename: string);

    function SaveTableToFile(Table, Filename: string): boolean;
    function AddTableToFile(Table, Filename: string): boolean;
    function LoadSqlFromFile(Filename: string): boolean;

    function add_slashes(mot: string): string;

    procedure ListDBsInListBox(ListBox: TListBox);
    procedure ListTablesInListBox(ListBox: TListBox; Database: string);
    procedure ListFieldsInListBox(ListBox: TListBox; Table: string);
    procedure ListInListBox(ListBox: TListBox; Result: PMYSQL_RES);

    function QueryIntoListBox(Querys: string; ListBox: TListBox): boolean;
    function QueryIntoComboBox(Querys: string; ComboBox: TComboBox): boolean;

    function QueryFirstResult(Querys: string; var FirstRowZero: string): boolean;
    function fields_type(Table: string; var Fields_names: TDynamicStringArray; var Fields_types: TDynamicIntegerArray): integer;
    function field_ConversionType_Nomtype(no: integer): string;
    function field_ConversionNomtype_Type(nom: string): integer;
    function field_MysqlType(no: integer): string;

    function table_change_name(hold_name, new_name: string): boolean;
    function create_table(name, query_table: string): boolean;
    function delete_table(name: string): boolean;

    function QueryIntoTStrings(Querys: string; var Strings: TStrings): boolean;
    function QueryIntoTStringsUnique(Querys: string; var Strings: TStrings): boolean;


  published
    { Published declarations }
    property Host: string read Hostp write SetHost;
    property Login: string read Loginp write SetLogin;
    property Password: string read Passwordp write SetPassword;
    property Database: string read Databasep write SetDatabase;

  end;

procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('Mysql DB', [TMySQLComponent]);
end;

function TMySQLComponent.create_table(name, query_table: string): boolean;
var
  Row: string;
begin
  if QueryFirstResult('SHOW tables LIKE ''' + name + ''';', Row) = false then
  begin
    Row := '';
    Query('CREATE TABLE `' + name + '` (' + query_table + ');');
    create_table := true;
  end
  else create_table := false;
end;


function TMySQLComponent.QueryIntoTStringsUnique(Querys: string; var Strings: TStrings): boolean;
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
begin
  if Selected = true then
  begin
    Res := Query(Querys);
    if Res = nil then QueryIntoTStringsUnique := false
    else
    try
      Strings.Clear;
      Row := mysql_fetch_row(Res);
      while Row <> nil do
      begin
        Strings.Add(Row[0]);
        Row := mysql_fetch_row(Res);
      end;
    finally
      mysql_free_result(Res);
      QueryIntoTStringsUnique := true;
    end;
  end;
end;


function TMySQLComponent.QueryIntoTStrings(Querys: string; var Strings: TStrings): boolean;
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  i, j: integer;
  s: string;
begin
  if Selected = true then
  begin
    Res := Query(Querys);
    if Res = nil then QueryIntoTStrings := false
    else
    try
      Strings.Clear;
      i := mysql_num_fields(Res);
      if (i > 1) then
      begin
        Row := mysql_fetch_row(Res);
        i := i - 2;
        while Row <> nil do
        begin
          s := Row[0] + ' (';
          for j := 1 to i do
            s := s + Row[j] + ',';
          s := s + Row[i + 1] + ')';
          Strings.Add(s);
          Row := mysql_fetch_row(Res);
        end;
      end
      else
      begin
        Row := mysql_fetch_row(Res);
        while Row <> nil do
        begin
          Strings.Add(Row[0]);
          Row := mysql_fetch_row(Res);
        end;
      end;
    finally
      mysql_free_result(Res);
      QueryIntoTStrings := true;
    end;
  end;
end;


function TMySQLComponent.delete_table(name: string): boolean;
var
  Row: string;
begin
  Query('DROP TABLE `' + name + '`;');
  if QueryFirstResult('SHOW tables LIKE ''' + name + ''';', Row) = false then
    delete_table := true
  else delete_table := false;
end;


function TMySQLComponent.table_change_name(hold_name, new_name: string): boolean;
var
  Row: string;
begin
  if QueryFirstResult('SHOW tables LIKE ''' + new_name + ''';', Row) = false then
  begin
    Query('ALTER TABLE `' + hold_name + '` RENAME `' + new_name + '`;');
    table_change_name := true;
  end
  else table_change_name := false;
end;



function TMySQLComponent.field_MysqlType(no: integer): string;
var
  s: string;
begin
  s := '';
  case no of
    FIELD_TYPE_DECIMAL: s := STRING1_FIELD_TYPE_DECIMAL;
    FIELD_TYPE_TINY: s := STRING1_FIELD_TYPE_TINY;
    FIELD_TYPE_SHORT: s := STRING1_FIELD_TYPE_SHORT;
    FIELD_TYPE_FLOAT: s := STRING1_FIELD_TYPE_FLOAT;
    FIELD_TYPE_DOUBLE: s := STRING1_FIELD_TYPE_DOUBLE;
    FIELD_TYPE_NULL: s := STRING1_FIELD_TYPE_NULL;
    FIELD_TYPE_TIMESTAMP: s := STRING1_FIELD_TYPE_TIMESTAMP;
    FIELD_TYPE_LONGLONG: s := STRING1_FIELD_TYPE_LONGLONG;
    FIELD_TYPE_INT24: s := STRING1_FIELD_TYPE_INT24;
    FIELD_TYPE_DATE: s := STRING1_FIELD_TYPE_DATE;
    FIELD_TYPE_TIME: s := STRING1_FIELD_TYPE_TIME;
    FIELD_TYPE_DATETIME: s := STRING1_FIELD_TYPE_DATETIME;
    FIELD_TYPE_YEAR: s := STRING1_FIELD_TYPE_YEAR;
    FIELD_TYPE_NEWDATE: s := STRING1_FIELD_TYPE_NEWDATE;
    FIELD_TYPE_ENUM: s := STRING1_FIELD_TYPE_ENUM;
    FIELD_TYPE_SET: s := STRING1_FIELD_TYPE_SET;
    FIELD_TYPE_TINY_BLOB: s := STRING1_FIELD_TYPE_TINY_BLOB;
    FIELD_TYPE_MEDIUM_BLOB: s := STRING1_FIELD_TYPE_MEDIUM_BLOB;
    FIELD_TYPE_LONG_BLOB: s := STRING1_FIELD_TYPE_LONG_BLOB;
    FIELD_TYPE_BLOB: s := STRING1_FIELD_TYPE_BLOB;
    FIELD_TYPE_VAR_STRING: s := STRING1_FIELD_TYPE_VAR_STRING;
    FIELD_TYPE_STRING: s := STRING1_FIELD_TYPE_STRING;
  end;
  field_MysqlType := s;
end;

function TMySQLComponent.field_ConversionType_Nomtype(no: integer): string;
var
  s: string;
begin
  s := '';
  case no of
    FIELD_TYPE_DECIMAL: s := STRING_FIELD_TYPE_DECIMAL;
    FIELD_TYPE_TINY: s := STRING_FIELD_TYPE_TINY;
    FIELD_TYPE_SHORT: s := STRING_FIELD_TYPE_SHORT;
    FIELD_TYPE_FLOAT: s := STRING_FIELD_TYPE_FLOAT;
    FIELD_TYPE_DOUBLE: s := STRING_FIELD_TYPE_DOUBLE;
    FIELD_TYPE_NULL: s := STRING_FIELD_TYPE_NULL;
    FIELD_TYPE_TIMESTAMP: s := STRING_FIELD_TYPE_TIMESTAMP;
    FIELD_TYPE_LONGLONG: s := STRING_FIELD_TYPE_LONGLONG;
    FIELD_TYPE_INT24: s := STRING_FIELD_TYPE_INT24;
    FIELD_TYPE_DATE: s := STRING_FIELD_TYPE_DATE;
    FIELD_TYPE_TIME: s := STRING_FIELD_TYPE_TIME;
    FIELD_TYPE_DATETIME: s := STRING_FIELD_TYPE_DATETIME;
    FIELD_TYPE_YEAR: s := STRING_FIELD_TYPE_YEAR;
    FIELD_TYPE_NEWDATE: s := STRING_FIELD_TYPE_NEWDATE;
    FIELD_TYPE_ENUM: s := STRING_FIELD_TYPE_ENUM;
    FIELD_TYPE_SET: s := STRING_FIELD_TYPE_SET;
    FIELD_TYPE_TINY_BLOB: s := STRING_FIELD_TYPE_TINY_BLOB;
    FIELD_TYPE_MEDIUM_BLOB: s := STRING_FIELD_TYPE_MEDIUM_BLOB;
    FIELD_TYPE_LONG_BLOB: s := STRING_FIELD_TYPE_LONG_BLOB;
    FIELD_TYPE_BLOB: s := STRING_FIELD_TYPE_BLOB;
    FIELD_TYPE_VAR_STRING: s := STRING_FIELD_TYPE_VAR_STRING;
    FIELD_TYPE_STRING: s := STRING_FIELD_TYPE_STRING;
  end;
  field_ConversionType_NomType := s;
end;

function TMySQLComponent.field_ConversionNomtype_Type(nom: string): integer;
var
  s: integer;
begin
  if nom = STRING_FIELD_TYPE_DECIMAL then s := FIELD_TYPE_DECIMAL
  else if nom = STRING_FIELD_TYPE_TINY then s := FIELD_TYPE_TINY
  else if nom = STRING_FIELD_TYPE_SHORT then s := FIELD_TYPE_SHORT
  else if nom = STRING_FIELD_TYPE_FLOAT then s := FIELD_TYPE_FLOAT
  else if nom = STRING_FIELD_TYPE_DOUBLE then s := FIELD_TYPE_DOUBLE
  else if nom = STRING_FIELD_TYPE_NULL then s := FIELD_TYPE_NULL
  else if nom = STRING_FIELD_TYPE_TIMESTAMP then s := FIELD_TYPE_TIMESTAMP
  else if nom = STRING_FIELD_TYPE_LONGLONG then s := FIELD_TYPE_LONGLONG
  else if nom = STRING_FIELD_TYPE_INT24 then s := FIELD_TYPE_INT24
  else if nom = STRING_FIELD_TYPE_DATE then s := FIELD_TYPE_DATE
  else if nom = STRING_FIELD_TYPE_TIME then s := FIELD_TYPE_TIME
  else if nom = STRING_FIELD_TYPE_DATETIME then s := FIELD_TYPE_DATETIME
  else if nom = STRING_FIELD_TYPE_YEAR then s := FIELD_TYPE_YEAR
  else if nom = STRING_FIELD_TYPE_NEWDATE then s := FIELD_TYPE_NEWDATE
  else if nom = STRING_FIELD_TYPE_ENUM then s := FIELD_TYPE_ENUM
  else if nom = STRING_FIELD_TYPE_SET then s := FIELD_TYPE_SET
  else if nom = STRING_FIELD_TYPE_TINY_BLOB then s := FIELD_TYPE_TINY_BLOB
  else if nom = STRING_FIELD_TYPE_MEDIUM_BLOB then s := FIELD_TYPE_MEDIUM_BLOB
  else if nom = STRING_FIELD_TYPE_LONG_BLOB then s := FIELD_TYPE_LONG_BLOB
  else if nom = STRING_FIELD_TYPE_BLOB then s := FIELD_TYPE_BLOB
  else if nom = STRING_FIELD_TYPE_VAR_STRING then s := FIELD_TYPE_VAR_STRING
  else if nom = STRING_FIELD_TYPE_STRING then s := FIELD_TYPE_STRING
  else s := -1;
  field_ConversionNomtype_Type := s;
end;

function TMySQLComponent.fields_type(Table: string; var Fields_names: TDynamicStringArray; var Fields_types: TDynamicIntegerArray): integer;
var
  Res: PMYSQL_RES;
  Field: PMYSQL_FIELD;
  Num, i: Integer;
  Fields_name_result: TDynamicStringArray;
  Fields_type_result: TDynamicIntegerArray;
begin
  if Selected = true then
  begin
    Num := -1;
    Res := Query('SELECT * FROM ' + Table + ' LIMIT 0,1;');
    if Res = nil then fields_type := -1
    else
    try
      Num := mysql_num_fields(Res);
      SetLength(Fields_name_result, Num);
      SetLength(Fields_type_result, Num);
      for i := 0 to (Num - 1) do
      begin
        Field := mysql_fetch_field_direct(Res, i);
        Fields_name_result[i] := Field.name;
        Fields_type_result[i] := Field._type;
      end;
    finally
      mysql_free_result(Res);
      fields_type := Num;
      Fields_names := Fields_name_result;
      Fields_types := Fields_type_result;
    end;
  end;
end;


function TMySQLComponent.QueryFirstResult(Querys: string; var FirstRowZero: string): boolean;
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
begin
  Res := Query(Querys);
  if Res = nil then QueryFirstResult := false
  else
  try
    Row := mysql_fetch_row(Res);
    if Row <> nil then
    begin
      FirstRowZero := Row[0];
      QueryFirstResult := true;
    end
    else QueryFirstResult := false;
  finally
    mysql_free_result(Res);
  end;
end;



function TMySQLComponent.QueryIntoComboBox(Querys: string; ComboBox: TComboBox): boolean;
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
begin
  Res := Query(Querys);
  if Res = nil then QueryIntoComboBox := false
  else
  try
    ComboBox.Clear;
    Row := mysql_fetch_row(Res);
    while Row <> nil do
    begin
      ComboBox.Items.Add(Row[0]);
      Row := mysql_fetch_row(Res);
    end;
  finally
    mysql_free_result(Res);
    QueryIntoComboBox := true;
    ComboBox.ItemIndex := 0;
  end;
end;

function TMySQLComponent.QueryIntoListBox(Querys: string; ListBox: TListBox): boolean;
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  i, j: integer;
  s: string;
begin
  Res := Query(Querys);
  if Res = nil then QueryIntoListBox := false
  else
  try
    ListBox.Clear;
    i := mysql_num_fields(Res);
    if (i > 1) then
    begin
      Row := mysql_fetch_row(Res);
      i := i - 2;
      while Row <> nil do
      begin
        s := Row[0] + ' (';
        for j := 1 to i do
          s := s + Row[j] + ',';
        s := s + Row[i + 1] + ')';
        ListBox.Items.Add(s);
        Row := mysql_fetch_row(Res);
      end;
    end
    else
    begin
      Row := mysql_fetch_row(Res);
      while Row <> nil do
      begin
        ListBox.Items.Add(Row[0]);
        Row := mysql_fetch_row(Res);
      end;
    end;
  finally
    mysql_free_result(Res);
    QueryIntoListBox := true;
  end;
end;

procedure TMySQLComponent.ListDBsInListBox(ListBox: TListBox);
var
  Result: PMYSQL_RES;
begin
  if Connected = true then
  begin
    Result := list_dbs('%');
    if Result <> nil then
      ListinListBox(ListBox, Result);
  end;
end;

procedure TMySQLComponent.ListTablesInListBox(ListBox: TListBox; Database: string);
var
  Result: PMYSQL_RES;
begin
  if Selected = true then
  begin
    Close;
    Databasep := Database;
    Connect;
    Result := list_tables('');
    if Result <> nil then
      ListinListBox(ListBox, Result);
  end;
end;

procedure TMySQLComponent.ListFieldsInListBox(ListBox: TListBox; Table: string);
var
  Result: PMYSQL_RES;
begin
  if Selected = true then
  begin
    Result := list_fields(Table, '');
    if Result <> nil then
      ListinListBox(ListBox, Result);
  end;
end;

procedure TMySQLComponent.ListInListBox(ListBox: TListBox; Result: PMYSQL_RES);
var
  Row: PMYSQL_ROW;
begin
  if Result <> nil then
  begin
    ListBox.Clear;
    if Result <> nil then
    try
      Row := mysql_fetch_row(Result);
      while Row <> nil do
      begin
        ListBox.Items.Add(Row[0]);
        Row := mysql_fetch_row(Result);
      end;
    finally
      mysql_free_result(Result);
    end;
  end;
end;


function TMySQLComponent.add_slashes(mot: string): string;
var
  i: integer;
  t: string;
begin
  t := '';
  for i := 1 to StrLen(PChar(mot)) do
    if mot[i] = '''' then t := t + '\'''
    else t := t + mot[i];
  add_slashes := t;
end;

function TMySQLComponent.LoadSqlFromFile(Filename: string): boolean;
var
  Querys: string;
  Fichier: TextFile;
begin
  Assignfile(Fichier, Filename);
  Reset(Fichier);
  while System.Eof(Fichier) <> true do
  begin
    Readln(Fichier, Querys);
    Query(Querys);
  end;
  LoadSqlFromFile := true;
end;



function TMySQLComponent.SaveTableToFile(Table, Filename: string): boolean;
var
  Fichier: TextFile;
begin
  Assignfile(Fichier, Filename);
  Rewrite(Fichier);
  CloseFile(Fichier);
  SaveTableToFile := AddTableToFile(Table, Filename);
end;

function TMySQLComponent.AddTableToFile(Table, Filename: string): boolean;
var
  Res: PMYSQL_RES;
  Row: PMYSQL_ROW;
  i: integer;
  Fields: PMYSQL_FIELD;
  Querys: string;
  underq: string;
  Fichier: TextFile;
begin
  Assignfile(Fichier, Filename);
  Append(Fichier);
  Res := Query('SELECT * FROM ' + Table + ';');
  if Res = nil then begin
    AddTableToFile := false;
  end
  else
  try
    querys := 'INSERT INTO ' + Table + ' (';
    for i := 0 to num_fields(Res) - 1 do
    begin
      Fields := fetch_field_direct(Res, i);
      if i = 0 then
        Querys := Querys + '`' + Fields.name + '`'
      else
        Querys := Querys + ',`' + Fields.name + '`';
    end;
    Querys := Querys + ') VALUES (';

    Row := fetch_row(Res);
    while Row <> nil do
    begin
      underq := '';
      for i := 0 to num_fields(Res) - 1 do
      begin
        if i = 0 then
          underq := underq + '''' + add_slashes(Row[i]) + ''''
        else
          underq := underq + ',''' + add_slashes(Row[i]) + '''';
      end;
      underq := Querys + underq + ');';
      Writeln(Fichier, underq);
      Row := fetch_row(Res);
    end;
  finally
    free_result(Res);
    AddTableToFile := true;
  end;
  Closefile(Fichier);
end;



procedure TMySQLComponent.LoadFromIni(Filename: string);
var
  MyIniFile: TIniFile;
begin
    {chargement du fichier de configuration}
  MyIniFile := TIniFile.Create(Filename);
  with MyIniFile do
  begin
    Hostp := ReadString('MYSQL CONFIG', 'host', 'localhost');
    Loginp := ReadString('MYSQL CONFIG', 'login', 'root');
    Passwordp := ReadString('MYSQL CONFIG', 'password', '');
    Databasep := ReadString('MYSQL CONFIG', 'database', '');
  end;
  MyIniFile.Free;
end;

procedure TMySQLComponent.SaveToIni(Filename: string);
var
  MyIniFile: TIniFile;
begin
    {chargement du fichier de configuration}
  MyIniFile := TIniFile.Create(Filename);
  with MyIniFile do
  begin
    WriteString('MYSQL CONFIG', 'host', Hostp);
    WriteString('MYSQL CONFIG', 'login', Loginp);
    WriteString('MYSQL CONFIG', 'password', Passwordp);
    WriteString('MYSQL CONFIG', 'database', Databasep);
  end;
  MyIniFile.Free;
end;

function TMySQLComponent.Connect(): boolean;
begin
  if Connected = false then
  begin
    Linkp := mysql_init(nil);
    if (mysql_connect(Linkp, PChar(Hostp), PChar(Loginp), PChar(Passwordp)) = nil) then
      Connected := false
    else
      Connected := true;
    if (mysql_select_db(Linkp, PChar(Databasep)) <> 0) then
      Selected := false
    else
      Selected := true;
  end;
  Connect := Connected;
end;

procedure TMySQLComponent.Close();
begin
  if Connected = true then
  begin
    mysql_close(Linkp);
    Connected := False;
    Selected := False;
  end;
end;

function TMySQLComponent.Select_Db(): boolean;
begin
  if (Connected = true) then
    if (mysql_select_db(Linkp, PChar(Databasep)) <> 0) then
      Selected := false
    else
      Selected := true;
  Select_Db := Selected;
end;

function TMySQLComponent.Select_Database(Database: string): boolean;
begin
  if (Connected = true) then
    if (mysql_select_db(Linkp, PChar(Database)) <> 0) then
      Selected := false
    else
    begin
      Databasep := Database;
      Selected := true;
    end;
  Select_Database := Selected;
end;

function TMySQLComponent.Query(s: string): PMYSQL_RES;
begin
  if mysql_query(Linkp, pChar(s)) <> 0 then
  begin
    Query := nil;
  end;
  Query := mysql_store_result(Linkp);
end;

procedure TMySQLComponent.Free_Result(Res: PMYSQL_RES);
begin
  mysql_free_result(Res);
end;

{------------------------------------------------------------}

function TMySQLComponent.affected_rows(): my_ulonglong;
begin
  affected_rows := mysql_affected_rows(Linkp);
end;

function TMySQLComponent.change_user(user, passwd, db: string): my_bool;
var
  b: my_bool;
begin
  b := mysql_change_user(Linkp, PChar(user), PChar(passwd), PChar(db));
  if (b = 0) then
  begin
    Loginp := user;
    Passwordp := passwd;
    Databasep := db;
  end;
  change_user := b;
end;

function TMySQLComponent.character_set_name(): pChar;
begin
  character_set_name := mysql_character_set_name(Linkp);
end;

function TMySQLComponent.create_db(db: string): longint;
begin
  create_db := mysql_create_db(Linkp, PChar(db));
end;

procedure TMySQLComponent.data_seek(result: PMYSQL_RES; offset: my_ulonglong);
begin
  mysql_data_seek(result, offset);
end;

function TMySQLComponent.drop_db(db: string): longint;
begin
  drop_db := mysql_drop_db(Linkp, PChar(db));
end;

function TMySQLComponent.dump_debug_info(): longint;
begin
  dump_debug_info := mysql_dump_debug_info(Linkp);
end;

function TMySQLComponent.eof(res: PMYSQL_RES): my_bool;
begin
  eof := mysql_eof(res);
end;

function TMySQLComponent.errno(): longword;
begin
  errno := mysql_errno(Linkp);
end;

function TMySQLComponent.error(): pChar;
begin
  error := mysql_error(Linkp);
end;

function TMySQLComponent.escape_string(_to, from: string): longword;
begin
  escape_string := mysql_escape_string(PChar(_to), PChar(from), Strlen(PChar(from)));
end;


function TMySQLComponent.fetch_field_direct(res: PMYSQL_RES; fieldnr: longword): PMYSQL_FIELD;
begin
  fetch_field_direct := mysql_fetch_field_direct(res, fieldnr);
end;

function TMySQLComponent.fetch_field(res: PMYSQL_RES): PMYSQL_FIELD;
begin
  fetch_field := mysql_fetch_field(res);
end;

function TMySQLComponent.fetch_fields(res: PMYSQL_RES): PMYSQL_FIELDS;
begin
  fetch_fields := mysql_fetch_fields(res);
end;

function TMySQLComponent.fetch_lengths(res: PMYSQL_RES): PMYSQL_LENGTHS;
begin
  fetch_lengths := mysql_fetch_lengths(res);
end;

function TMySQLComponent.fetch_row(res: PMYSQL_RES): PMYSQL_ROW;
begin
  fetch_row := mysql_fetch_row(res);
end;

function TMySQLComponent.field_seek(res: PMYSQL_RES; offset: MYSQL_FIELD_OFFSET): MYSQL_FIELD_OFFSET;
begin
  field_seek := mysql_field_seek(res, offset);
end;

function TMySQLComponent.field_count(): longword;
begin
  field_count := mysql_field_count(Linkp);
end;

function TMySQLComponent.field_tell(res: PMYSQL_RES): longword;
begin
  field_tell := mysql_field_tell(res);
end;

function TMySQLComponent.info(): pChar;
begin
  info := mysql_info(Linkp);
end;

function TMySQLComponent.insert_id(): my_ulonglong;
begin
  insert_id := mysql_insert_id(Linkp);
end;

function TMySQLComponent.kill(pid: longword): longint;
begin
  kill := mysql_kill(Linkp, pid);
end;

function TMySQLComponent.list_dbs(wild: string): PMYSQL_RES;
begin
  list_dbs := mysql_list_dbs(Linkp, PChar(wild));
end;

function TMySQLComponent.list_fields(table, wild: string): PMYSQL_RES;
begin
  if (wild <> '') then
    list_fields := query('SHOW COLUMNS FROM ' + table + ' LIKE ''' + wild + ''' ;')
  else
    list_fields := query('SHOW COLUMNS FROM ' + table + ' ;');
end;

function TMySQLComponent.list_tables(wild: string): PMYSQL_RES;
begin
  if (wild <> '') then
    list_tables := query('SHOW tables LIKE ''' + wild + ''' ;')
  else
    list_tables := query('SHOW tables ;');
end;

function TMySQLComponent.num_fields(res: PMYSQL_RES): longword;
begin
  num_fields := mysql_num_fields(res);
end;

function TMySQLComponent.num_rows(res: PMYSQL_RES): my_ulonglong;
begin
  num_rows := mysql_num_rows(res);
end;

function TMySQLComponent.ping(): longint;
begin
  ping := mysql_ping(Linkp);
end;

function TMySQLComponent.real_escape_string(_to, from: string; length: longword): longword;
begin
  real_escape_string := mysql_real_escape_string(Linkp, PChar(_to), PChar(from), length);
end;

function TMySQLComponent.real_query(q: string; length: longword): longint;
begin
  real_query := mysql_real_query(Linkp, PChar(q), length);
end;

function TMySQLComponent.reload(): longint;
begin
  reload := mysql_reload(Linkp);
end;

function TMySQLComponent.row_seek(res: PMYSQL_RES; offset: MYSQL_ROW_OFFSET): MYSQL_ROW_OFFSET;
begin
  row_seek := mysql_row_seek(res, offset);
end;

function TMySQLComponent.row_tell(res: PMYSQL_RES): PMYSQL_ROWS;
begin
  row_tell := mysql_row_tell(res);
end;

function TMySQLComponent.shutdown(): longint;
begin
  shutdown := mysql_shutdown(Linkp);
end;

function TMySQLComponent.use_result(): PMYSQL_RES;
begin
  use_result := mysql_use_result(Linkp);
end;

{######################################################################}

procedure TMySQLComponent.SetHost(Value: string);
begin
  if (Connected = false) then Hostp := Value;
end;

procedure TMySQLComponent.SetLogin(Value: string);
begin
  if (Connected = false) then Loginp := Value;
end;

procedure TMySQLComponent.SetPassword(Value: string);
begin
  if (Connected = false) then Passwordp := Value;
end;

procedure TMySQLComponent.SetDatabase(Value: string);
begin
  if (Connected = false) then Databasep := Value;
end;

end.
