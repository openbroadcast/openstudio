unit MysqlComponent;

interface

uses
  SysUtils, Classes, Windows, Winsock, INIFiles, ComObj, Variants,
  StdCtrls // pour TListbox
  ;

// ----------------
// From myEspiritu.h ...
// ----------------

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
  STRING1_FIELD_TYPE_LONG = 'INT'; //INT(11)
  STRING1_FIELD_TYPE_FLOAT = 'FLOAT';
  STRING1_FIELD_TYPE_DOUBLE = 'DOUBLE';
  STRING1_FIELD_TYPE_NULL = 'NULL';
  STRING1_FIELD_TYPE_TIMESTAMP = 'TIMESTAMP';
  STRING1_FIELD_TYPE_LONGLONG = 'BIGINT'; //BIGINT(20)
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
  STRING1_FIELD_TYPE_BLOB = 'BLOB';
  STRING1_FIELD_TYPE_VAR_STRING = 'VARCHAR';
  STRING1_FIELD_TYPE_STRING = 'TEXT';

  FIELD_TYPE_TINYTEXT = 255;
  STRING1_FIELD_TYPE_TINYTEXT = 'TINYTEXT';
  FIELD_TYPE_TEXT = 256;
  STRING1_FIELD_TYPE_TEXT = 'TEXT';
  FIELD_TYPE_MEDIUMTEXT = 257;
  STRING1_FIELD_TYPE_MEDIUMTEXT = 'MEDIUMTEXT';
  FIELD_TYPE_LONGTEXT = 258;
  STRING1_FIELD_TYPE_LONGTEXT = 'LONGTEXT';

// ----------------
// From mysql.h ...
// ----------------

type
  my_bool = byte;
  gptr = pChar;

type
  PUSED_MEM = ^TUSED_MEM;  // struct for once_alloc
  TUSED_MEM = record
    next: PUSED_MEM;       // Next block in use
    left: longword;        // memory left in block
    size: longword;        // size of block
  end;

type
  error_proc = procedure;

type
  PMEM_ROOT = ^TMEM_ROOT;
  TMEM_ROOT = record
    free: PUSED_MEM;
    used: PUSED_MEM;
    pre_alloc: PUSED_MEM;
    min_malloc: longword;
    block_size: longword;
    error_handler: error_proc;
  end;

type
  my_socket = TSocket;

// --------------------
// From mysql_com.h ...
// --------------------

const
  NAME_LEN = 64;               // Field/table name length
  HOSTNAME_LENGTH = 60;
  USERNAME_LENGTH = 16;
  SERVER_VERSION_LENGTH = 60;

  LOCAL_HOST = 'localhost';
  LOCAL_HOST_NAMEDPIPE = '.';

  MYSQL_NAMEDPIPE = 'MySQL';
  MYSQL_SERVICENAME = 'MySql';

type
  enum_server_command = (
    COM_SLEEP, COM_QUIT, COM_INIT_DB, COM_QUERY,
    COM_FIELD_LIST, COM_CREATE_DB, COM_DROP_DB, COM_REFRESH,
    COM_SHUTDOWN, COM_STATISTICS,
    COM_PROCESS_INFO, COM_CONNECT, COM_PROCESS_KILL,
    COM_DEBUG, COM_PING, COM_TIME, COM_DELAYED_INSERT,
    COM_CHANGE_USER, COM_BINLOG_DUMP,
    COM_TABLE_DUMP, COM_CONNECT_OUT
  );

const
  NOT_NULL_FLAG = 1;      // Field can't be NULL
  PRI_KEY_FLAG = 2;       // Field is part of a primary key
  UNIQUE_KEY_FLAG = 4;    // Field is part of a unique key
  MULTIPLE_KEY_FLAG = 8;  // Field is part of a key
  BLOB_FLAG = 16;         // Field is a blob
  UNSIGNED_FLAG = 32;     // Field is unsigned
  ZEROFILL_FLAG = 64;     // Field is zerofill
  BINARY_FLAG = 128;

  // The following are only sent to new clients

  ENUM_FLAG = 256;            // field is an enum
  AUTO_INCREMENT_FLAG = 512;  // field is a autoincrement field
  TIMESTAMP_FLAG = 1024;      // Field is a timestamp
  SET_FLAG = 2048;            // field is a set
  NUM_FLAG = 32768;           // Field is num (for clients)
  PART_KEY_FLAG = 16384;      // Intern; Part of some key
  GROUP_FLAG = 32768;         // Intern: Group field
  UNIQUE_FLAG = 65536;        // Intern: Used by sql_yacc

  REFRESH_GRANT = 1;     // Refresh grant tables
  REFRESH_LOG = 2;       // Start on new log file
  REFRESH_TABLES = 4;    // close all tables
  REFRESH_HOSTS = 8;     // Flush host cache
  REFRESH_STATUS = 16;   // Flush status variables
  REFRESH_THREADS = 32;  // Flush status variables
  REFRESH_SLAVE = 64;    // Reset master info and restart slave
                         // thread
  REFRESH_MASTER = 128;  // Remove all bin logs in the index
                         // and truncate the index

  // The following can't be set with mysql_refresh()

  REFRESH_READ_LOCK = 16384;  // Lock tables for read
  REFRESH_FAST = 32768;       // Intern flag

  CLIENT_LONG_PASSWORD = 1;      // new more secure passwords
  CLIENT_FOUND_ROWS = 2;         // Found instead of affected rows
  CLIENT_LONG_FLAG = 4;          // Get all column flags
  CLIENT_CONNECT_WITH_DB = 8;    // One can specify db on connect
  CLIENT_NO_SCHEMA = 16;         // Don't allow database.table.column
  CLIENT_COMPRESS = 32;          // Can use compression protcol
  CLIENT_ODBC = 64;              // Odbc client
  CLIENT_LOCAL_FILES = 128;      // Can use LOAD DATA LOCAL
  CLIENT_IGNORE_SPACE = 256;     // Ignore spaces before '('
  CLIENT_INTERACTIVE = 1024;     // This is an interactive client
  CLIENT_SSL = 2048;             // Switch to SSL after handshake
  CLIENT_IGNORE_SIGPIPE = 4096;  // IGNORE sigpipes
  CLIENT_TRANSACTIONS = 8192;    // Client knows about transactions

  SERVER_STATUS_IN_TRANS = 1;    // Transaction has started
  SERVER_STATUS_AUTOCOMMIT = 2;  // Server in auto_commit mode

  MYSQL_ERRMSG_SIZE = 200;
  NET_READ_TIMEOUT = 30;       // Timeout on read
  NET_WRITE_TIMEOUT = 60;      // Timeout on write
  NET_WAIT_TIMEOUT = 8*60*60;  // Wait for new query

type
  PVio = ^TVio;
  TVio = record
  end;

type
  PNET = ^TNET;
  TNET = record
    vio: PVio;
    fd: my_socket;
    fcntl: longint;
    buff, buff_end, write_pos, read_pos: pByte;
    last_error: array [0..MYSQL_ERRMSG_SIZE - 1] of char;
    last_errno, max_packet, timeout, pkt_nr: longword;
    error: byte;
    return_errno, compress: my_bool;
    no_send_ok: my_bool;  // needed if we are doing several
      // queries in one command ( as in LOAD TABLE ... FROM MASTER ),
      // and do not want to confuse the client with OK at the wrong time
    remain_in_buf, length, buf_length, where_b: longword;
    return_status: pLongword;
    reading_or_writing: byte;
    save_char: char;
  end;

const
  packet_error: longword = $ffffffff;

const
  FIELD_TYPE_DECIMAL = 0;
  FIELD_TYPE_TINY = 1;
  FIELD_TYPE_SHORT = 2;
  FIELD_TYPE_LONG = 3;
  FIELD_TYPE_FLOAT = 4;
  FIELD_TYPE_DOUBLE = 5;
  FIELD_TYPE_NULL = 6;
  FIELD_TYPE_TIMESTAMP = 7;
  FIELD_TYPE_LONGLONG = 8;
  FIELD_TYPE_INT24 = 9;
  FIELD_TYPE_DATE = 10;
  FIELD_TYPE_TIME = 11;
  FIELD_TYPE_DATETIME = 12;
  FIELD_TYPE_YEAR = 13;
  FIELD_TYPE_NEWDATE = 14;
  FIELD_TYPE_ENUM = 247;
  FIELD_TYPE_SET = 248;
  FIELD_TYPE_TINY_BLOB = 249;
  FIELD_TYPE_MEDIUM_BLOB = 250;
  FIELD_TYPE_LONG_BLOB = 251;
  FIELD_TYPE_BLOB = 252;
  FIELD_TYPE_VAR_STRING = 253;
  FIELD_TYPE_STRING = 254;

