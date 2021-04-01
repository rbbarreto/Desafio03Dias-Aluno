program SrvHorse;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.Compression,
  Horse.BasicAuthentication,
  Horse.HandleException,
  System.SysUtils,
  Controller.Casa in 'controllers\Controller.Casa.pas',
  DAO.Casa in 'DAO\DAO.Casa.pas',
  DAO.Login in 'DAO\DAO.Login.pas',
  Controller.Login in 'controllers\Controller.Login.pas',
  Controller.Reserva in 'controllers\Controller.Reserva.pas',
  DAO.Reserva in 'DAO\DAO.Reserva.pas';

begin
  IsConsole := False;
  ReportMemoryLeaksOnShutdown := True;

  THorse
    .Use(Compression())
    .Use(Jhonson)
    .Use(HandleException)
    .Use(HorseBasicAuthentication(
      function (const AUserName, APassword: string): Boolean
      begin
        Result := Controller.Login.Login(AUserName, APassword);
        if not Result then
          exit;
      end
      ));

  Controller.Casa.RegisterCasa;
  Controller.Reserva.RegisterReserva;

  THorse.Listen(9001,
    procedure (Horse: THorse)
    begin
      WriteLn(Format('Servidor Horse inicializado na porta: %d', [Horse.Port]));
      WriteLn('Pronto para receber requests');
      ReadLn;
    end
  );

end.
