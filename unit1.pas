unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, LazFileUtils, LazUTF8, Forms, EditBtn, StdCtrls, Buttons,
  ExtCtrls, Classes, Controls;
type

  { TfrmFileConvertor }

  TfrmFileConvertor = class(TForm)
    ApplicationProperties1: TApplicationProperties;
    BitBtn1: TBitBtn;
    edtFilename: TFileNameEdit;
    Label1: TLabel;
    mmoTextPreview: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure ApplicationProperties1DropFiles(Sender: TObject;
      const FileNames: array of String);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of String);
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

procedure TfrmFileConvertor.ApplicationProperties1DropFiles(Sender: TObject;
  const FileNames: array of String);
begin
  if FileExistsUTF8(FileNames[0]) then
    ConvertFile(FileNames[0]);
end;

procedure TfrmFileConvertor.BitBtn1Click(Sender: TObject);
begin

  if FileExistsUTF8(edtFilename.FileName) then
    ConvertFile(edtFilename.FileName);
end;

procedure TfrmFileConvertor.FormDropFiles(Sender: TObject;
  const FileNames: array of String);
begin
   if FileExistsUTF8(FileNames[0]) then
     ConvertFile(FileNames[0]);
end;

procedure TfrmFileConvertor.ConvertFile(FileName: string);
var
  myFile : TextFile;
  textLn, replacedLine, newFileName   : string;
begin
   edtFilename.Text := FileName;
   mmoTextPreview.Lines.Clear;
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

