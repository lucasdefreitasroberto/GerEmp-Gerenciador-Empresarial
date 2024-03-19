unit untFrmPedidoVendaQntProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.StdCtrls, Vcl.Mask,JvExMask, JvToolEdit,
  JvMaskEdit, JvDBControls, Vcl.Buttons, Vcl.ExtCtrls,
  UDMPedidoVenda;

type
  TfrmPedidoVendaQntProduto = class(TForm)
    Panel4: TPanel;
    Panel5: TPanel;
    Label15: TLabel;
    Panel6: TPanel;
    btnImportar: TBitBtn;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    edtMakDESCRICAO_PESSOA_TEL: TJvDBMaskEdit;
    ds: TDataSource;
    procedure btnImportarClick(Sender: TObject);
    procedure edtMakDESCRICAO_PESSOA_TELKeyPress(Sender: TObject;
      var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedidoVendaQntProduto: TfrmPedidoVendaQntProduto;

implementation

{$R *.dfm}

procedure TfrmPedidoVendaQntProduto.btnImportarClick(Sender: TObject);
begin
  if ds.DataSet.FieldByName('QUANTIDADE_VENDA_PDV_PRODUTO').AsString = EmptyStr then
    raise Exception.Create('Digite uma quantidade');

   if ds.DataSet.FieldByName('QUANTIDADE_VENDA_PDV_PRODUTO').AsInteger = 0 then
    raise Exception.Create('Quantidade não pode ser 0');

  close;
end;

procedure TfrmPedidoVendaQntProduto.edtMakDESCRICAO_PESSOA_TELKeyPress(
  Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9', #8, #13]) then
    Key := #0;
end;

end.
