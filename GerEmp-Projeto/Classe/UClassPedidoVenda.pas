unit UClassPedidoVenda;

interface

uses
  Data.DB, UClassPai;

type
  TClassPedidoVenda = class(TclassPai)
  public
    procedure configurarCampo(Fields: TFields); override;
    function nomeTabela: string; override;
    function campoChave: string; override;
    function sqlPesquisa: string; override;
    function sqlCadastro: string; override;
    function nomeGenerator: string; override;
    {----------------------------------------}
    class function sqlCliente: string;
    {----------------------------------------}
    class function sqlProduto: string;
    class function sqlPesquisaProduto: string;
  end;

implementation

{ TClassPedidoVenda }

function TClassPedidoVenda.campoChave: string;
begin
  Result := 'CODIGO_PDV';
end;

procedure TClassPedidoVenda.configurarCampo(Fields: TFields);
var
  Field: TField;
begin
  for Field in Fields do
  begin

    if Field.FieldName = 'CODIGO_PDV' then
      Field.DisplayLabel := 'Código'

    else if Field.FieldName = 'OBS_PDV' then
      Field.DisplayLabel := 'Observação'

    else if Field.FieldName = 'NOME_PESSOA' then
      Field.DisplayLabel := 'Nome'

    else if Field.FieldName = 'CODIGO_PESSOA' then
      Field.DisplayLabel := 'Código Cliente'

    else if Field.FieldName = 'SEXO_PESSOA' then
      Field.DisplayLabel := 'Sexo'

    else if Field.FieldName = 'DOCUMENTO_PESSOA' then
      Field.DisplayLabel := 'Documento'

    else if Field.FieldName = 'PVP_PRODUTO_PDV' then
      Field.DisplayLabel := 'Código Produto'

    else if Field.FieldName = 'DTCADASTRO_PDV' then
      Field.DisplayLabel := 'Data de Cadastro'

    else if Field.FieldName = 'DTALTERACAO_PDV' then
      Field.DisplayLabel := 'Última Alteração'

  {------------------------------------------------}
    else if Field.FieldName = 'CODIGO_PRODUTO' then
      Field.DisplayLabel := 'Código do Produto'

    else if Field.FieldName = 'NOME_PRODUTO' then
      Field.DisplayLabel := 'Nome'

    else if Field.FieldName = 'PRECONORMAL_PRODUTO' then
      Field.DisplayLabel := 'Preço Normal'

    else if Field.FieldName = 'PRECOPROMO_PRODUTO' then
      Field.DisplayLabel := 'Preço Promocional'

    else if Field.FieldName = 'QUANTIDADE_VENDA_PDV_PRODUTO' then
      Field.DisplayLabel := 'Quantidade'

  end;

  inherited;
end;

function TClassPedidoVenda.nomeGenerator: string;
begin
  Result := 'GEN_PEDIDO_VENDA';
end;

function TClassPedidoVenda.nomeTabela: string;
begin
  Result := 'PEDIDO_VENDA';
end;

function TClassPedidoVenda.sqlCadastro: string;
var
  SQL: string;
begin
  SQL :=

    ' select CODIGO_PDV,      '+
    ' PESSOA.NOME_PESSOA,     '+
    ' PESSOA.DOCUMENTO_PESSOA,'+
    ' OBS_PDV,                '+
    ' DTCADASTRO_PDV,         '+
    ' DTALTERACAO_PDV,        '+
    ' PESSOA_CLIENTE_PDV      '+
    ' from PEDIDO_VENDA       '+
    ' inner join PESSOA on (PESSOA.CODIGO_PESSOA = PEDIDO_VENDA.PESSOA_CLIENTE_PDV)'+
    ' where PEDIDO_VENDA.CODIGO_PDV = :CODIGO';

 Result := SQL;
end;

class function TClassPedidoVenda.sqlCliente: string;
var
  SQL: string;
begin
  SQL :=

    ' select           '+
    ' CODIGO_PESSOA,   '+
    ' NOME_PESSOA,     '+
    ' SEXO_PESSOA,     '+
    ' DOCUMENTO_PESSOA '+
    ' from PESSOA      '+
    ' where PESSOA.CODIGO_PESSOA > 0 and '+
    ' PESSOA.CLIENTE_PESSOA = ''S''';

  Result := SQL;
end;

function TClassPedidoVenda.sqlPesquisa: string;
var
  SQL: string;
begin
  SQL :=

    ' select CODIGO_PDV,      '+
    ' PESSOA.CODIGO_PESSOA,   '+
    ' PESSOA.NOME_PESSOA,     '+
    ' PESSOA.DOCUMENTO_PESSOA,'+
    ' DTCADASTRO_PDV,         '+
    ' DTALTERACAO_PDV        '+
    ' from PEDIDO_VENDA       '+
    ' inner join PESSOA on (PESSOA.CODIGO_PESSOA = PEDIDO_VENDA.PESSOA_CLIENTE_PDV)'+
    ' where PEDIDO_VENDA.CODIGO_PDV > 0';

  Result := SQL;
end;

class function TClassPedidoVenda.sqlPesquisaProduto: string;
var
  SQL: string;
begin
  SQL :=
    ' select                '+
    ' CODIGO_PRODUTO,       '+
    ' NOME_PRODUTO,         '+
    ' PRECONORMAL_PRODUTO,  '+
    ' PRECOPROMO_PRODUTO   '+
    ' from PRODUTO          '+
    ' where produto.codigo_produto > 0';

  Result := SQL;
end;

class function TClassPedidoVenda.sqlProduto: string;
var
  SQL: string;
begin
  SQL:=

    ' select                        '+
    ' CODIGO_PDV_PRODUTO,           '+
    ' PRODUTO.CODIGO_PRODUTO,       '+
    ' PRODUTO.NOME_PRODUTO,         '+
    ' PRODUTO.PRECONORMAL_PRODUTO,  '+
    ' QUANTIDADE_VENDA_PDV_PRODUTO, '+
    ' PRODUTO_PDV_PRODUTO,          '+
    ' PEDIDO_VENDA_PDV_PRODUTO      '+
    ' from PEDIDO_VENDA_PRODUTO     '+
    ' inner join PRODUTO on (PRODUTO.codigo_produto = PEDIDO_VENDA_PRODUTO.produto_pdv_produto)'+
    ' where pedido_venda_pdv_produto = :CODIGO_PDV';

  Result := SQL;
end;
end.
