inherited DMPedidoCompra: TDMPedidoCompra
  OldCreateOrder = True
  Height = 146
  Width = 251
  inherited SQLDataSet: TSQLDataSet
    AfterOpen = SQLDataSetAfterOpen
  end
  inherited CDS: TClientDataSet
    AfterInsert = CDSAfterInsert
  end
  object dsProduto: TDataSource
    DataSet = SQLDataSet
    Left = 113
    Top = 24
  end
  object SQLDSProduto: TSQLDataSet
    AfterOpen = SQLDSProdutoAfterOpen
    MaxBlobSize = -1
    Params = <>
    Left = 173
    Top = 24
  end
  object cdsProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = cdsProdutoAfterOpen
    BeforePost = cdsProdutoBeforePost
    BeforeDelete = cdsProdutoBeforeDelete
    Left = 173
    Top = 71
  end
end
