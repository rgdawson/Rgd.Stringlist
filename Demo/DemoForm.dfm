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
  object btnOperators: TButton
    Left = 8
    Top = 70
    Width = 193
    Height = 25
    Caption = 'Value/Const Parameters'
    TabOrder = 2
    OnClick = btnOperatorsClick
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
    TabOrder = 6
    WordWrap = False
  end
  object btnAlign: TButton
    Left = 8
    Top = 101
    Width = 193
    Height = 25
    Caption = 'Delimiter Align'
    TabOrder = 3
    OnClick = btnAlignClick
  end
  object btnSets: TButton
    Left = 8
    Top = 132
    Width = 193
    Height = 25
    Caption = 'Set Intersection'
    TabOrder = 4
    OnClick = btnSetsClick
  end
  object btnClear: TButton
    Left = 803
    Top = 39
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Clear'
    TabOrder = 8
    OnClick = btnClearClick
  end
  object btnClose: TButton
    Left = 803
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Close'
    TabOrder = 7
    OnClick = btnCloseClick
  end
  object btnFunctionResult: TButton
    Left = 8
    Top = 163
    Width = 193
    Height = 25
    Caption = 'Function Result'
    TabOrder = 5
    OnClick = btnFunctionResultClick
  end
  object btnBasic: TButton
    Left = 8
    Top = 8
    Width = 193
    Height = 25
    Caption = 'Assignment'
    TabOrder = 0
    OnClick = btnBasicClick
  end
  object btnConstructors: TButton
    Left = 8
    Top = 39
    Width = 193
    Height = 25
    Caption = 'Stringlist.Default() "Constructors"'
    TabOrder = 1
    OnClick = btnConstructorsClick
  end
end
