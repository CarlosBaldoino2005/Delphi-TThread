unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type


  TProcesso = class(TThread)
    private
      FAux : String;
      FMemo : TMemo;
    public
      constructor Create (AMemo : TMemo); reintroduce;
      procedure Execute; override;
      procedure Sincronizar;
  end;


  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FProcesso : TProcesso;
    procedure ExecutaDepois(Sender : TObject);
    procedure TratamentoExeception(Sender : TObject);
  public
    { Public declarations }
  end;




var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Self.FProcesso:= TProcesso.Create(Memo1);
  //FProcesso.OnTerminate := TratamentoExeception;
  Self.FProcesso.Start;
end;

procedure TForm1.ExecutaDepois(Sender: TObject);
begin
  FProcesso.Synchronize(
  procedure
  begin
   Memo1.Lines.Add('Fim da execu??o da thread!');
  end);
end;

procedure TForm1.TratamentoExeception(Sender: TObject);
begin
  if Sender is TThread then
  begin
    if Assigned(TThread(Sender).FatalException) then
    begin
      Memo1.Lines.Add('Ocorreu um erro: ' + Exception(TThread(Sender).FatalException).Message);
    end;
  end;
end;

{ TProcesso }

constructor TProcesso.Create(AMemo: TMemo);
begin
  inherited Create(True);
  Self.FreeOnTerminate := True;
  FAux := '';
  FMemo := AMemo;
end;

procedure TProcesso.Execute;
var
  I : Integer;
begin
  inherited;

  I := 0;
  while I < 100000 do
  begin
    I := I + 1;
    Self.FAux := 'Valor de I: ' + IntToStr(I);
    Self.Queue(Self.Sincronizar);
    Self.Sleep(1);

    raise Exception.Create('Ocorreu um probema!');
  end;
end;

procedure TProcesso.Sincronizar;
begin
  FMemo.Lines.Add(Self.FAux);
end;

end.
