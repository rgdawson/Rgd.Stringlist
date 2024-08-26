Unit Rgd.Stringlist;

{ StringList is a  Delphi Custom Managed Record implementation of TStringlist.
  Stringlist does not need to be explcitly created/freed in your code.
  https://blogs.embarcadero.com/custom-managed-records-coming-to-delphi-10-4/

  Usage Example:

    procedure MyProc;
    var
      LStrings: StringList;
    begin
      LStrings.Add('test1');
      LStrings.Add('test2');
      Memo1.Lines.AddStrings(LStrings);
    end;

  Custom Managed Record class operators:

    (1) This implementation uses Delphi's Custom Managed Record class operators.
        The class operators Initialize() and Finalize() Create and Free the internal
        TStringlist. Each instance has its own unique internal TStringlist, 
        so no need for reference counting on the internal TStringlist.
        Basically, A := B is the same as A.Assign(B)
    (2) Implicits allow you to pass a StringList to TObject, TPersistent,
        TStrings, and TStringlist.

  Differences with a regular TStringlist

    (1) When passing a StringList as a value parameter to a function, instead 
        of var or const, a new record gets created and all the strings are copied 
        to the new record's internal TStringlist, leaving the original unchanged.
    (2) CommaText property always uses StrictDelimiter = True (my own preference)
        Use DelimitedText property if you need StrictDelimer = False.
    (3) Some additional functions have been added, such as set functions, and more...

  Other:

    (1) This is based on Delphi's TStringlist implementation as of Delphi 12.
        If using with an older version of Delphi, you may need to remove refences
        to missing members that were not present in an ealier version of Delphi.
        
    (2) Stringlist records can be "re-constructed"/reinitialized using:
          MyStrings := Stringlist.Default
            - Create a new default Stringlist
          MyStrings := Stringlist.Default(...)
            - Create a new Stringlist with specified properties (like TStringlist constructors)
          MyStrings := Stringlist.Default(Strings1)
            - Create a new TRgdStringlist with same properties as Strings1.

        WARNING, DO NOT USE:  MyStrings := Default(Stringlist);
          as this causes a memory leak as MyStringlist gets Initialized twice and finalized once
          and the original FData does not get freed.  Not sure why yet, cuz I thought it should.
          INSTEAD, use MyStrings := Stringlist.Default;}

Interface

uses
  WinApi.Windows,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections;

