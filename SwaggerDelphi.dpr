program SwaggerDelphi;

uses
  Vcl.Forms,
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Horse.ETag,
  Horse.GBSwagger,
  uMain in 'Source\uMain.pas' {uFrmMain} ,
  uDM in 'Source\Connection\uDM.pas' {DM: TDataModule} ,
  Router.Client in 'Source\Routers\Router.Client.pas',
  Service.Client in 'Source\Services\Service.Client.pas',
  Utils in 'Source\Utils\Utils.pas',
  Router.Default in 'Source\Routers\Router.Default.pas',
  Models.Client in 'Source\Models\Models.Client.pas';

{$R *.res}

begin
  Application.Initialize;
  { Controle de Vazamento de Mem�ria }
  ReportMemoryLeaksOnShutdown := True;
  { Controle de Vazamento de Mem�ria }

  { Middlewares }
  THorse.Use(CORS).Use(Jhonson()).Use(ETag).Use(HorseSwagger);
  { Middlewares }

  { Carregar todas as Rotas }
  Router.Default.LoadRouters;
  Router.Client.LoadRouters;
  { Carregar todas as Rotas }

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TuFrmMain, uFrmMain);
  Application.CreateForm(TDM, DM);
  Application.Run;

end.
