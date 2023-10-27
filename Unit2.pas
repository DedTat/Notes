unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.ExtCtrls, Vcl.ImgList;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    A1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    FontDialog1: TFontDialog;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    Edit1: TEdit;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    ImageList1: TImageList;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    procedure N4Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

    procedure Save;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

const
  extention = '.txt';  //���������� ����� �������
  path = 'C:\Notes\';  //���� � ����� � ���������
implementation

{$R *.dfm}

uses Unit1, Unit3;

//���������
procedure TForm2.Button1Click(Sender: TObject);

begin
//  Save;    //����� ����� ��������� ����������
  ShowMessage('������� ������� ���������!');  //������� ������������ ������ ����������
end;

//�����
procedure TForm2.Button2Click(Sender: TObject);
begin
  Form2.Close;       //������� �����
  Form1.FileListBox1.Update;  //������� ������ � �������� � �����
end;

//������������� ����������� ������������ ������ ������������ ������� � ��� �������
procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 // ��������� ������� �������
 case Key of
  // ����� ���������
  '0'..'9': key:=key;
  // ���������  ����������� (������ ������ �������������)
  '.', ',','_': key:='_';
  //����� ����������� ��������
  'a'..'z': key:=key;
  //��������� ����� ����������� ��������
  'A'..'Z': key:=key;
  //����� �������� ��������
  '�'..'�': key:=key;
  //��������� ����� ������� ��������
  '�'..'�': key:=key;
  //����� � � �
  '�','�': key:=key;
  // ��������� BackSpace
  #8: key:=key;
  // ��� ������ ������� ���������
  else key:=#0;
 end;
end;

//�������� �����
procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  rezult : TModalResult;
begin
     rezult := MessageDlg('�� ������ ��������� ��������� � �������?',mtCustom,[mbYes, mbNo],0);
  if rezult = mrYes then
  begin
    Save;                           //��������� ���������� ������ �� ���� � ����
    ShowMessage('������� ������� ���������!');
 //   Form1.FileListBox1.Update;   //������� ������ � �������� � �����
//    Form2.Close;                   //������� �����
   end
   else
   begin
    Memo1.Clear;       //������� ���� �������������� ������
    Edit1.Clear;       //������� ���� �������� �������
//    Form2.Close;       //������� �����
   end;

   Form1.FileListBox1.Update;  //������� ������ � �������� � �����
end;


procedure TForm2.N2Click(Sender: TObject);
begin

end;

//�������(����)
procedure TForm2.N3Click(Sender: TObject);
var
  F : TextFile;
  name : string;
begin
  SaveDialog1.InitialDir := path;
  SaveDialog1.DefaultExt := extention;                //������ ����������
  SaveDialog1.FileName := '';                         //������� ���� ����� � ���������� ���� ���������� �����

  if SaveDialog1.Execute then
   try
      Memo1.Clear;           //������� ���� ������ �������
      Edit1.Clear;           //������� ���� �������� �������

      name := ExtractFileName(SaveDialog1.FileName);   //������ ������ ��� �����
      Delete(name, Pos('.', name), Length(name));      //������ ����������
      Edit1.Text := name;                              //������� � ���� �����

      AssignFile (F, SaveDialog1.FileName);   //������� �������
      ReWrite (F);
      CloseFile (F);
    except
      ShowMessage('������ ���������� �����.');
    end;

  Form1.FileListBox1.Update;    //������� ������ �������
end;

//������� (����)
procedure TForm2.N4Click(Sender: TObject);
var
  name : string;
begin
  OpenDialog1.InitialDir := path;                     //������ ����� � ���������
  OpenDialog1.DefaultExt := extention;                //������ ����������

  if OpenDialog1.Execute then
  try
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);  //�������� � ���� ��������� ����� �� �����
    name := ExtractFileName(OpenDialog1.FileName);   //������ ������ ��� �����
    Delete(name, Pos('.', name), Length(name));      //������ ����������
    Edit1.Text := name;                              //������� � ���� ����� ����� ��������������
  except
   ShowMessage('������ �������� �����.');
  end;
end;

//��������� ���...(����)
procedure TForm2.N7Click(Sender: TObject);
var
  name : string;
begin
  SaveDialog1.InitialDir := path;                   //������ ����� � ���������
  saveDialog1.DefaultExt := extention;              //������ ����������
  SaveDialog1.FileName := Edit1.Text + '_new';      //��������� ��������� ��� �� ���� �������� � ��� �����

  if SaveDialog1.Execute then
  try
    name := ExtractFileName(SaveDialog1.FileName);  //������ ������ ��� �����
    Delete(name, Pos('.', name), Length(name));     //������ ����������
    Edit1.Text := name;                             //������� � ���� ����� ����� ��������������

    //���������� �� ���� ��������� ������ ������� � ���� �� ������
    Form2.Memo1.Lines.SaveToFile(SaveDialog1.FileName);
  except
    ShowMessage('������ ���������� �����.');
  end;

  Form1.FileListBox1.Update; //������� ������ � �������� � �����
end;

//��������� (��������������)
procedure TForm2.N5Click(Sender: TObject);
begin
    Save;
end;

//��������(��������������)
procedure TForm2.N6Click(Sender: TObject);
begin
   Memo1.Clear;
end;

//� ��������� (�������)
procedure TForm2.N8Click(Sender: TObject);
begin
  Form3.Show;
end;

//��������� ����������
procedure TForm2.Save;
begin
  //���������� �� ���� ��������� ����� � ���� �� ������
  Form2.Memo1.Lines.SaveToFile(Form1.FileListBox1.Directory+'\'+Form2.Edit1.Text+extention);

  Form1.FileListBox1.Update;  //������� ������ � �������� � �����
end;

end.



