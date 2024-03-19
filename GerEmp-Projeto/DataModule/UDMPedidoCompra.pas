unit UDMPedidoCompra;

interface

uses
  System.SysUtils, System.Classes, UDMPai,
  Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider, Data.DB,
  Data.SqlExpr, UClassPedidoCompra, UDMConexao;

type
  TDMPedidoCompra = class(TDMPai)
    dsProduto: TDataSource;
    SQLDSProduto: TSQLDataSet;
    cdsProduto: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSAfterInsert(DataSet: TDataSet);
    procedure CDSAfterOpen(DataSet: TDataSet);
    procedure CDSBeforePost(DataSet: TDataSet);
    procedure cdsProdutoAfterOpen(DataSet: TDataSet);
    procedure cdsProdutoBeforePost(DataSet: TDataSet);
    procedure cdsProdutoBeforeDelete(DataSet: TDataSet);
    procedure SQLDSProdutoAfterOpen(DataSet: TDataSet);
    procedure SQLDataSetAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    procedure OnValidateCliente(Parametro: TField);
    procedure OnValidateProduto(Parametro: TField);
    procedure AtualizaEstoque;
    procedure EstornoEstoque;
  end;

var
  DMPedidoCompra: TDMPedidoCompra;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMPedidoCompra.AtualizaEstoque;
var
  SQL: string;
  sqlEstoque, estoque: string;
  EstoqueXVpn: Currency;
begin

  sqlEstoque := ' select ESTOQUE_PRODUTO from PRODUTO where CODIGO_PRODUTO = '+cdsProduto.FieldByName('CODIGO_PRODUTO').AsString;
  estoque := DMConexao.ExecuteScalar(sqlEstoque);

  estoque := IntToStr(estoque.ToInteger + cdsProduto.FieldByName('QUANTIDADE_COMPRA_PDC_PRODUTO').AsInteger);

  EstoqueXVpn := (cdsProduto.FieldByName('PRECONORMAL_PRODUTO').AsFloat * estoque.ToInteger);

  SQL:= ' update PRODUTO             '+
        ' set PRECOULTCOMP_PRODUTO = '+ StringReplace( cdsProduto.FieldByName('PRECONORMAL_PRODUTO').AsString, ',', '.', [rfReplaceAll]) +','+
        '     ESTOQUE_PRODUTO =      '+ StringReplace( estoque, ',', '.', [rfReplaceAll]) +','+
        ' ESTOQUEXVPN_PRODUTO =      '+ StringReplace( CurrToStr(EstoqueXVpn), ',', '.', [rfReplaceAll])+
        ' where (CODIGO_PRODUTO = :CODIGO_PRODUTO)';

     DMConexao.ExecuteCommand(SQL, cdsProduto.FieldByName('CODIGO_PRODUTO').AsInteger, 'CODIGO_PRODUTO');
end;

procedure TDMPedidoCompra.EstornoEstoque;
var
  SQL: string;
  sqlEstoque, estoque: string;
  EstoqueXVpn: Currency;
begin

  sqlEstoque := ' select ESTOQUE_PRODUTO from PRODUTO where CODIGO_PRODUTO = '+cdsProduto.FieldByName('CODIGO_PRODUTO').AsString;
  estoque := DMConexao.ExecuteScalar(sqlEstoque);
  estoque := IntToStr(estoque.ToInteger - cdsProduto.FieldByName('QUANTIDADE_COMPRA_PDC_PRODUTO').AsInteger);

  EstoqueXVpn := (cdsProduto.FieldByName('PRECONORMAL_PRODUTO').AsFloat * estoque.ToInteger);

  SQL:= ' update PRODUTO             '+
        ' set PRECOULTCOMP_PRODUTO = '+ StringReplace( cdsProduto.FieldByName('PRECONORMAL_PRODUTO').AsString, ',', '.', [rfReplaceAll]) +','+
        '     ESTOQUE_PRODUTO =      '+ StringReplace( estoque, ',', '.', [rfReplaceAll]) +','+
        ' ESTOQUEXVPN_PRODUTO =      '+ StringReplace( CurrToStr(EstoqueXVpn), ',', '.', [rfReplaceAll])+
        ' where (CODIGO_PRODUTO = :CODIGO_PRODUTO)';

  DMConexao.ExecuteCommand(SQL, cdsProduto.FieldByName('CODIGO_PRODUTO').AsInteger, 'CODIGO_PRODUTO');
end;

procedure TDMPedidoCompra.CDSAfterInsert(DataSet: TDataSet);
begin
  if CDS.State in [dsInsert] then
  begin
    CDS.FieldByName('DTCADASTRO_PDC').AsDateTime := Now;
  end;
  inherited;
end;

procedure TDMPedidoCompra.CDSAfterOpen(DataSet: TDataSet);
begin
  CDS.FieldByName('PESSOA_FORNECEDOR_PDC').OnValidate:= OnValidateCliente;
  cdsProduto.DataSetField := TDataSetField(CDS.FieldByName(SQLDSProduto.Name));
  inherited;
end;

procedure TDMPedidoCompra.CDSBeforePost(DataSet: TDataSet);
begin
  DMPai.VerificarCamposVazios(CDS, ['PESSOA_FORNECEDOR_PDC']);

  if CDS.State in [dsEdit] then
  begin
    CDS.FieldByName('DTALTERACAO_PDC').AsDateTime := Now;
  end;

  inherited;
end;