const
  FIELD_TYPE_CHAR = FIELD_TYPE_TINY;      // For compability
  FIELD_TYPE_INTERVAL = FIELD_TYPE_ENUM;  // For compability

type
  enum_field_types = FIELD_TYPE_DECIMAL..FIELD_TYPE_STRING;

// ------------------------
// From mysql_version.h ...
// ------------------------

const
  PROTOCOL_VERSION = 10;
  MYSQL_SERVER_VERSION = '3.23.49';
  MYSQL_SERVER_SUFFIX = '';
  FRM_VER = 6;
  MYSQL_VERSION_ID = 32349;
  MYSQL_PORT = 3306;
  MYSQL_UNIX_ADDR = '/tmp/mysql.sock';

// ----------------
// From mysql.h ...
// ----------------

type
  PMYSQL_FIELD = ^TMYSQL_FIELD;
  TMYSQL_FIELD = record
    name: pChar;              // Name of column
    table: pChar;             // Table of column if column was a field
    def: pChar;               // Default value (set by mysql_list_fields)
    _type: enum_field_types;  // Type of field. Se mysql_com.h for types
    length: longword;         // Width of column
    max_length: longword;     // Max width of selected set
    flags: longword;          // Div flags
    decimals: longword;       // Number of decimals in field
  end;

type
  PMYSQL_ROW = ^TMYSQL_ROW;  // return data as array of strings
  TMYSQL_ROW = array[0..MaxInt div SizeOf(pChar) - 1] of pChar;

type
  MYSQL_FIELD_OFFSET = longword;  // offset to current field

type
  my_ulonglong = int64;

const
  MYSQL_COUNT_ERROR: my_ulonglong = not 0;

type
  PMYSQL_ROWS = ^TMYSQL_ROWS;
  TMYSQL_ROWS = record
    next: PMYSQL_ROWS;  // list of rows
    data: PMYSQL_ROW;
  end;

type
  MYSQL_ROW_OFFSET = PMYSQL_ROWS;  // offset to current row

type
  PMYSQL_DATA = ^TMYSQL_DATA;
  TMYSQL_DATA = record
    rows: my_ulonglong;
    fields: longword;
    data: PMYSQL_ROWS;
    alloc: TMEM_ROOT;
  end;

type
  PMYSQL_OPTIONS = ^TMYSQL_OPTIONS;
  TMYSQL_OPTIONS = record
    connect_timeout, client_flag: longword;
    compress, named_pipe: my_bool;
    port: longword;
    host, init_command, user, password, unix_socket, db: pChar;
    my_cnf_file, my_cnf_group, charset_dir, charset_name: pChar;
    use_ssl: my_bool;   // if to use SSL or not
    ssl_key: pChar;     // PEM key file
    ssl_cert: pChar;    // PEM cert file
    ssl_ca: pChar;      // PEM CA file
    ssl_capath: pChar;  // PEM directory of CA-s?
  end;

type
  mysql_option = (
    MYSQL_OPT_CONNECT_TIMEOUT, MYSQL_OPT_COMPRESS,
    MYSQL_OPT_NAMED_PIPE, MYSQL_INIT_COMMAND,
    MYSQL_READ_DEFAULT_FILE, MYSQL_READ_DEFAULT_GROUP,
    MYSQL_SET_CHARSET_DIR, MYSQL_SET_CHARSET_NAME,
    MYSQL_OPT_LOCAL_INFILE
  );

type
  mysql_status = (
    MYSQL_STATUS_READY, MYSQL_STATUS_GET_RESULT,
    MYSQL_STATUS_USE_RESULT
  );

type
  PMYSQL_FIELDS = ^TMYSQL_FIELDS;
  TMYSQL_FIELDS = array[0..MaxInt div SizeOf(TMYSQL_FIELD) - 1] of TMYSQL_FIELD;

type
  PCHARSET_INFO = ^TCHARSET_INFO;
  TCHARSET_INFO = record
    // Omitted: Structure not necessarily needed.
    // Definition of struct charset_info_st can be
    // found in include/m_ctype.h
  end;

type
  PMYSQL = ^TMYSQL;
  TMYSQL = record
    net: TNET;                    // Communication parameters
    connector_fd: gptr;           // ConnectorFd for SSL
    host, user, passwd, unix_socket, server_version, host_info, info, db: pChar;
    port, client_flag, server_capabilities: longword;
    protocol_version: longword;
    field_count: longword;
    server_status: longword;
    thread_id: longword;          // Id for connection in server
    affected_rows: my_ulonglong;
    insert_id: my_ulonglong;      // id if insert on table with NEXTNR
    extra_info: my_ulonglong;     // Used by mysqlshow
    packet_length: longword;
    status: mysql_status;
    fields: PMYSQL_FIELDS;
    field_alloc: TMEM_ROOT;
    free_me: my_bool;             // If free in mysql_close
    reconnect: my_bool;           // set to 1 if automatic reconnect
    options: TMYSQL_OPTIONS;
    scramble_buff: array [0..8] of char;
    charset: PCHARSET_INFO;
    server_language: longword;
  end;

type
  PMYSQL_RES = ^TMYSQL_RES;
  TMYSQL_RES = record
    row_count: my_ulonglong;
    field_count, current_field: longword;
    fields: PMYSQL_FIELDS;
    data: PMYSQL_DATA;
    data_cursor: PMYSQL_ROWS;
    field_alloc: TMEM_ROOT;
    row: PMYSQL_ROW;          // If unbuffered read
    current_row: PMYSQL_ROW;  // buffer to current row
    lengths: pLongword;       // column lengths of current row
    handle: PMYSQL;           // for unbuffered reads
    eof: my_bool;             // Used my mysql_fetch_row
  end;

type
  PMYSQL_LENGTHS = ^TMYSQL_LENGTHS;
  TMYSQL_LENGTHS = array[0..MaxInt div SizeOf(longword) - 1] of longword;

type
  extend_buffer_func = function(void: pointer; _to: pChar; length: pLongword): pChar;

// Status codes for libmySQL.dll

const
  LIBMYSQL_UNDEFINED = 0;     // libmysql_load() has not yet been called
  LIBMYSQL_MISSING = 1;       // No suitable DLL could be located
  LIBMYSQL_INCOMPATIBLE = 2;  // A DLL was found but it is not compatible
  LIBMYSQL_READY = 3;         // The DLL was loaded successfully

var
  libmysql_handle: HMODULE = 0;
  libmysql_status: byte = LIBMYSQL_UNDEFINED;

{------------------------------------------------------------------------------}
function IS_NUM_FIELD(f: PMYSQL_FIELD): boolean;
function INTERNAL_NUM_FIELD(f: PMYSQL_FIELD): boolean;
function IS_BLOB(n: longword): boolean;
function IS_NUM(t: longword): boolean;
function IS_PRI_KEY(n: longword): boolean;
function IS_NOT_NULL(n: longword): boolean;

type
  TDynamicStringArray = array of String;
  TDynamicIntegerArray = array of Integer;

{------------------------------------------------------------------------------}

