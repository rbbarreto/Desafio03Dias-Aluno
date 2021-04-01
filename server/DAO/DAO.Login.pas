unit DAO.Login;

interface

uses
  ADRConn.Model.Interfaces,
  ADRConn.DAO.Base,
  System.JSON;

type
  TADRConnDAOLogin = class(TADRConnDAOBase)

    public
      function BasicLogin(const AUser, APassword: string): Boolean;
  end;


implementation

{ TADRConnDAOLogin }

function TADRConnDAOLogin.BasicLogin(const AUser, APassword: string): Boolean;
const
  LSQL = 'SELECT * FROM USUARIO WHERE USUARIO = :pUSUARIO AND SENHA = :pSENHA';
var
  LDataSet : TDataSet;
begin
  LDataSet :=
    FQuery
      .SQL(LSQL)
      .ParamAsString('pUSUARIO', AUser)
      .ParamAsString('pSENHA', APassword)
      .Open;
  try
    Result := not LDataSet.IsEmpty;
  finally
    LDataSet.Free;
  end;
end;

end.
