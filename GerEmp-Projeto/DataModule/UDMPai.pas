unit UDMPai;

interface

uses
  System.SysUtils, System.Classes,
  Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider, Data.DB,
  Data.SqlExpr, UDMConexao, UClassPai,
  Vcl.DBGrids, Vcl.Grids, System.Types, Vcl.Forms;

type
  TDMPai = class(TDataModule)
    SQLDataSet: TSQLDataSet;
    DataSetProvider: TDataSetProvider;
    CDS: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CDSAfterCancel(DataSet: TDataSet);
    procedure CDSAfterDelete(DataSet: TDataSet);
    procedure CDSAfterOpen(DataSet: TDataSet);
    procedure CDSAfterPost(DataSet: TDataSet);
    procedure CDSBeforePost(DataSet: TDataSet);
    procedure CDSReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    FClassPai: TClassPai;

  public
    property ClassPai: TClassPai read FClassPai write FClassPai;

    procedure criarParametro(SQLDataSet: TSQLDataSet; NomeCampo: string);
    procedure AbrirRegistro(Codigo: integer);

    procedure PrimeiroRegistro;
    procedure UltimoRegistro;
    procedure ProximoRegistro;
    procedure RegistroAnterior;

    procedure EditarCorDBGrid(DataSource: TDataSource; Sender: TDBGrid; state: TGridDrawState; rect: TRect; Color: TColumn);
    procedure VerificarCamposVazios(const CDS: TClientDataSet; const Campos: array of string);

    function AbreForm(FormClasse: TFormClass; FForm: TForm; wtipo: Word): boolean;
  end;

var
  DMPai: TDMPai;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{$REGION ' Abrir Registro '}
function TDMPai.AbreForm(FormClasse: TFormClass; FForm: TForm;
  wtipo: Word): boolean;
var
  obForm: TObject;
begin

  try
    obForm := FForm;

    if (TForm(obForm) = Nil) or (not TForm(obForm).HandleAllocated) then
    begin
      obForm := FormClasse.Create(Application.MainForm)
    end;

    TForm(obForm).ShowModal;

  finally

    TForm(obForm).Release;
    TForm(obForm).free;
    TForm(obForm) := nil;
  end;

end;

procedure TDMPai.AbrirRegistro(Codigo: integer);
begin

  CDS.Close;
  SQLDataSet.ParamByName('CODIGO').AsInteger := Codigo;
  CDS.FetchParams;

  try
    CDS.Open;
  except
    on E: Exception do
      raise Exception.Create('Error ao Abrir Registro');
  end;

end;
{$ENDREGION}

{$REGION ' Verifica Campos Vazios '}
procedure TDMPai.VerificarCamposVazios(const CDS: TClientDataSet;
  const Campos: array of string);
var
  Campo: TField;
  i: Integer;
begin
  for i := Low(Campos) to High(Campos) do
  begin
    Campo := CDS.FieldByName(Campos[i]);
    if (Campo is TStringField) and (Campo.AsString = '') then
      raise Exception.Create(Campos[i] + ' em Branco');
  end;
end;
{$ENDREGION}

{$REGION ' Criar Parametro '}
procedure TDMPai.criarParametro(SQLDataSet: TSQLDataSet; NomeCampo: string);
begin
  SQLDataSet.params.Clear;
  SQLDataSet.params.CreateParam(ftString, NomeCampo, ptInput);
end;
{$ENDREGION}

{$REGION ' State CDS '}
procedure TDMPai.CDSAfterCancel(DataSet: TDataSet);
begin
  CDS.Cancel;
end;

procedure TDMPai.CDSAfterDelete(DataSet: TDataSet);
begin
  CDS.ApplyUpdates(0);
end;

procedure TDMPai.CDSAfterOpen(DataSet: TDataSet);
begin
  ClassPai.configurarCampo(CDS.Fields);
end;

procedure TDMPai.CDSAfterPost(DataSet: TDataSet);
begin
  CDS.ApplyUpdates(-1);
end;

procedure TDMPai.CDSBeforePost(DataSet: TDataSet);
begin
  if CDS.State in [dsInsert] then
  begin
    CDS.FieldByName(ClassPai.campoChave).AsString := DMConexao.GenerateNextCode(ClassPai.NomeGenerator);
  end;