procedure TDMPedidoCompra.cdsProdutoAfterOpen(DataSet: TDataSet);
begin
  cdsProduto.FieldByName('CODIGO_PDC_PRODUTO').Visible := False;
  cdsProduto.FieldByName('PRODUTO_PDC_PRODUTO').Visible := False;
  cdsProduto.FieldByName('PEDIDO_COMPRA_PDC_PRODUTO').Visible := False;

  ClassPai.configurarCampo(cdsProduto.Fields);
  cdsProduto.FieldByName('PRODUTO_PDC_PRODUTO').OnValidate := OnValidateProduto;

  (cdsProduto.FieldByName('PRECONORMAL_PRODUTO') as TNumericField).DisplayFormat := 'R$ ,#,0.00';

end;

procedure TDMPedidoCompra.cdsProdutoBeforeDelete(DataSet: TDataSet);
begin
   EstornoEstoque;
end;

procedure TDMPedidoCompra.cdsProdutoBeforePost(DataSet: TDataSet);
begin
  if cdsProduto.State in [dsInsert] then
  begin
    cdsProduto.FieldByName('CODIGO_PDC_PRODUTO').AsString := DMConexao.GenerateNextCode('GEN_PEDIDO_COMPRA_PRODUTO');
    AtualizaEstoque;
  end;
   inherited;
end;

procedure TDMPedidoCompra.DataModuleCreate(Sender: TObject);
begin
  ClassPai := TClassPedidoCompra.Create;

  //DETAIL
  SQLDSProduto.SQLConnection :=  DMConexao.Conexao;
  SQLDSProduto.CommandText   :=  TClassPedidoCompra.sqlProduto;
  criarParametro(SQLDSProduto, 'CODIGO_PDC');
  dsProduto.DataSet := SQLDataSet;
  SQLDSProduto.DataSource:= dsProduto;
  inherited;
end;

procedure TDMPedidoCompra.OnValidateCliente(Parametro: TField);
var
  sqlNomeCliente,
  nomeCliente,
  sqlDocumentoCliente,
  documentoCliente: string;
begin

   sqlNomeCliente :=
                ' select NOME_PESSOA  '+
                '        from PESSOA  '+
                ' where PESSOA.CODIGO_PESSOA = ' + CDS.FieldByName('PESSOA_FORNECEDOR_PDC').AsString;

   sqlDocumentoCliente :=
                ' select DOCUMENTO_PESSOA  '+
                '        from PESSOA       '+
                ' where PESSOA.CODIGO_PESSOA = ' + CDS.FieldByName('PESSOA_FORNECEDOR_PDC').AsString;

   nomeCliente      := DMConexao.ExecuteScalar(Format(sqlNomeCliente,         [Parametro.AsInteger] ));
   documentoCliente := DMConexao.ExecuteScalar(Format(sqlDocumentoCliente,    [Parametro.AsInteger] ));


  if (nomeCliente <> EmptyStr) then
  begin
    CDS.FieldByName('NOME_PESSOA').AsString       := nomeCliente;
    CDS.FieldByName('DOCUMENTO_PESSOA').AsString  := documentoCliente;
  end
  else
    raise Exception.Create('Pessoa inválida');

end;

procedure TDMPedidoCompra.OnValidateProduto(Parametro: TField);
var
  sqlNomeProduto,
     NomeProduto: string;

  sqlPrecoProduto,
     PrecoProduto: string;
begin

   sqlNomeProduto :=
                ' select NOME_PRODUTO  '+
                '        from PRODUTO  '+
                ' where PRODUTO.CODIGO_PRODUTO = ' + cdsProduto.FieldByName('PRODUTO_PDC_PRODUTO').AsString;

   sqlPrecoProduto :=
                ' select PRECONORMAL_PRODUTO   '+
                '                from PRODUTO  '+
                ' where PRODUTO.CODIGO_PRODUTO = ' + cdsProduto.FieldByName('PRODUTO_PDC_PRODUTO').AsString;


   NomeProduto  := DMConexao.ExecuteScalar(Format(sqlNomeProduto,  [Parametro.AsInteger] ));
   PrecoProduto := DMConexao.ExecuteScalar(Format(sqlPrecoProduto, [Parametro.AsInteger] ));

  if (NomeProduto <> EmptyStr) then
  begin
    cdsProduto.FieldByName('NOME_PRODUTO').AsString        := NomeProduto;
    cdsProduto.FieldByName('PRECONORMAL_PRODUTO').AsString := PrecoProduto;
    cdsProduto.FieldByName('CODIGO_PRODUTO').AsString      := cdsProduto.FieldByName('PRODUTO_PDC_PRODUTO').AsString;
    cdsProduto.FieldByName('PEDIDO_COMPRA_PDC_PRODUTO').AsInteger := CDS.FieldByName('CODIGO_PDC').AsInteger;
  end
  else
    raise Exception.Create('Produto inválida');

end;

procedure TDMPedidoCompra.SQLDataSetAfterOpen(DataSet: TDataSet);
begin
  SQLDataSet.FieldByName('NOME_PESSOA').ProviderFlags        := [];
  SQLDataSet.FieldByName('DOCUMENTO_PESSOA').ProviderFlags   := [];

  inherited;
end;

procedure TDMPedidoCompra.SQLDSProdutoAfterOpen(DataSet: TDataSet);
begin
  SQLDSProduto.FieldByName('CODIGO_PRODUTO').ProviderFlags      := [];
  SQLDSProduto.FieldByName('NOME_PRODUTO').ProviderFlags        := [];
  SQLDSProduto.FieldByName('PRECONORMAL_PRODUTO').ProviderFlags := [];
end;

end.
