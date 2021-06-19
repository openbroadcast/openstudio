

# MySQL installation

Install MySQL 5.5 (mysql-installer-community-5.5.60.1.msi) download from https://downloads.mysql.com/archives/get/p/25/file/mysql-installer-community-5.5.60.1.msi

Enable 'old passwords' with the command: 

```
SET PASSWORD FOR 'root'@'localhost' = OLD_PASSWORD('YOUR PASSWORD');
```

Install HeidiSQL https://www.heidisql.com/download.php

Open HeidiSQL, connect to you DB, and import the MySQL schema: https://raw.githubusercontent.com/openbroadcast/openstudio-db-schema/main/struct55.sql

Copy config.ini.default to config.ini and set your MySQL password



#  Compilation (Delphi 7, x32)

Please add this components to your IDE:

JCL + JVCL (unzip JVCL320CompleteJCL197-Build2172.zip from https://sourceforge.net/projects/jvcl/files/OldFiles/JVCL320CompleteJCL197-Build2172.zip/download into Borland/Delphi/Source and install JCL before JVCL)

TServerSocket -> Component -> Install package -> Add " (C:/.../Borland/Delphi7/) bin/dclsockets70.bpl"

RLed

Mysql Component

CoolTrayIcon (https://github.com/coolshou/CoolTrayIcon)

InfoMP3 (http://www.phidels.com/php/toutpourmoteur.htm)

VaComm (optional)
