inherited frmProduto: TfrmProduto
  Caption = 'frmProduto'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPrincipal: TPanel
    inherited pnlCentro: TPanel
      inherited pgcPrincipal: TPageControl
        inherited tsPesquisa: TTabSheet
          object Panel1: TPanel
            Left = 69
            Top = 1
            Width = 1018
            Height = 550
            BevelOuter = bvNone
            TabOrder = 0
            object Panel2: TPanel
              Left = 0
              Top = 0
              Width = 1018
              Height = 41
              Align = alTop
              TabOrder = 0
              object Label1: TLabel
                Left = 406
                Top = 7
                Width = 206
                Height = 28
                Caption = 'Cadastro de Produto'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -20
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
            end
            object GroupBox1: TGroupBox
              Left = 3
              Top = 64
              Width = 666
              Height = 86
              TabOrder = 1
              object Label3: TLabel
                Left = 20
                Top = 16
                Width = 47
                Height = 21
                Caption = 'Nome'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
              object dbedtNome: TDBEdit
                Left = 20
                Top = 40
                Width = 629
                Height = 29
                CharCase = ecUpperCase
                DataField = 'NOME_PRODUTO'
                DataSource = DS
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
            end
            object GroupBox3: TGroupBox
              Left = 3
              Top = 272
              Width = 666
              Height = 86
              TabOrder = 2
              object Label7: TLabel
                Left = 16
                Top = 9
                Width = 130
                Height = 21
                Caption = 'Data de Inclus'#227'o'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
              object Label6: TLabel
                Left = 364
                Top = 9
                Width = 133
                Height = 21
                Caption = #218'tilma Altera'#231#227'o'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
              object GroupBox6: TGroupBox
                Left = 16
                Top = 33
                Width = 285
                Height = 45
                Align = alCustom
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                object edtMakDTCADASTRO_PESSOA: TJvDBMaskEdit
                  Left = 15
                  Top = 9
                  Width = 254
                  Height = 28
                  DataField = 'DTCADASTRO_PRODUTO'
                  DataSource = DS
                  Enabled = False
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clGrayText
                  Font.Height = -15
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  MaxLength = 10
                  ParentFont = False
                  TabOrder = 0
                  EditMask = '!99/99/0000;1'
                end
              end
              object GroupBox5: TGroupBox
                Left = 364
                Top = 33
                Width = 284
                Height = 45
                Align = alCustom
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                object edtMakDTALTERACAO_PESSOA: TJvDBMaskEdit
                  Left = 12
                  Top = 9
                  Width = 254
                  Height = 28
                  DataField = 'DTALTERACAO_PRODUTO'
                  DataSource = DS
                  Enabled = False
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clGrayText
                  Font.Height = -15
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  MaxLength = 10
                  ParentFont = False
                  TabOrder = 0
                  EditMask = '!99/99/0000;1'
                end
              end
            end
            object GroupBox9: TGroupBox
              Left = 3
              Top = 168
              Width = 327
              Height = 86
              TabOrder = 3
              object Label10: TLabel
                Left = 20
                Top = 16
                Width = 147
                Height = 21
                Caption = 'Pre'#231'o Promocional'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
              object dbedtPRECOPROMO: TDBEdit
                Left = 20
                Top = 40
                Width = 276
                Height = 29
                CharCase = ecUpperCase
                DataField = 'PRECOPROMO_PRODUTO'
                DataSource = DS
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
            end
            object GroupBox2: TGroupBox
              Left = 342
              Top = 168
              Width = 327
              Height = 86
              TabOrder = 4
              object Label2: TLabel
                Left = 20
                Top = 16
                Width = 107
                Height = 21
                Caption = 'Pre'#231'o Normal'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
              object DBEdit1: TDBEdit
                Left = 20
                Top = 40
                Width = 276
                Height = 29
                CharCase = ecUpperCase
                DataField = 'PRECONORMAL_PRODUTO'
                DataSource = DS
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
            end
            object GroupBox4: TGroupBox
              Left = 688
              Top = 64
              Width = 327
              Height = 86
              TabOrder = 5
              object Label4: TLabel
                Left = 20
                Top = 16
                Width = 63
                Height = 21
                Caption = 'Estoque'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
              object DBEdit3: TDBEdit
                Left = 20
                Top = 40
                Width = 276
                Height = 29
                CharCase = ecUpperCase
                Color = clGradientInactiveCaption
                DataField = 'ESTOQUE_PRODUTO'
                DataSource = DS
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
              end
            end
            object GroupBox7: TGroupBox
              Left = 688
              Top = 168
              Width = 327
              Height = 86
              TabOrder = 6
              object Label5: TLabel
                Left = 20
                Top = 16
                Width = 166
                Height = 21
                Caption = 'Pre'#231'o '#218'ltima Compra'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
              object DBEdit4: TDBEdit
                Left = 20
                Top = 40
                Width = 276
                Height = 29
                CharCase = ecUpperCase
                Color = clGradientInactiveCaption
                DataField = 'PRECOULTCOMP_PRODUTO'
                DataSource = DS
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
              end
            end
            object GroupBox8: TGroupBox
              Left = 688
              Top = 272
              Width = 327
              Height = 86
              TabOrder = 7
              object Label8: TLabel
                Left = 20
                Top = 16
                Width = 133
                Height = 21
                Caption = 'Estoque [x] PVN '
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
              object DBEdit5: TDBEdit
                Left = 20
                Top = 40
                Width = 276
                Height = 29
                CharCase = ecUpperCase
                Color = clGradientInactiveCaption
                DataField = 'ESTOQUEXVPN_PRODUTO'
                DataSource = DS
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
              end
            end
          end
        end
      end
    end
  end
end
