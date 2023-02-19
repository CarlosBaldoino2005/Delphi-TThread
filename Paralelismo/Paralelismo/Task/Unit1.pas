unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    procedure Teste;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Vcl.Dialogs,
  System.Threading;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Sleep(10000);
  Label1.Caption := DateTimeToStr(Now);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TTask.Run(
  procedure
  begin
    Sleep(10000);
    Label1.Caption := DateTimeToStr(Now);
  end

  );
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  t2: ITask;
begin
  t2 := TTask.Create(procedure
  begin
    Sleep(10000);
    TThread.Synchronize(
    TThread.CurrentThread,
    procedure
    begin
      Label1.Caption := DateTimeToStr(Now);
    end
    );
  end);

  t2.Start;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Teste;
end;

procedure TForm1.Teste;
begin
  Label1.Caption := 'Teste';
end;

end.
