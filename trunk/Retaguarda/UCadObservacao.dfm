object CadObservacaoForm: TCadObservacaoForm
  Left = 0
  Top = 0
  Caption = 'Observa'#231#245'es'
  ClientHeight = 275
  ClientWidth = 464
  Color = 8673536
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 242
    Width = 464
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    Color = clGradientInactiveCaption
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = -140
    ExplicitTop = 190
    ExplicitWidth = 566
    object BTCancelar: THTMLButton
      Left = 241
      Top = 4
      Width = 108
      Height = 25
      Cancel = True
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      Alignment = haCenter
      Background = stNormal
      BorderColor = clGray
      Color = 11179887
      DownColor = 8673536
      Flat = True
      VAlignment = vaCenter
      Version = '1.4.5.1'
    end
    object BitBtn1: THTMLButton
      Left = 352
      Top = 4
      Width = 108
      Height = 25
      Caption = 'Ok'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      Alignment = haCenter
      Background = stNormal
      BorderColor = clGray
      Color = 11179887
      DownColor = 8673536
      Flat = True
      VAlignment = vaCenter
      Version = '1.4.5.1'
    end
  end
  object MObservacao: TMemo
    Left = 0
    Top = 0
    Width = 464
    Height = 242
    Align = alClient
    Lines.Strings = (
      '')
    TabOrder = 1
    ExplicitLeft = 144
    ExplicitTop = 40
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
end
