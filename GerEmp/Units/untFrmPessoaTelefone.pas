unit untFrmPessoaTelefone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB,
  Datasnap.DBClient, JvExMask, JvToolEdit, JvMaskEdit, JvDBControls, UDMConexao,
  UDMPessoa;

type
  TfrmPessoaTelefone = class(TForm)
    Panel4: TPanel;
    Panel5: TPanel;
    Label15: TLabel;
    Panel6: TPanel;
    btnGravar: TBitBtn;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    edtMakArea: TJvDBMaskEdit;
    btnFechar: TBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    edtMakNUMERO: TJvDBMaskEdit;
    GroupBox12: TGroupBox;
    Label13: TLabel;
    dbcbbAparelho: TDBComboBox;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    edtMakDESCRICAO_PESSOA_TEL: TJvDBMaskEdit;
    ds: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbcbbAparelhoKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbbAparelhoExit(Sender: TObject);
  private

    { Private declarations }
  public
  end;

var
  frmPessoaTelefone: TfrmPessoaTelefone;

implementation

uses
  UClassPessoa;

{$R *.dfm}

procedure TfrmPessoaTelefone.btnFecharClick(Sender: TObject);
begin
  if ds.DataSet.State in [dsInsert, dsEdit] then
    ds.DataSet.Cancel;

  Close;
end;

procedure TfrmPessoaTelefone.btnGravarClick(Sender: TObject);
begin
  if ds.DataSet.FieldByName('NUMERO_PESSOA_TEL').AsString = EmptyStr then
    raise Exception.Create('Precisa informar o Número');

  if ds.DataSet.FieldByName('AREA_PESSOA_TEL').AsString = EmptyStr then
    raise Exception.Create('Precisa informar o DDD');

  if ds.DataSet.FieldByName('APARELHO_PESSOA_TEL').AsString = EmptyStr then
    raise Exception.Create('Precisa informar Tipo do Aparelho');


  if ds.DataSet.State in [dsInsert, dsEdit] then
  begin
    ds.DataSet.Post;
  end;

  Close;
end;

procedure TfrmPessoaTelefone.dbcbbAparelhoExit(Sender: TObject);
begin
  if dbcbbAparelho.ItemIndex = 0 then
    edtMakNUMERO.EditMask := '0000-0000;0;_'

  else if dbcbbAparelho.ItemIndex = 1 then
    edtMakNUMERO.EditMask := '00000-0000;0;_'

  else if dbcbbAparelho.ItemIndex = 2 then
    edtMakNUMERO.EditMask := '0000-0000;0;_';
end;

procedure TfrmPessoaTelefone.dbcbbAparelhoKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TfrmPessoaTelefone.FormCreate(Sender: TObject);
begin
  KeyPreview := True;
  edtMakArea.EditMask := '!\(99\);0; ';
  edtMakNUMERO.EditMask := '00000-0000;0;_';
end;

end.