type
  TMysqlComponent = class(TComponent)
  private
    { Private declarations }
    Hostp     : String;
    Loginp    : String;
    Passwordp : String;
    Databasep : String;
    INIFileNamep : String;
    procedure SetHost     (Value : string);
    procedure SetLogin    (Value : string);
    procedure SetPassword (Value : string);
    procedure SetDatabase (Value : string);

    procedure assign_proc(var proc: FARPROC; name: pChar);
    function  mysql_reload(_mysql: PMySQL): longint;
    function  libmysql_load(name: pChar): byte;
    procedure libmysql_free;

  protected
    { Protected declarations }
  public
    { Public declarations }
    name_libmysql : pChar;
    { link a la base }
    Linkp     : PMYSQL;
    { ¿on est connecté? }
    Connected : boolean;
    { ¿on s séléctionné la base? }
    Selected  : boolean;

    { Public functions }
  mysql_init: function(_mysql: PMYSQL): PMYSQL; stdcall;
  {$IFDEF HAVE_OPENSSL}
  mysql_ssl_set: function(_mysql: PMYSQL; const key, cert, ca, capath: pChar): longint; stdcall;
  mysql_ssl_cipher: function(_mysql: PMYSQL): pChar; stdcall;
  mysql_ssl_clear: function(_mysql: PMYSQL): longint; stdcall;
  {$ENDIF} // HAVE_OPENSSL
  mysql_connect: function(_mysql: PMYSQL; const host, user, passwd: pChar): PMYSQL; stdcall;
  mysql_change_user: function(_mysql: PMYSQL; const user, passwd, db: pChar): my_bool; stdcall;
  mysql_real_connect: function(_mysql: PMYSQL; const host, user, passwd, db: pChar; port: longword; const unix_socket: pChar; clientflag: longword): PMYSQL; stdcall;
  mysql_close: procedure(sock: PMYSQL); stdcall;
  mysql_select_db: function(_mysql: PMYSQL; const db: pChar): longint; stdcall;
  mysql_query: function(_mysql: PMYSQL; const q: pChar): longint; stdcall;
  mysql_send_query: function(_mysql: PMYSQL; const q: pChar; length: longword): longint; stdcall;
  mysql_read_query_result: function(_mysql: PMYSQL): longint; stdcall;
  mysql_real_query: function(_mysql: PMYSQL; const q: pChar; length: longword): longint; stdcall;
  mysql_create_db: function(_mysql: PMYSQL; const DB: pChar): longint; stdcall;
  mysql_drop_db: function(_mysql: PMYSQL; const DB: pChar): longint; stdcall;
  mysql_shutdown: function(_mysql: PMYSQL): longint; stdcall;
  mysql_dump_debug_info: function(_mysql: PMYSQL): longint; stdcall;
  mysql_refresh: function(_mysql: PMYSQL; refresh_options: longword): longint; stdcall;
  mysql_kill: function(_mysql: PMYSQL; pid: longword): longint; stdcall;
  mysql_ping: function(_mysql: PMYSQL): longint; stdcall;
  mysql_stat: function(_mysql: PMYSQL): pChar; stdcall;
  mysql_get_server_info: function(_mysql: PMYSQL): pChar; stdcall;
  mysql_get_client_info: function: pChar; stdcall;
  mysql_get_host_info: function(_mysql: PMYSQL): pChar; stdcall;
  mysql_get_proto_info: function(_mysql: PMYSQL): longword; stdcall;
  mysql_list_dbs: function(_mysql: PMYSQL; const wild: pChar): PMYSQL_RES; stdcall;
  mysql_list_tables: function(_mysql: PMYSQL; const wild: pChar): PMYSQL_RES; stdcall;
  mysql_list_fields: function(_mysql: PMYSQL; const table, wild: pChar): PMYSQL_RES; stdcall;
  mysql_list_processes: function(_mysql: PMYSQL): PMYSQL_RES; stdcall;
  mysql_store_result: function(_mysql: PMYSQL): PMYSQL_RES; stdcall;
  mysql_use_result: function(_mysql: PMYSQL): PMYSQL_RES; stdcall;
  mysql_options: function(_mysql: PMYSQL; option: mysql_option; const arg: pChar): longint; stdcall;
  mysql_free_result: procedure(result: PMYSQL_RES); stdcall;
  free_Result: procedure(result: PMYSQL_RES); stdcall;

  mysql_data_seek: procedure(result: PMYSQL_RES; offset: my_ulonglong); stdcall;
  mysql_row_seek: function(result: PMYSQL_RES; offset: MYSQL_ROW_OFFSET): MYSQL_ROW_OFFSET; stdcall;
  mysql_field_seek: function(result: PMYSQL_RES; offset: MYSQL_FIELD_OFFSET): MYSQL_FIELD_OFFSET; stdcall;
  mysql_fetch_row: function(result: PMYSQL_RES): PMYSQL_ROW; stdcall;
  fetch_row: function(result: PMYSQL_RES): PMYSQL_ROW; stdcall;
  mysql_fetch_lengths: function(result: PMYSQL_RES): PMYSQL_LENGTHS; stdcall;
  mysql_fetch_field: function(result: PMYSQL_RES): PMYSQL_FIELD; stdcall;
  mysql_escape_string: function(_to: pChar; const from: pChar; from_length: longword): longword; stdcall;
  mysql_real_escape_string: function(_mysql: PMYSQL; _to: pChar; const from: pChar; length: longword): longword; stdcall;
  mysql_debug: procedure(const debug: pChar); stdcall;
  mysql_odbc_escape_string: function(_mysql: PMYSQL; _to: pChar; to_length: longword; const from: pChar; from_length: longword; param: pointer; extend_buffer: extend_buffer_func): pChar; stdcall;
  myodbc_remove_escape: procedure(_mysql: PMYSQL; name: pChar); stdcall;
  mysql_thread_safe: function: longword; stdcall;
  mysql_field_count: function(_mysql: PMYSQL): longword; stdcall;
  mysql_affected_rows: function(_mysql: PMYSQL): my_ulonglong; stdcall;
  mysql_insert_id: function(_mysql: PMYSQL): my_ulonglong; stdcall;
  mysql_errno: function(_mysql: PMYSQL): longword; stdcall;
  mysql_error: function(_mysql: PMYSQL): pChar; stdcall;
  mysql_info: function(_mysql: PMYSQL): pChar; stdcall;
  mysql_thread_id: function(_mysql: PMYSQL): longword; stdcall;
  mysql_character_set_name: function(_mysql: PMYSQL): pChar; stdcall;
  mysql_num_rows: function(res: PMYSQL_RES): my_ulonglong; stdcall;
  num_rows: function(res: PMYSQL_RES): my_ulonglong; stdcall;
  mysql_num_fields: function(res: PMYSQL_RES): longword; stdcall;
  num_fields: function(res: PMYSQL_RES): longword; stdcall;
  mysql_eof: function(res: PMYSQL_RES): my_bool; stdcall;
  mysql_fetch_field_direct: function(res: PMYSQL_RES; fieldnr: longword): PMYSQL_FIELD; stdcall;
  fetch_field_direct: function(res: PMYSQL_RES; fieldnr: longword): PMYSQL_FIELD; stdcall;
  mysql_fetch_fields: function(res: PMYSQL_RES): PMYSQL_FIELDS; stdcall;
  mysql_row_tell: function(res: PMYSQL_RES): PMYSQL_ROWS; stdcall;
  mysql_field_tell: function(res: PMYSQL_RES): longword; stdcall;

    Constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;

    function IS_NUM_FIELD(f: PMYSQL_FIELD): boolean;
    function INTERNAL_NUM_FIELD(f: PMYSQL_FIELD): boolean;
    function IS_BLOB(n: longword): boolean;
    function IS_NUM(t: longword): boolean;
    function IS_PRI_KEY(n: longword): boolean;
    function IS_NOT_NULL(n: longword): boolean;
    function IS_AUTO_INCREMENT(n: longword): boolean;

    { redefinition de fonctions de base pour le composant }
    function  Connect : integer;
    procedure Close;
    function  Query (requete : PChar) : PMYSQL_RES; overload;
    function  Query (requete : String) : PMYSQL_RES; overload;


    procedure LoadFromINI; overload;
    procedure LoadFromINI (FileName : String); overload;
    procedure SaveToINI; overload;
    procedure SaveToINI   (FileName : String); overload;

    function  SaveTableToFile (Table, Filename: string): boolean; overload;
    function  SaveTableToFile (Table, Filename: string;
                Append,TableRef,DelData,DropTable : boolean): boolean; overload;
//    function  SaveTableToXLS(FileName, Table: string) : boolean;

    procedure SaveBaseToFile(FileName : String;
                          Append,TableRef,DelData,DropTable : boolean); overload;
    procedure SaveBaseToFile(FileName, DatabaseToSave : String;
                          Append,TableRef,DelData,DropTable : boolean); overload;


    function  field_Details_descr(Field : PMYSQL_FIELD) : string;
    function  field_MysqlType (Field : PMYSQL_FIELD) : string;

    function  add_slashes (mot : string) : string;

    function  AddTableToFile(Table, Filename: string): boolean;
    function  LoadSQLFromFile(Filename: string): boolean;

    procedure ListDBsInTStrings (var Items : TStrings);
    procedure ListDBsInListBox (ListBox : TListBox);
    procedure ListFieldsInListBox (ListBox : TListBox;Table : string);
    procedure ListTablesInListBox (ListBox : TListBox;Database : string);

    procedure ListInListBox (ListBox : TListBox;Res: PMYSQL_RES);

    procedure ListTablesInTStrings (var Items : TStrings); overload;
    procedure ListTablesInTStrings (var Items : TStrings;Database : string); overload;

    function  List_Tables (DatabaseToList : string) : PMYSQL_RES;
    function  list_dbs (wild: string): PMYSQL_RES;
    function  list_fields (table, wild: string): PMYSQL_RES;

    procedure ListFieldsInTStrings (var Items : TStrings;Table : string);
    procedure ListInTStrings (var Items : TStrings;Res: PMYSQL_RES);

    function QueryIntoTStrings (Querys : string;var Items : TStrings) : boolean;
    function QueryIntoTStringList (Querys : string;var Items : TStringList) : boolean;
    function QueryIntoTListBox (Querys : string;ListBox : TListBox) : boolean;

    function QueryFirstResult (Querys : string;var FirstRowZero : string) : boolean;
    function fields_type (Table : string;var Fields_names : TDynamicStringArray;var Fields_types : TDynamicIntegerArray) : integer;
    function field_ConversionType_Nomtype (no : integer ) : string;
    function field_ConversionNomtype_Type (nom : string) : integer;

    function table_change_name (hold_name, new_name : string) : boolean;
    function create_table (name,query_table : string) : boolean;
    function delete_table (name : string) : boolean;

