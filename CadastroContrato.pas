unit CadastroContrato;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Edit, FMX.Layouts, System.IOutils,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.TabControl, rcs_str_mobile, System.JSON, Data.Bind.GenData,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TFormCadastroContrato = class(TForm)
    actionBar: TRectangle;
    lblTitulo: TLabel;
    btMenu: TButton;
    btVoltar: TButton;
    layoutAll: TLayout;
    layoutCampos: TLayout;
    layoutLabels: TLayout;
    lblNumero: TLabel;
    cpNumero: TLabel;
    Layout1: TLayout;
    lblData: TLabel;
    Layout2: TLayout;
    cpData: TLabel;
    lblSubTitulo: TLabel;
    listaProdutos: TListView;
    Layout3: TLayout;
    Layout4: TLayout;
    cpParcelas: TLabel;
    Layout5: TLayout;
    lblParcelas: TLabel;
    Layout6: TLayout;
    lblValor: TLabel;
    Layout7: TLayout;
    cpValor: TLabel;
    Rectangle1: TRectangle;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    procedure btVoltarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure carregaDados();
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    cpfCliente: Integer;
    numeroContrato: Integer;
  end;

var
  FormCadastroContrato: TFormCadastroContrato;

implementation

{$R *.fmx}

uses CadastroCliente;

procedure TFormCadastroContrato.btVoltarClick(Sender: TObject);
begin
    FormCadastroCliente.Show;
    Self.Hide;
end;

procedure TFormCadastroContrato.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Application.Terminate
end;

procedure TFormCadastroContrato.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
    btVoltarClick(nil);
end;

procedure TFormCadastroContrato.FormShow(Sender: TObject);
begin
    carregaDados();
end;

procedure TFormCadastroContrato.carregaDados();
var
  arquivo: TFileName;
  JSONObj: TJSONObject;
  ja: TJSONArray;
  jv: TJSONValue;
  i: Integer;
  ItemAdd : TListViewItem;
begin
    arquivo:= PathZ('clientes.json');
    jv:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TFile.ReadAllText(arquivo)), 0);
    ja := jv as TJSONArray;

    try
      JSONObj := (ja.Items[0] as TJSONObject);

      jv:= TJSONObject.ParseJSONValue(JSONObj.GetValue('contrato').ToJSON);
      ja:= jv as TJSONArray;

      JSONObj := (ja.Items[numeroContrato] as TJSONObject);

      cpNumero.Text  := JSONObj.GetValue('numeroContrato').value;
      cpData.Text    := JSONObj.GetValue('dataContratacao').value;
      cpParcelas.Text:= JSONObj.GetValue('qtdeParcelas').value;
      cpValor.Text   := 'R$ '+JSONObj.GetValue('valor').value;

      try
        listaProdutos.Items.Clear;
        listaProdutos.BeginUpdate;
        try
          jv:= TJSONObject.ParseJSONValue(JSONObj.GetValue('produto').ToJSON);
          ja:= jv as TJSONArray;

          for i:= 0 to ja.Count-1 do
          begin
              JSONObj := (ja.Items[i] as TJSONObject);

              ItemAdd := listaProdutos.Items.Add;

              ItemAdd.Text  := JSONObj.GetValue('nome').value;
              ItemAdd.Detail:= JSONObj.GetValue('qtde').Value+' Unidades';
          end;
        except
        end;
      except
      end;

      listaProdutos.EndUpdate
    except
        on E: Exception do
          ShowMessage(E.Message);
    end;
end;
end.
