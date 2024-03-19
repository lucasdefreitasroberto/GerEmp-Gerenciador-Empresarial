unit UDMConexao;

interface

uses
  System.SysUtils, System.Classes, Data.DBXFirebird, Data.FMTBcd,
  Datasnap.Provider, Data.DB, Data.SqlExpr, Vcl.Dialogs;

type
  TDMConexao = class(TDataModule)
    Conexao: TSQLConnection;
    SQLDSConexao: TSQLDataSet;
    DSPConexao: TDataSetProvider;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function  ExecuteScalar(SQL: string): Variant;
    function  ExecuteReader(SQL: string): OleVariant;
    procedure ExecuteCommand(SQL: string; NomeCampo: Integer; NomeParametroSQL: string);
    function  GenerateNextCode(generator: string): string;
  end;

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{$REGION ' DM Create ' }
procedure TDMConexao.DataModuleCreate(Sender: TObject);
var
  auxError: string;

begin

  const driver   = 'Firebird';
  const database = 'C:\GerEmp\Dados\DADOS.FDB';
  const password = 'masterkey';
  const user     = 'SYSDBA';
  const protocol = 'LOCAL';
  const server   = '';
  const port     = 3050;
  const Lib      = 'C:\GerEmp\exe\fbclient.dll';

  Conexao.Params.Add('DriverID='  +  driver);
  Conexao.Params.Add('Database='  +  database);
  Conexao.Params.Add('Password='  +  password);
  Conexao.Params.Add('User_Name=' +  user);
  Conexao.Params.Add('Protocol='  +  protocol);
  Conexao.Params.Add('Server='    +  server);
  Conexao.Params.Add('Port='      +  System.SysUtils.IntToStr(port));
  Conexao.Params.Add('VendorLib=' +  Lib);

  SQLDSConexao.SQLConnection := Conexao;
  DSPConexao.DataSet := SQLDSConexao;

  if Conexao.Connected then
    Conexao.Close;

  try

    Conexao.Open;

  except

    on E: exception do
    begin
      auxError := Copy(E.Message, 20, 500);
      MessageDlg(' Erro ao tentar se conectar com o banco de dados.'
                   + #13 + #13 + ' Motivo:' + #13 + #13
                   + '' + auxError, TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
    end;

  end;

end;
{$ENDREGION}

{$REGION ' Execute Command '}
procedure TDMConexao.ExecuteCommand(SQL: string; NomeCampo: Integer;
  NomeParametroSQL: string);
var
  Parametros: TParams;
begin
  Parametros := TParams.Create(Self);

  try
    Parametros.CreateParam(ftInteger, NomeParametroSQL, ptInput);
    Parametros.ParamByName(NomeParametroSQL).AsString := IntToStr(NomeCampo);
    Conexao.Execute(SQL, Parametros);
  finally
    Parametros.Free;
  end;
end;
{$ENDREGION}

{$REGION ' Execute Reader '}
function TDMConexao.ExecuteReader(SQL: string): OleVariant;
begin
  SQLDSConexao.Close;
  SQLDSConexao.CommandText := SQL;
  SQLDSConexao.SQLConnection := Conexao;

  Result := DSPConexao.Data;
end;
{$ENDREGION}

{$REGION ' Execute Scalar'}
function TDMConexao.ExecuteScalar(SQL: string): Variant;
begin
  SQLDSConexao.Close;
  SQLDSConexao.CommandText := SQL;
  SQLDSConexao.Open;

  Result := SQLDSConexao.Fields[0].AsString;
end;
{$ENDREGION}

{$REGION ' GenerateNextCode '}
function TDMConexao.GenerateNextCode(generator: string): string;
begin
  Result := ExecuteScalar('Select GEN_ID( ' + generator +', 1) from RDB$DATABASE');
end;
{$ENDREGION}

end.
