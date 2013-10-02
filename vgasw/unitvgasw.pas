unit unitvgasw; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, Menus, process, about;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    Process1: TProcess;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure Label4Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1;
  highgpu: TProcess;
  lowgpu: TProcess;
  checkgpu:TProcess;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  highgpu := TProcess.Create(nil);
  highgpu.CommandLine := 'gksu /opt/ucc/highgpu.sh';
  highgpu.Execute;
 //Countdown
 sleep(9000);
 //Kill gnome session
 highgpu:= TProcess.Create(nil);
 highgpu.CommandLine := 'gksu service lightdm restart';
 highgpu.Execute;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  lowgpu := TProcess.Create(nil);
  lowgpu.CommandLine := 'gksu /opt/ucc/lowgpu.sh';
  lowgpu.Execute;
  //Countdown
   sleep(9000);
  //Kill gnome session
  lowgpu:= TProcess.Create(nil);
  lowgpu.CommandLine := 'gksu service lightdm restart';
  lowgpu.Execute;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
 //Check actual state
 checkgpu:= TProcess.Create(nil);
 checkgpu.CommandLine := 'gksu /opt/ucc/check_vga.sh';
 checkgpu.Execute;
 memo1.lines.loadfromfile('/opt/ucc/vga.txt');
end;

procedure TForm1.FormDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
 //Check actual state
 checkgpu:= TProcess.Create(nil);
 checkgpu.CommandLine := 'gksu /opt/ucc/check_vga.sh';
 checkgpu.Execute;
 memo1.lines.loadfromfile('/opt/ucc/vga.txt');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  //Check actual state
 checkgpu:= TProcess.Create(nil);
 checkgpu.CommandLine := 'gksu /opt/ucc/check_vga.sh';
 checkgpu.Execute;
 memo1.lines.loadfromfile('/opt/ucc/vga.txt');
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
  aboutform.show;
end;

end.

