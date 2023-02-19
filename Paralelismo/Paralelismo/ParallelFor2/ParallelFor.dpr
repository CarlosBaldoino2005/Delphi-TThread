program ParallelFor;

uses
  System.StartUpCopy,
  FMX.Forms,
  ParallelForMain in 'ParallelForMain.pas' {btnParallelFor};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TbtnParallelFor, btnParallelFor);
  Application.Run;
end.
