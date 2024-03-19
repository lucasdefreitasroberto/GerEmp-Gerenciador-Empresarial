unit untFrmPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCadastro,
  Data.DB, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, JvExMask, JvToolEdit,
  JvBaseEdits, Vcl.ExtCtrls, UDMPedidoVenda,
   JvMaskEdit, JvDBControls,
  Vcl.DBCtrls, untFrmPesquisa, UClassPedidoVenda,
  Vcl.Grids, Vcl.DBGrids, untFrmPedidoVendaQntProduto;

type
  TfrmPedidoVenda = class(TfrmPaiCadastro)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    dbedtNome: TDBEdit;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label6: TLabel;
    GroupBox6: TGroupBox;
    edtMakDTCADASTRO_PESSOA: TJvDBMaskEdit;
    GroupBox5: TGroupBox;
    edtMakDTALTERACAO_PESSOA: TJvDBMaskEdit;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    dbmmoOBS_PDV: TDBMemo;
    TabSheet1: TTabSheet;
    edtCodPessoa: TJvDBCalcEdit;
    Panel4: TPanel;
    Panel5: TPanel;
    Label15: TLabel;
    GroupBox14: TGroupBox;
    dbgrdProduto: TDBGrid;
    Panel6: TPanel;
    btnNovoProd: TBitBtn;
    btnApagarProd: TBitBtn;
    dsProduto: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodPessoaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPessoaButtonClick(Sender: TObject);
    procedure btnNovoProdClick(Sender: TObject);
    procedure btnApagarProdClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;

implementation

{$R *.dfm}



procedure TfrmPedidoVenda.btnApagarProdClick(Sender: TObject);
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

procedure TfrmPedidoVenda.btnNovoProdClick(Sender: TObject);
var
  qnt: string;
begin
  FrmPesquisa := TFrmPesquisa.Create(self);

  try
    if (DMPai.CDS.FieldByName('CODIGO_PDV').AsInteger > 0) then
    begin

      FrmPesquisa.ClassPesquisa      := DMPai.ClassPai;
      FrmPesquisa.sqlPesquisa        := TClassPedidoVenda.sqlPesquisaProduto;
      FrmPesquisa.campoChavePesquisa := 'CODIGO_PRODUTO';
      FrmPesquisa.ShowModal;

      begin

        if FrmPesquisa.RetornoConsulta > 0 then
        begin        
                  
          if not (dsProduto.DataSet.State in [dsInsert, dsEdit]) then
          begin
            dsProduto.DataSet.Insert;
          end;

          dsProduto.DataSet.FieldByName('PRODUTO_PDV_PRODUTO').AsInteger := FrmPesquisa.RetornoConsulta;

         DMPai.AbreForm(TfrmPedidoVendaQntProduto, frmPedidoVendaQntProduto, 0);
//          qnt := InputBox('Produto', 'Quantidade :', '1');
//          if qnt = '' then
//            qnt := '1';

//        dsProduto.DataSet.FieldByName('QUANTIDADE_VENDA_PDV_PRODUTO').AsInteger :=  qnt.ToInteger;
          DMPai.CDS.Post;
        end;

      end;

    end;

  finally

    FreeAndNil(FrmPesquisa);

  end;

  abort;
end;

procedure TfrmPedidoVenda.edtCodPessoaButtonClick(Sender: TObject);
begin

  FrmPesquisa := TFrmPesquisa.Create(self);

  try

    FrmPesquisa.ClassPesquisa      := DMPai.ClassPai;
    FrmPesquisa.sqlPesquisa        := TClassPedidoVenda.sqlCliente;
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

        DMPai.CDS.FieldByName('PESSOA_CLIENTE_PDV').AsInteger := FrmPesquisa.RetornoConsulta;
        edtCodPessoa.AsInteger := FrmPesquisa.RetornoConsulta;
      end;
    end;

  finally

    FreeAndNil(FrmPesquisa);

  end;

  abort;

end;

procedure TfrmPedidoVenda.edtCodPessoaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := #0;
end;

procedure TfrmPedidoVenda.FormCreate(Sender: TObject);
begin
   DMPai := TDMPedidoVenda.Create(Self);
  inherited;
end;

procedure TfrmPedidoVenda.FormDestroy(Sender: TObject);
begin
  inherited;
  frmPedidoVenda.Free;
end;

{$REGION ' Register and UnRegister Class '}
initialization
  RegisterClass(TfrmPedidoVenda);

finalization
  UnRegisterClass(TfrmPedidoVenda);
{$ENDREGION}

end.
