object DMPai: TDMPai
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 116
  object SQLDataSet: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DMConexao.Conexao
    Left = 34
    Top = 21
  end
  object DataSetProvider: TDataSetProvider
    Left = 34
    Top = 49
  end
  object CDS: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = CDSAfterOpen
    BeforePost = CDSBeforePost
    AfterPost = CDSAfterPost
    AfterCancel = CDSAfterCancel
    AfterDelete = CDSAfterDelete
    OnReconcileError = CDSReconcileError
    Left = 34
    Top = 77
  end
end
