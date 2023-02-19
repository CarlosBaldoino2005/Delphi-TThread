unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  SyncObjs;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Memo1: TMemo;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    procedure BuscarDados( aSql : String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BuscarDados(aSql: String);
begin
  FDQuery1.Open(aSql);
  Memo1.Lines.Add(aSql);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

  TThread.CreateAnonymousThread(
  procedure
  begin
    TThread.Sleep(1000);
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      BuscarDados('SELECT * FROM CLIENTE');
    end);
  end
  ).Start;

  TThread.CreateAnonymousThread(
  procedure
  begin
    TThread.Sleep(1000);
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      BuscarDados('SELECT * FROM MENSAGERIA');
    end);
  end
  ).Start;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  FSession : TCriticalSection;
begin
  FSession := TCriticalSection.Create;

  TThread.CreateAnonymousThread(
  procedure
  begin
    FSession.Enter;
    try
      TThread.Sleep(1000);
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        BuscarDados('SELECT * FROM CLIENTE');
      end);
    finally
      FSession.Leave;
    end;

  end
  ).Start;

  TThread.CreateAnonymousThread(
  procedure
  begin
    FSession.Enter;
    try
      TThread.Sleep(1000);
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        BuscarDados('SELECT * FROM MENSAGERIA');
      end);
    finally
      FSession.Leave;
    end;

  end
  ).Start;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    System.TMonitor.Enter(FDQuery1);
    try
      TThread.Sleep(1000);
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        BuscarDados('SELECT * FROM CLIENTE');
      end);
    finally
      System.TMonitor.Exit(FDQuery1);
    end;

  end
  ).Start;

  TThread.CreateAnonymousThread(
  procedure
  begin
    System.TMonitor.Enter(FDQuery1);
    try
      TThread.Sleep(1000);
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        BuscarDados('SELECT * FROM MENSAGERIA');
      end);
    finally
      System.TMonitor.Exit(FDQuery1);
    end;
  end
  ).Start;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin

  TThread.CreateAnonymousThread(
  procedure
  begin
    TThread.Sleep(5000);
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      Memo1.Lines.Add('Teste AnonymousThread');
    end);
  end).Start;

end;

end.
