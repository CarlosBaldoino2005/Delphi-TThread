unit UnitFormMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo,
  System.Threading, FMX.StdCtrls;

type
  TFormMain = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure ButtonStartParallelForClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

procedure TFormMain.Button1Click(Sender: TObject);
var
  I: Integer;
begin
  Memo1.Lines.Clear;
  for I := 0 to 9 do
  begin
    Sleep(1000);
    Memo1.Lines.Add(I.ToString);
  end;
end;

procedure TFormMain.ButtonStartParallelForClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
  TParallel.For(0, 9,
    procedure(Index: Integer)
    begin
      Sleep(1000);
      TThread.Queue(TThread.CurrentThread,
        procedure
        begin
          Memo1.Lines.Add(Index.ToString);
        end);
    end);
end;

end.
