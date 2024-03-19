unit untFrmPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls,
  UClassPai, System.Rtti, System.StrUtils,
  UDMConexao, UDMPai;

type
  TFrmPesquisa = class(TForm)
    pnlCampos: TPanel;
    lblCampo: TLabel;
    Label1: TLabel;
    lblPesquisa: TLabel;
    cbbCampo: TComboBox;
    cbbCondicao: TComboBox;
    edtPesquisa: TMaskEdit;
    btnPesquisa: TBitBtn;
    btnConfirmar: TBitBtn;
    statPesquisa: TStatusBar;
    dbgrdPesquisa: TDBGrid;
    dsPesquisa: TDataSource;
    cdsPesquisa: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbgrdPesquisaDblClick(Sender: TObject);
    procedure dbgrdPesquisaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgrdPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbCampoChange(Sender: TObject);
    procedure cbbCondicaoChange(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cdsPesquisaAfterOpen(DataSet: TDataSet);
  private
    FClassPesquisa: TclassPai;
    FRetornoConsulta: Integer;
    FsqlPesquisa: string;
    FcampoChavePesquisa: string;

    type
      TRetornoField = (rfFieldName, rfDisplayName, rfDataType);

  public

    property ClassPesquisa: TclassPai read FClassPesquisa write FClassPesquisa;
    property RetornoConsulta: Integer read FRetornoConsulta write FRetornoConsulta;

    property sqlPesquisa: string read FsqlPesquisa write FsqlPesquisa;
    property campoChavePesquisa: string read FcampoChavePesquisa write FcampoChavePesquisa;

    procedure AddComboBoxCondicao;
    procedure AddComboBoxCampo;

    function RetornarValorCampo<T>(Retorno: TRetornoField): T;
    procedure consultaPesquisa;
    procedure ValidarCampos;
  end;

var
  FrmPesquisa: TFrmPesquisa;

implementation

{$R *.dfm}

{$REGION ' State Form '}

procedure TFrmPesquisa.FormCreate(Sender: TObject);
begin
  KeyPreview := True;

  dsPesquisa.DataSet := cdsPesquisa;

  dbgrdPesquisa.DataSource := dsPesquisa;
end;

procedure TFrmPesquisa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    close;
end;

procedure TFrmPesquisa.FormShow(Sender: TObject);
begin
  AddComboBoxCondicao;
  AddComboBoxCampo;
  consultaPesquisa;
  FClassPesquisa.configurarCampo(cdsPesquisa.Fields);
end;

{$ENDREGION}

{$REGION ' Retorna Valor dos Campos'}
function TFrmPesquisa.RetornarValorCampo<T>(Retorno: TRetornoField): T;
var
  Campo: TField;
  RttiContext: TRttiContext;
begin
  Result := Default(T);

  for Campo in cdsPesquisa.Fields do
  begin

    if Campo.DisplayLabel = cbbCampo.Items[cbbCampo.ItemIndex] then
    begin

      case Retorno of

        rfFieldName:
          Result := TValue.From<string>(Campo.FieldName).AsType<T>;

        rfDisplayName:
          Result := TValue.From<string>(Campo.DisplayName).AsType<T>;

        rfDataType:
          Result := TValue.From<TFieldType>(Campo.DataType).AsType<T>;

      end;

      Break;
    end;

  end;
end;
{$ENDREGION}

{$REGION ' Validar os Campos '}
procedure TFrmPesquisa.ValidarCampos;
var
  vDataType: TFieldType;
  useMask: Boolean;
begin
  vDataType := RetornarValorCampo<TFieldType>(rfDataType);
  useMask := False;

  case vDataType of
    ftString:
      begin
        if (cbbCondicao.ItemIndex in [1, 2, 4]) then
        begin
          cbbCondicao.ItemIndex := 3;
        end;
      end;

    ftDate, ftDateTime, ftTimeStamp:
      begin
        useMask := True;
        if (cbbCondicao.ItemIndex = 3) then
        begin
          cbbCondicao.ItemIndex := 4;
        end;
      end;

    ftInteger, ftLargeint, ftFMTBcd:
      begin
        edtPesquisa.EditMask := '';
      end;
  end;

  edtPesquisa.EditMask := IfThen(useMask, '!99.99.0000;1', '');

  edtPesquisa.Enabled := (cbbCondicao.ItemIndex <> 0);
end;
{$ENDREGION}

{$REGION ' ADD Campos Combobox '}
procedure TFrmPesquisa.AddComboBoxCampo;
var
  Campo: TField;
  cdsTemp: TClientDataSet;
begin

  cdsTemp := TClientDataSet.create(self);
  try

    cdsTemp.Close;
    cdsTemp.Data := DMConexao.ExecuteReader(FsqlPesquisa);
    FClassPesquisa.configurarCampo(cdsTemp.Fields);

    cbbCampo.Items.Clear;
    for Campo in cdsTemp.Fields do
    begin
      cbbCampo.Items.Add(Campo.DisplayLabel);
    end;

    cbbCampo.ItemIndex := 0;
    statPesquisa.Panels[1].Text := IntToStr(cdsTemp.RecordCount);
  finally
    cdsTemp.Close;
  end;

end;
{$ENDREGION}

{$REGION ' ADD Condição Combobox '}
procedure TFrmPesquisa.AddComboBoxCondicao;
begin
  cbbCondicao.Items.Clear;
  cbbCondicao.Items.AddStrings(['Todos', 'Maior que', 'Menor que', 'Que Contém', 'Igual a']);
  cbbCampo.ItemIndex := 0;
  cbbCondicao.ItemIndex := 0;
end;
{$ENDREGION}

{$REGION ' Consulta Pesquisa'}
procedure TFrmPesquisa.consultaPesquisa;
var
  CampoConsulta: TField;
  vDataType: TFieldType;
  vFieldName, vDisplayLabel, SQL, conteudoConsulta: string;

begin

  SQL := FsqlPesquisa;

  conteudoConsulta := UpperCase(edtPesquisa.Text);

  vDataType := RetornarValorCampo<TFieldType>(rfDataType);

  vFieldName := RetornarValorCampo<string>(rfFieldName);

  vDisplayLabel := RetornarValorCampo<string>(rfDisplayName);

  if (trim(conteudoConsulta) = EmptyStr) or (trim(conteudoConsulta) = '.  .') then
  begin

    SQL := SQL + ' and ' + FcampoChavePesquisa + ' > 0 ';

  end
  else
  begin

    if (vDataType = ftString) or (vDataType = ftDate) then
    begin

      case cbbCondicao.ItemIndex of

        1:
          SQL := SQL + ' and ' + vFieldName + ' > ' + QuotedStr(conteudoConsulta);

        2:
          SQL := SQL + ' and ' + vFieldName + ' < ' + QuotedStr(conteudoConsulta);

        3:
          SQL := SQL + ' and ' + vFieldName + ' LIKE ' + QuotedStr('%' + conteudoConsulta + '%');

        4:
          SQL := SQL + ' and ' + vFieldName + ' = ' + QuotedStr(conteudoConsulta);

      end;

    end
    else if (vDataType = ftInteger) or (vDataType = ftLargeint) or (vDataType = ftFMTBcd) then
    begin

      case cbbCondicao.ItemIndex of

        1:
          SQL := SQL + ' and ' + vFieldName + ' > ' + conteudoConsulta;

        2:
          SQL := SQL + ' and ' + vFieldName + ' < ' + conteudoConsulta;

        3:
          SQL := SQL + ' and ' + vFieldName + ' LIKE ' + QuotedStr('%' + conteudoConsulta + '%');

        4:
          SQL := SQL + ' and ' + vFieldName + ' = ' + conteudoConsulta;

      end;

    end;

  end;

  SQL:= SQL + 'order by '+FcampoChavePesquisa;

  cdsPesquisa.Close;
  cdsPesquisa.Data := DMConexao.ExecuteReader(SQL);
  cdsPesquisa.Open;

end;
{$ENDREGION}

{$REGION ' State DBGrid '}

procedure TFrmPesquisa.dbgrdPesquisaDblClick(Sender: TObject);
begin
  FRetornoConsulta := cdsPesquisa.FieldByName(FcampoChavePesquisa).AsInteger;
  Close;
end;

procedure TFrmPesquisa.dbgrdPesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   DMPai.EditarCorDBGrid(dsPesquisa, dbgrdPesquisa, State, Rect, Column);
end;

procedure TFrmPesquisa.dbgrdPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    FRetornoConsulta := cdsPesquisa.FieldByName(FcampoChavePesquisa).AsInteger;
    Close;
  end;
end;



{$ENDREGION}

{$REGION ' State Search Fields and Buttons'}
procedure TFrmPesquisa.cbbCampoChange(Sender: TObject);
begin
  ValidarCampos;
  edtPesquisa.Clear;
end;

procedure TFrmPesquisa.cbbCondicaoChange(Sender: TObject);
begin
  ValidarCampos;
  edtPesquisa.Clear;
end;

procedure TFrmPesquisa.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    consultaPesquisa;
  end;
end;

procedure TFrmPesquisa.btnPesquisaClick(Sender: TObject);
begin
  consultaPesquisa;
end;

procedure TFrmPesquisa.btnConfirmarClick(Sender: TObject);
begin
  FRetornoConsulta := cdsPesquisa.FieldByName(FcampoChavePesquisa).AsInteger;
  Close;
end;
{$ENDREGION}

{$REGION ' State CDS '}
procedure TFrmPesquisa.cdsPesquisaAfterOpen(DataSet: TDataSet);
begin
  FClassPesquisa.configurarCampo(cdsPesquisa.Fields);
end;
{$ENDREGION}

end.

