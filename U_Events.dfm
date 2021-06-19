object Events: TEvents
  Left = 821
  Top = 438
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Timer'
  ClientHeight = 250
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 151
    Top = 8
    Width = 42
    Height = 13
    Caption = 'Total : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 152
    Top = 21
    Width = 37
    Height = 13
    Caption = 'Fin '#224' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object total: TLabel
    Left = 190
    Top = 8
    Width = 99
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object fin: TLabel
    Left = 190
    Top = 21
    Width = 99
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object diffuser: TBitBtn
    Left = 7
    Top = 8
    Width = 137
    Height = 25
    Caption = 'Diffusion imm'#233'diate'
    TabOrder = 0
    OnClick = diffuserClick
  end
  object StringGrid1: TStringGrid
    Left = 2
    Top = 38
    Width = 425
    Height = 209
    ColCount = 1
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Options = [goFixedVertLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 311
    Top = 8
    Width = 113
    Height = 25
    Caption = 'Supprimer tout'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object pageclignote: TTimer
    Enabled = False
    OnTimer = pageclignoteTimer
    Left = 168
    Top = 40
  end
  object findevents: TTimer
    Interval = 900
    OnTimer = findeventsTimer
    Left = 40
    Top = 40
  end
  object compteur: TTimer
    Enabled = False
    OnTimer = compteurTimer
    Left = 136
    Top = 40
  end
  object decompte: TTimer
    OnTimer = decompteTimer
    Left = 72
    Top = 40
  end
  object findnextevents: TTimer
    Interval = 10000
    OnTimer = findnexteventsTimer
    Left = 8
    Top = 40
  end
end
