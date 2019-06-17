unit Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects;

type
  TFormLogin = class(TForm)
    actionBar1: TRectangle;
    lblTitulo: TLabel;
    layoutAll: TLayout;
    layoutCampos: TLayout;
    cpSenha: TEdit;
    cpUsuario: TEdit;
    layoutLabels: TLayout;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    btSalvar: TButton;
    lblSubTitulo: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  const
    USUARIO= 'adm';
    SENHA  = 'adm';
  end;


var
  FormLogin: TFormLogin;

implementation

{$R *.fmx}

uses Inicial;

procedure TFormLogin.btSalvarClick(Sender: TObject);
begin
    if (cpUsuario.Text.Equals(USUARIO)) and (cpSenha.Text.Equals(SENHA)) then
    begin
        if FormInicial= nil then
          Application.CreateForm(TFormInicial, FormInicial);

          FormInicial.Show;

          Self.Hide
    end;
end;

procedure TFormLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Application.Terminate;
end;

end.
