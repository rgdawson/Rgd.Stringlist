unit DemoForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Diagnostics,
  System.StrUtils,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Rgd.Stringlist;

type
  MyRecord = record
    ANumber: integer;
    AString: string;
  end;

  TMainForm = class(TForm)
    btnTest1: TButton;
    Memo1: TMemo;
    btnAlign: TButton;
    Button9: TButton;
    btnClear: TButton;
    btnClose: TButton;
    procedure btnTest1Click(Sender: TObject);
    procedure btnAlignClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    //
  public
    //
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

function TrueFalse(ABool: Boolean): string;
begin
  If ABool then
    Result := 'True'
  else
    Result := 'False';
end;

function GenerateRandomString(const ALength: Integer; const ACharSequence: String = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'): String;
var
  Ch, SequenceLength: Integer;
begin
  SequenceLength := Length(ACharSequence);
  SetLength(Result, ALength);
  Randomize;
  for Ch := Low(Result) to High(Result) do
    Result[Ch] := ACharSequence.Chars[Random(SequenceLength)];
end;

procedure TMainForm.btnClearClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TMainForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

function SortStringList_ValParam(AStringList: StringList): Stringlist;
begin
  AStringList.Sort;
  Result := AStringlist;
end;

function SortStringList_ConstParam(const AStringList: StringList): Stringlist;
begin
  AStringList.Sort;
  Result := AStringlist;
end;

procedure TMainForm.btnTest1Click(Sender: TObject);
var
  Strings1: Stringlist;
  Strings2: Stringlist;
begin
  Memo1.Lines.BeginUpdate;
  Memo1.Lines.Add(StringOfChar('=', 70));
  Memo1.Lines.Add('BEGIN: Stringlist class operators ');
  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.Add('Code: Strings1 := Stringlist.Default(dupIgnore, True, False);');
  Memo1.Lines.Add(StringOfChar('-', 70));

  Strings1 := Stringlist.Default(dupIgnore, True, False);

  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.Add('Code: Strings1.AddStrings([''CCCCC'', ''BBBBB'', ''DDDDD'', ''AAAA'']);');
  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.Add('Strings1:');
  Memo1.Lines.Add(StringOfChar('-', 70));
  Strings1.AddStrings(['CCCCC', 'BBBBB', 'DDDDD', 'AAAA']);
  Memo1.Lines.AddStrings(Strings1);

  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.Add('Code: Strings2 := Strings1');
  Memo1.Lines.Add('Strings2:');
  Memo1.Lines.Add(StringOfChar('-', 70));
  Strings2 := Strings1;
  Memo1.Lines.AddStrings(Strings2);

  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.Add('Code: Strings2 := Stringlist.Default;');
  Memo1.Lines.Add(StringOfChar('-', 70));
  Strings2 := Stringlist.Default; {not sorted}

  Memo1.Lines.Add('Code: Strings2.AddStrings([''CCCCC'', ''BBBBB'', ''DDDDD'', ''AAAA''])');
  Strings2.AddStrings(['CCCCC', 'BBBBB', 'DDDDD', 'AAAA']);
  Memo1.Lines.Add('Strings2:');
  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.AddStrings(Strings2);

  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.Add('Code: Memo1.Lines.AddStrings(SortStringList_ValParam(Strings2));');
  Memo1.Lines.AddStrings(SortStringList_ValParam(Strings2));
  Memo1.Lines.Add(StringOfChar('-', 70));

  Memo1.Lines.Add('Code: Memo1.Lines.AddStrings(MyStrings2);');
  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.AddStrings(Strings2);

  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.Add('Code: Memo1.Lines.AddStrings(SortStringList_ConstParam(Strings2));');
  Memo1.Lines.AddStrings(SortStringList_ConstParam(Strings2));
  Memo1.Lines.Add(StringOfChar('-', 70));

  Memo1.Lines.Add('Code: Memo1.Lines.AddStrings(MyStrings2);');
  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.AddStrings(Strings2);

  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.Add('END: Stringlist class operators ');
  Memo1.Lines.Add(StringOfChar('=', 70));
  Memo1.Lines.EndUpdate;
end;

procedure TMainForm.btnAlignClick(Sender: TObject);
var
  i, j: integer;
  S: string;
  SL0, SL1: Stringlist;
begin
  Memo1.Lines.BeginUpdate;
  Memo1.Lines.Add('======================');
  Memo1.Lines.Add('BEGIN: Delimiter Align ');
  Memo1.Lines.Add('----------------------');

  for i := 0 to 9 do
  begin
    SL0.Clear;
    for j := 0 to 5 do
    begin
      S := GenerateRandomString(Random(12)+4);
      SL0.Add(S);
    end;
   SL1.Add(SL0.CommaText);
  end;

  Memo1.Lines.AddStrings(SL1);
  Memo1.Lines.Add('---------------------------');
  Memo1.Lines.Add('Call: SL1.AlignDelimiters()');
  Memo1.Lines.Add('---------------------------');
  SL1.Text := Trim(ReplaceStr(Sl1.Text, ',', ', '));
  SL1.AlignDelimiters(',');
  Memo1.Lines.AddStrings(SL1);
  Memo1.Lines.Add('----------------------');
  Memo1.Lines.Add('END: Delimiter Align ');
  Memo1.Lines.Add('======================');
  Memo1.Lines.EndUpdate;
end;

procedure TMainForm.Button9Click(Sender: TObject);
var
  SL1, SL2, SL3: Stringlist;
begin
  Memo1.Lines.BeginUpdate;
  Memo1.Lines.Add(StringOfChar('=', 70));
  Memo1.Lines.Add('BEGIN: Set Intersection');
  SL1.Sorted := False;

  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.Add('Code: SL1.AddStrings([''Greg'', ''Monica'', ''Robert'', ''Bob'', ''Mark'']);');
  Memo1.Lines.Add('Code: SL1.AddStrings([''Rita'', ''Monica'', ''Robert'', ''Gina'', ''Dawson'']);');
  SL1.AddStrings(['Greg', 'Monica', 'Robert', 'Bob', 'Mark']);
  SL2.AddStrings(['Rita', 'Monica', 'Robert', 'Gina', 'Dawson']);
  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.Add('Code: SL3 := SL1.IntersectWith(SL2);');
  Memo1.Lines.Add(StringOfChar('-', 70));
  Sl3.Sorted := True;
  SL3 := SL1.IntersectWith(SL2);
  Memo1.Lines.Add('SL3 = ' + SL3.CommaText);
  Memo1.Lines.Add(StringOfChar('-', 70));
  Memo1.Lines.Add('END: Set Intersection');
  Memo1.Lines.Add(StringOfChar('=', 70));
  Memo1.Lines.EndUpdate;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  LogMemo := Memo1;
end;

end.
