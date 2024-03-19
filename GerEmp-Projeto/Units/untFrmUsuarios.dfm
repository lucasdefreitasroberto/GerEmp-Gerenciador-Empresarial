inherited frmUsuarios: TfrmUsuarios
  Caption = 'frmUsuarios'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPrincipal: TPanel
    inherited pnlCentro: TPanel
      inherited pgcPrincipal: TPageControl
        inherited tsPesquisa: TTabSheet
          object Panel1: TPanel
            Left = 146
            Top = 1
            Width = 865
            Height = 549
            BevelOuter = bvNone
            TabOrder = 0
            object Panel2: TPanel
              Left = 0
              Top = 0
              Width = 865
              Height = 41
              Align = alTop
              TabOrder = 0
              object Label1: TLabel
                Left = 324
                Top = 7
                Width = 211
                Height = 28
                Caption = 'Cadastro de '#218'suarios'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -20
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
            end
            object GroupBox1: TGroupBox
              Left = 19
              Top = 96
              Width = 398
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
                Width = 358
                Height = 29
                CharCase = ecUpperCase
                DataField = 'NOME_USUARIOS'
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
              Left = 19
              Top = 208
              Width = 398
              Height = 86
              TabOrder = 2
              object Label4: TLabel
                Left = 20
                Top = 16
                Width = 44
                Height = 21
                Caption = 'Login'
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
                Width = 358
                Height = 29
                CharCase = ecUpperCase
                DataField = 'LOGIN_USUARIOS'
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
              Left = 439
              Top = 96
              Width = 398
              Height = 310
              TabOrder = 3
              object Label5: TLabel
                Left = 12
                Top = 16
                Width = 50
                Height = 21
                Caption = 'Status'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
              object Label6: TLabel
                Left = 20
                Top = 221
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
              object Label7: TLabel
                Left = 12
                Top = 125
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
              object RdStatus: TDBRadioGroup
                Left = 12
                Top = 40
                Width = 361
                Height = 41
                BiDiMode = bdLeftToRight
                Color = clBtnFace
                Columns = 2
                DataField = 'STATUS_USUARIOS'
                DataSource = DS
                DragCursor = crDefault
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -13
                Font.Name = 'Segoe UI'
                Font.Style = [fsBold]
                Font.Quality = fqClearTypeNatural
                Items.Strings = (
                  'Ativo'
                  'Bloqueado')
                ParentBackground = False
                ParentBiDiMode = False
                ParentColor = False
                ParentFont = False
                TabOrder = 0
                Values.Strings = (
                  'N'
                  'S')
              end
              object GroupBox5: TGroupBox
                Left = 20
                Top = 245
                Width = 357
                Height = 45
                Align = alCustom
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                object JvDBMaskEdit1: TJvDBMaskEdit
                  Left = 12
                  Top = 9
                  Width = 254
                  Height = 28
                  DataField = 'DTALTERACAO_USUARIOS'
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
              object GroupBox6: TGroupBox
                Left = 12
                Top = 149
                Width = 356
                Height = 45
                Align = alCustom
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
                object JvDBMaskEdit2: TJvDBMaskEdit
                  Left = 12
                  Top = 9
                  Width = 254
                  Height = 28
                  DataField = 'DTCADASTRO_USUARIOS'
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
            object GroupBox4: TGroupBox
              Left = 19
              Top = 320
              Width = 398
              Height = 86
              TabOrder = 4
              object Label2: TLabel
                Left = 20
                Top = 16
                Width = 47
                Height = 21
                Caption = 'Senha'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI Black'
                Font.Style = []
                ParentFont = False
              end
              object DBEdit2: TDBEdit
                Left = 20
                Top = 40
                Width = 358
                Height = 29
                CharCase = ecUpperCase
                DataField = 'SENHA_USUARIOS'
                DataSource = DS
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGrayText
                Font.Height = -16
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                PasswordChar = '*'
                TabOrder = 0
              end
            end
          end
        end
      end
    end
  end
  inherited DS: TDataSource
    DataSet = DMUsuarios.CDS
  end
end
