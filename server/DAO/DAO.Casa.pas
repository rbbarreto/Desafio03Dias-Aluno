unit DAO.Casa;

interface

uses
  ADRConn.Model.Interfaces,
  ADRConn.DAO.Base,
  DataSet.Serialize,
  System.JSON;

type
  TADRConnDAOCasa = class(TADRConnDAOBase)
    public
      function List: TJSONArray;
  end;

implementation

{ TADRConnDAOCasa }

function TADRConnDAOCasa.List: TJSONArray;
var
  LDataSet : TDataSet;
begin
  LDataSet :=
    FQuery
      .SQL('SELECT * FROM CASAS')
      .Open;
  try
    Result := LDataSet.ToJSONArray;
  finally

  end;
end;

end.