//    function QueryIntoTStrings (Querys : string;var Strings : TStrings) : boolean;
    function QueryIntoTStringsUnique (Querys : string;var Strings : TStrings) : boolean;

    function  field_count(): longword;

  published
    { Published declarations }
    property Host     : string read Hostp     write SetHost;
    property Login    : string read Loginp    write SetLogin;
    property Password : string read Passwordp write SetPassword;
    property Database : string read Databasep write SetDatabase;
    property INIFileName : string read INIFileNamep write INIFileNamep;


  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mysql DB', [TMysqlComponent]);
end;

{------------------------------------------------------------------------------}

Constructor TMySqlComponent.Create(AOwner:TComponent);
begin
  InHerited Create(AOwner);
     name_libmysql := 'libmysql.dll';
     if (csDesigning in ComponentState) then
     begin
         // si on est en mode conception
         { Definition des variables }
         Host      := 'localhost';
         Login     := 'root';
         Password  := '';
         Database  := 'test';
         INIFileName := 'MySqlComponent.ini';
     end
     else
     begin
          // si on est en mode execution
          libmysql_load(nil);
     end;
end;

destructor TMySqlComponent.Destroy;
begin
     if (csDesigning in ComponentState) then
     begin

     end
     else
     begin
         libmysql_free;
     end;
     InHerited Destroy;
end;

{------------------------------------------------------------------------------}

function IS_PRI_KEY(n: longword): boolean;
begin
  IS_PRI_KEY := (n and PRI_KEY_FLAG) = PRI_KEY_FLAG;
end;

function IS_NOT_NULL(n: longword): boolean;
begin
  IS_NOT_NULL := (n and NOT_NULL_FLAG) = NOT_NULL_FLAG;
end;

function IS_BLOB(n: longword): boolean;
begin
  IS_BLOB := (n and BLOB_FLAG) = BLOB_FLAG;
end;

function IS_NUM(t: longword): boolean;
begin
  IS_NUM := (t <= FIELD_TYPE_INT24) or (t = FIELD_TYPE_YEAR);
end;

function IS_NUM_FIELD(f: PMYSQL_FIELD): boolean;
begin
  IS_NUM_FIELD := (f.flags and NUM_FLAG) = NUM_FLAG;
end;

function INTERNAL_NUM_FIELD(f: PMYSQL_FIELD): boolean;
begin
  INTERNAL_NUM_FIELD := (((f._type <= FIELD_TYPE_INT24) and ((f._type <> FIELD_TYPE_TIMESTAMP) or (f.length = 14) or (f.length = 8))) or (f._type = FIELD_TYPE_YEAR));
end;

function IS_AUTO_INCREMENT(n: longword): boolean;
begin
  IS_AUTO_INCREMENT := (n and AUTO_INCREMENT_FLAG) = AUTO_INCREMENT_FLAG;
end;

{------------------------------------------------------------------------------}

function TMySqlComponent.IS_PRI_KEY(n: longword): boolean;
begin
  IS_PRI_KEY := (n and PRI_KEY_FLAG) = PRI_KEY_FLAG;
end;

function TMySqlComponent.IS_NOT_NULL(n: longword): boolean;
begin
  IS_NOT_NULL := (n and NOT_NULL_FLAG) = NOT_NULL_FLAG;
end;

function TMySqlComponent.IS_BLOB(n: longword): boolean;
begin
  IS_BLOB := (n and BLOB_FLAG) = BLOB_FLAG;
end;

function TMySqlComponent.IS_NUM(t: longword): boolean;
begin
  IS_NUM := (t <= FIELD_TYPE_INT24) or (t = FIELD_TYPE_YEAR);
end;

function TMySqlComponent.IS_NUM_FIELD(f: PMYSQL_FIELD): boolean;
begin
  IS_NUM_FIELD := (f.flags and NUM_FLAG) = NUM_FLAG;
end;

function TMySqlComponent.INTERNAL_NUM_FIELD(f: PMYSQL_FIELD): boolean;
begin
  INTERNAL_NUM_FIELD := (((f._type <= FIELD_TYPE_INT24) and ((f._type <> FIELD_TYPE_TIMESTAMP) or (f.length = 14) or (f.length = 8))) or (f._type = FIELD_TYPE_YEAR));
end;

function  TMySqlComponent.IS_AUTO_INCREMENT(n: longword): boolean;
begin
  IS_AUTO_INCREMENT := (n and AUTO_INCREMENT_FLAG) = AUTO_INCREMENT_FLAG;
end;


{------------------------------------------------------------------------------}

procedure TMySQLComponent.SetHost (Value : string);
begin
     if (not Connected) then Hostp := Value;
end;

procedure TMySQLComponent.SetLogin (Value : string);
begin
     if (not Connected) then Loginp := Value;
end;

procedure TMySQLComponent.SetPassword (Value : string);
begin
     if (not Connected) then Passwordp := Value;
end;

procedure TMySQLComponent.SetDatabase (Value : string);
begin
     if (not Connected) then Databasep := Value;
end;                                                                

{------------------------------------------------------------------------------}

function TMysqlComponent.mysql_reload(_mysql: PMYSQL): longint;
begin
  mysql_reload := mysql_refresh(_mysql, REFRESH_GRANT);
end;

procedure TMysqlComponent.assign_proc(var proc: FARPROC; name: pChar);
begin
    proc := GetProcAddress(libmysql_handle, name);
    if proc = nil then libmysql_status := LIBMYSQL_INCOMPATIBLE;
end;

function TMysqlComponent.libmysql_load(name: pChar): byte;
begin
  libmysql_free;
  if name = nil then name := 'libmysql.dll';
  libmysql_handle := LoadLibrary(name);
  if libmysql_handle = 0 then libmysql_status := LIBMYSQL_MISSING
  else begin
    libmysql_status := LIBMYSQL_READY;
    assign_proc(@mysql_num_rows, 'mysql_num_rows');
    assign_proc(@num_rows, 'mysql_num_rows');
    assign_proc(@mysql_num_fields, 'mysql_num_fields');
    assign_proc(@num_fields, 'mysql_num_fields');
    assign_proc(@mysql_eof, 'mysql_eof');
    assign_proc(@mysql_fetch_field_direct, 'mysql_fetch_field_direct');
    assign_proc(@fetch_field_direct, 'mysql_fetch_field_direct');
    assign_proc(@mysql_fetch_fields, 'mysql_fetch_fields');
    assign_proc(@mysql_row_tell, 'mysql_row_tell');
    assign_proc(@mysql_field_tell, 'mysql_field_tell');
    assign_proc(@mysql_field_count, 'mysql_field_count');
    assign_proc(@mysql_affected_rows, 'mysql_affected_rows');
    assign_proc(@mysql_insert_id, 'mysql_insert_id');
    assign_proc(@mysql_errno, 'mysql_errno');
    assign_proc(@mysql_error, 'mysql_error');
    assign_proc(@mysql_info, 'mysql_info');
    assign_proc(@mysql_thread_id, 'mysql_thread_id');
    assign_proc(@mysql_character_set_name, 'mysql_character_set_name');
    assign_proc(@mysql_init, 'mysql_init');
    {$IFDEF HAVE_OPENSSL}
    assign_proc(@mysql_ssl_set, 'mysql_ssl_set');
    assign_proc(@mysql_ssl_cipher, 'mysql_ssl_cipher');
    assign_proc(@mysql_ssl_clear, 'mysql_ssl_clear');
    {$ENDIF} // HAVE_OPENSSL
    assign_proc(@mysql_connect, 'mysql_connect');
    assign_proc(@mysql_change_user, 'mysql_change_user');
    assign_proc(@mysql_real_connect, 'mysql_real_connect');
    assign_proc(@mysql_close, 'mysql_close');
    assign_proc(@mysql_select_db, 'mysql_select_db');
    assign_proc(@mysql_query, 'mysql_query');
    assign_proc(@mysql_send_query, 'mysql_send_query');
    assign_proc(@mysql_read_query_result, 'mysql_read_query_result');
    assign_proc(@mysql_real_query, 'mysql_real_query');
    assign_proc(@mysql_create_db, 'mysql_create_db');
    assign_proc(@mysql_drop_db, 'mysql_drop_db');
    assign_proc(@mysql_shutdown, 'mysql_shutdown');
    assign_proc(@mysql_dump_debug_info, 'mysql_dump_debug_info');
    assign_proc(@mysql_refresh, 'mysql_refresh');
    assign_proc(@mysql_kill, 'mysql_kill');
    assign_proc(@mysql_ping, 'mysql_ping');
    assign_proc(@mysql_stat, 'mysql_stat');
    assign_proc(@mysql_get_server_info, 'mysql_get_server_info');
    assign_proc(@mysql_get_client_info, 'mysql_get_client_info');
    assign_proc(@mysql_get_host_info, 'mysql_get_host_info');
    assign_proc(@mysql_get_proto_info, 'mysql_get_proto_info');
    assign_proc(@mysql_list_dbs, 'mysql_list_dbs');
    assign_proc(@mysql_list_tables, 'mysql_list_tables');
    assign_proc(@mysql_list_fields, 'mysql_list_fields');
    assign_proc(@mysql_list_processes, 'mysql_list_processes');
    assign_proc(@mysql_store_result, 'mysql_store_result');
    assign_proc(@mysql_use_result, 'mysql_use_result');
    assign_proc(@mysql_options, 'mysql_options');
    assign_proc(@mysql_free_result, 'mysql_free_result');
    assign_proc(@free_result, 'mysql_free_result');
    assign_proc(@mysql_data_seek, 'mysql_data_seek');
    assign_proc(@mysql_row_seek, 'mysql_row_seek');
    assign_proc(@mysql_field_seek, 'mysql_field_seek');
    assign_proc(@mysql_fetch_row, 'mysql_fetch_row');
    assign_proc(@fetch_row, 'mysql_fetch_row');
    assign_proc(@mysql_fetch_lengths, 'mysql_fetch_lengths');
    assign_proc(@mysql_fetch_field, 'mysql_fetch_field');
    assign_proc(@mysql_escape_string, 'mysql_escape_string');
    assign_proc(@mysql_real_escape_string, 'mysql_real_escape_string');
    assign_proc(@mysql_debug, 'mysql_debug');
    assign_proc(@mysql_odbc_escape_string, 'mysql_odbc_escape_string');
    assign_proc(@myodbc_remove_escape, 'myodbc_remove_escape');
    assign_proc(@mysql_thread_safe, 'mysql_thread_safe');
  end;
  libmysql_load := libmysql_status;
