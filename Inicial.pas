unit Inicial;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.StdCtrls, FMX.ListView, FMX.Controls.Presentation, FMX.Objects,
  FMX.Layouts, FMX.MultiView, Data.Bind.GenData, System.Rtti, System.IOUtils,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt, System.JSON,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope, IPPeerClient,
  REST.Client, rcs_str_mobile, REST.Types, FMX.TabControl;

type
  TFormInicial = class(TForm)
    actionBar2: TRectangle;
    lblTitulo2: TLabel;
    lblSubTitulo:  TLabel;
    listaClientes: TListView;
    btNovoCliente: TButton;
    layoutGeral: TLayout;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    actionBar1: TRectangle;
    lblTitulo1: TLabel;
    actionBar3: TRectangle;
    lblTitulo3: TLabel;
    Label1: TLabel;
    btNovoProduto: TButton;
    btClientes: TButton;
    layoutBt: TLayout;
    Rectangle1: TRectangle;
    lblBtClientes: TLabel;
    btProdutos: TButton;
    Rectangle2: TRectangle;
    lblBtProdutos: TLabel;
    btVoltar1: TButton;
    btVoltar2: TButton;
    procedure btNovoClienteClick(Sender: TObject);
    function getJSON():TJSONValue;
    procedure preencheLista();
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btNovoProdutoClick(Sender: TObject);
    procedure btClientesClick(Sender: TObject);
    procedure lblBtProdutosClick(Sender: TObject);
    procedure btVoltar2Click(Sender: TObject);
    procedure btProdutosClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure listaClientesItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    stringJSON:String;
    nome:String;
  end;

var
  FormInicial: TFormInicial;

implementation

{$R *.fmx}

uses CadastroCliente, CadastroProduto;

procedure TFormInicial.btNovoProdutoClick(Sender: TObject);
begin
    if FormCadastroProduto= nil then
      Application.CreateForm(TFormCadastroProduto, FormCadastroProduto);

    FormCadastroProduto.idProduto:= -1;
    FormCadastroProduto.Show;

    Self.Hide;
end;

procedure TFormInicial.btVoltar2Click(Sender: TObject);
begin
    TabControl1.ActiveTab:= TabItem1;
end;

procedure TFormInicial.btClientesClick(Sender: TObject);
begin
    TabControl1.ActiveTab:= TabItem2;
end;

procedure TFormInicial.btProdutosClick(Sender: TObject);
begin
    TabControl1.ActiveTab:= TabItem3;
end;

procedure TFormInicial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Application.Terminate
end;

procedure TFormInicial.FormCreate(Sender: TObject);
begin
    getJSON()
end;

procedure TFormInicial.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
      if (TabControl1.ActiveTab= TabItem2) or (TabControl1.ActiveTab= TabItem3) then
        btVoltar2Click(nil)
      else
          Application.Terminate
  end;
end;

procedure TFormInicial.FormResize(Sender: TObject);
var
  larguraBt,
  larguraTotal: Single;
begin
    larguraTotal:= layoutBt.Width;
    larguraBt   := (larguraTotal/2) - 5;

    btClientes.Width:= larguraBt;
end;

procedure TFormInicial.btNovoClienteClick(Sender: TObject);
begin
    if FormCadastroCliente= nil then
      Application.CreateForm(TFormCadastroCliente, FormCadastroCliente);

    FormCadastroCliente.cpfCliente:= -1;
    FormCadastroCliente.Show;

    Self.Hide;
end;

procedure TFormInicial.FormShow(Sender: TObject);
begin
    TabControl1.ActiveTab:= TabItem1;

    preencheLista();
end;

function TFormInicial.getJSON():TJSONValue;
var
  arquivo: TFileName;
  resposta: TJSONValue;
  json: TStringList;
begin
    arquivo:= PathZ('clientes.json');
    json:= TStringList.create();

    try
      RESTRequest1.Execute;

      resposta  := RESTResponse1.JSONValue;
      stringJSON:= resposta.ToString;

      json.Text := StringJSON;

      if not FileExists(PathZ('clientes.json')) then
        json.SaveToFile(arquivo);
    except
        on E: Exception do
          ShowMessage(E.Message)
    end;
    result:= resposta;
end;

procedure TFormInicial.lblBtProdutosClick(Sender: TObject);
begin
    TabControl1.ActiveTab:= TabItem3;
end;

procedure TFormInicial.listaClientesItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    if FormCadastroCliente= nil then
      Application.CreateForm(TFormCadastroCliente, FormCadastroCliente);

    FormCadastroCliente.cpfCliente:= AItem.Index;
    FormCadastroCliente.Show;

    Self.Hide;
end;

procedure TFormInicial.preencheLista();
var
  arquivo: TFileName;
  JSONObj: TJSONObject;
  ja: TJSONArray;
  jv: TJSONValue;
  i: Integer;
  ItemAdd : TListViewItem;
begin
    arquivo:= PathZ('clientes.json');
    jv := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TFile.ReadAllText(arquivo)), 0);
    ja := jv as TJSONArray;

    listaClientes.Items.Clear;
    listaClientes.BeginUpdate;

    try
      for i:= 0 to ja.Count-1 do
      begin
          JSONObj := (ja.Items[i] as TJSONObject);

          ItemAdd := listaClientes.Items.Add;
          ItemAdd.Text := JSONObj.GetValue('nome').value;
      end;
    finally
        listaClientes.EndUpdate
    end;
end;


end.
