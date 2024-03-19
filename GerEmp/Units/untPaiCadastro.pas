unit untPaiCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, JvExMask,
  JvToolEdit, JvBaseEdits, Vcl.ComCtrls,
  Data.DB, UDMPai, untFrmPesquisa;

type
  TfrmPaiCadastro = class(TForm)
    pnlPrincipal: TPanel;
    Shape1: TShape;
    pnlCentro: TPanel;
    Panel3: TPanel;
    btnFechar: TSpeedButton;
    pnlheader: TPanel;
    lblCod: TLabel;
    edtPesquisarCod: TJvCalcEdit;
    pnlNavegar: TPanel;
    BttPrimeiro: TSpeedButton;
    BttAnterior: TSpeedButton;
    BttProximo: TSpeedButton;
    BttUltimo: TSpeedButton;
    pnlBotoes: TPanel;
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnApagar: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    pnlBotoesExtras: TPanel;
    pgcPrincipal: TPageControl;
    tsPesquisa: TTabSheet;
    DS: TDataSource;
    procedure btnFecharClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPesquisarCodExit(Sender: TObject);
    procedure DSDataChange(Sender: TObject; Field: TField);
    procedure BttPrimeiroClick(Sender: TObject);
    procedure BttAnteriorClick(Sender: TObject);
    procedure BttProximoClick(Sender: TObject);
    procedure BttUltimoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisarCodButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FDMPai: TDMPai;

  public
      property DMPai: TDMPai read FDMPai write FDMPai;
  end;

var
  frmPaiCadastro: TfrmPaiCadastro;

implementation

{$R *.dfm}

{$REGION ' State Interaction Buttons '}
procedure TfrmPaiCadastro.btnApagarClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir o registro?', mtConfirmation, [mbyes, mbno], 0) = mryes then
  begin

    try
      DS.DataSet.Delete;
    except
      raise Exception.Create('Error ao Excluir Registro');
    end;

  end;

  edtPesquisarCod.AsInteger := DMPai.CDS.Fields[0].AsInteger;
end;

procedure TfrmPaiCadastro.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja cancelar o registro?', mtConfirmation, [mbyes, mbno], 0) = mryes then
  begin
    DS.DataSet.Cancel;
  end;

  edtPesquisarCod.AsInteger := DMPai.CDS.Fields[0].AsInteger;
end;

procedure TfrmPaiCadastro.btnGravarClick(Sender: TObject);
begin
  DS.DataSet.Post;
  edtPesquisarCod.AsInteger := DMPai.CDS.Fields[0].AsInteger;
end;

procedure TfrmPaiCadastro.btnNovoClick(Sender: TObject);
begin
  DS.DataSet.Insert;
  edtPesquisarCod.AsInteger := DMPai.CDS.Fields[0].AsInteger;
end;

procedure TfrmPaiCadastro.btnFecharClick(Sender: TObject);
begin
  Close;
end;
{$ENDREGION}

{$REGION ' State Navigation Buttons '}
procedure TfrmPaiCadastro.BttAnteriorClick(Sender: TObject);
begin
  DMPai.RegistroAnterior;
  edtPesquisarCod.AsInteger := DMPai.CDS.Fields[0].AsInteger;
end;

procedure TfrmPaiCadastro.BttPrimeiroClick(Sender: TObject);
begin
  DMPai.PrimeiroRegistro;
  edtPesquisarCod.AsInteger := DMPai.CDS.Fields[0].AsInteger;
end;

procedure TfrmPaiCadastro.BttProximoClick(Sender: TObject);
begin
  DMPai.ProximoRegistro;
  edtPesquisarCod.AsInteger := DMPai.CDS.Fields[0].AsInteger;
end;

procedure TfrmPaiCadastro.BttUltimoClick(Sender: TObject);
begin
  DMPai.UltimoRegistro;
  edtPesquisarCod.AsInteger := DMPai.CDS.Fields[0].AsInteger;
end;
{$ENDREGION}

{$REGION ' State DataSource '}

procedure TfrmPaiCadastro.DSDataChange(Sender: TObject; Field: TField);
var
  StatusBtn: Boolean;
begin
  StatusBtn := DS.State in [dsInsert, dsEdit];

  btnNovo.Enabled := not StatusBtn;
  btnApagar.Enabled := not StatusBtn;
  btnCancelar.Enabled := StatusBtn;
  btnGravar.Enabled := StatusBtn;
end;
{$ENDREGION}

{$REGION ' State Search field'}
procedure TfrmPaiCadastro.edtPesquisarCodButtonClick(Sender: TObject);
var
  cod: Integer;
begin

  cod := DMPai.CDS.FieldByName(DMPai.ClassPai.campoChave).AsInteger;
  FrmPesquisa := TFrmPesquisa.Create(self);

  try
    FrmPesquisa.ClassPesquisa      := DMPai.ClassPai;
    FrmPesquisa.sqlPesquisa        := DMPai.ClassPai.sqlPesquisa;
    FrmPesquisa.campoChavePesquisa := DMPai.ClassPai.campoChave;
    FrmPesquisa.ShowModal;

    if FrmPesquisa.RetornoConsulta > 0 then
    begin
      edtPesquisarCod.AsInteger := FrmPesquisa.RetornoConsulta;
      DMPai.AbrirRegistro(edtPesquisarCod.AsInteger);
    end
    else
    begin
      edtPesquisarCod.AsInteger := cod;
      DMPai.AbrirRegistro(cod);
    end;

  finally
    FreeAndNil(FrmPesquisa);
  end;

  abort;

end;

procedure TfrmPaiCadastro.edtPesquisarCodExit(Sender: TObject);
begin
  DMPai.AbrirRegistro(edtPesquisarCod.AsInteger);
end;
{$ENDREGION}

{$REGION ' State Form '}
procedure TfrmPaiCadastro.FormCreate(Sender: TObject);
begin
   DS.DataSet := DMPai.CDS;

   KeyPreview := True;

   edtPesquisarCod.AsInteger := DMPai.CDS.Fields[0].AsInteger;
end;

procedure TfrmPaiCadastro.FormDestroy(Sender: TObject);
begin
  DMPai.Free;
end;

procedure TfrmPaiCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if DMPai.CDS.State in [dsEdit, dsInsert] then
    begin
      if Application.MessageBox('Deseja Cancelar a Operação Atual ?', '', MB_YESNO + MB_ICONWARNING) = IDYES then
      begin
        Close;
      end
      else
        Exit

    end
    else
      Close;
  end;

end;

procedure TfrmPaiCadastro.FormResize(Sender: TObject);
begin
   pnlPrincipal.Top := Round((Height - pnlPrincipal.Height) / 2);
   pnlPrincipal.Left := Round((Width - pnlPrincipal.Width) / 2);
end;
{$ENDREGION}

{$REGION ' Register and UnRegister Class '}
initialization
  RegisterClass(TfrmPaiCadastro);

finalization
  UnRegisterClass(TfrmPaiCadastro);
{$ENDREGION}

end.

