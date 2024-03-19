unit UClassProduto;

interface

uses
  Data.DB, UClassPai;

type
  TClassProduto = class(TClassPai)

  public
    procedure configurarCampo(Fields: TFields); override;
    function nomeTabela: string; override;
    function campoChave: string; override;
    function sqlCadastro: string; override;
    function sqlPesquisa: string; override;
    function nomeGenerator: string; override;
  end;

implementation

{ TClassProduto }

function TClassProduto.campoChave: string;
begin
  Result := 'CODIGO_PRODUTO';
end;

procedure TClassProduto.configurarCampo(Fields: TFields);
var
  Field: TField;
begin
  for Field in Fields do
  begin

    if Field.FieldName = 'CODIGO_PRODUTO' then
      Field.DisplayLabel := 'Código'

    else if Field.FieldName = 'NOME_PRODUTO' then
      Field.DisplayLabel := 'Nome'

    else if Field.FieldName = 'PRECONORMAL_PRODUTO' then
      Field.DisplayLabel := 'Preço Normal'

    else if Field.FieldName = 'PRECOPROMO_PRODUTO' then
      Field.DisplayLabel := 'Preço Promocional'

    else if Field.FieldName = 'PRECOULTCOMP_PRODUTO' then
      Field.DisplayLabel := 'Preço da Última Compra'

    else if Field.FieldName = 'ESTOQUE_PRODUTO' then
      Field.DisplayLabel := 'Estoque'

    else if Field.FieldName = 'ESTOQUEXVPN_PRODUTO' then
      Field.DisplayLabel := 'Estoque [x] VPN'

    else if Field.FieldName = 'DTCADASTRO_PRODUTO' then
      Field.DisplayLabel := 'Última Alteração'

    else if Field.FieldName = 'DTALTERACAO_PRODUTO' then
      Field.DisplayLabel := 'Última Alteração'

  end;

  inherited;
end;

function TClassProduto.nomeGenerator: string;
begin
  Result := 'GEN_PRODUTO';
end;

function TClassProduto.nomeTabela: string;
begin
  Result := 'PRODUTO';
end;

function TClassProduto.sqlCadastro: string;
var
  SQL: string;
begin
  SQL :=
    ' select                '+
    ' CODIGO_PRODUTO,       '+
    ' NOME_PRODUTO,         '+
    ' PRECONORMAL_PRODUTO,  '+
    ' PRECOPROMO_PRODUTO,   '+
    ' PRECOULTCOMP_PRODUTO, '+
    ' ESTOQUE_PRODUTO,      '+
    ' ESTOQUEXVPN_PRODUTO,  '+
    ' DTCADASTRO_PRODUTO,   '+
    ' DTALTERACAO_PRODUTO   '+
    ' from PRODUTO          '+
    ' where produto.codigo_produto = :CODIGO ';

  Result := SQL;
end;

function TClassProduto.sqlPesquisa: string;
var
  SQL: string;
begin
  SQL :=
    ' select                '+
    ' CODIGO_PRODUTO,       '+
    ' NOME_PRODUTO,         '+
    ' PRECONORMAL_PRODUTO,  '+
    ' PRECOPROMO_PRODUTO,   '+
    ' PRECOULTCOMP_PRODUTO, '+
    ' ESTOQUE_PRODUTO,      '+
    ' ESTOQUEXVPN_PRODUTO,  '+
    ' DTCADASTRO_PRODUTO,   '+
    ' DTALTERACAO_PRODUTO   '+
    ' from PRODUTO          '+
    ' where produto.codigo_produto > 0';

  Result := SQL;
end;

end.
