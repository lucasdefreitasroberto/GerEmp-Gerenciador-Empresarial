unit UDMPedidoVenda;

interface

uses
  System.SysUtils, System.Classes,
  UDMPai, Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider, Data.DB, Data.SqlExpr,
  UClassPedidoVenda, UDMConexao;

type
  TDMPedidoVenda = class(TDMPai)
    dsProduto: TDataSource;
    SQLDSProduto: TSQLDataSet;
    cdsProduto: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSAfterInsert(DataSet: TDataSet);
    procedure CDSBeforePost(DataSet: TDataSet);
    procedure SQLDataSetAfterOpen(DataSet: TDataSet);
    procedure CDSAfterOpen(DataSet: TDataSet);
    procedure cdsProdutoAfterOpen(DataSet: TDataSet);
    procedure SQLDSProdutoAfterOpen(DataSet: TDataSet);
    procedure cdsProdutoBeforePost(DataSet: TDataSet);
    procedure cdsProdutoBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    procedure OnValidateCliente(Parametro: TField);
    procedure OnValidateProduto(Parametro: TField);
    procedure AtualizaEstoque;
    procedure EstornoEstoque;
  end;

var
  DMPedidoVenda: TDMPedidoVenda;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMPedidoVenda.EstornoEstoque;
var
  SQL: string;
  sqlEstoque, estoque: string;
  EstoqueXVpn: Currency;
begin

  sqlEstoque := ' select ESTOQUE_PRODUTO from PRODUTO where CODIGO_PRODUTO = '+cdsProduto.FieldByName('CODIGO_PRODUTO').AsString;
  estoque := DMConexao.ExecuteScalar(sqlEstoque);
  estoque := IntToStr(estoque.ToInteger + cdsProduto.FieldByName('QUANTIDADE_VENDA_PDV_PRODUTO').AsInteger);

  EstoqueXVpn := (cdsProduto.FieldByName('PRECONORMAL_PRODUTO').AsFloat * estoque.ToInteger);

  SQL:= ' update PRODUTO             '+
        ' set PRECOULTCOMP_PRODUTO = '+ StringReplace( cdsProduto.FieldByName('PRECONORMAL_PRODUTO').AsString, ',', '.', [rfReplaceAll]) +','+
        '     ESTOQUE_PRODUTO =      '+ StringReplace( estoque, ',', '.', [rfReplaceAll]) +','+
        ' ESTOQUEXVPN_PRODUTO =      '+ StringReplace( CurrToStr(EstoqueXVpn), ',', '.', [rfReplaceAll])+
        ' where (CODIGO_PRODUTO = :CODIGO_PRODUTO)';

  DMConexao.ExecuteCommand(SQL, cdsProduto.FieldByName('CODIGO_PRODUTO').AsInteger, 'CODIGO_PRODUTO');
end;

procedure TDMPedidoVenda.AtualizaEstoque;
var
  SQL: string;
  sqlEstoque, estoque: string;
  EstoqueXVpn: Currency;
begin

  sqlEstoque := ' select ESTOQUE_PRODUTO from PRODUTO where CODIGO_PRODUTO = '+cdsProduto.FieldByName('CODIGO_PRODUTO').AsString;
  estoque := DMConexao.ExecuteScalar(sqlEstoque);

  if estoque.ToInteger <= 0 then
  begin
    cdsProduto.Cancel;
    raise Exception.Create('Estoque deste Produto esté Zerado');
  end;


  estoque := IntToStr(estoque.ToInteger - cdsProduto.FieldByName('QUANTIDADE_VENDA_PDV_PRODUTO').AsInteger);

  EstoqueXVpn := (cdsProduto.FieldByName('PRECONORMAL_PRODUTO').AsFloat * estoque.ToInteger);

  SQL:= ' update PRODUTO             '+
        ' set PRECOULTCOMP_PRODUTO = '+ StringReplace( cdsProduto.FieldByName('PRECONORMAL_PRODUTO').AsString, ',', '.', [rfReplaceAll]) +','+
        '     ESTOQUE_PRODUTO =      '+ StringReplace( estoque, ',', '.', [rfReplaceAll]) +','+
        ' ESTOQUEXVPN_PRODUTO =      '+ StringReplace( CurrToStr(EstoqueXVpn), ',', '.', [rfReplaceAll])+
        ' where (CODIGO_PRODUTO = :CODIGO_PRODUTO)';

     DMConexao.ExecuteCommand(SQL, cdsProduto.FieldByName('CODIGO_PRODUTO').AsInteger, 'CODIGO_PRODUTO');
end;

procedure TDMPedidoVenda.CDSAfterInsert(DataSet: TDataSet);
begin

  if CDS.State in [dsInsert] then
  begin
    CDS.FieldByName('DTCADASTRO_PDV').AsDateTime := Now;
  end;
  inherited;
end;

procedure TDMPedidoVenda.CDSAfterOpen(DataSet: TDataSet);
begin
  CDS.FieldByName('PESSOA_CLIENTE_PDV').OnValidate:= OnValidateCliente;
  cdsProduto.DataSetField := TDataSetField(CDS.FieldByName(SQLDSProduto.Name));
  inherited;
end;

