unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp,
  Data.Win.ADODB, Data.DB;

type
  TWebModule1 = class(TWebModule)
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    procedure WebModuleCreate(Sender: TObject);
    procedure DefaultAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure ToursAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    procedure InitDB;
  public
  end;

var
  WebModule1: TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TWebModule1.InitDB;
begin
  ADOConnection.LoginPrompt := False;
  ADOConnection.Connected := True;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  InitDB;
  OnDefaultHandler := DefaultAction;
  AddWebAction('/tours', ToursAction);
end;

procedure TWebModule1.DefaultAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.ContentType := 'text/html; charset=utf-8';
  Response.Content :=
    '<h1>Каталог туристических туров</h1>' +
    '<p><a href="/tours">Показать все туры</a></p>';
  Handled := True;
end;

procedure TWebModule1.ToursAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  ADOQuery.Connection := ADOConnection;
  ADOQuery.SQL.Text :=
    'SELECT t.TourID, t.Title, c.CountryName, tt.TypeName, ' +
    't.StartDate, t.EndDate, t.Price ' +
    'FROM Tours t ' +
    'JOIN Countries c ON t.CountryID = c.CountryID ' +
    'JOIN TourTypes tt ON t.TypeID = tt.TypeID';
  ADOQuery.Open;

  Response.ContentType := 'text/html; charset=utf-8';
  Response.Content := '<h2>Список доступных туров</h2><ul>';
  while not ADOQuery.Eof do
  begin
    Response.Content := Response.Content + Format(
      '<li>[%d] %s — %s (%s), с %s по %s: %.2f USD</li>',
      [ADOQuery.FieldByName('TourID').AsInteger,
       ADOQuery.FieldByName('Title').AsString,
       ADOQuery.FieldByName('CountryName').AsString,
       ADOQuery.FieldByName('TypeName').AsString,
       ADOQuery.FieldByName('StartDate').AsDateTime.ToString('yyyy-MM-dd'),
       ADOQuery.FieldByName('EndDate').AsDateTime.ToString('yyyy-MM-dd'),
       ADOQuery.FieldByName('Price').AsFloat]);
    ADOQuery.Next;
  end;
  Response.Content := Response.Content + '</ul>';
  Handled := True;
end;

end.
