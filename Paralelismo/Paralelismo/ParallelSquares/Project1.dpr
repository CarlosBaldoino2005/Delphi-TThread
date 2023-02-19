program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitFormMain in 'UnitFormMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
