unit untFrmUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  untPaiCadastro, Data.DB, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  JvExMask, JvToolEdit,JvBaseEdits, Vcl.ExtCtrls,
  UDMUsuarios, Vcl.DBCtrls, JvMaskEdit, JvDBControls;

type
  TfrmUsuarios = class(TfrmPaiCadastro)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    dbedtNome: TDBEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    RdStatus: TDBRadioGroup;
    Label5: TLabel;
    GroupBox5: TGroupBox;
    JvDBMaskEdit1: TJvDBMaskEdit;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox6: TGroupBox;
    JvDBMaskEdit2: TJvDBMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

{$R *.dfm}

procedure TfrmUsuarios.FormCreate(Sender: TObject);
begin
  DMPai := TDMUsuarios.Create(Self);
  inherited;
end;

procedure TfrmUsuarios.FormDestroy(Sender: TObject);
begin
  inherited;
  frmUsuarios.Free;
end;

{$REGION ' Register and UnRegister Class '}
initialization
  RegisterClass(TfrmUsuarios);

finalization
  UnRegisterClass(TfrmUsuarios);
{$ENDREGION}

end.
