unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types,
  System.Threading,
  FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, Winapi.Windows;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    a: IFuture<string>;
    b: IFuture<string>;
    c: IFuture<string>;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.Button1Click(Sender: TObject);
begin
  TTask.Run(
    procedure
    var
      tempo: Cardinal;
      resultado: string;
    begin
      tempo := GetTickCount;

      a := TTask.Future<string>(
        function: string
        begin
          Sleep(5000);
          Result := Random(100).ToString;
        end);

      b := TTask.Future<string>(
        function: string
        begin
          Sleep(3000);
          Result := Random(100).ToString;
        end);

      c := TTask.Future<string>(
        function: string
        begin
          Sleep(2000);
          Result := Random(100).ToString;
        end);

      resultado := a.Value + ', ' + b.Value + ', ' + c.Value;
      tempo := GetTickCount - tempo;

      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        Label1.Text := 'Tempo gasto: ' + IntToStr(tempo) + 'ms ' + 'Valor: ' + resultado;
      end);


    end);
end;

end.
