unit UCadMovimentoEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, htmlbtns, ExtCtrls, ComCtrls, Mask, DBCtrls, Grids, DBGrids, DB,
  rxToolEdit, RXDBCtrl;

type
  TCadMovimentoEstoqueForm = class(TForm)
    AbaSuperior: TPageControl;
    tsConsulta: TTabSheet;
    tsManutencao: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    BTPesquisar: THTMLButton;
    CBPesquisar: TComboBox;
    EditPesquisar: TEdit;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    BTInserir: THTMLButton;
    BTAlterar: THTMLButton;
    BTSair: THTMLButton;
    Panel4: TPanel;
    Label5: TLabel;
    DBText1: TDBText;
    DBCheckBox2: TDBCheckBox;
    Label3: TLabel;
    DBEditNome: TDBEdit;
    Panel3: TPanel;
    BTGravar: THTMLButton;
    BTCancelar: THTMLButton;
    BTExcluir: THTMLButton;
    Label28: TLabel;
    CHApenasAtivos: TCheckBox;
    DBDateEdit1: TDBDateEdit;
    procedure BTInserirClick(Sender: TObject);
    procedure BTAlterarClick(Sender: TObject);
    procedure BTSairClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure CBPesquisarChange(Sender: TObject);
    procedure EditPesquisarChange(Sender: TObject);
    procedure BTPesquisarClick(Sender: TObject);
    procedure BTGravarClick(Sender: TObject);
    procedure BTCancelarClick(Sender: TObject);
    procedure BTExcluirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure tsConsultaShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tsManutencaoShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CadMovimentoEstoqueForm: TCadMovimentoEstoqueForm;
  MovimentoEstoqueID : Integer;
implementation
uses Base, UFuncoes;
{$R *.dfm}

procedure TCadMovimentoEstoqueForm.BTAlterarClick(Sender: TObject);
begin
  AbaSuperior.ActivePage := tsManutencao;
  DBEditNome.SetFocus;
end;

procedure TCadMovimentoEstoqueForm.BTCancelarClick(Sender: TObject);
begin
  BancoDeDados.qryCadMovimentoEstoque.Cancel;
  BancoDeDados.qryCsMovimentoEstoque.Refresh;
  AbaSuperior.ActivePage := tsConsulta;
  EditPesquisar.SetFocus;
end;

procedure TCadMovimentoEstoqueForm.BTExcluirClick(Sender: TObject);
begin
  try
    BancoDeDados.qryCadMovimentoEstoque.Delete;
  except on E: EDatabaseError do
      if (Pos('violates foreign key',e.message) > 0) then
        MessageDlg('N�o foi possivel excluir este registros.'+#13+
          'Foram localizados lan�amentos feitos para este registro.',mtWarning,[mbOK],0);
  end;
  BancoDeDados.qryCsMovimentoEstoque.Refresh;
  AbaSuperior.ActivePage := tsConsulta;
  EditPesquisar.SetFocus;
end;

procedure TCadMovimentoEstoqueForm.BTGravarClick(Sender: TObject);
begin
  BancoDeDados.qryCadMovimentoEstoque.ApplyUpdates;
  AbaSuperior.ActivePage := tsConsulta;
end;

procedure TCadMovimentoEstoqueForm.BTInserirClick(Sender: TObject);
begin
  if not (BancoDeDados.qryCadMovimentoEstoque.Active) then
    BancoDeDados.qryCadMovimentoEstoque.Open;
  BancoDeDados.qryCadMovimentoEstoque.Append;
  AbaSuperior.ActivePage := tsManutencao;
  DBEditNome.SetFocus;
end;

procedure TCadMovimentoEstoqueForm.BTPesquisarClick(Sender: TObject);
var
  Campo : ShortString;
begin
  case (CBPesquisar.ItemIndex) of
    0: Campo := 'idmovimento_estoque';
    1: Campo := 'nome';
  end;
  with BancodeDados.qryCsGrupo do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from lanmovimento_estoque');
      if (CBPesquisar.ItemIndex in [0]) then
        begin
            if (EditPesquisar.Text <> '') then
              if (TestaInteiro(EditPesquisar.Text)) then
                SQL.Add(' where '+Campo+' = '+EditPesquisar.Text)
              else
                begin
                  MessageDlg('Para este filtro, s�o permitidos apenas n�meros.',mtWarning,[mbOK],0);
                  EditPesquisar.SetFocus;
                  Abort;
                end;
        end
      else
        SQL.Add('where '+Campo+' ilike '+''''+EditPesquisar.Text+'%'+'''');
      if (CHApenasAtivos.Checked) then
        if (Pos('where',SQL.Text) > 0) then
          SQL.Add(' and ativo = '+QuotedStr('TRUE'))
        else
          SQL.Add(' where ativo = '+QuotedStr('TRUE'));
      SQL.Add('order by '+Campo);
      Open;
    end;
end;

procedure TCadMovimentoEstoqueForm.BTSairClick(Sender: TObject);
begin
  Close;
end;

procedure TCadMovimentoEstoqueForm.CBPesquisarChange(Sender: TObject);
begin
  EditPesquisar.Clear;
  EditPesquisar.SetFocus;
end;

procedure TCadMovimentoEstoqueForm.DBGrid1DblClick(Sender: TObject);
begin
  BTAlterarClick(Self);
end;

procedure TCadMovimentoEstoqueForm.EditPesquisarChange(Sender: TObject);
begin
  BTPesquisarClick(Self);
end;

procedure TCadMovimentoEstoqueForm.FormCreate(Sender: TObject);
begin
  AbaSuperior.ActivePage := tsConsulta;
  CHApenasAtivos.Checked := True;
end;

procedure TCadMovimentoEstoqueForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0);
    end;
  if (key = #27) then
    begin
      key := #0;
      Close;
    end;
end;

procedure TCadMovimentoEstoqueForm.tsConsultaShow(Sender: TObject);
begin
  BTPesquisarClick(Self);
  EditPesquisar.SetFocus;
end;

procedure TCadMovimentoEstoqueForm.tsManutencaoShow(Sender: TObject);
begin
  if not (BancodeDados.qryCadMovimentoEstoque.State in [dsInsert]) then
    with BancoDeDados.qryCadMovimentoEstoque do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select * from lanmovimento_estoque where idmovimento_estoque = '+
            IntToStr(BancoDeDados.qryCsMovimentoEstoqueidmovimento_estoque.Value));
        Open;
        Edit;
      end;
end;

end.
