unit DAO.Reserva;

interface

uses
  ADRConn.Model.Interfaces,
  ADRConn.DAO.Base,
  DataSet.Serialize,
  System.JSON;

type
  TADRConnDAOReserva = class(TADRConnDAOBase)
    public
      function List: TJSONArray;
  end;


implementation

{ TADRConnDAOReserva }

function TADRConnDAOReserva.List: TJSONArray;
const
  LSQL = 'SELECT * FROM RESERVA';

var
  LDataSet : TDataSet;
begin
  LDataSet :=
    FQuery
      .SQL(LSQL)
      .Open;
  try
    Result := LDataSet.ToJSONArray;
  finally
    LDataSet.Free;
  end;
end;

end.
