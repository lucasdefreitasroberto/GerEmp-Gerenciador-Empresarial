unit UClassPai;

interface

uses
  Data.DB;

type
  TclassPai = class
  public
    procedure configurarCampo(Fields: TFields); virtual; abstract;
    function nomeTabela: string; virtual; abstract;
    function campoChave: string; virtual; abstract;
    function sqlPesquisa: string; virtual; abstract;
    function sqlCadastro: string; virtual; abstract;
    function nomeGenerator: string; virtual; abstract;
  end;

implementation

end.

