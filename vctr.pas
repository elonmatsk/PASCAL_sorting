Unit vctr;

interface

{$MODE OBJFPC}

uses sysutils;

	TYPE TItem = integer;
	EDimException = class(Exception);
	TMasVector = array of TItem;
	TObjVector = Object
		public
			procedure init(n: longint);
			procedure setVect(vect: TMasVector);
			procedure getVect(var vect: TMasVector);
			procedure getSize(var n: longint);
			function VectToStr(delimeter: string): string;
		private
			V: TMasVector;
			dim: longint;
		end;

operator + (a, b: TObjVector)c: TObjVector;
operator - (a, b: TObjVector)c: TObjVector;
operator * (a, b: TObjVector)c: double;

function VectorNorm(a: TObjVector):double;
procedure readVector(FileName: string; var n: longint; var M: TMasVector);

implementation

procedure TObjVector.init(n: longint);
	begin
		setLength(V, n);
		dim := n;
	end;

procedure TObjVector.setVect(vect: TMasVector);
	begin
		setLength(V, dim);
		V := vect;
	end;

procedure TObjVector.getVect(var vect: TMasVector);
	begin
		setLength(vect, dim);
		vect := V;
	end;

procedure TObjVector.getSize(var n: longint);
	begin
		n := dim;
	end;

function TObjVector.VectToStr(delimeter: string): string;
var i: longint;
	str: string;
	begin
		str := '';
		for i := 0 to dim - 1 do
			if i < dim - 1 then
				str := str + floatToStr(v[i]) + delimeter
			else str := str + floatToStr(v[i]);
		VectToStr := str;
	end;

operator + (a, b: TObjVector)c: TObjVector;
var v1, v2, v3: TMasVector;
	i, n1, n2: longint;
	begin
		a.getVect(v1);
		b.getVect(v2);
		a.getSize(n1);
		b.getSize(n2);
		if n1 = n2 then begin
			setLength(v3, n1);
			for i := 0 to n1 - 1 do
				v3[i] := v1[i] + v2[i];
			c.init(n1);
			c.setVect(v3);
		end
		else raise EDimException.Create('Dimensions do not match');
	end;

operator - (a, b: TObjVector)c: TObjVector;
var v1, v2, v3: TMasVector;
	i, n1, n2: longint;
	begin
		a.getVect(v1);
		b.getVect(v2);
		a.getSize(n1);
		b.getSize(n2);
		if n1 = n2 then begin
			setLength(v3, n1);
			for i := 0 to n1 - 1 do
				v3[i] := v1[i] - v2[i];
			c.init(n1);
			c.setVect(v3);
		end
		else raise EDimException.Create('Dimensions do not match')
	end;

operator * (a, b: TObjVector)c: double;
var v1, v2: TMasVector;
	i, n1, n2: longint;
	s: TItem;
	begin
		a.getVect(v1);
		b.getVect(v2);
		a.getSize(n1);
		b.getSize(n2);
		if n1 = n2 then begin
			s := 0;
			for i := 0 to n1 - 1 do
				s := s + v1[i]*v2[i];
			c := s;
		end
		else raise EDimException.Create('Dimensions do not match')
	end;

procedure readVector(FileName: string; var n: longint; var M: TMasVector);
var i, j: longint;
    t: text;
begin
    assign(t, FileName);
    reset(t);
    setLength(M, n);
	    for i := 0 to n - 1 do
	            read(t, M[i]);
	close(t);
end;

function VectorNorm(a: TObjVector): double;
var v1, v2: TMasVector;
	i, n: longint;
	sum: double;
	begin
		sum := 0;
		a.getVect(v1);
		a.getSize(n);
		for i := 0 to n - 1 do
			sum := sum + v1[i]*v1[i];
		VectorNorm := sqrt(sum);
	end;

end.
