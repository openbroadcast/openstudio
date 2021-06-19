object Config: TConfig
  Left = 221
  Top = 196
  Width = 679
  Height = 421
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSizeToolWin
  Caption = 'Configuration'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PgConfig: TPageControl
    Left = 8
    Top = 8
    Width = 633
    Height = 313
    ActivePage = TabSheet3
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object onglet_soundcard: TTabSheet
      Caption = 'Cartes son Musique/ Jingle'
      object GroupBox1: TGroupBox
        Left = 8
        Top = 16
        Width = 273
        Height = 121
        Caption = 'Player 1'
        TabOrder = 0
        object ComboBox1: TComboBox
          Left = 8
          Top = 18
          Width = 257
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
        object RadioGroup1: TRadioGroup
          Left = 8
          Top = 48
          Width = 257
          Height = 65
          Caption = 'Channel'
          TabOrder = 1
        end
        object dsc1front: TRadioButton
          Left = 24
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Front'
          Checked = True
          TabOrder = 2
          TabStop = True
        end
        object dsc1rear: TRadioButton
          Left = 144
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Rear'
          TabOrder = 3
        end
        object dsc1center: TRadioButton
          Left = 24
          Top = 88
          Width = 113
          Height = 17
          Caption = 'Center'
          TabOrder = 4
        end
        object dsc1rear2: TRadioButton
          Left = 144
          Top = 89
          Width = 113
          Height = 17
          Caption = 'Rear2'
          TabOrder = 5
        end
      end
      object GroupBox2: TGroupBox
        Left = 296
        Top = 16
        Width = 273
        Height = 121
        Caption = 'Player 2'
        TabOrder = 1
        object ComboBox2: TComboBox
          Left = 8
          Top = 18
          Width = 257
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
        object RadioGroup2: TRadioGroup
          Left = 8
          Top = 48
          Width = 257
          Height = 65
          Caption = 'Channel'
          TabOrder = 1
        end
        object dsc2front: TRadioButton
          Left = 24
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Front'
          Checked = True
          TabOrder = 2
          TabStop = True
        end
        object dsc2rear: TRadioButton
          Left = 144
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Rear'
          TabOrder = 3
        end
        object dsc2center: TRadioButton
          Left = 24
          Top = 88
          Width = 113
          Height = 17
          Caption = 'Center'
          TabOrder = 4
        end
        object dsc2rear2: TRadioButton
          Left = 144
          Top = 89
          Width = 113
          Height = 17
          Caption = 'Rear2'
          TabOrder = 5
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 152
        Width = 273
        Height = 121
        Caption = 'Jingle 1 (gauche)'
        TabOrder = 2
        object ComboBox3: TComboBox
          Left = 8
          Top = 18
          Width = 257
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
        object RadioGroup3: TRadioGroup
          Left = 8
          Top = 48
          Width = 257
          Height = 65
          Caption = 'Channel'
          TabOrder = 1
        end
        object jingle1front: TRadioButton
          Left = 24
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Front'
          Checked = True
          TabOrder = 2
          TabStop = True
        end
        object jingle1rear: TRadioButton
          Left = 144
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Rear'
          TabOrder = 3
        end
        object jingle1center: TRadioButton
          Left = 24
          Top = 88
          Width = 113
          Height = 17
          Caption = 'Center'
          TabOrder = 4
        end
        object jingle1rear2: TRadioButton
          Left = 144
          Top = 89
          Width = 113
          Height = 17
          Caption = 'Rear2'
          TabOrder = 5
        end
      end
      object GroupBox4: TGroupBox
        Left = 304
        Top = 152
        Width = 273
        Height = 121
        Caption = 'Jingle 2 (droite)'
        TabOrder = 3
        object ComboBox4: TComboBox
          Left = 8
          Top = 18
          Width = 257
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
        object RadioGroup4: TRadioGroup
          Left = 8
          Top = 48
          Width = 257
          Height = 65
          Caption = 'Channel'
          TabOrder = 1
        end
        object jingle2front: TRadioButton
          Left = 24
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Front'
          Checked = True
          TabOrder = 2
          TabStop = True
        end
        object jingle2rear: TRadioButton
          Left = 144
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Rear'
          TabOrder = 3
        end
        object jingle2center: TRadioButton
          Left = 24
          Top = 88
          Width = 113
          Height = 17
          Caption = 'Center'
          TabOrder = 4
        end
        object jingle2rear2: TRadioButton
          Left = 144
          Top = 89
          Width = 113
          Height = 17
          Caption = 'Rear2'
          TabOrder = 5
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Carte son Pub/Pad/Record'
      ImageIndex = 1
      object GroupBox5: TGroupBox
        Left = 11
        Top = 152
        Width = 273
        Height = 121
        Caption = 'Pr'#233#233'coute'
        TabOrder = 0
        object ComboBox5: TComboBox
          Left = 8
          Top = 18
          Width = 257
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
        object RadioGroup5: TRadioGroup
          Left = 8
          Top = 48
          Width = 257
          Height = 65
          Caption = 'Channel'
          TabOrder = 1
        end
        object cue1front: TRadioButton
          Left = 24
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Front'
          Checked = True
          TabOrder = 2
          TabStop = True
        end
        object cue1rear: TRadioButton
          Left = 144
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Rear'
          TabOrder = 3
        end
        object cue1center: TRadioButton
          Left = 24
          Top = 88
          Width = 113
          Height = 17
          Caption = 'Center'
          TabOrder = 4
        end
        object cue1rear2: TRadioButton
          Left = 144
          Top = 89
          Width = 113
          Height = 17
          Caption = 'Rear2'
          TabOrder = 5
        end
      end
      object GroupBox12: TGroupBox
        Left = 296
        Top = 16
        Width = 273
        Height = 121
        Caption = 'Pub'
        TabOrder = 1
        object ComboBox7: TComboBox
          Left = 8
          Top = 18
          Width = 257
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
        object RadioGroup8: TRadioGroup
          Left = 8
          Top = 48
          Width = 257
          Height = 65
          Caption = 'Channel'
          TabOrder = 1
        end
        object pubfront: TRadioButton
          Left = 24
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Front'
          Checked = True
          TabOrder = 2
          TabStop = True
        end
        object pubrear: TRadioButton
          Left = 144
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Rear'
          TabOrder = 3
        end
        object pubcenter: TRadioButton
          Left = 24
          Top = 88
          Width = 113
          Height = 17
          Caption = 'Center'
          TabOrder = 4
        end
        object pubrear2: TRadioButton
          Left = 144
          Top = 89
          Width = 113
          Height = 17
          Caption = 'Rear2'
          TabOrder = 5
        end
      end
      object GroupBox14: TGroupBox
        Left = 11
        Top = 16
        Width = 273
        Height = 121
        Caption = 'Pad'
        TabOrder = 2
        object ComboBox8: TComboBox
          Left = 8
          Top = 18
          Width = 257
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
        object RadioGroup7: TRadioGroup
          Left = 8
          Top = 48
          Width = 257
          Height = 65
          Caption = 'Channel'
          TabOrder = 1
        end
        object padfront: TRadioButton
          Left = 24
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Front'
          Checked = True
          TabOrder = 2
          TabStop = True
        end
        object padrear: TRadioButton
          Left = 144
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Rear'
          TabOrder = 3
        end
        object padcenter: TRadioButton
          Left = 24
          Top = 88
          Width = 113
          Height = 17
          Caption = 'Center'
          TabOrder = 4
        end
        object padrear2: TRadioButton
          Left = 144
          Top = 89
          Width = 113
          Height = 17
          Caption = 'Rear2'
          TabOrder = 5
        end
      end
      object GroupBox11: TGroupBox
        Left = 297
        Top = 152
        Width = 273
        Height = 121
        Caption = 'Record'
        TabOrder = 3
        object ComboBox6: TComboBox
          Left = 8
          Top = 18
          Width = 257
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
        object RadioGroup9: TRadioGroup
          Left = 8
          Top = 48
          Width = 257
          Height = 65
          Caption = 'Channel'
          TabOrder = 1
        end
        object recordfront: TRadioButton
          Left = 24
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Front'
          Checked = True
          TabOrder = 2
          TabStop = True
        end
        object recordrear: TRadioButton
          Left = 144
          Top = 66
          Width = 113
          Height = 17
          Caption = 'Rear'
          TabOrder = 3
        end
        object recordcenter: TRadioButton
          Left = 24
          Top = 88
          Width = 113
          Height = 17
          Caption = 'Center'
          TabOrder = 4
        end
        object recordrear2: TRadioButton
          Left = 144
          Top = 89
          Width = 113
          Height = 17
          Caption = 'Rear2'
          TabOrder = 5
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Base de donn'#233'es'
      ImageIndex = 2
      object Label3: TLabel
        Left = 12
        Top = 5
        Width = 242
        Height = 13
        Caption = 'Les '#233'tapes indispensables sont surlign'#233'es en gras.'
      end
      object GroupBox7: TGroupBox
        Left = 8
        Top = 24
        Width = 313
        Height = 121
        Caption = 'MySQL'
        TabOrder = 0
        object Label4: TLabel
          Left = 16
          Top = 20
          Width = 23
          Height = 13
          Caption = 'H'#244'te'
        end
        object Label5: TLabel
          Left = 168
          Top = 20
          Width = 25
          Height = 13
          Caption = 'Login'
        end
        object Label6: TLabel
          Left = 168
          Top = 60
          Width = 46
          Height = 13
          Caption = 'Password'
        end
        object Label7: TLabel
          Left = 16
          Top = 60
          Width = 23
          Height = 13
          Caption = 'Base'
        end
        object host: TEdit
          Left = 16
          Top = 36
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'localhost'
        end
        object login: TEdit
          Left = 168
          Top = 36
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'root'
        end
        object password: TMaskEdit
          Left = 168
          Top = 76
          Width = 121
          Height = 21
          PasswordChar = '*'
          TabOrder = 3
        end
        object database: TEdit
          Left = 16
          Top = 76
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'openstudio'
        end
      end
      object TestConnect: TButton
        Left = 14
        Top = 156
        Width = 297
        Height = 25
        Caption = 'Test de connexion MySQL'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = TestConnectClick
      end
      object CreateDb: TButton
        Left = 14
        Top = 187
        Width = 297
        Height = 25
        Caption = 'Cr'#233'er la Database'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = CreateDbClick
      end
      object CreateTablesEssentials: TButton
        Left = 14
        Top = 220
        Width = 299
        Height = 25
        Caption = 'Charger les tables syst'#232'me'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = CreateTablesEssentialsClick
      end
      object CreateTablesDemo: TButton
        Left = 14
        Top = 252
        Width = 299
        Height = 25
        Hint = 
          'Inclus des cat'#233'gories, un canvas de programmation, une grille de' +
          ' timer'
        Caption = 'Charger les donn'#233'es d'#233'mo'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = CreateTablesDemoClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Divers'
      ImageIndex = 3
      object GroupBox6: TGroupBox
        Left = 8
        Top = 140
        Width = 281
        Height = 137
        Caption = 'Automation'
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 18
          Width = 241
          Height = 32
          AutoSize = False
          Caption = 
            'Si les fin de disques ne sont pas marqu'#233's, le logiciel peut util' +
            'iser une fonction int'#233'lligente.'
          WordWrap = True
        end
        object Label2: TLabel
          Left = 80
          Top = 104
          Width = 90
          Height = 13
          Caption = 'ms, alors fader en '
        end
        object Label10: TLabel
          Left = 16
          Top = 57
          Width = 7
          Height = 13
          Caption = 'A'
        end
        object Label11: TLabel
          Left = 90
          Top = 57
          Width = 148
          Height = 13
          Caption = 'secondes de la fin, si le volume'
        end
        object Label12: TLabel
          Left = 16
          Top = 80
          Width = 116
          Height = 13
          Caption = 'passe sous la barre des '
        end
        object Label13: TLabel
          Left = 196
          Top = 80
          Width = 34
          Height = 13
          Caption = 'plus de'
        end
        object Label14: TLabel
          Left = 232
          Top = 104
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object AUTOSILENCE: TSpinEdit
          Left = 134
          Top = 76
          Width = 59
          Height = 22
          MaxLength = 1
          MaxValue = 65000
          MinValue = 1
          TabOrder = 0
          Value = 8000
        end
        object AUTOOUT: TSpinEdit
          Left = 30
          Top = 54
          Width = 57
          Height = 22
          MaxLength = 1
          MaxValue = 300
          MinValue = 1
          TabOrder = 1
          Value = 10
        end
        object AUTOFENETRE: TSpinEdit
          Left = 20
          Top = 101
          Width = 57
          Height = 22
          MaxLength = 1
          MaxValue = 10000
          MinValue = 1
          TabOrder = 2
          Value = 800
        end
        object AUTOFADEOUT: TSpinEdit
          Left = 172
          Top = 101
          Width = 57
          Height = 22
          MaxLength = 1
          MaxValue = 10000
          MinValue = 1
          TabOrder = 3
          Value = 1200
        end
      end
      object GroupBox9: TGroupBox
        Left = 8
        Top = 16
        Width = 281
        Height = 121
        Caption = 'D'#233'marrage'
        TabOrder = 1
        object startauto: TCheckBox
          Left = 16
          Top = 24
          Width = 185
          Height = 17
          Caption = 'D'#233'marrage en mode automatique'
          TabOrder = 0
        end
        object startlocked: TCheckBox
          Left = 16
          Top = 48
          Width = 177
          Height = 17
          Caption = 'D'#233'marrer verrouill'#233
          TabOrder = 1
        end
      end
      object GroupBox10: TGroupBox
        Left = 300
        Top = 16
        Width = 305
        Height = 121
        Caption = 'Communication'
        TabOrder = 2
        object Label8: TLabel
          Left = 16
          Top = 24
          Width = 44
          Height = 13
          Caption = 'Port DRC'
        end
        object Label9: TLabel
          Left = 16
          Top = 80
          Width = 133
          Height = 13
          Caption = 'D'#233'crocher '#224' partir du seuil :'
        end
        object Label15: TLabel
          Left = 16
          Top = 51
          Width = 174
          Height = 13
          Caption = 'D'#233'tection de tone sur la fr'#233'quence :'
        end
        object Label16: TLabel
          Left = 248
          Top = 52
          Width = 11
          Height = 13
          Caption = 'hz'
        end
        object portdrc: TSpinEdit
          Left = 72
          Top = 20
          Width = 57
          Height = 22
          MaxLength = 1
          MaxValue = 4
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object TONEDETECTFREQ: TSpinEdit
          Left = 190
          Top = 47
          Width = 57
          Height = 22
          MaxLength = 1
          MaxValue = 46000
          MinValue = 0
          TabOrder = 1
          Value = 20
        end
        object TONEDETECTNIVEAU: TSpinEdit
          Left = 152
          Top = 76
          Width = 57
          Height = 22
          MaxLength = 1
          MaxValue = 10000
          MinValue = 0
          TabOrder = 2
          Value = 150
        end
      end
    end
  end
  object Fermer: TBitBtn
    Left = 304
    Top = 334
    Width = 161
    Height = 25
    Caption = 'Fermer sans modifier'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = FermerClick
  end
  object enregistrer: TBitBtn
    Left = 480
    Top = 334
    Width = 161
    Height = 25
    Caption = 'Enregistrer les modifications'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = enregistrerClick
  end
  object sql: TMysqlComponent
    Host = 'localhost'
    Login = 'root'
    Database = 'test'
    INIFileName = 'MySqlComponent.ini'
    Left = 300
    Top = 56
  end
end
