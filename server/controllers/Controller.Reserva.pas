unit Controller.Reserva;

interface

uses
  Horse,

  ADRConn.Model.Interfaces,
  ADRConn.Model.Factory,
  System.JSON,

  DAO.Reserva;

  procedure RegisterReserva;

  procedure List(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure RegisterReserva;
begin
  THorse.Get('reserva', List);
end;

procedure List(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LConnection : IADRConnection;
  LDAO        : TADRConnDAOReserva;
begin
  LConnection := TADRConnModelFactory.GetConnectionIniFile;
  LConnection.Connect;
  LDAO        := TADRConnDAOReserva.Create(LConnection);

  try
    Res.Send<TJSONArray>(LDAO.List);
  finally
    LDAO.Free;
  end;
end;

end.
