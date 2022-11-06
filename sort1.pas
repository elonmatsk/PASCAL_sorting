unit sort1;

INTERFACE
{$Mode Delphi}
uses sysutils, presort, vctr;
var t: text;

procedure StraightChoice(AObj: TObjVector; SortMethod, InitSortData: ansistring;
N: longword; var ComparisonCount, MoveCount: QWord; RezTextFileName: ansistring);

procedure StraightSelect(AObj: TObjVector; SortMethod, InitSortData: ansistring;
N: longword; var ComparisonCount, MoveCount: QWord; RezTextFileName: ansistring);

IMPLEMENTATION

{$R-}

procedure StraightChoice(AObj: TObjVector; SortMethod, InitSortData: ansistring;
N: longword; var ComparisonCount, MoveCount: QWord; RezTextFileName: ansistring);
var i, j: longword;
    H: longint;
    temp: TItem;
	t: text;
    A: TMasVector;
begin
    AObj.getSize(H);
    AObj.getVect(A);
    ComparisonCount := 0;
    MoveCount := 0;
	for i := 2 to H do begin
	    temp := A[i];
		A[0] := temp;
		MoveCount := MoveCount + 1;
		j := i - 1;
		ComparisonCount := ComparisonCount + 1;
		while temp < A[j] do begin
		    A[j + 1] := A[j];
		    MoveCount := MoveCount + 1;
		    j := j - 1;
		end;
		A[j + 1] := temp;
		MoveCount := MoveCount + 1;
	end;
    try
            Assign(t, RezTextFileName);
	    Append(t);
	    writeln(t, concat(SortMethod, Chr(9), InitSortData, Chr(9), IntToStr(N),
	    Chr(9), IntToStr(ComparisonCount), Chr(9), IntToStr(MoveCount)));
	    Close(t);
    except
        writeln('Problem with FILE');
    end;
end;



procedure StraightSelect(AObj: TObjVector; SortMethod, InitSortData: ansistring;
N: longword; var ComparisonCount, MoveCount: QWord; RezTextFileName: ansistring);
var i, j, k: longword;
    H: longint;
    temp: TItem;
	t: text;
    A: TMasVector;
begin
    AObj.GetSize(H);
    AObj.GetVect(A);
    ComparisonCount := 0;
	MoveCount := 0;
	for i := 0 to H - 1 do begin
	    k := i;
	    temp := A[i];
		for j := i + 1 to H - 1 do begin
		    ComparisonCount := ComparisonCount + 1;
			if A[j] < temp then begin
			    k := j;
				temp := A[j];
			end;
			A[k] := A[i];
			A[i] := temp;
			MoveCount := MoveCount + 2;
		end;
	end;
    try
        Assign(t, RezTextFileName);
	    Append(t);
	    writeln(t, concat(SortMethod, Chr(9), InitSortData, Chr(9), IntToStr(N),
	    Chr(9), IntToStr(ComparisonCount), Chr(9), IntToStr(MoveCount)));
	    Close(t);
    except
        writeln('Problem with FILE');
    end;
end;


BEGIN
END.
