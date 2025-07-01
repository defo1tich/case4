object WebModule1: TWebModule1
  OnCreate = WebModuleCreate
  object ADOConnection: TADOConnection
    ConnectionString = 'Provider=SQLOLEDB;Data Source=localhost;Initial Catalog=TourismDB;Integrated Security=SSPI;'
    LoginPrompt = False
  end
  object ADOQuery: TADOQuery
  end
end
