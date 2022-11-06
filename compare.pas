program compare;

{$Mode Delphi}
{$R-}

uses sysutils, vctr, presort, sort1;
TYPE TArrayInt = array[1..3] of longword;
     TArrayStr = array[1..3] of ansistring;
     TSortMethod = procedure(AObj: TObjVector; SortMethod, InitSortData: ansistring;
     N: longword; var ComparisonCount, MoveCount: QWord; RezTextFileName: ansistring);

const ArrayN: TArrayInt = (16, 256, 1024);
      ArrayFileName: TArrayStr = ('Random1024.txt', 'ASC1024.txt', 'DESC1024.txt');
      ArraySortData: TArrayStr = ('Random', 'ASC', 'DESC');
var   RezTextFileName: ansistring;
      TextFile: text;
      SortMethod, TextFileName: ansistring;

procedure AllCaseOneSortMethod(SortMethod: ansistring; SomeSortMethod: TSortMethod;
ArrayN: TArrayInt; ArrayFileName, ArraySortData: TArrayStr; RezTextFileName: string);
var A: TMasVector;
    Meh: TObjVector;
    SortData: ansistring;
    n: longword;
    ComparisonCount, MoveCount: QWord;
    TypeFileName: ansistring;
    i, j: byte;
begin
    for i := 1 to 3 do begin
        n := ArrayN[i];
	      for j := 1 to 3 do begin
	          TypeFileName := ArrayFileName[j];
            TextFileToTypeFile(TypeFileName, n);
	          SortData := ArraySortData[j];
	          TypeFileToArray(TypeFileName, A, n);
            Meh.init(n);
            Meh.setVect(A);
	          SomeSortMethod(Meh, SortMethod, SortData, n, ComparisonCount,
	          MoveCount, RezTextFileName);
	      end;
    end;
end;

begin

    RezTextFileName := 'RESULT.txt';
    Assign(TextFile, RezTextFileName);
    Rewrite(TextFile);
    writeln(TextFile, concat('Sort method: ',Chr(9),'Sort Mas: ',
    Chr(9),'n: ',Chr(9),'Comp.Count: ', Chr(9),'Move Count: '));
    Close(TextFile);

    SortMethod := 'Straight Selection';
    AllCaseOneSortMethod(SortMethod, StraightSelect,
    ArrayN, ArrayFileName, ArraySortData, RezTextFileName);

    SortMethod := 'Straight Choice';
    AllCaseOneSortMethod(SortMethod, StraightChoice,
    ArrayN, ArrayFileName, ArraySortData, RezTextFileName);

    writeln('GOTOVO!');
    readln;
END.
