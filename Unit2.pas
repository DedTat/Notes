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
  extention = '.txt';  //расширение файла заметки
  path = 'C:\Notes\';  //путь к папке с заметками
implementation

{$R *.dfm}

uses Unit1, Unit3;

//Сохранить
procedure TForm2.Button1Click(Sender: TObject);

begin
//  Save;    //вызов своей процедуры сохранения
  ShowMessage('Заметка успешно сохранена!');  //сообщим пользователю статус сохранения
end;

//Выход
procedure TForm2.Button2Click(Sender: TObject);
begin
  Form2.Close;       //закроем форму
  Form1.FileListBox1.Update;  //обновим данные о заметках в папке
end;

//Предотвращаем возможность пользователя ввести недопустимые символы в имя заметки
procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 // проверяем нажатую клавишу
 case Key of
  // цифры разрешаем
  '0'..'9': key:=key;
  // разрешаем  разделитель (только нижнее подчеркивание)
  '.', ',','_': key:='_';
  //буквы английского алфавита
  'a'..'z': key:=key;
  //заглавные буквы английского алфавита
  'A'..'Z': key:=key;
  //буквы русского алфавита
  'а'..'я': key:=key;
  //заглавные буквы руского алфавита
  'А'..'Я': key:=key;
  //буква Ё и ё
  'Ё','ё': key:=key;
  // разрешаем BackSpace
  #8: key:=key;
  // все прочие клавиши запрещаем
  else key:=#0;
 end;
end;

//Закрытие формы
procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  rezult : TModalResult;
begin
     rezult := MessageDlg('Вы хотите сохранить изменения в заметке?',mtCustom,[mbYes, mbNo],0);
  if rezult = mrYes then
  begin
    Save;                           //процедура сохранения текста из поля в файл
    ShowMessage('Заметка успешно сохранена!');
 //   Form1.FileListBox1.Update;   //обновим данные о заметках в папке
//    Form2.Close;                   //закроем форму
   end
   else
   begin
    Memo1.Clear;       //очистим поле редактирования текста
    Edit1.Clear;       //очистим поле названия заметки
//    Form2.Close;       //закроем форму
   end;

   Form1.FileListBox1.Update;  //обновим данные о заметках в папке
end;


procedure TForm2.N2Click(Sender: TObject);
begin

end;

//Создать(Файл)
procedure TForm2.N3Click(Sender: TObject);
var
  F : TextFile;
  name : string;
begin
  SaveDialog1.InitialDir := path;
  SaveDialog1.DefaultExt := extention;                //укажем расширение
  SaveDialog1.FileName := '';                         //очистим поле имени в вызываемом окне сохранения файла

  if SaveDialog1.Execute then
   try
      Memo1.Clear;           //очистим поле текста заметки
      Edit1.Clear;           //очистим поле названия заметки

      name := ExtractFileName(SaveDialog1.FileName);   //возьмём только имя файла
      Delete(name, Pos('.', name), Length(name));      //удалим расширение
      Edit1.Text := name;                              //запишем в поле имени

      AssignFile (F, SaveDialog1.FileName);   //создаем заметку
      ReWrite (F);
      CloseFile (F);
    except
      ShowMessage('Ошибка сохранения файла.');
    end;

  Form1.FileListBox1.Update;    //Обновим список заметок
end;

//Открыть (Файл)
procedure TForm2.N4Click(Sender: TObject);
var
  name : string;
begin
  OpenDialog1.InitialDir := path;                     //укажем папку с заметками
  OpenDialog1.DefaultExt := extention;                //укажем расширение

  if OpenDialog1.Execute then
  try
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);  //загрузим в поле редактора текст из файла
    name := ExtractFileName(OpenDialog1.FileName);   //возьмём только имя файла
    Delete(name, Pos('.', name), Length(name));      //удалим расширение
    Edit1.Text := name;                              //запишем в поле имени формы Редактирование
  except
   ShowMessage('Ошибка открытия файла.');
  end;
end;

//Сохранить как...(Файл)
procedure TForm2.N7Click(Sender: TObject);
var
  name : string;
begin
  SaveDialog1.InitialDir := path;                   //укажем папку с заметками
  saveDialog1.DefaultExt := extention;              //укажем расширение
  SaveDialog1.FileName := Edit1.Text + '_new';      //передадим изменённое имя из поля названия в имя файла

  if SaveDialog1.Execute then
  try
    name := ExtractFileName(SaveDialog1.FileName);  //возьмём только имя файла
    Delete(name, Pos('.', name), Length(name));     //удалим расширение
    Edit1.Text := name;                             //запишем в поле имени формы Редактирование

    //Сохранение из поля редактора текста заметки в файл по адресу
    Form2.Memo1.Lines.SaveToFile(SaveDialog1.FileName);
  except
    ShowMessage('Ошибка сохранения файла.');
  end;

  Form1.FileListBox1.Update; //обновим данные о заметках в папке
end;

//Сохранить (Редактирование)
procedure TForm2.N5Click(Sender: TObject);
begin
    Save;
end;

//Очистить(Редактирование)
procedure TForm2.N6Click(Sender: TObject);
begin
   Memo1.Clear;
end;

//О программе (Справка)
procedure TForm2.N8Click(Sender: TObject);
begin
  Form3.Show;
end;

//ПРоцедура сохранения
procedure TForm2.Save;
begin
  //Сохранение из поля редактора строк в файл по адресу
  Form2.Memo1.Lines.SaveToFile(Form1.FileListBox1.Directory+'\'+Form2.Edit1.Text+extention);

  Form1.FileListBox1.Update;  //обновим данные о заметках в папке
end;

end.



