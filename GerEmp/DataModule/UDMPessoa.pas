unit UDMPessoa;

interface

uses
  System.SysUtils, System.Classes, UDMPai,
  Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider, Data.DB, Data.SqlExpr,
  UClassPessoa, UDMConexao;

type
  TDMPessoa = class(TDMPai)
    dsTelefone: TDataSource;
    SQLDSTelefone: TSQLDataSet;
    cdsTelefone: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSAfterInsert(DataSet: TDataSet);
    procedure CDSBeforePost(DataSet: TDataSet);
    procedure cdsTelefoneAfterOpen(DataSet: TDataSet);
    procedure CDSAfterOpen(DataSet: TDataSet);
    procedure cdsTelefoneBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPessoa: TDMPessoa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMPessoa.CDSAfterInsert(DataSet: TDataSet);
begin
  if CDS.State in [dsInsert] then
  begin
    CDS.FieldByName('TIPO_PESSOA').AsString := 'F';
    CDS.FieldByName('SEXO_PESSOA').AsString := 'M';
    CDS.FieldByName('CLIENTE_PESSOA').AsString := 'S';
    CDS.FieldByName('FORNECEDOR_PESSOA').AsString := 'N';
    CDS.FieldByName('DTCADASTRO_PESSOA').AsDateTime := Now;
  end;
end;

procedure TDMPessoa.CDSAfterOpen(DataSet: TDataSet);
begin
  cdsTelefone.DataSetField := TDataSetField(CDS.FieldByName(SQLDSTelefone.Name));
  inherited;
end;

procedure TDMPessoa.CDSBeforePost(DataSet: TDataSet);
begin
  inherited;

  DMPai.VerificarCamposVazios(CDS, ['NOME_PESSOA', 'DOCUMENTO_PESSOA', 'BAIRRO_PESSOA', 'ESTADO_PESSOA', 'NUMERO_PESSOA']);

  if CDS.State in [dsEdit] then
  begin
    CDS.FieldByName('DTALTERACAO_PESSOA').AsDateTime := Now;
  end;
end;

procedure TDMPessoa.cdsTelefoneAfterOpen(DataSet: TDataSet);
begin
  cdsTelefone.FieldByName('CODIGO_PESSOA_TEL').Visible := False;
  cdsTelefone.FieldByName('PESSOA_PESSOA_TEL').Visible := False;
  ClassPai.configurarCampo(cdsTelefone.Fields);
end;

procedure TDMPessoa.cdsTelefoneBeforePost(DataSet: TDataSet);
begin
  inherited;
  if cdsTelefone.State in [dsInsert] then
  begin
    cdsTelefone.FieldByName('CODIGO_PESSOA_TEL').AsString := DMConexao.GenerateNextCode('GEN_PESSOA_TELEFONE');
  end;

end;

procedure TDMPessoa.DataModuleCreate(Sender: TObject);
begin
  ClassPai := TClassPessoa.Create;

  //DETAIL
  SQLDSTelefone.SQLConnection :=  DMConexao.Conexao;
  SQLDSTelefone.CommandText   :=  TClassPessoa.sqlCadTelefone;
  criarParametro(SQLDSTelefone, 'CODIGO_PESSOA');
  dsTelefone.DataSet := SQLDataSet;
  SQLDSTelefone.DataSource:= dsTelefone;

  inherited;
end;

end.
