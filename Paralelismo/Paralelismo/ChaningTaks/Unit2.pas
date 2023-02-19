unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Imaging.GIFImg, Vcl.ExtCtrls, System.Threading, Vcl.StdCtrls, Unit3,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids;

type
  TForm2 = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    FDConnection1: TFDConnection;
    FDTable1: TFDTable;
    DataSource1: TDataSource;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    AllTasks: array of ITask;
    fLoading : TForm3;
  public
    { Public declarations }
    procedure RunTask(var aTask: ITask);
    procedure ExibirLoading;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  SetLength(AllTasks, 1);
  RunTask(AllTasks[0]);
  ExibirLoading;
end;

procedure TForm2.ExibirLoading;
begin
  TTask.Run(
  procedure
  begin
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      fLoading := TForm3.Create(nil);
      fLoading.Show;
    end);

    TTask.WaitForAll(AllTasks);
    TThread.Queue(TThread.CurrentThread,
    procedure
    begin
      fLoading.Close;
      fLoading.Free;
    end);
  end);
end;

procedure TForm2.RunTask(var aTask: ITask);
begin
  aTask := TTask.Run(
    procedure
    begin
      FDTable1.Close;
      Sleep(10000);
      TThread.Synchronize(nil,
        procedure
        begin
          FDTable1.Open;
        end);

    end);
end;

end.
