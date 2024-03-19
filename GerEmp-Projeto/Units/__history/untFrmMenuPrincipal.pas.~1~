unit untFrmMenuPrincipal;

interface

uses
  SysUtils, StrUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Buttons, Vcl.ExtCtrls, Vcl.Menus, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.Themes, Vcl.Styles, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.OleCtrls, SHDocVw, View.WebCharts, Data.DB,
  Charts.Types, Datasnap.DBClient, acPNG;

type
  TfrmMenuPrincipal = class(TForm)
    pnlMenu: TPanel;
    pnlMenuCategoria1: TPanel;
    btnMenuCategoria1: TSpeedButton;
    pnlMenuCategoria2: TPanel;
    btnMenuCategoria2: TSpeedButton;
    pnlMenuCategoria5: TPanel;
    btnMenuCategoria5: TSpeedButton;
    pnlSubMenuCategoria1: TPanel;
    btnPessoa: TSpeedButton;
    btnProduto: TSpeedButton;
    btnUsuarios: TSpeedButton;
    pnlSubMenuCategoria2: TPanel;
    btnPedidoCompra: TSpeedButton;
    btnPedidoVenda: TSpeedButton;
    pnlTitulo: TPanel;
    imgMenu: TImage;
    pnlMenuCategoria4: TPanel;
    btnMenuCategoria4: TSpeedButton;
    pnlMenuCategoria3: TPanel;
    btnMenuCategoria3: TSpeedButton;
    pnlCentral: TPanel;
    procedure abrirSubMenu(Sender: TObject);
    procedure abrirFormulario(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMenuCategoria5Click(Sender: TObject);

  private
    FormularioAtual: TForm;
    procedure SpeedButton1MouseLeave(Sender: TObject);
    procedure SpeedButton1MouseMovePreto(Sender: TObject; Shift: TShiftState; X, Y: Integer);

  public

  end;

var
  frmMenuPrincipal: TfrmMenuPrincipal;

implementation
{$R *.dfm}

{$REGION ' AbrirFormulario '}
procedure TfrmMenuPrincipal.AbrirFormulario(Sender: TObject);
var
  Formulario: TForm;
  FormularioClasse: TFormClass;
  NomeFormulario: string;
begin

  NomeFormulario := StringReplace(TSpeedButton(Sender).Name, 'btn', 'Tfrm', [rfReplaceAll]);


  if Assigned(FormularioAtual) then
  begin
    FormularioAtual.Close;
    FormularioAtual.Free;

  end;

  try
    FormularioClasse := TFormClass(FindClass(NomeFormulario));
    if Assigned(FormularioClasse) then
    begin
      Formulario := FormularioClasse.Create(Application);
      Formulario.Parent := pnlCentral;
      Formulario.Align := alClient;
      Formulario.Show;
      FormularioAtual := Formulario;
    end
    else
      raise Exception.CreateFmt('Classe %s não encontrada.', [NomeFormulario]);
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao abrir o formulário: ' + E.Message);
    end;
  end;
end;
{$ENDREGION}

{$REGION ' abrirSubMenu '}
procedure TfrmMenuPrincipal.abrirSubMenu(Sender: TObject);
var
  NomePanelMenu, NomePanelSubMenu: string;
  i, dimensao: Integer;
begin

  NomePanelMenu := StringReplace(TSpeedButton(Sender).Name, 'btn', 'pnl', [rfReplaceAll]);
  NomePanelSubMenu := StringReplace(TSpeedButton(Sender).Name, 'btn', 'pnlSub', [rfReplaceAll]);
  dimensao := 33;

  for i := ComponentCount - 1 downto 0 do
  begin

    if (Copy(TPanel(Components[i]).Name, 1, 7) = 'pnlMenu') and (TPanel(Components[i]).Height <> 33) and (TPanel(Components[i]).Name <> NomePanelMenu) then
      TPanel(Components[i]).Height := 33;

    if Components[i].GetParentComponent = TPanel(FindComponent(NomePanelSubMenu)) then
    begin
      dimensao := dimensao + 33;
    end;

  end;

  if TPanel(FindComponent(NomePanelMenu)).Height = 33 then
  begin
    TPanel(FindComponent(NomePanelMenu)).Height := dimensao;
  end else
  begin
    TPanel(FindComponent(NomePanelMenu)).Height := 33;
  end;

end;
{$ENDREGION}

{$REGION ' FormCreate '}
procedure TfrmMenuPrincipal.FormCreate(Sender: TObject);
begin

  for var i := 0 to ComponentCount - 1 do
  begin

    if Components[i] is TSpeedButton then
    begin
      TSpeedButton(Components[i]).OnMouseLeave := SpeedButton1MouseLeave;
      TSpeedButton(Components[i]).OnMouseMove := SpeedButton1MouseMovePreto;
    end;
  end;

end;
{$ENDREGION}

{$Region ' status buttons '}
procedure TfrmMenuPrincipal.SpeedButton1MouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).font.Color := clBtnFace;
end;

procedure TfrmMenuPrincipal.SpeedButton1MouseMovePreto(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  TSpeedButton(Sender).Font.Color := clBlack;
end;

procedure TfrmMenuPrincipal.btnMenuCategoria5Click(Sender: TObject);
begin
  if MessageDlg('Sair do sistema ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Application.Terminate;
  end;
end;
{$ENDREGION}

end.

