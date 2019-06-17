unit CadastroCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Edit, FMX.Layouts, System.IOUtils,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, Data.Bind.GenData, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, REST.Client, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IPPeerClient, rcs_str_mobile,
  REST.Types;

type
  TFormCadastroCliente = class(TForm)
    actionBar: TRectangle;
    lblTitulo: TLabel;
    btAlterarCliente: TButton;
    btExcluirCliente: TButton;
    btVoltar: TButton;
    lblSubTitulo: TLabel;
    layoutAll: TLayout;
    cpNome: TEdit;
    cpConta: TEdit;
    cpAgencia: TEdit;
    cpCpf: TEdit;
    layoutCampos: TLayout;
    layoutLabels: TLayout;
    lblNome: TLabel;
    lblCpf: TLabel;
    lblAgencia: TLabel;
    Label4: TLabel;
    btSalvar: TButton;
    listaContratos: TListView;
    Label1: TLabel;
    Layout1: TLayout;
    btNovoContrato: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    function validaCampos():String;
    procedure btVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LiberaCampos();
    procedure btAlterarClienteClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure preencheCampos(pos: Integer);
    procedure btExcluirClienteClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure listaContratosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getJSON():TJSONValue;
  private
    { Private declarations }
  public
    { Public declarations }
    stringJSON:String;
    cpfCliente: integer;
  end;

var
  FormCadastroCliente: TFormCadastroCliente;

implementation

{$R *.fmx}

uses Inicial, CadastroContrato;


procedure TFormCadastroCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Application.Terminate
end;

procedure TFormCadastroCliente.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
    btVoltarClick(nil);
end;

procedure TFormCadastroCliente.FormShow(Sender: TObject);
begin
    getJSON();

    listaContratos.Items.Clear;

    if cpfCliente= -1 then
    begin
        LiberaCampos();

        btAlterarCliente.Visible:= False;
        btExcluirCliente.Visible:= False;
        btSalvar.Visible:= True;
    end
    else
    begin

        btAlterarCliente.Visible:= True;
        btExcluirCliente.Visible:= True;

        cpNome.Enabled   := False;
        cpCpf.Enabled    := False;
        cpAgencia.Enabled:= False;
        cpConta.Enabled  := False;


        preencheCampos(cpfCliente);

        btSalvar.Visible:= False;
    end;
end;

procedure TFormCadastroCliente.btAlterarClienteClick(Sender: TObject);
begin
    LiberaCampos();
    btAlterarCliente.Visible:= False;

    btSalvar.Visible:= True;
end;

procedure TFormCadastroCliente.btExcluirClienteClick(Sender: TObject);

var
  arquivo: TFileName;
  ja: TJSONArray;
  jv: TJSONValue;
  json: TStringList;
begin
    if cpfCliente>= 0 then
    begin
        arquivo:= PathZ('clientes.json');
        json:= TStringList.create();
        jv:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TFile.ReadAllText(arquivo)), 0);
        ja:= jv as TJSONArray;

        ja.Remove(cpfCliente);


        json.Text := jv.ToString;

        json.SaveToFile(arquivo);

        FormInicial.preencheLista();

        ShowMessage('Cadastro excluido com sucesso!');

        btVoltarClick(nil);
    end
end;

procedure TFormCadastroCliente.btSalvarClick(Sender: TObject);
var
  arquivo: TFileName;
  jo: TJSONObject;
  jv: TJSONValue;
  ja: TJSONArray;
  jp: TJSONPair;
  json: TStringList;
  aux:String;

