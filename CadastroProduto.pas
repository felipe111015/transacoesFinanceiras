unit CadastroProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, rcs_str_mobile, FMX.Edit, FMX.Layouts,
  System.JSON, System.IOUtils;

type
  TFormCadastroProduto = class(TForm)
    actionBar: TRectangle;
    lblTitulo: TLabel;
    btMenu: TButton;
    btVoltar: TButton;
    layoutAll: TLayout;
    layoutCampos: TLayout;
    cpValor: TEdit;
    cpDesc: TEdit;
    cpNome: TEdit;
    layoutLabels: TLayout;
    lblNome: TLabel;
    lblDesc: TLabel;
    lblValor: TLabel;
    btSalvar: TButton;
    lblSubTitulo: TLabel;
    procedure btVoltarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    stringJSON:String;
  public
    { Public declarations }
    idProduto: Integer;
  end;

var
  FormCadastroProduto: TFormCadastroProduto;

implementation

{$R *.fmx}

uses Inicial;

procedure TFormCadastroProduto.btSalvarClick(Sender: TObject);
var
  arquivo: TFileName;
  jo: TJSONObject;
  jv: TJSONValue;
  ja: TJSONArray;
  jp: TJSONPair;
  json: TStringList;
begin
    arquivo:= PathZ('produtos.json');
    json:= TStringList.create();

    try
      jv := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TFile.ReadAllText(stringJSON)), 0);
      ja := jv as TJSONArray;

      if idProduto= -1 then
      begin
          jo := TJsonObject.Create();

          jo.AddPair(TJsonPair.Create('codigo_produto', '0'));
          jo.AddPair(TJsonPair.Create('descricao',      cpDesc.Text));
          jo.AddPair(TJsonPair.Create('nome',           cpNome.Text));
          jo.AddPair(TJsonPair.Create('valor',          cpValor.Text));

          ja.AddElement(jo);

          ShowMessage('Cadastro efetuado com sucesso!');
      end
      else
      begin
            jo := (ja.Items[0] as TJSONObject);
            jo.RemovePair('codigo_produto');
            jo.RemovePair('descricao');
            jo.RemovePair('nome');
            jo.RemovePair('valor');

            jo.AddPair('codigo_produto', (idProduto+1).toString);
            jo.AddPair('descricao',      cpDesc.Text);
            jo.AddPair('nome',           cpNome.Text);
            jo.AddPair('valor',          cpValor.Text);

            ShowMessage('Cadastro alterado com sucesso!');
      end;

      json.Text:= jv.ToString;

      if not FileExists(PathZ('produtos.json')) then
        json.SaveToFile(arquivo);
    except
        on E: Exception do
          ShowMessage(E.Message)
    end;
end;

procedure TFormCadastroProduto.btVoltarClick(Sender: TObject);
begin
    idProduto:= -1;

    FormInicial.Show;
    Self.Hide;
end;
procedure TFormCadastroProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Application.Terminate
end;

procedure TFormCadastroProduto.FormCreate(Sender: TObject);
var
  arquivo: TFileName;
  json: TStringList;
begin
    arquivo:= PathZ('produtos.json');

    stringJSON:= '[{"codigo_produto":"", "descricao":"", "nome":"", "valor":""}]';
    json.Text:= stringJSON;

    if not FileExists(arquivo) then
      json.SaveToFile(arquivo);
end;

procedure TFormCadastroProduto.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
    btVoltarClick(nil);
end;

end.
