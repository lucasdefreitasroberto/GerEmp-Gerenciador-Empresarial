unit UClassPedidoCompra;

interface

uses
  Data.DB, UClassPai;

type
  TClassPedidoCompra = class(TclassPai)
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

{ TClassPedidoCompra }

function TClassPedidoCompra.campoChave: string;
begin
  Result := 'CODIGO_PDC';
end;

procedure TClassPedidoCompra.configurarCampo(Fields: TFields);
var
  Field: TField;
begin
  for Field in Fields do
  begin

    if Field.FieldName = 'CODIGO_PDC' then
      Field.DisplayLabel := 'Código'

    else if Field.FieldName = 'OBS_PDC' then
      Field.DisplayLabel := 'Observação'

    else if Field.FieldName = 'NOME_PESSOA' then
      Field.DisplayLabel := 'Nome'

    else if Field.FieldName = 'CODIGO_PESSOA' then
      Field.DisplayLabel := 'Código Cliente'

    else if Field.FieldName = 'SEXO_PESSOA' then
      Field.DisplayLabel := 'Sexo'

    else if Field.FieldName = 'DOCUMENTO_PESSOA' then
      Field.DisplayLabel := 'Documento'

    else if Field.FieldName = 'DTCADASTRO_PDC' then
      Field.DisplayLabel := 'Data de Cadastro'

    else if Field.FieldName = 'DTALTERACAO_PDC' then
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

    else if Field.FieldName = 'QUANTIDADE_COMPRA_PDC_PRODUTO' then
      Field.DisplayLabel := 'Quantidade'

  end;

  inherited;
end;

function TClassPedidoCompra.nomeGenerator: string;
begin
  Result := 'GEN_PEDIDO_COMPRA';
end;

function TClassPedidoCompra.nomeTabela: string;
begin
 Result := 'PEDIDO_COMPRA';
end;

function TClassPedidoCompra.sqlCadastro: string;
var
  SQL: string;
begin
  SQL :=

    ' select CODIGO_PDC,      '+
    ' PESSOA.NOME_PESSOA,     '+
    ' PESSOA.DOCUMENTO_PESSOA,'+
    ' OBS_PDC,                '+
    ' DTCADASTRO_PDC,         '+
    ' DTALTERACAO_PDC,        '+
    ' PESSOA_FORNECEDOR_PDC   '+
    ' from PEDIDO_COMPRA       '+
    ' inner join PESSOA on (PESSOA.CODIGO_PESSOA = PEDIDO_COMPRA.PESSOA_FORNECEDOR_PDC)'+
    ' where PEDIDO_COMPRA.CODIGO_PDC = :CODIGO';

 Result := SQL;
end;

class function TClassPedidoCompra.sqlCliente: string;
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
    ' PESSOA.FORNECEDOR_PESSOA = ''S''';

  Result := SQL;
end;

function TClassPedidoCompra.sqlPesquisa: string;
var
  SQL: string;
begin
  SQL :=

    ' select CODIGO_PDC,      '+
    ' PESSOA.NOME_PESSOA,     '+
    ' PESSOA.DOCUMENTO_PESSOA,'+
    ' OBS_PDC,                '+
    ' DTCADASTRO_PDC,         '+
    ' DTALTERACAO_PDC,        '+
    ' PESSOA_FORNECEDOR_PDC   '+
    ' from PEDIDO_COMPRA       '+
    ' inner join PESSOA on (PESSOA.CODIGO_PESSOA = PEDIDO_COMPRA.PESSOA_FORNECEDOR_PDC)'+
    ' where PEDIDO_COMPRA.CODIGO_PDC > 0';

  Result := SQL;
end;

class function TClassPedidoCompra.sqlPesquisaProduto: string;
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

class function TClassPedidoCompra.sqlProduto: string;
var
  SQL: string;
begin
  SQL:=

    ' select                        '+
    ' CODIGO_PDC_PRODUTO,           '+
    ' PRODUTO.CODIGO_PRODUTO,       '+
    ' PRODUTO.NOME_PRODUTO,         '+
    ' PRODUTO.PRECONORMAL_PRODUTO,  '+
    ' QUANTIDADE_COMPRA_PDC_PRODUTO,'+
    ' PRODUTO_PDC_PRODUTO,          '+
    ' PEDIDO_COMPRA_PDC_PRODUTO     '+
    ' from PEDIDO_COMPRA_PRODUTO    '+
    ' inner join PRODUTO on (PRODUTO.codigo_produto = PEDIDO_COMPRA_PRODUTO.PRODUTO_PDC_PRODUTO)'+
    ' where PEDIDO_COMPRA_PDC_PRODUTO = :CODIGO_PDC';

  Result := SQL;
end;

end.