end;

procedure TMysqlComponent.libmysql_free;
begin
  if libmysql_handle <> 0 then FreeLibrary(libmysql_handle);
  libmysql_handle := 0;
  libmysql_status := LIBMYSQL_UNDEFINED;
end;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

function TMySQLComponent.Connect : integer;
begin
     if (not Connected) or (not Selected) then
     begin
          Linkp   := mysql_init(nil);
          if (mysql_connect(Linkp, PChar(Hostp), PChar(Loginp), PChar(Passwordp)) = nil) then
          begin
               Connected := false;
               Connect := -1;
               exit;
          end
          else
          begin
               Connected := true;
               if (mysql_select_db(Linkp, PChar(Databasep))<>0) then
               begin
                    Selected := false;
                    Connect := -2;
                    exit;
               end;
               Selected := true;
          end;
     end;
     Connect := 0;
end;

procedure TMySQLComponent.Close;
begin
     if Connected = true then
     begin
          mysql_close(Linkp);
          Connected := False;
          Selected  := False;
     end;
end;


function TMySQLComponent.Query (requete : String) : PMYSQL_RES;
begin
     Query := Query (PChar(requete));
end;
function TMySQLComponent.Query (requete : PChar) : PMYSQL_RES;
begin
    if mysql_query(Linkp, requete) <> 0 then
    begin
         Query := nil;
         exit;
    end;
    Query := mysql_store_result(Linkp);
end;


procedure TMySQLComponent.LoadFromIni;
begin
     LoadFromIni (INIFileNamep);
end;
procedure TMySQLComponent.LoadFromIni (Filename : String);
var
   MyIniFile: TIniFile;
begin
    {chargement du fichier de configuration}
    MyIniFile := TIniFile.Create(Filename);
    with MyIniFile do
    begin
        Hostp     := ReadString('MYSQL CONFIG', 'host', 'localhost');
        Loginp    := ReadString('MYSQL CONFIG', 'login', 'root');
        Passwordp := ReadString('MYSQL CONFIG', 'password', '');
        Databasep := ReadString('MYSQL CONFIG', 'database', 'test');
    end;
    MyIniFile.Free;
end;

procedure TMySQLComponent.SaveToIni;
begin
     SaveToIni (INIFileNamep);
end;
procedure TMySQLComponent.SaveToIni (Filename : String);
var
   MyIniFile: TIniFile;
begin
    {chargement du fichier de configuration}
    MyIniFile := TIniFile.Create(Filename);
    with MyIniFile do
    begin
         WriteString('MYSQL CONFIG', 'host'    , Hostp);
         WriteString('MYSQL CONFIG', 'login'   , Loginp);
         WriteString('MYSQL CONFIG', 'password', Passwordp);
         WriteString('MYSQL CONFIG', 'database', Databasep);
    end;
    MyIniFile.Free;
end;


function TMySQLComponent.SaveTableToFile (Table, Filename: string): boolean;
begin
   SaveTableToFile := SaveTableToFile (Table, Filename,False,False,False,False);
end;
function TMySQLComponent.SaveTableToFile (Table, Filename: string;
                          Append,TableRef,DelData,DropTable : boolean): boolean;
var
   Fichier: TextFile;
   Res: PMYSQL_RES;
   Row: PMYSQL_ROW;
   i  : integer;
   Fields : PMYSQL_FIELD;
   Querys,
   underq,
   FieldsT,FieldsFin : string;
