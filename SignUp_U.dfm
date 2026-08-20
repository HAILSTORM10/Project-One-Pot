object frmSignUp: TfrmSignUp
  Left = 0
  Top = 0
  Caption = 'frmSignUp'
  ClientHeight = 412
  ClientWidth = 765
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edtName: TEdit
    Left = 296
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'edtName'
  end
  object edtSurname: TEdit
    Left = 296
    Top = 168
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'edtSurname'
  end
  object edtPass: TEdit
    Left = 296
    Top = 208
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'edtPass'
  end
  object Button1: TButton
    Left = 312
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
    OnClick = Button1Click
  end
end
