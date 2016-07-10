unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, LazFileUtils, LazUTF8, Forms, EditBtn, StdCtrls, Buttons,
  ExtCtrls, Classes;
type

  { TfrmFileConvertor }

  TfrmFileConvertor = class(TForm)
    BitBtn1: TBitBtn;
    FileNameEdit1: TFileNameEdit;
    Label1: TLabel;
    mmoTextPreview: TMemo;
    Panel1: TPanel;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { private declarations }
    procedure ConvertFile(FileName: string);
  public
    { public declarations }
  end;

var
  frmFileConvertor: TfrmFileConvertor;

implementation

{$R *.lfm}

{ TfrmFileConvertor }

procedure TfrmFileConvertor.FormCreate(Sender: TObject);
begin

end;
procedure TfrmFileConvertor.BitBtn1Click(Sender: TObject);
begin

  if FileExistsUTF8(FileNameEdit1.FileName) then
    ConvertFile(FileNameEdit1.FileName);
end;

procedure TfrmFileConvertor.ConvertFile(FileName: string);
var
  myFile : TextFile;
  textLn, replacedLine, newFileName   : string;
begin
   newFileName := StringReplace(FileName, 'txt', 'csv', [rfReplaceAll, rfIgnoreCase]);
   AssignFile(myFile, FileName);
   Reset(myFile);
   // Display the file contents
   while not Eof(myFile) do
   begin
     ReadLn(myFile, textLn);
     replacedLine := StringReplace(textLn, ';', ',', [rfReplaceAll, rfIgnoreCase]);
     mmoTextPreview.Lines.Add(replacedLine);
   end;

   mmoTextPreview.Lines.SaveToFile(newFileName);

end;

end.