begin
    json:= TStringList.Create;
    arquivo:= PathZ('clientes.json');

    aux:= validaCampos();
    if aux= '' then
    begin
        try
          if FileExists(arquivo) then
          begin
              jv := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TFile.ReadAllText(arquivo)), 0);
              ja := jv as TJSONArray;

              if cpfCliente= -1 then
              begin
                  jo := TJsonObject.Create();

                  jo.AddPair(TJsonPair.Create('nome',    cpNome.Text));
                  jo.AddPair(TJsonPair.Create('cpf',        cpCpf.Text));
                  jo.AddPair(TJsonPair.Create('agencia',     cpAgencia.Text));
                  jo.AddPair(TJsonPair.Create('conta', cpConta.Text));

                  ja.AddElement(jo);

                  ShowMessage('Cadastro efetuado com sucesso!');
              end
              else
              begin
                  jo := (ja.Items[0] as TJSONObject);
                  jo.RemovePair('nome');
                  jo.RemovePair('cpf');
                  jo.RemovePair('agencia');
                  jo.RemovePair('conta');

                  jo.AddPair('nome',    cpNome.Text);
                  jo.AddPair('cpf',        cpCpf.Text);
                  jo.AddPair('agencia',     cpAgencia.Text);
                  jo.AddPair('conta', cpConta.Text);

                  ShowMessage('Cadastro alterado com sucesso!');
              end;

              json.Text:= jv.ToString;
              json.SaveToFile(arquivo);
              // TO-DO: ENVIAR JSON ATUALIZADO
          end;
        finally
            btVoltarClick(nil);
        end;
    end
    else
    begin
        cpNome.SetFocus;
        ShowMessage('Por favor preencha o campo '+ aux +' corretamente!');
    end;

end;

// EVENTO DO BOTAO VOLTAR
procedure TFormCadastroCliente.btVoltarClick(Sender: TObject);
begin
    cpfCliente:=-1;
    cpNome.Text   :='';
    cpCpf.Text    :='';
    cpAgencia.Text:='';
    cpConta.Text  :='';

    FormInicial.Show;
    Self.Hide;
end;

// METODO RESPONSAVEL POR DESBLOQUEAR OS CAMPOS COM OS DADOS DO CLIENTE
procedure TFormCadastroCliente.LiberaCampos();
begin
    if cpNome.Enabled= False then
    begin
        cpNome.Enabled   := True;
        cpCpf.Enabled    := True;
        cpAgencia.Enabled:= True;
        cpConta.Enabled  := True;
    end;
end;

procedure TFormCadastroCliente.listaContratosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    if FormCadastroContrato= nil then
      Application.CreateForm(TFormCadastroContrato, FormCadastroContrato);

    FormCadastroContrato.cpfCliente     := cpfCliente;
    FormCadastroContrato.numeroContrato:= AItem.Index;
    FormCadastroContrato.Show;

    Self.Hide;
end;

procedure TFormCadastroCliente.preencheCampos(pos: Integer);
var
  JSONObj: TJSONObject;
  ja: TJSONArray;
  jv: TJSONValue;
  jp: TJSONPair;
  i: Integer;
  ItemAdd : TListViewItem;
begin
    jv:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(stringJSON), 0);
    ja := jv as TJSONArray;

    JSONObj := (ja.Items[pos] as TJSONObject);

    cpNome.Text   := JSONObj.GetValue('nome'   ).value;
    cpCpf.Text    := JSONObj.GetValue('cpf'       ).value;
    cpAgencia.Text:= JSONObj.GetValue('agencia'    ).value;
    cpconta.Text  := JSONObj.GetValue('conta').value;

    listaContratos.Items.Clear;
    listaContratos.BeginUpdate;

    try
      jv:= TJSONObject.ParseJSONValue(JSONObj.GetValue('contrato').ToJSON);
      ja:= jv as TJSONArray;

      for i:= 0 to ja.Count-1 do
      begin
          JSONObj := (ja.Items[i] as TJSONObject);
          ItemAdd := listaContratos.Items.Add;

          ItemAdd.Text:= JSONObj.GetValue('numeroContrato').value;
      end;
    finally
        listaContratos.EndUpdate
    end;
end;

function TFormCadastroCliente.validaCampos():String;
begin
    if cpNome.text.IsEmpty then
    begin
        result:= 'Nome';
        exit;
    end
    else if cpCpf.Text.IsEmpty then
        begin
            result:= 'CPF';
            exit;
        end
        else if cpAgencia.Text.IsEmpty then
            begin
                result:= 'Agencia';
                exit;
            end
            else if cpConta.Text.IsEmpty then
                begin
                    result:= 'Conta';
                    exit;
                end;


    result:= '';
end;


function TFormCadastroCliente.getJSON():TJSONValue;
var
  resposta: TJSONValue;
  arquivo: TFileName;
begin
    try
    arquivo:= PathZ('clientes.json');
    resposta := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TFile.ReadAllText(arquivo)), 0);
      //RESTRequest1.Execute;

      //resposta  := RESTResponse1.JSONValue;
      stringJSON:= resposta.ToString;
    except
        on E: Exception do
          ShowMessage(E.Message)
    end;
    result:= resposta;
end;
end.
