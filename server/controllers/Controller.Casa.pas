unit Controller.Casa;

interface

uses
  Horse,

  ADRConn.Model.Interfaces,
  ADRConn.Model.Factory,
  System.JSON,
  DAO.Casa;

  procedure RegisterCasa;

  procedure List(Req: THorseRequest; Res : THorseResponse; Next: TProc);

implementation

procedure RegisterCasa;
begin
  THorse.Get('casa', List);
end;

procedure List(Req: THorseRequest; Res : THorseResponse; Next: TProc);
var
  connection: IADRConnection;
  dao: TADRConnDAOCasa;
begin
  connection := TADRConnModelFactory.GetConnectionIniFile;
  connection.Connect;
  dao := TADRConnDAOCasa.create(connection);
  try
    Res.Send<TJsonArray>(dao.List);
  finally
    dao.Free;
  end;
end;

end.
