object ServerPage: TServerPage
  Left = 338
  Top = 204
  AlphaBlendValue = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'miniserv 1.0'
  ClientHeight = 373
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MemoHistory: TMemo
    Left = 0
    Top = 0
    Width = 392
    Height = 373
    Align = alClient
    BevelInner = bvNone
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    WantTabs = True
  end
  object ServerWeb: TServerSocket
    Active = False
    Port = 8585
    ServerType = stNonBlocking
    OnClientRead = ServerWebClientRead
    Left = 360
    Top = 8
  end
end
