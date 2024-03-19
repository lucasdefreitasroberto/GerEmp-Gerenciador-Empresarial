unit untFrmPedidoCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCadastro, Data.DB,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, JvExMask, JvToolEdit,
  JvBaseEdits, Vcl.ExtCtrls, Vcl.DBCtrls, JvMaskEdit, JvDBControls,
  Vcl.Grids, Vcl.DBGrids, UDMPedidoCompra, untFrmPesquisa, UClassPedidoCompra,
  untFrmPedidoCompraQntProduto;

type
  TfrmPedidoCompra = class(TfrmPaiCadastro)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    dbedtNome: TDBEdit;
    DBEdit1: TDBEdit;
    edtCodPessoa: TJvDBCalcEdit;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label6: TLabel;
    GroupBox6: TGroupBox;
    edtMakDTCADASTRO_PESSOA: TJvDBMaskEdit;
    GroupBox5: TGroupBox;
    edtMakDTALTERACAO_PESSOA: TJvDBMaskEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    dbmmoOBS_PDV: TDBMemo;
    TabSheet1: TTabSheet;
    Panel4: TPanel;
    Panel5: TPanel;
    Label15: TLabel;
    GroupBox14: TGroupBox;
    dbgrdProduto: TDBGrid;
    Panel6: TPanel;
    btnNovoProdut: TBitBtn;
    btnApagarProd: TBitBtn;
    dsProduto: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure edtCodPessoaButtonClick(Sender: TObject);
    procedure btnNovoProdutClick(Sender: TObject);
    procedure edtCodPessoaKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnApagarProdClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedidoCompra: TfrmPedidoCompra;

implementation

{$R *.dfm}

{$REGION ' btn Novo Produto '}
procedure TfrmPedidoCompra.btnNovoProdutClick(Sender: TObject);
begin
  FrmPesquisa := TFrmPesquisa.Create(self);

  try
    if (DMPai.CDS.FieldByName('CODIGO_PDC').AsInteger > 0) then
    begin

      FrmPesquisa.ClassPesquisa      := DMPai.ClassPai;
      FrmPesquisa.sqlPesquisa        := TClassPedidoCompra.sqlPesquisaProduto;
      FrmPesquisa.campoChavePesquisa := 'CODIGO_PRODUTO';
      FrmPesquisa.ShowModal;

      begin

        if FrmPesquisa.RetornoConsulta > 0 then
        begin

          if not (dsProduto.DataSet.State in [dsInsert, dsEdit]) then
          begin
            dsProduto.DataSet.Insert;
          end;

          dsProduto.DataSet.FieldByName('PRODUTO_PDC_PRODUTO').AsInteger := FrmPesquisa.RetornoConsulta;

          DMPai.AbreForm(TfrmPedidoCompraQntProduto, frmPedidoCompraQntProduto, 0);

          DMPai.CDS.Post;
        end;

      end;

    end;

  finally

    FreeAndNil(FrmPesquisa);

  end;

  abort;
end;
{$ENDREGION}

{$REGION ' btn Apagar Produto '}
procedure TfrmPedidoCompra.btnApagarProdClick(Sender: TObject);
begin
  inherited;

  if not dsProduto.DataSet.IsEmpty then
  begin
    if MessageDlg('Deseja realmente excluir esse Produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin

      Beep;

      dsProduto.DataSet.Delete;
      DMPai.CDS.Edit;
      DMPai.CDS.Post;

    end;
  end;
end;
{$ENDREGION}

{$REGION ' edtCodPessoa '}
procedure TfrmPedidoCompra.edtCodPessoaButtonClick(Sender: TObject);
begin
  FrmPesquisa := TFrmPesquisa.Create(self);

  try

    FrmPesquisa.ClassPesquisa := DMPai.ClassPai;
    FrmPesquisa.sqlPesquisa := TClassPedidoCompra.sqlCliente;
    FrmPesquisa.campoChavePesquisa := 'CODIGO_PESSOA';
    FrmPesquisa.ShowModal;

    if (edtCodPessoa.AsInteger <> FrmPesquisa.RetornoConsulta) then
    begin
      if FrmPesquisa.RetornoConsulta > 0 then
      begin

        if not (DMPai.CDS.State in [dsInsert, dsEdit]) then
        begin
          DMPai.CDS.Edit;
        end;

        DMPai.CDS.FieldByName('PESSOA_FORNECEDOR_PDC').AsInteger := FrmPesquisa.RetornoConsulta;
        edtCodPessoa.AsInteger := FrmPesquisa.RetornoConsulta;
      end;
    end;

  finally

    FreeAndNil(FrmPesquisa);

  end;

  abort;

end;
{$ENDREGION}

{$REGION ' edtCodPessoaKeyPress '}
procedure TfrmPedidoCompra.edtCodPessoaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := #0;
end;
{$ENDREGION}

{$REGION ' Forms State'}
procedure TfrmPedidoCompra.FormCreate(Sender: TObject);
begin
  DMPai := TDMPedidoCompra.Create(Self);
  inherited;
end;

procedure TfrmPedidoCompra.FormDestroy(Sender: TObject);
begin
  inherited;
  frmPedidoCompra.Free;
end;
{$ENDREGION}

{$REGION ' Register and UnRegister Class '}
initialization
  RegisterClass(TfrmPedidoCompra);

finalization
  UnRegisterClass(TfrmPedidoCompra);
{$ENDREGION}
end.
