unit untFrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  JvExControls, JvAnimatedImage, JvGIFCtrl, Vcl.Samples.Gauges,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Imaging.jpeg,
  Data.DB, Datasnap.DBClient;

type
  TfrmLogin = class(TForm)
    pnlPrincipal: TPanel;
    Shape1: TShape;
    Panel3: TPanel;
    btnFechar: TSpeedButton;
    Panel4: TPanel;
    Image1: TImage;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel1: TPanel;
    btnCancelar: TSpeedButton;
    pnl_user: TPanel;
    edtUsuario: TEdit;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    edtSenha: TEdit;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    btnEntrar: TSpeedButton;
    lbl1: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure EfetuarLogin(Usuario, Senha: string);
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  UDMConexao, untFrmMenuPrincipal;

{$R *.dfm}

{$REGION ' button functions'}
procedure TfrmLogin.btnCancelarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
   EfetuarLogin(edtUsuario.Text, edtSenha.Text);
end;

procedure TfrmLogin.btnFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;
{$ENDREGION}

{$REGION ' EfetuarLogin '}
procedure TfrmLogin.EfetuarLogin(Usuario, Senha: String);
var
  SQL: string;
  CDS: TClientDataSet;
begin

  SQL := ' select LOGIN_USUARIOS, SENHA_USUARIOS, STATUS_USUARIOS '+
         ' from USUARIOS '+
         ' where LOGIN_USUARIOS = '+ QuotedStr(UpperCase(Usuario)) +
         ' and SENHA_USUARIOS = '  + QuotedStr(UpperCase(Senha));

  if (Usuario = EmptyStr) or (Senha = EmptyStr) then
  begin
    Application.MessageBox('Usuário ou senha estão em branco.', 'Atenção', MB_Ok + MB_ICONWARNING);
    Abort
  end;


  CDS := TClientDataSet.Create(Self);

  try
   CDS.Close;
   CDS.Data := DMConexao.ExecuteReader(SQL);

    if CDS.RecordCount > 0 then
    begin

      if CDS.FieldByName('STATUS_USUARIOS').AsString = 'S' then
      begin
        Application.MessageBox('Usuário Bloqueado.', 'Atenção', MB_Ok + MB_ICONWARNING);
        Abort
      end;

      Application.CreateForm(TfrmMenuPrincipal, frmMenuPrincipal);
      frmMenuPrincipal.Show;

      Hide;
    end
    else
    begin
      Application.MessageBox('Usuário ou senha incorretos.', 'Atenção', MB_OK + MB_ICONWARNING);
    end;

  finally
   CDS.Free;
  end;

end;
{$ENDREGION}

{$REGION ' FormKeyPress AND FormCreate'}
procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  KeyPreview := True;
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
  begin
    EfetuarLogin(edtUsuario.Text, edtSenha.Text);
    Key := #0;
  end;
end;
{$ENDREGION}

end.
