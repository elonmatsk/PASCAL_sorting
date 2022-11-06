unit presort;
INTERFACE
{$MODE OBJFPC}
uses sysutils, vctr;

TYPE TTypeFile = file of TItem;
var  TArray: TMasVector;
     TextFileName, TypeFileName: ansistring;
     CountNumber: longword;

procedure TextFileToTypeFile(TextFileName: ansistring; CountNumber:longword);
procedure TypeFileToArray(var TypeFileName: ansistring; var TArray: TMasVector; CountNumber: longword);

IMPLEMENTATION


function TransformName(TextFileName: ansistring): ansistring;
begin
    TransformName := concat(copy(TextFileName, 1, length(TextFileName) - 3),'dat');
end;

procedure TextFileToTypeFile(TextFileName: ansistring; CountNumber: longword);
var i: longword;
    Temp: TItem;
    TextFile: text;
    TypeFile: TTypeFile;
    TypeFileName: ansistring;
    a: byte;
begin
    try
        assign(TextFile,TextFileName);
	reset(TextFile);
	TypeFileName:=TransformName(TextFileName);
	assign(TypeFile,TypeFileName);
	rewrite(TypeFile);
	for i:=1 to CountNumber do begin
	    read(TextFile,Temp);
	    write(TypeFile,Temp);
	end;
        close(TextFile);
	close(TypeFile);
    except
        writeln('Problem with FILE');
        exit;
    end;
end;

procedure TypeFileToArray(var TypeFileName: ansistring; var TArray: TMasVector; CountNumber: longword);
var i: longword;
    TypeFile: TTypeFile;
begin
    TypeFileName := TransformName(TypeFileName);
    Assign(TypeFile, TypeFileName);
    Reset(TypeFile);
    i := 0;
    if CountNumber = 0 then SetLength(TArray, FileSize(TypeFile))
    else SetLength(TArray, CountNumber);
    if CountNumber <> 0 then begin
        while not eof(TypeFile) do begin
	     read(TypeFile, TArray[i]);
             inc(i);
    	end;
    end
    else begin
        for i := 0 to CountNumber do begin
	    if eof(TypeFile) then reset(TypeFile);
            read(TypeFile,TArray[i - 1]);
	end;
    end;
    close(TypeFile);
end;

begin

end.
