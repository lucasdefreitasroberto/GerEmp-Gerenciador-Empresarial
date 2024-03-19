unit untFrmProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCadastro,
  Data.DB, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, JvExMask, JvToolEdit,
  JvBaseEdits, Vcl.ExtCtrls, UDMProduto, JvMaskEdit, JvDBControls,
  Vcl.DBCtrls;

type
  TfrmProduto = class(TfrmPaiCadastro)
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
    GroupBox9: TGroupBox;
    Label10: TLabel;
    dbedtPRECOPROMO: TDBEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    GroupBox7: TGroupBox;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    GroupBox8: TGroupBox;
    Label8: TLabel;
    DBEdit5: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProduto: TfrmProduto;

implementation

{$R *.dfm}

procedure TfrmProduto.FormCreate(Sender: TObject);
begin
  DMPai := TDMProduto.Create(Self);
  inherited;
end;

procedure TfrmProduto.FormDestroy(Sender: TObject);
begin
  inherited;
  frmProduto.Free;
end;

{$REGION ' Register and UnRegister Class '}
initialization
  RegisterClass(TfrmProduto);

finalization
  UnRegisterClass(TfrmProduto);
{$ENDREGION}
end.
