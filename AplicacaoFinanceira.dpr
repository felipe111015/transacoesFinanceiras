program AplicacaoFinanceira;

uses
  System.StartUpCopy,
  FMX.Forms,
  Inicial in 'Inicial.pas' {FormInicial},
  CadastroCliente in 'CadastroCliente.pas' {FormCadastroCliente},
  CadastroContrato in 'CadastroContrato.pas' {FormCadastroContrato},
  CadastroProduto in 'CadastroProduto.pas' {FormCadastroProduto},
  Splash in 'Splash.pas' {FormSplash},
  Login in 'Login.pas' {FormLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormSplash, FormSplash);
  Application.Run;
end.