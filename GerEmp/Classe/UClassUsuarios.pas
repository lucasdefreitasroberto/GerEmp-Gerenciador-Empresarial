unit UClassUsuarios;

interface

uses
  data.DB, UClassPai, System.SysUtils, UDMConexao;

type
  TClassUsuarios = class(TclassPai)
  public
    procedure configurarCampo(Fields: TFields); override;
    function nomeTabela: string; override;
    function campoChave: string; override;
    function sqlPesquisa: string; override;
    function sqlCadastro: string; override;
    function nomeGenerator: string; override;
  end;

implementation

{ TClassUsuarios }

function TClassUsuarios.campoChave: string;
begin
  Result := 'CODIGO_USUARIOS'
end;

procedure TClassUsuarios.configurarCampo(Fields: TFields);
var
  Field: TField;
begin
  for Field in Fields do
  begin

    if Field.FieldName = 'CODIGO_USUARIOS' then
      Field.DisplayLabel := 'Código'

    else if Field.FieldName = 'NOME_USUARIOS' then
      Field.DisplayLabel := 'Nome'

    else if Field.FieldName = 'LOGIN_USUARIOS' then
      Field.DisplayLabel := 'Login'

    else if Field.FieldName = 'SENHA_USUARIOS' then
      Field.DisplayLabel := 'Senha'

    else if Field.FieldName = 'STATUS_USUARIOS' then
      Field.DisplayLabel := 'Status'

    else if Field.FieldName = 'DTCADASTRO_USUARIOS' then
      Field.DisplayLabel := 'Data de Cadastro'

    else if Field.FieldName = 'DTALTERACAO_USUARIOS' then
      Field.DisplayLabel := 'Última Alteração'
  end;

  inherited;
end;

function TClassUsuarios.nomeGenerator: string;
begin
  Result := 'GEN_USUARIOS';
end;

function TClassUsuarios.nomeTabela: string;
begin
 Result := 'USUARIOS';
end;

function TClassUsuarios.sqlCadastro: string;
var
  SQL: string;
begin
   SQL:=
        ' select CODIGO_USUARIOS, ' +
        ' NOME_USUARIOS,          ' +
        ' LOGIN_USUARIOS,         ' +
        ' SENHA_USUARIOS,         ' +
        ' STATUS_USUARIOS,        ' +
        ' DTCADASTRO_USUARIOS,    ' +
        ' DTALTERACAO_USUARIOS    ' +
        ' from USUARIOS           ' +
        ' where USUARIOS.CODIGO_USUARIOS = :CODIGO';

  Result := SQL;
end;

function TClassUsuarios.sqlPesquisa: string;
var
  SQL: string;
begin
  SQL:=
       ' select CODIGO_USUARIOS,  ' +
       ' NOME_USUARIOS,           ' +
       ' LOGIN_USUARIOS,          ' +
       ' SENHA_USUARIOS,          ' +
       ' STATUS_USUARIOS,         ' +
       ' DTCADASTRO_USUARIOS,     ' +
       ' DTALTERACAO_USUARIOS     ' +
       ' from USUARIOS            ' +
       ' where USUARIOS.CODIGO_USUARIOS > 0';

  Result := SQL;
end;

end.

