unit untFrmPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCadastro, Data.DB,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, JvExMask, JvToolEdit,
  JvBaseEdits, Vcl.ExtCtrls, UDMPessoa, JvMaskEdit, JvDBControls,
  Vcl.DBCtrls, JvExStdCtrls, JvCombobox, JvDBCombobox, Vcl.Grids,
  Vcl.DBGrids, untFrmPessoaTelefone;

type
  TfrmPessoa = class(TfrmPaiCadastro)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    dbedtNome: TDBEdit;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    GroupBox6: TGroupBox;
    edtMakDTCADASTRO_PESSOA: TJvDBMaskEdit;
    TabSheet1: TTabSheet;
    GroupBox5: TGroupBox;
    edtMakDTALTERACAO_PESSOA: TJvDBMaskEdit;
    Label6: TLabel;
    GroupBox7: TGroupBox;
    DBRadioGroup1: TDBRadioGroup;
    Label8: TLabel;
    Label5: TLabel;
    GroupBox8: TGroupBox;
    Label9: TLabel;
    DBRadioGroup2: TDBRadioGroup;
    GroupBox4: TGroupBox;
    Label2: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    GroupBox9: TGroupBox;
    Label10: TLabel;
    DBEdit2: TDBEdit;
    GroupBox10: TGroupBox;
    Label11: TLabel;
    DBEdit4: TDBEdit;
    GroupBox11: TGroupBox;
    Label12: TLabel;
    dbedtMUNICIPIO_PESSOA: TDBEdit;
    GroupBox12: TGroupBox;
    Label13: TLabel;
    dbcbbESTADO_PESSOA: TDBComboBox;
    GroupBox13: TGroupBox;
    Label14: TLabel;
    DBEdit6: TDBEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    Panel4: TPanel;
    Panel5: TPanel;
    Label15: TLabel;
    edtMakDocumento: TJvDBMaskEdit;
    GroupBox14: TGroupBox;
    dbgrdTelefone: TDBGrid;
    Panel6: TPanel;
    btnNovoTel: TBitBtn;
    btnApagarTel: TBitBtn;
    dsTelefone: TDataSource;
    btnEditarTel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DSDataChange(Sender: TObject; Field: TField);
    procedure dbcbbESTADO_PESSOAKeyPress(Sender: TObject; var Key: Char);
    procedure dbgrdTelefoneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnNovoTelClick(Sender: TObject);
    procedure btnEditarTelClick(Sender: TObject);
    procedure btnApagarTelClick(Sender: TObject);
  private
    FCodigoTelefone: string;

  public
    property CodigoPessoa: string read FCodigoTelefone write  FCodigoTelefone;

  end;

var
  frmPessoa: TfrmPessoa;

implementation

{$R *.dfm}


procedure TfrmPessoa.btnApagarTelClick(Sender: TObject);
begin
  inherited;

  if not dsTelefone.DataSet.IsEmpty then
  begin

    if MessageDlg('Deseja excluir esse registro ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Beep;

      dsTelefone.DataSet.Delete;
      DMPai.CDS.Edit;
    end;

  end;
end;

procedure TfrmPessoa.btnEditarTelClick(Sender: TObject);
begin
  if (DMPai.CDS.FieldByName('CODIGO_PESSOA').AsString <> EmptyStr) then
  begin
    dsTelefone.DataSet.Edit;
    DMPai.AbreForm(TfrmPessoaTelefone, frmPessoaTelefone, 0);
  end;
end;

procedure TfrmPessoa.btnNovoTelClick(Sender: TObject);
begin

  if (DMPai.CDS.FieldByName('CODIGO_PESSOA').AsString <> EmptyStr) then
  begin
    dsTelefone.DataSet.Insert;
    dsTelefone.DataSet.FieldByName('PESSOA_PESSOA_TEL').AsString := DMPai.CDS.FieldByName('CODIGO_PESSOA').AsString;
    DMPai.AbreForm(TfrmPessoaTelefone, frmPessoaTelefone, 0);
    DMPai.CDS.Post;
  end;

end;

procedure TfrmPessoa.dbcbbESTADO_PESSOAKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := #0;
end;

procedure TfrmPessoa.dbgrdTelefoneKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = vk_Delete) then
  begin

    if not dsTelefone.DataSet.IsEmpty then
    begin

      if MessageDlg('Deseja realmente excluir o conteúdo?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Beep;

        dsTelefone.DataSet.Delete;
        DMPai.CDS.Edit;
      end;

    end;

  end;
end;

procedure TfrmPessoa.DSDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  if DS.DataSet.State in [dsEdit, dsInsert] then
  begin
    if DS.DataSet.FieldByName('TIPO_PESSOA').AsString = 'F' then
      edtMakDocumento.EditMask := '!999.999.999-99;0;'
    else if DS.DataSet.FieldByName('TIPO_PESSOA').AsString = 'J' then
      edtMakDocumento.EditMask := '!99.999.999.999/9999-99;0;';
  end;

end;

procedure TfrmPessoa.FormCreate(Sender: TObject);
begin
  DMPai := TDMPessoa.Create(Self);
  inherited;
end;

procedure TfrmPessoa.FormDestroy(Sender: TObject);
begin
  inherited;
  frmPessoa.Free;
end;

{$REGION ' Register and UnRegister Class '}
initialization
  RegisterClass(TfrmPessoa);

finalization
  UnRegisterClass(TfrmPessoa);
{$ENDREGION}


end.
