

# MySQL installation

Install MySQL 5.5 (mysql-installer-community-5.5.60.1.msi) download from https://downloads.mysql.com/archives/get/p/25/file/mysql-installer-community-5.5.60.1.msi

Enable 'old passwords' with the command: SET PASSWORD FOR 'root'@'localhost' = OLD_PASSWORD('YOUR PASSWORD');

Install HeidiSQL https://www.heidisql.com/download.php

Open HeidiSQL, connect to you DB, and import the MySQL schema: https://raw.githubusercontent.com/openbroadcast/openstudio-db-schema/main/struct55.sql

Copy config.ini.default to config.ini and set your MySQL password



#  Compilation (Delphi 7, x32)

Please add this components to your IDE:

JCL + JVCL (unzip JVCL320CompleteJCL197-Build2172.zip into Borland/Delphi/Source and install JCL before JVCL)

RLed

Mysql Component

TServerSocket -> Composant -> Installer des paquets -> Ajouter "/bin/dclsockets70.bpl"

CoolTrayIcon

InfoMP3

VaComm (optional)
