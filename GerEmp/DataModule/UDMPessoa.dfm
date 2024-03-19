inherited DMPessoa: TDMPessoa
  OldCreateOrder = True
  Width = 317
  inherited CDS: TClientDataSet
    AfterInsert = CDSAfterInsert
  end
  object dsTelefone: TDataSource
    DataSet = SQLDataSet
    Left = 113
    Top = 24
  end
  object SQLDSTelefone: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 173
    Top = 24
  end
  object cdsTelefone: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = cdsTelefoneAfterOpen
    BeforePost = cdsTelefoneBeforePost
    Left = 173
    Top = 71
  end
end
