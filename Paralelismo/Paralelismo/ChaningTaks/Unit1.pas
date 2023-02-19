unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    AllTasks: array [0 .. 1] of ITask;
  public
    { Public declarations }
     procedure RunTask(aLabel: TLabel; var aTask: ITask);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  RunTask(Label1, AllTasks[0]);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  RunTask(Label2, AllTasks[1]);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Label3.Caption := '--';
  TTask.Run(
    procedure
    begin
      TTask.WaitForAll(AllTasks);
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          Label3.Caption := Label1.Caption + ' + ' + Label2.Caption;
        end);
    end);
end;

procedure TForm1.RunTask(aLabel: TLabel; var aTask: ITask);
begin
  aLabel.Caption := '--';
  aTask := TTask.Run(
    procedure
    var
      lValue: Integer;
    begin
      { Some calculation that takes time }
      Sleep(3000);
      lValue := Random(10);
      TThread.Synchronize(nil,
        procedure
        begin
          aLabel.Caption := lValue.ToString;
        end);
    end);
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