procedure TDMPedidoVenda.CDSBeforePost(DataSet: TDataSet);
begin

  DMPai.VerificarCamposVazios(CDS, ['PESSOA_CLIENTE_PDV']);

  if CDS.State in [dsEdit] then
  begin
    CDS.FieldByName('DTALTERACAO_PDV').AsDateTime := Now;
  end;

  inherited;
end;

procedure TDMPedidoVenda.cdsProdutoAfterOpen(DataSet: TDataSet);
begin
  cdsProduto.FieldByName('CODIGO_PDV_PRODUTO').Visible := False;
  cdsProduto.FieldByName('PRODUTO_PDV_PRODUTO').Visible := False;
  cdsProduto.FieldByName('PEDIDO_VENDA_PDV_PRODUTO').Visible := False;

  ClassPai.configurarCampo(cdsProduto.Fields);
  cdsProduto.FieldByName('PRODUTO_PDV_PRODUTO').OnValidate := OnValidateProduto;

  (cdsProduto.FieldByName('PRECONORMAL_PRODUTO') as TNumericField).DisplayFormat := 'R$ ,#,0.00';
end;

procedure TDMPedidoVenda.cdsProdutoBeforeDelete(DataSet: TDataSet);
begin
  EstornoEstoque;
end;

procedure TDMPedidoVenda.cdsProdutoBeforePost(DataSet: TDataSet);
begin

  if cdsProduto.State in [dsInsert] then
  begin
    cdsProduto.FieldByName('CODIGO_PDV_PRODUTO').AsString := DMConexao.GenerateNextCode('GEN_PEDIDO_VENDO_PRODUTO');
    AtualizaEstoque;
  end;
   inherited;
end;

procedure TDMPedidoVenda.DataModuleCreate(Sender: TObject);
begin
  ClassPai := TClassPedidoVenda.Create;

  //DETAIL
  SQLDSProduto.SQLConnection :=  DMConexao.Conexao;
  SQLDSProduto.CommandText   :=  TClassPedidoVenda.sqlProduto;
  criarParametro(SQLDSProduto, 'CODIGO_PDV');
  dsProduto.DataSet := SQLDataSet;
  SQLDSProduto.DataSource:= dsProduto;

  inherited;
end;

procedure TDMPedidoVenda.OnValidateCliente(Parametro: TField);
var
  sqlNomeCliente,
  nomeCliente,
  sqlDocumentoCliente,
  documentoCliente: string;
begin

   sqlNomeCliente :=
                ' select NOME_PESSOA  '+
                '        from PESSOA  '+
                ' where PESSOA.CODIGO_PESSOA = ' + CDS.FieldByName('PESSOA_CLIENTE_PDV').AsString;

   sqlDocumentoCliente :=
                ' select DOCUMENTO_PESSOA  '+
                '        from PESSOA       '+
                ' where PESSOA.CODIGO_PESSOA = ' + CDS.FieldByName('PESSOA_CLIENTE_PDV').AsString;

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


procedure TDMPedidoVenda.OnValidateProduto(Parametro: TField);
var
  sqlNomeProduto,
     NomeProduto: string;

  sqlPrecoProduto,
     PrecoProduto: string;
begin

   sqlNomeProduto :=
                ' select NOME_PRODUTO  '+
                '        from PRODUTO  '+
                ' where PRODUTO.CODIGO_PRODUTO = ' + cdsProduto.FieldByName('PRODUTO_PDV_PRODUTO').AsString;

   sqlPrecoProduto :=
                ' select PRECONORMAL_PRODUTO   '+
                '                from PRODUTO  '+
                ' where PRODUTO.CODIGO_PRODUTO = ' + cdsProduto.FieldByName('PRODUTO_PDV_PRODUTO').AsString;


   NomeProduto  := DMConexao.ExecuteScalar(Format(sqlNomeProduto,  [Parametro.AsInteger] ));
   PrecoProduto := DMConexao.ExecuteScalar(Format(sqlPrecoProduto, [Parametro.AsInteger] ));

  if (NomeProduto <> EmptyStr) then
  begin
    cdsProduto.FieldByName('NOME_PRODUTO').AsString        := NomeProduto;
    cdsProduto.FieldByName('PRECONORMAL_PRODUTO').AsString := PrecoProduto;
    cdsProduto.FieldByName('CODIGO_PRODUTO').AsString      := cdsProduto.FieldByName('PRODUTO_PDV_PRODUTO').AsString;
    cdsProduto.FieldByName('PEDIDO_VENDA_PDV_PRODUTO').AsInteger := CDS.FieldByName('CODIGO_PDV').AsInteger;
  end
  else
    raise Exception.Create('Produto inválida');

end;

procedure TDMPedidoVenda.SQLDataSetAfterOpen(DataSet: TDataSet);
begin

  SQLDataSet.FieldByName('NOME_PESSOA').ProviderFlags        := [];
  SQLDataSet.FieldByName('DOCUMENTO_PESSOA').ProviderFlags   := [];

  inherited;
end;

procedure TDMPedidoVenda.SQLDSProdutoAfterOpen(DataSet: TDataSet);
begin
  SQLDSProduto.FieldByName('CODIGO_PRODUTO').ProviderFlags      := [];
  SQLDSProduto.FieldByName('NOME_PRODUTO').ProviderFlags        := [];
  SQLDSProduto.FieldByName('PRECONORMAL_PRODUTO').ProviderFlags := [];
end;

end.
