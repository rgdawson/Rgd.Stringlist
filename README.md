# Rgd.Stringlist
A Delphi Custom Managed Record implementation of TStringlist

Inspired by Janez Atmapuri Makovsek, www.dewresearch.com, https://github.com/toppermitz/StringVar
TRgdStringlist is a record variable replacement for TStringList that does not need to be create/freed.

  Usage Example:

    procedure MyProc;
    var
      strings: TRgdStringList;
    begin
      strings.Add('test1');
      strings.Add('test2');
      RichEdit.Lines.AddStrings(strings);
    end;

  This implementation is different that Makovsek's as follows:

    (1) This implementation uses Delphi's Custom Managed Record class operators.
        I use the class operator Initialize() and Finalize() to Create/Free the internal TStringlist.
        Each instance has its own unique internal TStringlist, so no need for reference counting.
        Basically, A := B is the same as A.Assign(B)
    (2) CommaText property always uses StrictDelimiter = True
        Use DelimitedText property if you need StrictDelimer = False
    (3) When passing a TRgdStringlist as a parameter to a function, if passed as a value instead of 
        var or const, a new record gets created and all the strings copied to the value parameter 
        as you would expect.
    (4) Implicits allow you to pass a TRgdStringlist to TObject, TPersistent, TStrings, 
        and TStringlist.
    (5) Based on the TStringlist implementation current as of Delphi 12.  If using with 
        an older version of Delphi, you may need to remove refences to missing members.
