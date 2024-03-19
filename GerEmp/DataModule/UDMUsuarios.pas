unit UDMUsuarios;

interface

uses
  System.SysUtils, System.Classes,
  UDMPai, Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider, Data.DB, Data.SqlExpr,
  UClassUsuarios;

type
  TDMUsuarios = class(TDMPai)
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSAfterInsert(DataSet: TDataSet);
    procedure CDSBeforePost(DataSet: TDataSet);
  private
    FClassUsuarios: TClassUsuarios;
    { Private declarations }
  public
    property ClassUsuarios: TClassUsuarios read FClassUsuarios write FClassUsuarios;
  end;

var
  DMUsuarios: TDMUsuarios;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{$REGION ' State CDS '}
procedure TDMUsuarios.CDSAfterInsert(DataSet: TDataSet);
begin
  if CDS.State in [dsInsert] then
  begin
    CDS.FieldByName('STATUS_USUARIOS').AsString := 'N';
    CDS.FieldByName('DTCADASTRO_USUARIOS').AsDateTime := Now;
  end;
end;

procedure TDMUsuarios.CDSBeforePost(DataSet: TDataSet);
begin
  inherited;
  DMPai.VerificarCamposVazios(CDS, ['NOME_USUARIOS', 'LOGIN_USUARIOS', 'SENHA_USUARIOS']);

  if CDS.State in [dsEdit] then
  begin
    CDS.FieldByName('DTALTERACAO_USUARIOS').AsDateTime := Now;
  end;

end;
{$ENDREGION}

{$REGION ' DM Create'}
procedure TDMUsuarios.DataModuleCreate(Sender: TObject);
begin
  ClassPai := TClassUsuarios.Create;
  inherited;
end;
{$ENDREGION}

end.
