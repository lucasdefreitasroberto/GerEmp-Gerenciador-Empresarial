unit UClassPessoa;

interface

uses
  Data.DB, UClassPai;

type
  TClassPessoa = class(TClassPai)
  public
    procedure configurarCampo(Fields: TFields); override;
    function nomeTabela: string; override;
    function campoChave: string; override;
    function sqlCadastro: string; override;
    function sqlPesquisa: string; override;
    function nomeGenerator: string; override;
    {---------------------------------------}
    class function sqlCadTelefone: string;

  end;

implementation

{ TClassPesoa }

function TClassPessoa.campoChave: string;
begin
  Result := 'CODIGO_PESSOA';
end;

procedure TClassPessoa.configurarCampo(Fields: TFields);
var
  Field: TField;
begin
  for Field in Fields do
  begin

    if Field.FieldName = 'CODIGO_PESSOA' then
      Field.DisplayLabel := 'Código'

    else if Field.FieldName = 'NOME_PESSOA' then
      Field.DisplayLabel := 'Nome'

    else if Field.FieldName = 'LOGRADOURO_PESSOA' then
      Field.DisplayLabel := 'Logradouro'

    else if Field.FieldName = 'SEXO_PESSOA' then
      Field.DisplayLabel := 'Sexo'

    else if Field.FieldName = 'NUMERO_PESSOA' then
      Field.DisplayLabel := 'Número'

    else if Field.FieldName = 'MUNICIPIO_PESSOA' then
      Field.DisplayLabel := 'Município'

    else if Field.FieldName = 'BAIRRO_PESSOA' then
      Field.DisplayLabel := 'Bairro'

    else if Field.FieldName = 'ESTADO_PESSOA' then
      Field.DisplayLabel := 'Estado'

    else if Field.FieldName = 'COMPLEMENTO_PESSOA' then
      Field.DisplayLabel := 'Complemento'

    else if Field.FieldName = 'TIPO_PESSOA' then
      Field.DisplayLabel := 'Tipo'

    else if Field.FieldName = 'CLIENTE_PESSOA' then
      Field.DisplayLabel := 'Cliente'

    else if Field.FieldName = 'FORNECEDOR_PESSOA' then
      Field.DisplayLabel := 'Fornecedor'

    else if Field.FieldName = 'DOCUMENTO_PESSOA' then
      Field.DisplayLabel := 'Documento'

    else if Field.FieldName = 'DTCADASTRO_PESSOA' then
      Field.DisplayLabel := 'Data de Cadastro'

    else if Field.FieldName = 'DTALTERACAO_PESSOA' then
      Field.DisplayLabel := 'Última Alteração'

    else if Field.FieldName = 'DOCUMENTO_PESSOA' then
      Field.DisplayLabel := 'Última Alteração'

      {----------------------------------------}

    else if Field.FieldName = 'AREA_PESSOA_TEL' then
      Field.DisplayLabel := 'Área'

    else if Field.FieldName = 'NUMERO_PESSOA_TEL' then
      Field.DisplayLabel := 'Número'

    else if Field.FieldName = 'APARELHO_PESSOA_TEL' then
      Field.DisplayLabel := 'Aparelho'

    else if Field.FieldName = 'DESCRICAO_PESSOA_TEL' then
      Field.DisplayLabel := 'Descrição'
  end;

  inherited;
end;

function TClassPessoa.nomeGenerator: string;
begin
  Result := 'GEN_PESSOA';
end;

function TClassPessoa.nomeTabela: string;
begin
 Result := 'PESSOA';
end;

function TClassPessoa.sqlCadastro: string;
var
  SQL: string;
begin
  SQL :=
    ' select             ' +
    ' CODIGO_PESSOA,     ' +
    ' NOME_PESSOA,       ' +
    ' LOGRADOURO_PESSOA, ' +
    ' SEXO_PESSOA,       ' +
    ' NUMERO_PESSOA,     ' +
    ' MUNICIPIO_PESSOA,  ' +
    ' BAIRRO_PESSOA,     ' +
    ' ESTADO_PESSOA,     ' +
    ' COMPLEMENTO_PESSOA,' +
    ' TIPO_PESSOA,       ' +
    ' CLIENTE_PESSOA,    ' +
    ' FORNECEDOR_PESSOA, ' +
    ' DOCUMENTO_PESSOA,  ' +
    ' DTCADASTRO_PESSOA, ' +
    ' DTALTERACAO_PESSOA ' +
    ' from PESSOA        ' +
    ' where PESSOA.CODIGO_PESSOA =  :CODIGO';

  Result := SQL;
end;

class function TClassPessoa.sqlCadTelefone: string;
var
  SQL: string;
begin
  SQL:=
    ' select                ' +
    ' CODIGO_PESSOA_TEL,    ' +
    ' AREA_PESSOA_TEL,      ' +
    ' NUMERO_PESSOA_TEL,    ' +
    ' APARELHO_PESSOA_TEL,  ' +
    ' DESCRICAO_PESSOA_TEL, ' +
    ' PESSOA_PESSOA_TEL     ' +
    ' from PESSOA_TELEFONE  ' +
    ' where PESSOA_PESSOA_TEL = :CODIGO_PESSOA';

  Result := SQL;
end;

function TClassPessoa.sqlPesquisa: string;
var
  SQL: string;
begin
  SQL :=
    ' select             ' +
    ' CODIGO_PESSOA,     ' +
    ' NOME_PESSOA,       ' +
    ' LOGRADOURO_PESSOA, ' +
    ' SEXO_PESSOA,       ' +
    ' NUMERO_PESSOA,     ' +
    ' MUNICIPIO_PESSOA,  ' +
    ' BAIRRO_PESSOA,     ' +
    ' ESTADO_PESSOA,     ' +
    ' COMPLEMENTO_PESSOA,' +
    ' TIPO_PESSOA,       ' +
    ' CLIENTE_PESSOA,    ' +
    ' FORNECEDOR_PESSOA, ' +
    ' DOCUMENTO_PESSOA,  ' +
    ' DTCADASTRO_PESSOA, ' +
    ' DTALTERACAO_PESSOA ' +
    ' from PESSOA        ' +
    ' where PESSOA.CODIGO_PESSOA > 0';

  Result := SQL;
end;

end.

