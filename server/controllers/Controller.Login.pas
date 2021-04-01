unit Controller.Login;

interface

uses
  Horse,

  ADRConn.Model.Interfaces,
  ADRConn.Model.Factory,

  System.JSON,
  DAO.Login;

  function Login(const AUsername, APassword: string): Boolean;

implementation

function Login(const AUsername, APassword: string): Boolean;
var
  LConnection : IADRConnection;
  LDAO        : TADRConnDAOLogin;
begin
  LConnection := TADRConnModelFactory.GetConnectionIniFile;
  LConnection.Connect;
  LDAO        := TADRConnDAOLogin.Create(LConnection);
  try
    Result := LDAO.BasicLogin(AUsername, APassword);
  finally
    LDAO.Free;
  end;
end;


end.