begin
    AssignFile(Fichier,FileName);
    if (not FileExists(FileName)) or (not Append)
      then Rewrite (Fichier)
      else System.Append (Fichier);
    Res := Query ('SELECT * FROM '+Table+';');
    if Res = nil then begin
         SaveTableToFile := false;
     end
   else
    try
       {Tag}
       Writeln(Fichier,
               '#--------------------------------------------'+#13+
               '# Table '+Table+#13+
               '# Sauvegarde du '+DateToStr(Date)+#13+
               '#--------------------------------------------');
       {Effacer les enregistrements precedents}

       if DropTable then Writeln(Fichier,'DROP TABLE IF EXISTS '+Table+';');


       FieldsT := 'CREATE TABLE '+Table+' (';
       FieldsFin := '';

       querys := 'INSERT INTO '+Table+' (';
       for i := 0 to mysql_num_fields(Res)-1 Do
       begin
            Fields := mysql_fetch_field_direct(Res,i);
            {primary key}
            if IS_PRI_KEY(Fields.flags) then
            begin
                 if FieldsFin=''
                   then FieldsFin := Fields.name
                   else FieldsFin := FieldsFin + ','+Fields.name;
            end;
            {champs}
            if i = 0 then
            begin
                 Querys := Querys +'`'+Fields.name+'`';
                 FieldsT := FieldsT + #13+field_Details_descr(Fields);
            end
            else
            begin
                 Querys := Querys +',`'+Fields.name+'`';
                 FieldsT := FieldsT +','+#13+field_Details_descr(Fields);
            end;
       end;
       {rajoute primary key}
       if FieldsFin <> '' then
          FieldsT := FieldsT +#13+', PRIMARY KEY ('+FieldsFin+')';
       FieldsT := FieldsT + ');';
       Querys := Querys + ') VALUES (';
       if TableRef then Writeln(Fichier,FieldsT);
       if DelData then Writeln(Fichier,'DELETE FROM '+Table+';');
       Row := mysql_fetch_row(Res);
       while Row <> nil do
       begin
            underq := '';
            for i := 0 to mysql_num_fields(Res)-1 Do
            begin
                 if i = 0 then
                        underq := underq +''''+add_slashes(Row[i])+''''
                 else
                        underq := underq +','''+add_slashes(Row[i])+'''';
            end;
            underq := Querys + underq + ');';
            Writeln(Fichier,underq);
            Row := mysql_fetch_row(Res);
       end;
    finally
      free_result(Res);
      SaveTableToFile := true;
    end;
    CloseFile(Fichier);
end;

function TMySQLComponent.AddTableToFile(Table, Filename: string): boolean;
var
   Res: PMYSQL_RES;
   Row: PMYSQL_ROW;
   i  : integer;
   Fields : PMYSQL_FIELD;
   Querys : string;
   underq : string;
   Fichier: TextFile;
begin
    Assignfile(Fichier,Filename);
    Append (Fichier);
    Res := Query ('SELECT * FROM '+Table+';');
    if Res = nil then begin
         AddTableToFile := false;
     end
   else
    try
       querys := 'INSERT INTO '+Table+' (';
       for i := 0 to mysql_num_fields(Res)-1 Do
       begin
            Fields := mysql_fetch_field_direct(Res,i);
            if i = 0 then
                Querys := Querys +'`'+Fields.name+'`'
               else
                Querys := Querys +',`'+Fields.name+'`';
       end;
       Querys := Querys + ') VALUES (';

       Row := mysql_fetch_row(Res);
       while Row <> nil do
       begin
            underq := '';
            for i := 0 to mysql_num_fields(Res)-1 Do
            begin
                 if i = 0 then
                        underq := underq +''''+add_slashes(Row[i])+''''
                 else
                        underq := underq +','''+add_slashes(Row[i])+'''';
            end;
            underq := Querys + underq + ');';
            Writeln(Fichier,underq);
            Row := mysql_fetch_row(Res);
       end;
    finally
      free_result(Res);
      AddTableToFile := true;
    end;
    Closefile(Fichier);
end;

function TMySQLComponent.List_Tables (DatabaseToList : string) : PMYSQL_RES;
var
   Res : PMYSQL_RES;
begin
     if Selected = true then
     begin
          if  (DatabaseToList<>'') and (DatabaseToList<>Databasep) then
          begin
               Close;
               Databasep := DatabaseToList;
               Connect;
          end;
          Res := query('SHOW tables ;');
          List_Tables := Res;
    end
    else List_Tables := nil;
end;

function  TMySQLComponent.list_dbs (wild: string): PMYSQL_RES;
begin
     list_dbs := mysql_list_dbs(Linkp,PChar(wild));
end;

procedure TMySQLComponent.SaveBaseToFile(FileName : String;
                          Append,TableRef,DelData,DropTable : boolean);
begin
   SaveBaseToFile(FileName, '',Append,TableRef,DelData,DropTable);
end;


procedure TMySQLComponent.SaveBaseToFile(FileName, DatabaseToSave : String;
                          Append,TableRef,DelData,DropTable : boolean);
var
   Res: PMYSQL_RES;
   Row: PMYSQL_ROW;
begin
     if Selected = true then
     begin
          if  (DatabaseToSave<>'') and (DatabaseToSave<>Databasep) then
          begin
               Close;
               Databasep := DatabaseToSave;
               Connect;
          end;
          Res := list_tables('');
          if Res <> nil then
          begin
                try
                    Row := mysql_fetch_row(Res);
                    if Row <> nil then SaveTableToFile (Row[0],Filename,Append,TableRef,DelData,DropTable);
                    Row := mysql_fetch_row(Res);
                    while Row <> nil do
                    begin
                         SaveTableToFile (Row[0],Filename,True,TableRef,DelData,DropTable);
                          Row := mysql_fetch_row(Res);
                    end;
                finally
                      mysql_free_result(Res);
                end;
          end;
    end;
end;



function LineFeedsToXLS(s:string):string;
var
  Res: string;
  i: Integer;
begin
  Res := '';
  for i := 1 to Length(s) do
    if s[i] <> #13 then
      Res := Res + s[i];
  LineFeedsToXls:=res;
end;

{function TMySQLComponent.SaveTableToXLS(FileName, Table: string) : boolean;
var
  { sauver sous excel }
{  FExcel: Variant;
  FWorkbook: Variant;
  FWorksheet: Variant;
  FArray: Variant;
  s,z: Integer;
  RangeStr: string;
  StrtCol,StrtRow: Integer;
  newbook: Boolean;
  { aller chercher les infos dans la base }
 {  Res: PMYSQL_RES;
   Row: PMYSQL_ROW;
   i  : integer;
   Fields : PMYSQL_FIELD;
   Querys,
   underq,
   FieldsT,FieldsFin : string;
   RowCount,
   ColCount : cardinal;
begin
    Res := Query ('SELECT * FROM '+Table+';');
    if Res = nil then
     begin
         SaveTableToXLS := false;
         exit;
     end
   else
   // try
       { Titres des colonnes }
  {     for i := 0 to mysql_num_fields(Res)-1 Do
       begin
            Fields := mysql_fetch_field_direct(Res,i);
          //         Fields.name
       end;
      { creation fichier excel }
   {   try
          FExcel := CreateOleObject('excel.application');
          SaveTableToXLS := false;
      except
            SaveTableToXLS := false;
            Exit;
      end;
      newbook := True;

      if Table = '' then
      begin
           FWorkBook := FExcel.WorkBooks.Add;
           FWorkSheet := FWorkBook.WorkSheets.Add;
      end
      else
      begin
           FWorkBook := FExcel.WorkBooks.Open(Filename);
           if VarIsEmpty(FWorkBook)
             then FWorkBook := FExcel.WorkBooks.Add
             else newbook := False;

           FWorkSheet := unAssigned;
           for s := 1 to FWorkbook.Sheets.Count do
              if (FWorkBook.Sheets[s].Name = Table) then
                   FWorkSheet := FWorkBook.Sheets[s];

          if VarIsEmpty(FWorksheet) then
          begin
               FWorkSheet := FWorkBook.WorkSheets.Add;
               FWorkSheet.Name := Table;
          end;
      end;


      { -------- RowCount - ColCount }
//      RowCount := mysql_num_rows;
//      RowCount := mysql_num_fields;

{  FArray := VarArrayCreate([0,{RowCount -} {1 - StrtRow,0, {ColCount -}{ 1 - StrtCol],VarVariant);

{  for s := StrtRow to {RowCount -}{ 1 {do
{  begin
    for z := StrtCol to {ColCount - }{1 {do
    begin
      // FArray[s - StrtRow,z - StrtCol] := '"' + LineFeedsToXLS(SaveCell(RemapCol(z),s)) + '"';
      FArray[s - StrtRow,z - StrtCol] := LineFeedsToXLS('Case a sauvegarder');
    end;
  end;

  RangeStr := 'A1:';

  if ({ColCount -}{ StrtCol) > 26 then
  begin
    if ({ColCount - }{StrtCol) mod 26 = 0 then
    begin
      RangeStr := RangeStr + Chr(Ord('A') - 2 + (({ColCount -}{ StrtCol) div 26));
      RangeStr := RangeStr + 'Z';
    end
    else
    begin
      RangeStr := RangeStr + Chr(Ord('A') - 1 + (({ColCount - }{StrtCol) div 26));
      RangeStr := RangeStr + Chr(Ord('A') - 1 + (({ColCount - }{StrtCol) mod 26));
    end;
  end
  else
    RangeStr := RangeStr + Chr(Ord('A') - 1 + ({ColCount -}{ StrtCol));

  RangeStr := RangeStr + IntToStr({RowCount -}{ StrtRow);

  FWorkSheet.Range[rangestr].Value := FArray;

  if newbook then
    FWorkbook.SaveAs(filename)
  else
    FWorkbook.Save;

  FExcel.Quit;
  FExcel := unAssigned;
end;                                           }






function TMySQLComponent.field_Details_descr(Field : PMYSQL_FIELD) : string;
var
  s : string;
begin
     {reprend les informations du champs afin d'en faire une chaine qui servira
      a créer une table
    name: pChar;              // Name of column
    table: pChar;             // Table of column if column was a field
    def: pChar;               // Default value (set by mysql_list_fields)
    _type: enum_field_types;  // Type of field. Se mysql_com.h for types
    length: longword;         // Width of column
    max_length: longword;     // Max width of selected set
    flags: longword;          // Div flags
    decimals: longword;       // Number of decimals in field

function IS_PRI_KEY(n: longword): boolean;
function IS_NOT_NULL(n: longword): boolean;
function IS_BLOB(n: longword): boolean;
function IS_NUM(t: longword): boolean;

     id tinyint(4) NOT NULL auto_increment,
      }
      s := Field.name+' '+field_MysqlType(Field);
     // field.def
      field_Details_descr := s;
end;

function TMySQLComponent.field_MysqlType (Field : PMYSQL_FIELD) : string;
var
   s : string;
   no : longword;
begin
     s := '';
     no := Field._type;

     {type TINYTEXT}
//     if not IS_BLOB(Field.flags) then
     begin
     case no of
      252 : begin
                 case Field.length of
                   255 : no := FIELD_TYPE_TINYTEXT;
                   65535 : no := FIELD_TYPE_TEXT;
                   16777215 : no := FIELD_TYPE_MEDIUMTEXT;
                 //  4294967296 : no := FIELD_TYPE_LONGTEXT;
                 end;
            end;
     end;
     end;{
     else
     begin
     case no of
      252 : begin
                 case Field.length of
                   255 : no := FIELD_TYPE_TINY_BLOB;
                   65535 : no := FIELD_TYPE_BLOB;
                   16777215 : no := FIELD_TYPE_MEDIUM_BLOB;
                 //  4294967296 : no := FIELD_TYPE_LONG_BLOB;
                 end;
            end;
     end;
     end; }


     case no of
         FIELD_TYPE_DECIMAL : s  := STRING1_FIELD_TYPE_DECIMAL;
         FIELD_TYPE_TINY    : s  := STRING1_FIELD_TYPE_TINY;
         FIELD_TYPE_SHORT   : s  := STRING1_FIELD_TYPE_SHORT;
         FIELD_TYPE_LONG    : s  := STRING1_FIELD_TYPE_LONG;
         FIELD_TYPE_FLOAT   : s  := STRING1_FIELD_TYPE_FLOAT;
         FIELD_TYPE_DOUBLE  : s  := STRING1_FIELD_TYPE_DOUBLE;
         FIELD_TYPE_NULL    : s  := STRING1_FIELD_TYPE_NULL;
         FIELD_TYPE_TIMESTAMP : s := STRING1_FIELD_TYPE_TIMESTAMP;
         FIELD_TYPE_LONGLONG  : s := STRING1_FIELD_TYPE_LONGLONG;
         FIELD_TYPE_INT24   : s  := STRING1_FIELD_TYPE_INT24;
         FIELD_TYPE_DATE    : s  := STRING1_FIELD_TYPE_DATE;
         FIELD_TYPE_TIME    : s  := STRING1_FIELD_TYPE_TIME;
         FIELD_TYPE_DATETIME: s  := STRING1_FIELD_TYPE_DATETIME;
         FIELD_TYPE_YEAR    : s  := STRING1_FIELD_TYPE_YEAR;
         FIELD_TYPE_NEWDATE : s  := STRING1_FIELD_TYPE_NEWDATE;
         FIELD_TYPE_ENUM    : begin
                                   s  := STRING1_FIELD_TYPE_ENUM + '('+field.def+')';
                              end;
         FIELD_TYPE_SET     : s  := STRING1_FIELD_TYPE_SET;
         {BLOB}
         FIELD_TYPE_TINY_BLOB: s := STRING1_FIELD_TYPE_TINY_BLOB;
         FIELD_TYPE_MEDIUM_BLOB: s := STRING1_FIELD_TYPE_MEDIUM_BLOB;
         FIELD_TYPE_LONG_BLOB: s   := STRING1_FIELD_TYPE_LONG_BLOB;
         FIELD_TYPE_BLOB: s   := STRING1_FIELD_TYPE_BLOB;

         {TEXT}
         FIELD_TYPE_VAR_STRING: s := STRING1_FIELD_TYPE_VAR_STRING;
         FIELD_TYPE_STRING: s := STRING1_FIELD_TYPE_STRING;

         FIELD_TYPE_TINYTEXT : s := STRING1_FIELD_TYPE_TINYTEXT;
         FIELD_TYPE_TEXT : s := STRING1_FIELD_TYPE_TEXT;
         FIELD_TYPE_MEDIUMTEXT : s := STRING1_FIELD_TYPE_MEDIUMTEXT;
         FIELD_TYPE_LONGTEXT : s := STRING1_FIELD_TYPE_LONGTEXT;

     end;
     {ajout ou non de (xxx) au type}
     if ((no < 249) and (Field.length>0)) or
        (no = FIELD_TYPE_BLOB) or
        (no = FIELD_TYPE_STRING)
        then s := s +'('+IntToStr(Field.length)+')';

     {ajout des Flags
  ENUM_FLAG = 256;            // field is an enum
  AUTO_INCREMENT_FLAG = 512;  // field is a autoincrement field
  TIMESTAMP_FLAG = 1024;      // Field is a timestamp
  SET_FLAG = 2048;            // field is a set
  NUM_FLAG = 32768;           // Field is num (for clients)
  PART_KEY_FLAG = 16384;      // Intern; Part of some key
  GROUP_FLAG = 32768;         // Intern: Group field
  UNIQUE_FLAG = 65536;        // Intern: Used by sql_yacc
}
  if IS_NOT_NULL(Field.flags) then s := s +' NOT NULL ';
  if IS_AUTO_INCREMENT(Field.flags) then  s := s + ' auto_increment ';
  field_MysqlType := s;
end;

function TMySQLComponent.add_slashes (mot : string) : string;
var
   i : integer;
   t : string;
begin
     t := '';
     for i := 1 to StrLen(PChar(mot)) do
     begin
       if mot[i] = '''' then t := t + '\'''
                        else
       if mot[i] = '\'
         then t := t + '\\'
         else t := t + mot[i];
     end;
     add_slashes := t;
end;

procedure TMySQLComponent.ListDBsInTStrings (var Items : TStrings);
var
   Res: PMYSQL_RES;
begin
     if Connected = true then
     begin
          Res := list_dbs(PChar('%'));
          if Res <> nil then
              ListInTStrings(Items,Res);
    end;
end;

procedure TMySQLComponent.ListDBsInListBox (ListBox : TListBox);
var
   Res: PMYSQL_RES;
begin
     if Connected = true then
     begin
          Res := list_dbs('%');
          if Res <> nil then
              ListinListBox(ListBox,Res);
    end;
end;

procedure TMySQLComponent.ListTablesInTStrings (var Items : TStrings);
begin
     ListTablesInTStrings (Items,'');
end;
procedure TMySQLComponent.ListTablesInTStrings (var Items : TStrings;Database : string);
var
   Res: PMYSQL_RES;
begin
     if Selected = true then
     begin
          if (Database<>'') and (Database<>Databasep) then
          begin
               Close;
               Databasep := Database;
               Connect;
          end;
          Res := query('SHOW tables ;');
          if Res <> nil
          then ListInTStrings(Items,Res)
          else items.Clear;
    end;
end;

procedure TMySQLComponent.ListFieldsInTStrings (var Items : TStrings;Table : string);
var
   Res: PMYSQL_RES;
begin
     if Selected = true then
     begin
          Res := query('SHOW COLUMNS FROM '+table+' LIKE '''+Table+''' ;');
          if Res <> nil
          then ListInTStrings(Items,Res)
          else items.Clear;
    end;
end;

function TMySQLComponent.LoadSqlFromFile(Filename: string): boolean;
var
   Querys : string;
   Fichier: TextFile;
begin
    Assignfile(Fichier,Filename);
    try
       Reset (Fichier);
       while (System.Eof(Fichier) <> true) do
       begin
            Readln(Fichier,Querys);
            Query(Querys);
       end;
    except
          LoadSqlFromFile := False;
          exit;
    end;
    LoadSqlFromFile := true;
end;

procedure TMySQLComponent.ListInTStrings (var Items : TStrings;Res: PMYSQL_RES);
var
   Row: PMYSQL_ROW;
begin
     if Res <> nil then
     begin
     Items.Clear;
     if Res <> nil then
     try
       Row := mysql_fetch_row(Res);
       while Row <> nil do
       begin
           Items.Add(Row[0]);
           Row := mysql_fetch_row(Res);
       end;
     finally
          mysql_free_result(Res);
     end;
    end;
end;

function TMySQLComponent.QueryIntoTListBox (Querys : string;ListBox : TListBox) : boolean;
var
   Res   : PMYSQL_RES;
   Row   : PMYSQL_ROW;
   i,j   : integer;
   s     : string;
begin
     if Selected = true then
     begin
          Res := Query (Querys);
          if Res = nil then
          begin
               QueryIntoTListbox := false;
               exit;
          end
          else
          try
             ListBox.Items.Clear;
             i := mysql_num_fields (Res);
             if (i > 1) then
             begin
                  Row := mysql_fetch_row(Res);
                  i := i - 2;
                  while Row <> nil do
                  begin
                       s := Row[0] + ' (';
                       for j := 1 to i do
                          s := s + Row[j]+ ',';
                       s := s + Row[i+1] + ')';
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
          end;
          QueryIntoTListBox := true;
          exit;
    end;
    QueryIntoTListBox := false;
end;


function TMySQLComponent.QueryIntoTStrings (Querys : string;var Items : TStrings) : boolean;
var
   Res   : PMYSQL_RES;
   Row   : PMYSQL_ROW;
   i,j   : integer;
   s     : string;
begin
     if Selected = true then
     begin
          Res := Query (Querys);
          if Res = nil then
          begin
               QueryIntoTStrings := false;
               exit;
          end
          else
          try
             Items.Clear;
             i := mysql_num_fields (Res);
             if (i > 1) then
             begin
                  Row := mysql_fetch_row(Res);
                  i := i - 2;
                  while Row <> nil do
                  begin
                       s := Row[0] + ' (';
                       for j := 1 to i do
                          s := s + Row[j]+ ',';
                       s := s + Row[i+1] + ')';
                       Items.Add(s);
                       Row := mysql_fetch_row(Res);
                  end;
             end
             else
             begin
                  Row := mysql_fetch_row(Res);
                  while Row <> nil do
                  begin
                       Items.Add(Row[0]);
                       Row := mysql_fetch_row(Res);
                  end;
             end;
          finally
               mysql_free_result(Res);
          end;
          QueryIntoTStrings := true;
          exit;
    end;
    QueryIntoTStrings := false;
end;

function TMySQLComponent.QueryIntoTStringList (Querys : string;var Items : TStringList) : boolean;
var
   Res   : PMYSQL_RES;
   Row   : PMYSQL_ROW;
   i,j   : integer;
   s     : string;
begin
     if Selected = true then
     begin
          Res := Query (Querys);
          if Res = nil then
          begin
               QueryIntoTStringList := false;
               exit;
          end
          else
          try
             Items.Clear;
             i := mysql_num_fields (Res);
             if (i > 1) then
             begin
                  Row := mysql_fetch_row(Res);
                  i := i - 2;
                  while Row <> nil do
                  begin
                       s := Row[0] + ' (';
                       for j := 1 to i do
                          s := s + Row[j]+ ',';
                       s := s + Row[i+1] + ')';
                       Items.Add(s);
                       Row := mysql_fetch_row(Res);
                  end;
             end
             else
             begin
                  Row := mysql_fetch_row(Res);
                  while Row <> nil do
                  begin
                       Items.Add(Row[0]);
                       Row := mysql_fetch_row(Res);
                  end;
             end;
          finally
               mysql_free_result(Res);
          end;
          QueryIntoTStringList := true;
          exit;
    end;
    QueryIntoTStringList := false;
end;


function TMySQLComponent.QueryFirstResult (Querys : string;var FirstRowZero : string) : boolean;
var
   Res   : PMYSQL_RES;
   Row   : PMYSQL_ROW;
begin
    Res := Query (Querys);
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

function  TMySQLComponent.fields_type (Table : string;var Fields_names : TDynamicStringArray;var Fields_types : TDynamicIntegerArray) : integer;
var
   Res  : PMYSQL_RES;
   Field  : PMYSQL_FIELD;
   Num,i  : Integer;
   Fields_name_result : TDynamicStringArray;
   Fields_type_result : TDynamicIntegerArray;
begin
    if Selected = true then
    begin
         Num := -1;
         Res := Query ('SELECT * FROM '+Table+' LIMIT 0,1;');
         if Res = nil then fields_type := -1
        else
         try
            Num := mysql_num_fields (Res);
            SetLength (Fields_name_result,Num);
            SetLength (Fields_type_result,Num);
            for i := 0 to (Num-1) do
            begin
                 Field := mysql_fetch_field_direct(Res,i);
                 Fields_name_result[i] := Field.name;
                 Fields_type_result[i] := Field._type;
            end;
         finally
            mysql_free_result(Res);
            fields_type := Num;
            Fields_names := Fields_name_result;
            Fields_types := Fields_type_result;
         end;
         exit;
    end;
    fields_type := -1 ;
end;

function TMySQLComponent.field_ConversionType_Nomtype (no : integer) : string;
var
   s : string;
begin
     s := '';
     case no of
         FIELD_TYPE_DECIMAL: s := STRING_FIELD_TYPE_DECIMAL;
         FIELD_TYPE_TINY: s    := STRING_FIELD_TYPE_TINY;
         FIELD_TYPE_SHORT: s   := STRING_FIELD_TYPE_SHORT;
         FIELD_TYPE_FLOAT: s   := STRING_FIELD_TYPE_FLOAT;
         FIELD_TYPE_DOUBLE: s  := STRING_FIELD_TYPE_DOUBLE;
         FIELD_TYPE_NULL: s    := STRING_FIELD_TYPE_NULL;
         FIELD_TYPE_TIMESTAMP: s := STRING_FIELD_TYPE_TIMESTAMP;
         FIELD_TYPE_LONGLONG: s  := STRING_FIELD_TYPE_LONGLONG;
         FIELD_TYPE_INT24: s   := STRING_FIELD_TYPE_INT24;
         FIELD_TYPE_DATE: s    := STRING_FIELD_TYPE_DATE;
         FIELD_TYPE_TIME: s    := STRING_FIELD_TYPE_TIME;
         FIELD_TYPE_DATETIME: s := STRING_FIELD_TYPE_DATETIME;
         FIELD_TYPE_YEAR: s     := STRING_FIELD_TYPE_YEAR;
         FIELD_TYPE_NEWDATE: s  := STRING_FIELD_TYPE_NEWDATE;
         FIELD_TYPE_ENUM: s     := STRING_FIELD_TYPE_ENUM;
         FIELD_TYPE_SET: s      := STRING_FIELD_TYPE_SET;
         FIELD_TYPE_TINY_BLOB: s := STRING_FIELD_TYPE_TINY_BLOB;
         FIELD_TYPE_MEDIUM_BLOB: s    := STRING_FIELD_TYPE_MEDIUM_BLOB;
         FIELD_TYPE_LONG_BLOB: s      := STRING_FIELD_TYPE_LONG_BLOB;
         FIELD_TYPE_BLOB: s     := STRING_FIELD_TYPE_BLOB;
         FIELD_TYPE_VAR_STRING: s := STRING_FIELD_TYPE_VAR_STRING;
         FIELD_TYPE_STRING: s := STRING_FIELD_TYPE_STRING;
     end;
     field_ConversionType_NomType := s;
end;

function TMySQLComponent.field_ConversionNomtype_Type (nom : string) : integer;
var
   s : integer;
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

function TMySQLComponent.table_change_name (hold_name, new_name : string) : boolean;
var
   Row : string;
begin
     if QueryFirstResult('SHOW tables LIKE '''+new_name+''';',Row) = false then
     begin
          Query('ALTER TABLE `'+hold_name+'` RENAME `'+new_name +'`;');
          table_change_name := true;
     end
     else table_change_name := false;
end;

function TMySQLComponent.create_table (name,query_table : string) : boolean;
var
   Row : string;
begin
     if QueryFirstResult('SHOW tables LIKE '''+name+''';',Row) = false then
     begin
          Row := '';
          Query('CREATE TABLE `'+name+'` ('+query_table+');');
          create_table := true;
     end
     else create_table := false;
end;

function TMySQLComponent.delete_table (name : string) : boolean;
var
   Row : string;
begin
     Query('DROP TABLE `'+name+'`;');
     if QueryFirstResult('SHOW tables LIKE '''+name+''';',Row) = false then
          delete_table := true
     else delete_table := false;
end;

function TMySQLComponent.QueryIntoTStringsUnique (Querys : string;var Strings : TStrings) : boolean;
var
   Res   : PMYSQL_RES;
   Row   : PMYSQL_ROW;
begin
     if Selected = true then
     begin
          Res := Query (Querys);
          if Res = nil then
          begin
               QueryIntoTStringsUnique := false;
               exit;
          end
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
          end;
          QueryIntoTStringsUnique := true;
          exit;
    end;
    QueryIntoTStringsUnique := false;
end;

function  TMySQLComponent.field_count(): longword;
begin
      field_count := mysql_field_count(Linkp);
end;

procedure TMySQLComponent.ListInListBox (ListBox : TListBox;Res: PMYSQL_RES);
var
   Row: PMYSQL_ROW;
begin
     if Res <> nil then
     begin
     ListBox.Clear;
     if Res <> nil then
     try
       Row := mysql_fetch_row(Res);
       while Row <> nil do
       begin
           ListBox.Items.Add(Row[0]);
           Row := mysql_fetch_row(Res);
       end;
     finally
          mysql_free_result(Res);
     end;
    end;
end;

procedure TMySQLComponent.ListFieldsInListBox (ListBox : TListBox;Table : string);
var
   Res: PMYSQL_RES;
begin
     if Selected = true then
     begin
          Res := list_fields(Table,'');
          if Res <> nil then
              ListinListBox(ListBox,Res);
    end;
end;

function TMySQLComponent.list_fields (table, wild: string): PMYSQL_RES;
begin
     if (wild <> '') then
             list_fields := query('SHOW COLUMNS FROM '+table+' LIKE '''+wild+''' ;')
     else
             list_fields := query('SHOW COLUMNS FROM '+table+' ;');
end;

procedure TMySQLComponent.ListTablesInListBox (ListBox : TListBox;Database : string);
var
   Res: PMYSQL_RES;
begin
     if Selected = true then
     begin
          if (Database<>'') and (Database<>Databasep) then
          begin
               Close;
               Databasep := Database;
               Connect;
          end;
          Res := list_tables('');
          if Res <> nil then
              ListinListBox(ListBox,Res);
    end;
end;



end.