end;

procedure TDMPai.CDSReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  raise Exception.Create('erro não propragado pelo CDS: ' + E.Message);
  Action := raCancel;
end;
{$ENDREGION}

{$REGION ' State DM '}
procedure TDMPai.DataModuleCreate(Sender: TObject);
begin

  SQLDataSet.SQLConnection := DMConexao.Conexao;
  SQLDataSet.CommandText := ClassPai.sqlCadastro;

  if SQLDataSet.Params.Count > 0 then
  begin
    criarParametro(SQLDataSet, 'CODIGO');
  end;

  // Conexão DataSetProvider
  DataSetProvider.DataSet := SQLDataSet;

  // Conexão ClientDataSet
  CDS.ProviderName := DataSetProvider.Name;

  // NÃO PRECISAR INICIAR CDS ABERTO
  CDS.Open;

end;

procedure TDMPai.DataModuleDestroy(Sender: TObject);
begin
  ClassPai.Free;
end;

{$ENDREGION}

{$region ' Records Movement '}
procedure TDMPai.PrimeiroRegistro;
var
  SQL: string;
  primeiroCodigo: integer;
begin

  SQL := ' select coalesce(min(' + ClassPai.CampoChave +
         '),0)' + #13 + ' from ' + ClassPai.nomeTabela +
          #13 + ' where ' + ClassPai.campoChave + ' > 0 ';

  primeiroCodigo := DMConexao.ExecuteScalar(SQL);
  AbrirRegistro(primeiroCodigo);

end;

procedure TDMPai.ProximoRegistro;
var
  codigoAtual, proximoCodigo: integer;
  SQL: string;
begin

  codigoAtual := CDS.FieldByName(ClassPai.campoChave).AsInteger;

  SQL := ' select coalesce(min(' + ClassPai.CampoChave + '),0)' + #13 +
         ' from ' + ClassPai.NomeTabela + #13 +
         ' Where ' + ClassPai.CampoChave + ' > '+ IntToStr(codigoAtual);

  proximoCodigo := DMConexao.ExecuteScalar(SQL);

  if proximoCodigo > 0 then
    AbrirRegistro(proximoCodigo);

end;

procedure TDMPai.RegistroAnterior;
var
  codigoAtual, CodigoAnterior: integer;
  SQL: string;
begin

  codigoAtual := CDS.FieldByName(ClassPai.campoChave).AsInteger;

  SQL := ' select coalesce(max(' + ClassPai.campoChave + '),0) ' + #13 +
         ' from ' + ClassPai.nomeTabela +
         ' where ' + ClassPai.campoChave + ' < ' + IntToStr(codigoAtual);

  CodigoAnterior := DMConexao.ExecuteScalar(SQL);

  if CodigoAnterior > 0 then
    AbrirRegistro(CodigoAnterior);

end;

procedure TDMPai.UltimoRegistro;
var
  SQL: string;
  ultimoCodigo: integer;
begin

  SQL := ' select coalesce(max(' + ClassPai.campoChave + '),0)' + #13 +
         ' from ' + ClassPai.nomeTabela + #13 +
         ' where ' + ClassPai.campoChave + ' > 0 ';

  ultimoCodigo := DMConexao.ExecuteScalar(SQL);
  AbrirRegistro(ultimoCodigo);

end;

{$ENDREGION}

{$REGION ' Edit Color DBGrid '}
procedure TDMPai.EditarCorDBGrid(DataSource: TDataSource; Sender: TDBGrid;
  state: TGridDrawState; rect: TRect; Color: TColumn);
begin

  if not Odd(DataSource.DataSet.recNO) then
  begin
    if not (gdSelected in state) then
    begin
      Sender.Canvas.Brush.Color := $ecf8e8 //$d9ead3//$cdb896; //$bebebe; //EBCE87;
    end;
  end;

  Sender.Canvas.FillRect(rect);
  Sender.Font.Size := 10;
  Sender.DefaultDrawDataCell(rect, Color.Field, state);

end;
{$ENDREGION}

end.