type
  TRgdStringlist = record
  private
    {Internal TStringlist...}
    FData: TStringList;
    {Getters/Setters...}
    function Get(Index: Integer): string;
    function GetCapacity: Integer;
    function GetCaseSensitive: Boolean;
    function GetCommaText: string; {Rgd!! Always uses StrictDelimiter=True}
    function GetCount: Integer;
    function GetDefaultEncoding: TEncoding;
    function GetDelimitedText: string;
    function GetDelimiter: Char;
    function GetDuplicates: TDuplicates;
    function GetEncoding: TEncoding;
    function GetIsEmpty: Boolean;
    function GetKeyNames(Index: integer): string;
    function GetLineBreak: string;
    function GetName(Index: Integer): string;
    function GetNameValueSeparator: Char;
    function GetObject(Index: Integer): TObject;
    function GetOnChange: TNotifyEvent;
    function GetOnChanging: TNotifyEvent;
    function GetOptions: TStringsOptions;
    function GetOwnsObjects: Boolean;
    function GetQuoteChar: Char;
    function GetSorted: Boolean;
    function GetStrictDelimiter: Boolean;
    function GetStringsAdapter: IStringsAdapter;
    function GetTextStr: string;
    function GetTrailingLineBreak: Boolean;
    function GetUpdating: Boolean;
    function GetUseLocale: Boolean;
    function GetValue(const Name: string): string;
    function GetValueFromIndex(Index: Integer): string;
    function GetWriteBOM: Boolean;
    procedure Put(Index: Integer; const Value: string);
    procedure PutObject(Index: Integer; Value: TObject);
    procedure SetCapacity(Value: Integer);
    procedure SetCaseSensitive(const Value: Boolean);
    procedure SetCommaText(const Value: string); {Rgd!! Always uses StrictDelimiter=True}
    procedure SetDefaultEncoding(const Value: TEncoding);
    procedure SetDelimitedText(const Value: string);
    procedure SetDelimiter(const Value: Char);
    procedure SetDuplicates(const Value: TDuplicates);
    procedure SetLineBreak(const Value: string);
    procedure SetNameValueSeparator(const Value: Char);
    procedure SetOnChange(const Value: TNotifyEvent);
    procedure SetOnChanging(const Value: TNotifyEvent);
    procedure SetOptions(const Value: TStringsOptions);
    procedure SetOwnsObjects(const Value: Boolean);
    procedure SetQuoteChar(const Value: Char);
    procedure SetSorted(const Value: Boolean);
    procedure SetStrictDelimiter(const Value: Boolean);
    procedure SetStringsAdapter(const Value: IStringsAdapter);
    procedure SetTextStr(const Value: string);
    procedure SetTrailingLineBreak(const Value: Boolean);
    procedure SetUseLocale(const Value: Boolean);
    procedure SetValue(const Name, Value: string);
    procedure SetValueFromIndex(Index: Integer; const Value: string);
    procedure SetWriteBOM(const Value: Boolean);
  public
    class operator Initialize(out Dest: TRgdStringlist);
    class operator Finalize(var Dest: TRgdStringlist);
    class operator Assign(var Dest: TRgdStringlist; const [ref] Source: TRgdStringlist);
    class operator Implicit(const AValue: TRgdStringlist): TObject;
    class operator Implicit(const AValue: TRgdStringlist): TPersistent;
    class operator Implicit(const AValue: TRgdStringlist): TStrings;
    class operator Implicit(const AValue: TRgdStringlist): TStringlist;
  public
    {Record "Constructors" (I elected to use class functions as more efficient.  Analogous to TStringlist Constructors}
    class function Default: TRgdStringlist; overload; static;
    class function Default(OwnsObjects: Boolean): TRgdStringlist; overload; static;
    class function Default(QuoteChar, Delimiter: Char): TRgdStringlist; overload; static;
    class function Default(QuoteChar, Delimiter: Char; Options: TStringsOptions): TRgdStringlist; overload; static;
    class function Default(Duplicates: TDuplicates; Sorted: Boolean; CaseSensitive: Boolean = False): TRgdStringlist; overload; static;
    {TStringlist Methods and properties...}
    function Add(const S: string): Integer;
    function AddObject(const S: string; AObject: TObject): Integer; overload;
    function AddPair(const Name, Value: string): TStrings; overload;
    function AddPair(const Name, Value: string; AObject: TObject): TStrings; overload;
    function Contains(const S: string): Boolean;
    function ContainsName(const S: string): Boolean;
    function ContainsObject(const AObject: TObject): Boolean;
    function Equals(Strings: TStrings): Boolean;
    function Find(const S: string; var Index: Integer): Boolean;
    function GetEnumerator: TStringsEnumerator;
    function GetHashCode: Integer;
    function GetText: PChar;
    function IndexOf(const S: string): Integer;
    function IndexOfName(const Name: string): Integer;
    function IndexOfObject(AObject: TObject): Integer;
    function ToStringArray: TArray<string>;
    procedure AddStrings(const Strings: array of string); overload;
    procedure AddStrings(Strings: TStrings); overload;
    procedure Append(const S: string);
    procedure Assign(Source: TPersistent);
    procedure BeginUpdate;
    procedure Clear;
    procedure CustomSort(Compare: TStringListSortCompare);
    procedure Delete(Index: Integer);
    procedure EndUpdate;
    procedure Exchange(Index1, Index2: Integer);
    procedure Insert(Index: Integer; const S: string);
    procedure InsertObject(Index: Integer; const S: string; AObject: TObject);
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure Move(CurIndex, NewIndex: Integer);
    procedure SaveToFile(const FileName: string); overload;
    procedure SaveToFile(const FileName: string; Encoding: TEncoding); overload;
    procedure SaveToStream(Stream: TStream); overload;
    procedure SaveToStream(Stream: TStream; Encoding: TEncoding); overload;
    procedure SetStrings(Source: TStrings); overload;
    procedure SetText(Text: PChar);
    procedure Sort;
    {Properties...}
    property Capacity: Integer                      read GetCapacity            write SetCapacity;
    property CaseSensitive: Boolean                 read GetCaseSensitive       write SetCaseSensitive;
    property CommaText: string                      read GetCommaText           write SetCommaText;
    property Count: Integer                         read GetCount;
    property DefaultEncoding: TEncoding             read GetDefaultEncoding     write SetDefaultEncoding;
    property DelimitedText: string                  read GetDelimitedText       write SetDelimitedText;
    property Delimiter: Char                        read GetDelimiter           write SetDelimiter;
    property Duplicates: TDuplicates                read GetDuplicates          write SetDuplicates;
    property Encoding: TEncoding                    read GetEncoding;
    property IsEmpty: Boolean                       read GetIsEmpty;
    property KeyNames[Index: Integer]: string       read GetKeyNames;
    property LineBreak: string                      read GetLineBreak           write SetLineBreak;
    property Names[Index: Integer]: string          read GetName;
    property NameValueSeparator: Char               read GetNameValueSeparator  write SetNameValueSeparator;
    property Objects[Index: Integer]: TObject       read GetObject              write PutObject;
    property Options: TStringsOptions               read GetOptions             write SetOptions;
    property OwnsObjects: Boolean                   read GetOwnsObjects         write SetOwnsObjects;
    property QuoteChar: Char                        read GetQuoteChar           write SetQuoteChar;
    property Sorted: Boolean                        read GetSorted              write SetSorted;
    property StrictDelimiter: Boolean               read GetStrictDelimiter     write SetStrictDelimiter;
    property Strings[Index: Integer]: string        read Get                    write Put; default;
    property StringsAdapter: IStringsAdapter        read GetStringsAdapter      write SetStringsAdapter;
    property Text: string                           read GetTextStr             write SetTextStr;
    property TrailingLineBreak: Boolean             read GetTrailingLineBreak   write SetTrailingLineBreak;
    property Updating: Boolean                      read GetUpdating;
    property UseLocale: Boolean                     read GetUseLocale           write SetUseLocale;
    property ValueFromIndex[Index: Integer]: string read GetValueFromIndex      write SetValueFromIndex;
    property Values[const Name: string]: string     read GetValue               write SetValue;
    property WriteBOM: Boolean                      read GetWriteBOM            write SetWriteBOM;
    property OnChange: TNotifyEvent                 read GetOnChange            write SetOnChange;
    property OnChanging: TNotifyEvent               read GetOnChanging          write SetOnChanging;

  {Added Methods and Properties...}
  public
    {Additional "constructors"}
    class function Default(QuoteChar, Delimiter: Char; StrictDelimiter: Boolean): TRgdStringlist; overload; static;
    class function Default(const RgdStrings: TRgdStringlist): TRgdStringlist; overload; static;
    {Additional methods}
    function CommaText2: string;
    function IndexOfSubString    (SubStr: string): integer;
    function IndexOfSubText      (SubText: string): integer;
    function Reversed: TRgdStringlist;
    procedure AlignDelimiters(const DelimStr: string);
    procedure SetStrings(StrArray: array of string); overload;
    {Set operations...}
    function DifferenceWith (Other: TStrings): TRgdStringlist;
    function ExceptWith     (Other: TStrings): TRgdStringlist;
    function IntersectWith  (Other: TStrings): TRgdStringlist;
    function UnionWith      (Other: TStrings): TRgdStringlist;
    function Overlaps       (Other: TStrings): Boolean;
    function SetEquals      (Other: TStrings): Boolean;
  end;

type
  StringList = TRgdStringlist;

Implementation


{$REGION ' CMR class Operators and functions '}

class operator TRgdStringlist.Initialize(out Dest: TRgdStringlist);
begin
  Dest.FData := TStringList.Create;
end;

class operator TRgdStringlist.Finalize(var Dest: TRgdStringlist);
begin
  Dest.FData.Free;
end;

class operator TRgdStringlist.Assign(var Dest: TRgdStringlist; const [ref] Source: TRgdStringlist);
begin
  Dest.FData.Assign(Source.FData);
end;

class operator TRgdStringlist.Implicit(const AValue: TRgdStringlist): TObject;
begin
  Result := AValue.FData;
end;

class operator TRgdStringlist.Implicit(const AValue: TRgdStringlist): TPersistent;
begin
  Result := AValue.FData;
end;

class operator TRgdStringlist.Implicit(const AValue: TRgdStringlist): TStrings;
begin
  Result := AValue.FData;
end;

class operator TRgdStringlist.Implicit(const AValue: TRgdStringlist): TStringlist;
begin
  Result := AValue.FData;
end;

class function TRgdStringlist.Default(OwnsObjects: Boolean): TRgdStringlist;
begin
  Result := TRgdStringlist.Default;
  Result.OwnsObjects := OwnsObjects;
end;

class function TRgdStringlist.Default(QuoteChar, Delimiter: Char): TRgdStringlist;
begin
  Result := TRgdStringlist.Default;
  Result.QuoteChar := QuoteChar;
  Result.Delimiter := Delimiter;
end;

class function TRgdStringlist.Default(QuoteChar, Delimiter: Char; Options: TStringsOptions): TRgdStringlist;
begin
  Result := TRgdStringlist.Default;
  Result.QuoteChar := QuoteChar;
  Result.Delimiter := Delimiter;
  Result.Options := Options;
end;

class function TRgdStringlist.Default(Duplicates: TDuplicates; Sorted: Boolean; CaseSensitive: Boolean = False): TRgdStringlist;
begin
  Result := TRgdStringlist.Default;
  Result.Duplicates := Duplicates;
  Result.Sorted := Sorted;
  Result.CaseSensitive := CaseSensitive;
end;

{$ENDREGION}

{$REGION ' TStringlist Lifted Members '}

function TRgdStringlist.Add(const S: string): Integer;
begin
  Result := FData.Add(S);
end;

function TRgdStringlist.AddPair(const Name, Value: string): TStrings;
begin
  Result := FData.AddPair(Name, Value);
end;

function TRgdStringlist.AddPair(const Name, Value: string; AObject: TObject): TStrings;
begin
  Result := FData.AddPair(Name, Value, AObject);
end;

function TRgdStringlist.AddObject(const S: string; AObject: TObject): Integer;
begin
  Result := FData.AddObject(S, AObject);
end;

function TRgdStringlist.Contains(const S: string): Boolean;
begin
  Result := FData.Contains(S);
end;

function TRgdStringlist.ContainsName(const S: string): Boolean;
begin
  Result := FData.ContainsName(S);
end;

function TRgdStringlist.ContainsObject(const AObject: TObject): Boolean;
begin
  Result := FData.ContainsObject(AObject);
end;

function TRgdStringlist.Equals(Strings: TStrings): Boolean;
begin
  Result := FData.Equals(Strings);
end;

function TRgdStringlist.Find(const S: string; var Index: Integer): Boolean;
begin
  Result := FData.Find(S, Index)
end;

function TRgdStringlist.Get(Index: Integer): string;
begin
  Result := FData[Index];
end;

function TRgdStringlist.GetStringsAdapter: IStringsAdapter;
begin
  Result := FData.StringsAdapter;
end;

function TRgdStringlist.GetCapacity: Integer;
begin
  Result := FData.Capacity;
end;

function TRgdStringlist.GetCaseSensitive: Boolean;
begin
  Result := FData.CaseSensitive;
end;

function TRgdStringlist.GetCommaText: string;
var
  LOldStrictDelimiter: Boolean;
begin
  LOldStrictDelimiter := FData.StrictDelimiter;
  FData.StrictDelimiter := True;
  try
    Result := FData.CommaText;
  finally
    FData.StrictDelimiter := LOldStrictDelimiter;
  end;
end;

function TRgdStringlist.GetCount: Integer;
begin
  Result := FData.Count;
end;

function TRgdStringlist.GetDefaultEncoding: TEncoding;
begin
  REsult := FData.DefaultEncoding;
end;

function TRgdStringlist.GetDelimitedText: string;
begin
  Result := FData.DelimitedText;
end;

function TRgdStringlist.GetDelimiter: Char;
begin
  Result := FData.Delimiter;
end;

function TRgdStringlist.GetDuplicates: TDuplicates;
begin
  Result := FData.Duplicates;
end;

function TRgdStringlist.GetEncoding: TEncoding;
begin
  Result := FData.Encoding;
end;

function TRgdStringlist.GetIsEmpty: Boolean;
begin
  Result := FData.IsEmpty;
end;

function TRgdStringlist.GetKeyNames(Index: integer): string;
begin
  Result := FData.KeyNames[Index];
end;

function TRgdStringlist.GetEnumerator: TStringsEnumerator;
begin
  Result := FData.GetEnumerator;
end;

function TRgdStringlist.GetLineBreak: string;
begin
  Result := FData.LineBreak;
end;

function TRgdStringlist.GetName(Index: Integer): string;
begin
  Result := FData.Names[Index];
end;

function TRgdStringlist.GetNameValueSeparator: Char;
begin
  Result := FData.NameValueSeparator;
end;

function TRgdStringlist.GetObject(Index: Integer): TObject;
begin
  Result := FData.Objects[Index];
end;

function TRgdStringlist.GetOptions: TStringsOptions;
begin
  Result := FData.Options;
end;

function TRgdStringlist.GetOnChange: TNotifyEvent;
begin
  Result := FData.OnChange;
end;

function TRgdStringlist.GetOnChanging: TNotifyEvent;
begin
  Result := FData.OnChanging;
end;

function TRgdStringlist.GetOwnsObjects: Boolean;
begin
  Result := FData.OwnsObjects;
end;

function TRgdStringlist.GetQuoteChar: Char;
begin
  Result := FData.QuoteChar;
end;

function TRgdStringlist.GetSorted: Boolean;
begin
  Result := FData.Sorted;
end;

function TRgdStringlist.GetStrictDelimiter: Boolean;
begin
  Result := FData.StrictDelimiter;
end;

function TRgdStringlist.GetHashCode: integer;
begin
  Result := FData.GetHashCode;
end;

function TRgdStringlist.GetText: PChar;
begin
  Result := StrNew(PChar(FData.Text));
end;

function TRgdStringlist.GetTextStr: string;
begin
  Result := FData.Text;
end;

function TRgdStringlist.GetTrailingLineBreak: Boolean;
begin
  Result := FData.TrailingLineBreak;
end;

function TRgdStringlist.GetUpdating: Boolean;
begin
  Result := FData.Updating;
end;

function TRgdStringlist.GetUseLocale: Boolean;
begin
  Result := FData.UseLocale;
end;

function TRgdStringlist.GetValue(const Name: string): string;
begin
{!  //Result := FData.Values['Name']; }
  Result := FData.Values[Name];
end;

function TRgdStringlist.GetValueFromIndex(Index: Integer): string;
begin
  Result := FData.ValueFromIndex[Index];
end;

function TRgdStringlist.GetWriteBOM: Boolean;
begin
  Result := FData.WriteBOM;
end;

function TRgdStringlist.IndexOf(const S: string): Integer;
begin
  Result := FData.IndexOf(S);
end;

function TRgdStringlist.IndexOfName(const Name: string): Integer;
begin
  Result := FData.IndexOfName(Name);
end;

function TRgdStringlist.IndexOfObject(AObject: TObject): Integer;
begin
  Result := FData.IndexOfObject(AObject);
end;

procedure TRgdStringlist.AddStrings(Strings: TStrings);
begin
  FData.AddStrings(Strings);
end;

procedure TRgdStringlist.AddStrings(const Strings: array of string);
begin
  FData.AddStrings(Strings);
end;

procedure TRgdStringlist.Append(const S: string);
begin
  FData.Append(S);
end;

procedure TRgdStringlist.Assign(Source: TPersistent);
begin
  FData.Assign(Source);
end;

procedure TRgdStringlist.BeginUpdate;
begin
  FData.BeginUpdate;
end;

procedure TRgdStringlist.Clear;
begin
  FData.Clear;
end;

procedure TRgdStringlist.CustomSort(Compare: TStringListSortCompare);
begin
  FData.CustomSort(Compare)
end;

procedure TRgdStringlist.Delete(Index: Integer);
begin
  FData.Delete(Index);
end;

procedure TRgdStringlist.EndUpdate;
begin
  FData.EndUpdate;
end;

procedure TRgdStringlist.Exchange(Index1, Index2: Integer);
begin
  FData.Exchange(Index1, Index2);
end;

procedure TRgdStringlist.Insert(Index: Integer; const S: string);
begin
  FData.Insert(Index, S);
end;

procedure TRgdStringlist.InsertObject(Index: Integer; const S: string; AObject: TObject);
begin
  FData.Insert(Index, S);
end;

procedure TRgdStringlist.LoadFromFile(const FileName: string);
begin
  FData.LoadFromFile(FileName);
end;

procedure TRgdStringlist.LoadFromStream(Stream: TStream);
begin
  FData.LoadFromStream(Stream);
end;

procedure TRgdStringlist.Move(CurIndex, NewIndex: Integer);
begin
  FData.Move(CurIndex, NewIndex);
end;

procedure TRgdStringlist.Put(Index: Integer; const Value: string);
begin
  FData[Index] := Value;
end;

procedure TRgdStringlist.PutObject(Index: Integer; Value: TObject);
begin
  FData.Objects[Index] := Value;
end;

procedure TRgdStringlist.SaveToFile(const FileName: string);
begin
  FData.SaveToFile(FileName);
end;

procedure TRgdStringlist.SaveToFile(const FileName: string; Encoding: TEncoding);
begin
  FData.SaveToFile(FileName, Encoding);
end;

procedure TRgdStringlist.SaveToStream(Stream: TStream);
begin
  FData.SaveToStream(Stream);
end;

procedure TRgdStringlist.SaveToStream(Stream: TStream; Encoding: TEncoding);
begin
  FData.SaveToStream(Stream, Encoding);
end;

procedure TRgdStringlist.SetStrings(Source: TStrings);
begin
  FData.SetStrings(Source);
end;

procedure TRgdStringlist.SetCapacity(Value: Integer);
begin
  FData.Capacity := Value;
end;

procedure TRgdStringlist.SetCaseSensitive(const Value: Boolean);
begin
  FData.CaseSensitive := Value;
end;

procedure TRgdStringlist.SetCommaText(const Value: string);
var
  LOldStrictDelimiter: Boolean;
begin
  LOldStrictDelimiter := FData.StrictDelimiter;
  FData.StrictDelimiter := True;
  try
    FData.CommaText := Value;
  finally
    FData.StrictDelimiter := LOldStrictDelimiter;
  end;
end;

procedure TRgdStringlist.SetDefaultEncoding(const Value: TEncoding);
begin
  FData.DefaultEncoding := Value;
end;

procedure TRgdStringlist.SetDelimitedText(const Value: string);
begin
  FData.DelimitedText := Value;
end;

procedure TRgdStringlist.SetDelimiter(const Value: Char);
begin
  FData.Delimiter := Value;
end;

procedure TRgdStringlist.SetDuplicates(const Value: TDuplicates);
begin
  FData.Duplicates := Value;
end;

procedure TRgdStringlist.SetLineBreak(const Value: string);
begin
  FData.LineBreak := Value;
end;

procedure TRgdStringlist.SetNameValueSeparator(const Value: Char);
begin
  FData.NameValueSeparator := Value;
end;

procedure TRgdStringlist.SetOptions(const Value: TStringsOptions);
begin
  FData.Options := Value;
end;

procedure TRgdStringlist.SetOnChange(const Value: TNotifyEvent);
begin
  FData.OnChange := Value;
end;

procedure TRgdStringlist.SetOnChanging(const Value: TNotifyEvent);
begin
  FData.OnChanging := Value;
end;

procedure TRgdStringlist.SetOwnsObjects(const Value: Boolean);
begin
  FData.OwnsObjects := Value;
end;

procedure TRgdStringlist.SetQuoteChar(const Value: Char);
begin
  FData.QuoteChar := Value;
end;

procedure TRgdStringlist.SetSorted(const Value: Boolean);
begin
  FData.Sorted := Value;
end;

procedure TRgdStringlist.SetStrictDelimiter(const Value: Boolean);
begin
  FData.StrictDelimiter := Value;
end;

procedure TRgdStringlist.SetStringsAdapter(const Value: IStringsAdapter);
begin
  FData.StringsAdapter := Value;
end;

procedure TRgdStringlist.SetText(Text: PChar);
begin
  FData.Text := Text;
end;

function TRgdStringlist.ToStringArray: TArray<string>;
begin
  Result := FData.ToStringArray;
end;

procedure TRgdStringlist.SetTextStr(const Value: string);
begin
  FData.Text := Value;
end;

procedure TRgdStringlist.SetTrailingLineBreak(const Value: Boolean);
begin
  FData.TrailingLineBreak := Value;
end;

procedure TRgdStringlist.SetUseLocale(const Value: Boolean);
begin
  FData.UseLocale := Value;
end;

procedure TRgdStringlist.SetValue(const Name, Value: string);
begin
  FData.Values[Name] := Value;
end;

procedure TRgdStringlist.SetValueFromIndex(Index: Integer; const Value: string);
begin
  FData.ValueFromIndex[Index] := Value;
end;

procedure TRgdStringlist.SetWriteBOM(const Value: Boolean);
begin
  FData.WriteBOM := Value;
end;

procedure TRgdStringlist.Sort;
begin
  FData.Sort;
end;

{$ENDREGION}

{$REGION ' Additional Stringlist Methods '}

{Additional "Constructors"}

class function TRgdStringlist.Default: TRgdStringlist;
var
  Default: TRgdStringlist;
begin
  Result := Default;
end;

class function TRgdStringlist.Default(QuoteChar, Delimiter: Char; StrictDelimiter: Boolean): TRgdStringlist;
begin
  Result := TRgdStringlist.Default;
  Result.QuoteChar       := QuoteChar;
  Result.Delimiter       := Delimiter;
  Result.StrictDelimiter := StrictDelimiter;
end;

class function TRgdStringlist.Default(const RgdStrings: TRgdStringlist): TRgdStringlist;
{This constructs a new record that inherits the properties of RgdStrings param}
begin
  Result := TRgdStringlist.Default;
  Result.CaseSensitive      := RgdStrings.CaseSensitive;
  Result.Duplicates         := RgdStrings.Duplicates;
  Result.Sorted             := RgdStrings.Sorted;
  Result.DefaultEncoding    := RgdStrings.DefaultEncoding;
  Result.LineBreak          := RgdStrings.LineBreak;
  Result.Delimiter          := RgdStrings.Delimiter;
  Result.QuoteChar          := RgdStrings.QuoteChar;
  Result.NameValueSeparator := RgdStrings.NameValueSeparator;
  Result.Options            := RgdStrings.Options;
end;

{Additional Methods...}

function TRgdStringlist.CommaText2: string;
{! This version does not do quoting}
var
  LStrict: Boolean;
  LDelimiter: Char;
  LQuoteChar: Char;
begin
  LStrict         := StrictDelimiter;
  LDelimiter      := Delimiter;
  LQuoteChar      := Self.QuoteChar;
  Delimiter       := ',';
  QuoteChar       := #0;
  Result          := DelimitedText;
  Delimiter       := LDelimiter;
  QuoteChar       := LQuoteChar;
  StrictDelimiter := LStrict;
end;

function TRgdStringlist.IndexOfSubString(SubStr: string): Integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Count-1 do
  begin
    if Pos(SubStr, Self[i]) > 0 then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TRgdStringlist.IndexOfSubText(SubText: string): Integer;
var
  i: integer;
  S: string;
begin
  Result := -1;
  S := UpperCase(SubText);
  for i := 0 to Count-1 do
  begin
    S := UpperCase(Self[i]);
    if Pos(S, UpperCase(Self[i])) > 0 then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TRgdStringlist.Reversed: TRgdStringlist;
var
  i: integer;
  TempResult: TRgdStringlist;
begin
  TempResult := TRgdStringlist.Default(Result);
  TempResult.Sorted := False;
  for i := Count-1 downto 0 do
    TempResult.Add(Self[i]);
  Result := TempResult;
end;

procedure TRgdStringlist.AlignDelimiters(const DelimStr: string);
{Takes a list of delimited strings and pads them so that the delimiters line up}
var
  i: integer;
  Index: integer;
  S: string;
  iPos, DelimPos: integer;
begin
  if Count = 0 then
    Exit;

  DelimPos := 0;
  while PosEx(DelimStr, Self[0], DelimPos + 1) <> 0 do
  begin
    Index := DelimPos + 1;

    {Get Next Delim position...}
    DelimPos := 0;
    for S in Self do
    begin
      iPos := PosEx(DelimStr, S, Index);
      if iPos > DelimPos then
        DelimPos := iPos;
    end;

    {Pas with Spaces...}
    for i := 0 to Count-1 do
    begin
      S := Self[i];
      iPos := PosEx(DelimStr, S, Index);
      System.Insert(StringOfChar(' ', DelimPos - iPos), S, iPos + Length(DelimStr));
      Self[i] := S;
    end;
  end;
end;

procedure TRgdStringlist.SetStrings(StrArray: array of string);
begin
  BeginUpdate;
  try
    Clear;
    AddStrings(StrArray);
  finally
    EndUpdate;
  end;
end;

{Additional Methods: Set operations}

function TRgdStringlist.DifferenceWith(Other: TStrings): TRgdStringlist;
var
  SelfSet, OtherSet, TempSet: THashSet<string>;
  SaveDuplicates: TDuplicates;
begin
  Assert(Duplicates <> dupAccept);
  Result := TRgdStringlist.Default(Self);    //Result gets assigned properties of Self
  SaveDuplicates := Duplicates;
  Result.Duplicates := dupIgnore;
  SelfSet := THashSet<string>.Create(Self.ToStringArray);
  OtherSet := THashSet<string>.Create(Other.ToStringArray);
  TempSet := THashSet<string>.Create;
  try
    TempSet.AddRange(SelfSet);
    TempSet.ExceptWith(OtherSet);
    Result.AddStrings(TempSet.ToArray);

    OtherSet.ExceptWith(SelfSet);
    Result.AddStrings(OtherSet.ToArray)
  finally
    TempSet.Free;
    OtherSet.Free;
    SelfSet.Free;
    Self.Duplicates := SaveDuplicates;
  end;
end;

function TRgdStringlist.ExceptWith(Other: TStrings): TRgdStringlist;
var
  SelfSet, OtherSet: THashSet<string>;
begin
  Result   := TRgdStringlist.Default(Self);    //Result gets assigned properties of Self
  SelfSet  := THashSet<string>.Create(Self.ToStringArray);
  OtherSet := THashSet<string>.Create(Other.ToStringArray);
  try
    SelfSet.ExceptWith(OtherSet);
    Result.AddStrings(SelfSet.ToArray)
  finally
    OtherSet.Free;
    SelfSet.Free;
  end;
end;

function TRgdStringlist.IntersectWith(Other: TStrings): TRgdStringlist;
var
  SelfSet, OtherSet: THashSet<string>;
begin
  Result   := TRgdStringlist.Default(Self);    //Result gets assigned properties of Self
  SelfSet  := THashSet<string>.Create(Self.ToStringArray);
  OtherSet := THashSet<string>.Create(Other.ToStringArray);
  try
    SelfSet.IntersectWith(OtherSet);
    Result.AddStrings(SelfSet.ToArray)
  finally
    OtherSet.Free;
    SelfSet.Free;
  end;
end;

function TRgdStringlist.UnionWith(Other: TStrings): TRgdStringlist;
var
  SelfSet, OtherSet: THashSet<string>;
begin
  Result := TRgdStringlist.Default(Self);    //Result gets assigned properties of Self
  SelfSet := THashSet<string>.Create(Self.ToStringArray);
  OtherSet := THashSet<string>.Create(Other.ToStringArray);
  try
    SelfSet.UnionWith(OtherSet);
    Result.AddStrings(SelfSet.ToArray)
  finally
    OtherSet.Free;
    SelfSet.Free;
  end;
end;

function TRgdStringlist.Overlaps(Other: TStrings): Boolean;
var
  SelfSet, OtherSet: THashSet<string>;
begin
  SelfSet := THashSet<string>.Create(Self.ToStringArray);
  OtherSet := THashSet<string>.Create(Other.ToStringArray);
  try
    Result := SelfSet.Overlaps(OtherSet)
  finally
    OtherSet.Free;
    SelfSet.Free;
  end;
end;

function TRgdStringlist.SetEquals(Other: TStrings): Boolean;
var
  SelfSet, OtherSet: THashSet<string>;
begin
  if Count <> Other.Count then
    Result := False
  else
  begin
    SelfSet := THashSet<string>.Create(Self.ToStringArray);
    OtherSet := THashSet<string>.Create(Other.ToStringArray);
    try
      Result := SelfSet.SetEquals(OtherSet);
    finally
      OtherSet.Free;
      SelfSet.Free;
    end;
  end;
end;

{$ENDREGION}

End.
