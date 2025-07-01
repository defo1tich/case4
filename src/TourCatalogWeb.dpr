library TourCatalogWeb;

uses
  Winapi.ActiveX,
  System.Win.ComObj,
  Web.WebBroker,
  Web.Win.ISAPIApp,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule1};

{$R *.res}

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  Application.WebModuleClass := WebModule1;
  Application.Run;
end.
