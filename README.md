# Rgd.Stringlist
A Delphi Custom Managed Record implementation of TStringlist

TRgdStringlist is a record variable replacement for TStringList that does not 
need to be created/freed.  

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

  Differences to TStringlist:
  
    (1) When passing a StringList as a value parameter to a function, instead 
        of var or const, a new record gets created and all the strings are copied 
        to the new record's internal TStringlist, leaving the original param unchanged.
    (2) CommaText property always uses StrictDelimiter = True (my own preference)
        Use DelimitedText property if you need StrictDelimer = False
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
          as this causes a memory leak where MyStrings gets Initialized twice and finalized once
          and the original FData does not get freed.
          INSTEAD, use: MyStrings := Stringlist.Default;
