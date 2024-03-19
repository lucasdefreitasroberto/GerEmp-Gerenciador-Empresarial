program GenEmp;
uses
  Vcl.Forms,
  untFrmMenuPrincipal in 'Units\untFrmMenuPrincipal.pas' {frmMenuPrincipal},
  UDMConexao in 'DataModule\UDMConexao.pas' {DMConexao: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  untFrmLogin in 'Units\untFrmLogin.pas' {frmLogin},
  untPaiCadastro in 'Units\untPaiCadastro.pas' {frmPaiCadastro},
  UDMPai in 'DataModule\UDMPai.pas' {DMPai: TDataModule},
  UClassPai in 'Classe\UClassPai.pas',
  untFrmPesquisa in 'Units\untFrmPesquisa.pas' {FrmPesquisa},
  untFrmUsuarios in 'Units\untFrmUsuarios.pas' {frmUsuarios},
  UDMUsuarios in 'DataModule\UDMUsuarios.pas' {DMUsuarios: TDataModule},
  UClassUsuarios in 'Classe\UClassUsuarios.pas',
  untFrmPessoa in 'Units\untFrmPessoa.pas' {frmPessoa},
  UDMPessoa in 'DataModule\UDMPessoa.pas' {DMPessoa: TDataModule},
  UClassPessoa in 'Classe\UClassPessoa.pas',
  untFrmPessoaTelefone in 'Units\untFrmPessoaTelefone.pas' {frmPessoaTelefone},
  untFrmProduto in 'Units\untFrmProduto.pas' {frmProduto},
  UDMProduto in 'DataModule\UDMProduto.pas' {DMProduto: TDataModule},
  UClassProduto in 'Classe\UClassProduto.pas',
  untFrmPedidoVenda in 'Units\untFrmPedidoVenda.pas' {frmPedidoVenda},
  UDMPedidoVenda in 'DataModule\UDMPedidoVenda.pas' {DMPedidoVenda: TDataModule},
  UClassPedidoVenda in 'Classe\UClassPedidoVenda.pas',
  untFrmPedidoVendaQntProduto in 'Units\untFrmPedidoVendaQntProduto.pas' {frmPedidoVendaQntProduto},
  untFrmPedidoCompra in 'Units\untFrmPedidoCompra.pas' {frmPedidoCompra},
  UDMPedidoCompra in 'DataModule\UDMPedidoCompra.pas' {DMPedidoCompra: TDataModule},
  UClassPedidoCompra in 'Classe\UClassPedidoCompra.pas',
  untFrmPedidoCompraQntProduto in 'Units\untFrmPedidoCompraQntProduto.pas' {frmPedidoCompraQntProduto};

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
