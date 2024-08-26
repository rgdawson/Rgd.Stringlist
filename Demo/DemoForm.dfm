object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 551
  ClientWidth = 886
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    886
    551)
  TextHeight = 15
  object btnTest1: TButton
    Left = 8
    Top = 8
    Width = 193
    Height = 25
    Caption = 'Stringlist class operators'
    TabOrder = 0
    OnClick = btnTest1Click
  end
  object Memo1: TMemo
    Left = 216
    Top = 8
    Width = 581
    Height = 529
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object btnAlign: TButton
    Left = 8
    Top = 39
    Width = 193
    Height = 25
    Caption = 'Delimiter Align'
    TabOrder = 2
    OnClick = btnAlignClick
  end
  object Button9: TButton
    Left = 8
    Top = 70
    Width = 193
    Height = 25
    Caption = 'Set Intersection'
    TabOrder = 3
    OnClick = Button9Click
  end
  object btnClear: TButton
    Left = 803
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Clear'
    TabOrder = 4
    OnClick = btnClearClick
  end
  object btnClose: TButton
    Left = 802
    Top = 39
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Close'
    TabOrder = 5
    OnClick = btnCloseClick
  end
  object btnFunctionResult: TButton
    Left = 8
    Top = 101
    Width = 193
    Height = 25
    Caption = 'Function Result'
    TabOrder = 6
    OnClick = btnFunctionResultClick
  end
end
