unit UDMProduto;

interface

uses
  System.SysUtils, System.Classes, UDMPai, Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider, Data.DB, Data.SqlExpr, UClassProduto;

type
  TDMProduto = class(TDMPai)
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSBeforePost(DataSet: TDataSet);
    procedure CDSAfterInsert(DataSet: TDataSet);
    procedure CDSAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMProduto: TDMProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMProduto.CDSAfterInsert(DataSet: TDataSet);
begin
  if CDS.State in [dsInsert] then
  begin
    CDS.FieldByName('PRECONORMAL_PRODUTO').AsFloat   := 0;
    CDS.FieldByName('PRECOPROMO_PRODUTO').AsFloat    := 0;
    CDS.FieldByName('PRECOULTCOMP_PRODUTO').AsFloat  := 0;
    CDS.FieldByName('ESTOQUE_PRODUTO').AsFloat       := 0;
    CDS.FieldByName('ESTOQUEXVPN_PRODUTO').AsFloat   := 0;
    CDS.FieldByName('DTCADASTRO_PRODUTO').AsDateTime := Now;
  end;

  inherited;
end;

procedure TDMProduto.CDSAfterOpen(DataSet: TDataSet);
begin
  (CDS.FieldByName('PRECONORMAL_PRODUTO')  as TNumericField).DisplayFormat := '#,##0.00';
  (CDS.FieldByName('PRECOPROMO_PRODUTO')   as TNumericField).DisplayFormat := '#,##0.00';
  (CDS.FieldByName('PRECOULTCOMP_PRODUTO') as TNumericField).DisplayFormat := '#,##0.00';
  (CDS.FieldByName('ESTOQUEXVPN_PRODUTO')  as TNumericField).DisplayFormat := '#,##0.00';

  inherited;
end;

procedure TDMProduto.CDSBeforePost(DataSet: TDataSet);
begin
  DMPai.VerificarCamposVazios(CDS, ['NOME_PRODUTO']);

  if CDS.State in [dsEdit] then
  begin
    CDS.FieldByName('DTALTERACAO_PRODUTO').AsDateTime := Now;
  end;

  if CDS.FieldByName('PRECONORMAL_PRODUTO').AsString = EmptyStr then
    CDS.FieldByName('PRECONORMAL_PRODUTO').AsFloat := 0;

  if CDS.FieldByName('PRECOPROMO_PRODUTO').AsString = EmptyStr then
    CDS.FieldByName('PRECOPROMO_PRODUTO').AsFloat := 0;

  inherited;
end;

procedure TDMProduto.DataModuleCreate(Sender: TObject);
begin
  ClassPai := TClassProduto.Create;
  inherited;
end;

end.

