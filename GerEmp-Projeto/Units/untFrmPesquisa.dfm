object FrmPesquisa: TFrmPesquisa
  Left = 0
  Top = 0
  Caption = 'Pesquisar'
  ClientHeight = 413
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCampos: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 978
    Height = 67
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object lblCampo: TLabel
      Left = 25
      Top = 13
      Width = 40
      Height = 16
      Caption = 'Campo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 279
      Top = 13
      Width = 52
      Height = 16
      Caption = 'Condi'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblPesquisa: TLabel
      Left = 491
      Top = 13
      Width = 55
      Height = 16
      Caption = 'Pesquisar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object cbbCampo: TComboBox
      Left = 25
      Top = 30
      Width = 227
      Height = 22
      BevelInner = bvNone
      BevelOuter = bvRaised
      Style = csOwnerDrawFixed
      DragCursor = crDefault
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arii'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = cbbCampoChange
    end
    object cbbCondicao: TComboBox
      Left = 279
      Top = 30
      Width = 179
      Height = 22
      BevelInner = bvNone
      BevelOuter = bvRaised
      Style = csOwnerDrawFixed
      DragCursor = crDefault
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arii'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = cbbCondicaoChange
    end
    object edtPesquisa: TMaskEdit
      Left = 491
      Top = 30
      Width = 326
      Height = 23
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
      TextHint = 'Digite sua pesquisa...'
      OnKeyDown = edtPesquisaKeyDown
    end
    object btnPesquisa: TBitBtn
      Tag = 20
      AlignWithMargins = True
      Left = 834
      Top = 30
      Width = 37
      Height = 24
      Cursor = crHandPoint
      ParentCustomHint = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      Font.Quality = fqClearType
      Glyph.Data = {
        36090000424D3609000000000000360000002800000018000000180000000100
        2000000000000009000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000010101
        0003010100040201000502010005010100050101000500000005000000050000
        0004000000030000000200000001000000000000000000000000000000000000
        00000000000000000000000000000000000000000003010100080A0702283C2D
        0A7F84651CBEBC9332DDC69B36E291701FC749370D8F0A08023C0000001D0000
        001D00000019000000120000000B000000060000000200000000000000000000
        0000000000000000000000000001010100070201001C503D0F95DFB85DF7F5E4
        BBFFFCF8EFFEFFFFFFFFFDFDFDFEFCF8F0FEF4E3B9FEE0B654F954400FA20201
        00420000003A00000032000000290000001C0000000E00000004000000000000
        000000000000000000000101000304030125997624CEF3E0B3FEFDFDFCFEFFFF
        FFFFFDFCF9FEF5E3B9FFFDFDFDFEFDFDFDFEFDFDFDFEFEFDFBFFEFD391FE7D5F
        17C50201004D00000048000000440000003A000000250000000D000000000000
        000000000000000000000504010D967423C9F8EDD1FFFFFFFFFFFFFFFFFFFEFC
        F9FFEBC66EFFE7BB53FFF4DFAFFFFAF1DCFFFEFEFEFFFFFFFFFFFFFFFFFFEFD1
        8AFF614912B40000004D0000004C000000470000003300000014000000000000
        000000000000000000006B541C85F3DFAFFEFFFFFFFFFDFDFDFEFDFBF7FEEAC4
        69FFE0A928FEE2AB29FFE0A928FEE1AA2AFEEAC671FEFDFBF5FFFDFDFDFEFDFB
        F7FEE4B444FE3E2F0B9700000048000000400000002C00000010000000000000
        00000000000015110718DEB658F4FDFDFCFEFFFFFFFFF6E8C6FEFBF8EFFEEECE
        84FFE1AA29FEE7BA50FFEED08BFEE3B13CFEE0A928FEEBC771FFFDFDFDFEFDFD
        FDFEF1D698FFDBA628FA18120463000000270000001500000006000000000000
        000000000000644E1D6FF5E2B5FFFFFFFFFFFCF6E9FFE3AF34FFECC975FFFFFF
        FEFFF4E0B2FFECCA79FFFFFFFFFFFBF5E7FFE4B23CFFE2AB2AFFFAF0DAFFFFFF
        FFFFF8ECCEFFE2AC2BFF97721BCA0101000A0000000400000000000000000000
        0000000000009D7B29B0FBF6EBFEFDFDFDFEF1D99EFFE0A928FEF5E5BFFEFFFF
        FFFFFDFDFDFEFDFAF4FFFDFDFDFEFDFDFDFEEDCE85FEE2AB29FFF3E0B3FEFDFD
        FDFEFBF5E5FFE1AA2AFEE0A928FE1C1605290000000000000000000000000000
        000000000000BD9434D3FEFEFEFFFFFFFFFFECCA78FFE2AB29FFFCF8EEFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFD28DFFE2AB29FFF5E2B7FFFFFF
        FFFFFAF2DFFFE2AC2DFFE2AB29FF55400F610000000000000000000000000000
        000000000000C09633D7FDFDFDFEFDFDFDFEEECE83FFE0A928FEF7EBCEFEFFFF
        FFFFFDFCF9FEFBF4E3FFFDFDFDFEFCFAF5FEE5B546FEE2AC2CFFFAF2E0FEFDFD
        FDFEF5E4BBFFE1AA2AFEE0A928FE694F13770000000000000000000000000000
        000000000000A8832BBCFBF7EDFEFDFDFDFEF6E6C1FFE1AA29FEE7BC58FEFCF8
        EEFFFCFAF3FEE5B441FFF5E5BFFEFAF5E7FEE5B649FEEBC772FFFDFDFDFEFDFD
        FDFEEDCB7AFFE1AA2AFEE0A928FE644C12710000000000000000000000000000
        000000000000725A1F80F4E2B7FEFDFDFDFEFEFEFDFFEAC56EFEE0A928FEE3B0
        36FFE7BD5AFEE2AB2BFFE1AB2CFEF1DBA5FEFBF6EAFEFDF9F0FFFDFDFDFEFAF4
        E6FEE3AE32FFE0AA29FEE0A928FE42320C4B0000000000000000000000000000
        00000000000020190A23E2B856F8FEFDFCFFFFFFFFFFFEFDF9FFF0D594FFE5B4
        40FFE2AD2FFFE2AB29FFE6B748FFFBF4E4FFFFFFFFFFFFFFFFFFFEFEFCFFEBC4
        6BFFE2AB2AFFE2AB29FFD8A427F40B08020C0000000000000000000000000000
        000000000000000000007B60208AF0D597FEFFFFFFFFFDFDFDFEFDFDFDFEFEFE
        FCFFFAF4E6FEE7BB54FFFAF4E5FEFDFDFDFEFDFDFDFEFEFEFDFFEED089FEE1AA
        2BFEE2AB29FFE0A928FE84641896000000000000000000000000000000000000
        0000000000000000000006050207A07C26B4F0D594FFFDFCFAFEFDFDFDFEFFFF
        FFFFFDFCF9FEFCF8EDFFFDFDFDFEFDFDFDFEFBF6ECFEEBC66FFFE1AA2BFEE0A9
        29FEE2AB29FFCE9B25E915100418000000000000000000000000000000000000
        00000000000000000000000000000403010482652291E3B74CFCF2DCA6FFFAF1
        DDFFFDFAF2FFFCF7ECFFF7E9C8FFEECF85FFE3B036FFE2AB2AFFE2AB29FFE2AB
        29FFD9A427F53A2C0B4200000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000004233114ACC9A26E6E2AB
        2BFFE1AA2AFEE2AB2AFFE1AA2BFEE1AA2AFEE1AA29FEE2AB29FFE0A928FECB99
        24E63A2C0A410000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000151004188A69
        199CD9A427F6E2AB29FFE1AA2AFEE0A928FEE0A928FED4A026EF7C5E168D130E
        0315000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000C09020E3D2E0B4557421062523E0F5D3428093B05040106000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Spacing = 1
      TabOrder = 3
      WordWrap = True
      OnClick = btnPesquisaClick
    end
    object btnConfirmar: TBitBtn
      Left = 889
      Top = 29
      Width = 80
      Height = 25
      Caption = 'Confirmar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      Font.Quality = fqClearType
      ParentFont = False
      TabOrder = 4
      OnClick = btnConfirmarClick
    end
  end
  object statPesquisa: TStatusBar
    Left = 0
    Top = 389
    Width = 984
    Height = 24
    DoubleBuffered = False
    Panels = <
      item
        Text = 'N'#250'mero de Registros:'
        Width = 125
      end
      item
        Text = '0'
        Width = 50
      end>
    ParentDoubleBuffered = False
  end
  object dbgrdPesquisa: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 76
    Width = 978
    Height = 310
    Align = alClient
    BorderStyle = bsNone
    DataSource = dsPesquisa
    DrawingStyle = gdsGradient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = dbgrdPesquisaDrawColumnCell
    OnDblClick = dbgrdPesquisaDblClick
    OnKeyDown = dbgrdPesquisaKeyDown
  end
  object dsPesquisa: TDataSource
    DataSet = cdsPesquisa
    Left = 46
    Top = 413
  end
  object cdsPesquisa: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = cdsPesquisaAfterOpen
    Left = 19
    Top = 413
  end
end
