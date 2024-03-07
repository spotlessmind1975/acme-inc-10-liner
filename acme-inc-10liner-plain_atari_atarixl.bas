0 DEFINE SCREEN MODE UNIQUE

DEFINE STRING COUNT 32

DEFINE STRING SPACE 256

BITMAP ENABLE (16)

a6@=0
f8=-1
f5=0
f6=0
f7=0
z=100
w=1000

CONST a0=6
CONST a1=4

DEFINE TASK COUNT7

CONST a2=ROWS/2

CONST a3 = SCREEN HEIGHT/2

CONST a4 = SCREEN WIDTH/2-8

DIM r@,a7@

CONST a8= SCREEN HEIGHT/8

CONST b9= SCREEN WIDTH-1

CONST b0= SCREEN HEIGHT-1

CONST b1 = SCREEN WIDTH-16

CONST b2 = SCREEN HEIGHT-8

DIM bt(a1) AS THREAD,b3 AS THREAD,b4@
DIM bx%(a1),by%(a1)

1 DIM a5%(a1),bf@(a1),ba@(a1)

CONST STRING b5="{168}{0}H${31}"
CONST STRING b6="{16}{0}{16}"+Z(10)+"{0}"+Z(10)
CONST STRING c2=Z(13)+"U{168}{0}{21}@{10}{0}T{0}{1}{1}"
CONST STRING c8="j{170}{170}{128}{0}{0}{2}{160}{5}{170}UT"
CONST STRING c1=Z(6)+"{1}@{21}`"+Z(7)+"{153}T"+Z(8)+"H${31}"
CONST STRING b7="{2}{8}{0}{8}{0}{8}{5}p5{252}{254}{181}z{165}"
CONST STRING c3="@{0}{1}@"+Z(5)+"{1}@{0}{5}"+Z(6)+"{9}{0}{0}T"
CONST STRING c9="{8}{0}{24}{2}{0}{9}@{4}@{5}{0}{5}{0}{6}@{27}"
2 CONST STRING c0="Z{173}^{191}?\{13}P{0}H${31}{8}{0}{8}{7}{208}{23}"
CONST STRING d8=Z(4)+"*{0}{1}UP{20}"+Z(4)+"P{0}{1}@"+Z(5)+"{1}"
CONST STRING c4="{192}V{148}U{193}{2}P{6}{176}{10}{128}{34}{144}{160}{144}"
CONST STRING c5="@{0}{2}{5}@{0}{4}{5}{0}{0}{20}{9}@{1}P{1}UU{0}{0}H${31}"
CONST STRING c6="{212}V{149}{250}{175}{250}{175}V{149}{23}{212}{7}{208}{0}H${31}"
CONST STRING d0="{0}{0}{0}{0}{5}U{215}{145}{2}{160}"+Z(5)+"%eZ{170}{168}{0}{0}{1}d{0}"
CONST STRING d9="({0}{16}"+Z(10)+"{0}"+Z(10)+"{0}"+Z(14)+"{5}{0}{0}{160}{0}{0}{0}{2}{150}{154}{165}{1}{2}{170}"
3 CONST STRING d7="{10}{144}{6}{128}*{128}*{128}{34}{0}{2}{0}{2}{0}{2}{0}{2}{0}{6}"
CONST STRING d2=b6+c2+c5
CONST STRING d3=b7+c0+c6
CONST STRING d4=c9+c4+d7+b5
CONST STRING d1=d9+d0+c8+d8+c3+c1

d5:=(IMAGE)d1
e6:=(IMAGE)d2
e7:=(IMAGES)d3
e8:=(IMAGE)d4
e9:=NwIm(8,24)
e0:=NwIm(40,16)
e1:=NwIm(8,8)

e2%=0
e3%=0
GLOBAL x,y,r,z,e8,d5,e6,e4,e9,e0,bx,by,a5,bf,e7,e1
4 GLOBAL ba,e3,b4,f5,f6,f7,a6,e2,f8,a7

PROCEDURE f9[cx,cy]
	PUT IMAGE e8 AT cx,cy
END PROCEDURE

PROCEDURE f0[cx,cy]
	PUT IMAGE e1 AT cx,cy
END PROCEDURE

PROCEDURE f1
	IF f7=0 THEN
		PUT IMAGE e9 AT 0,e4
		f7=f5
	ENDIF
	IF f2<>x OR e4<>y THEN
		PUT IMAGE e0 AT 0,e4
		e4=y
	ENDIF
	
	PUT IMAGE d5 AT 0,y
	
	IF r=1 THEN
		PUT IMAGE e6 AT 0,y
	ENDIF
END PROCEDURE

PROCEDURE f3
	SOUND NOTE G4,z;NOTE E4,z
	5 SOUND NOTE D4,z
END PROCEDURE

PROCEDURE g4
	IF f7>0 THEN
		PUT IMAGE e0 AT 0,e4
		f7=f5
	ENDIF
	
	IF f2<>x OR e4<>y THEN
		PUT IMAGE e9 AT 0,e4
		e4=y
		r=0
	ENDIF
	
	f9[0,y]
	
END PROCEDURE

PARALLEL PROCEDURE g5
	CLS
	INK COLOR(1)
	BAR 0,b2 TO b9,b0
	
	DO
		i=0
		REPEAT
			IF ba(i)=1 THEN
				WAIT VBL by(i)+16
				f0[a5(i),by(i)]
				PUT IMAGE e7 FRAME bf(i) AT bx(i),by(i)
				a5(i)=bx(i)
			ELSEIF fba(i)=2 THEN
				6 f0[bx(i),by(i)]
				ba(i)=0
			ENDIF
			INC i
		UNTIL i=a1
		
		IF f5=0 THEN
			g4[]
		ELSE
			f1[]
		ENDIF
		
	LOOP
END PROCEDURE

PARALLEL PROCEDURE g6
	DO
		WAIT UNTIL[ba]=1
			[bx]=b1
			[by]=8+6*(RND(a8))
			[a5]=[bx]
			REPEAT
				ADD[bx],-f5-1
				ADD[bf],1,0To1
			WAIT UNTIL[bx]=[a5]
			a6=(POINT([bx]-4,[by])<>a7)OR(POINT([bx]-4,[by]+4)<>a7)OR(POINT([bx]-4,[by]+7)<>a7)
		7 UNTIL[bx]<=(8+f5)
		INC e2
		[ba]=2
	LOOP
END PROCEDURE

PARALLEL PROCEDURE g7
	RANDOMIZE TIMER
	x=0
	f2=-1
	e4=-1
	y=a3
	DO
		DO
			ADD r,1,0 TO 1
			EXIT IF f6
		LOOP
		ADD f5,f6
		IF f5>a0 THEN
			f5=a0
		ELSEIF f5<0 THEN
			f5=0
		ENDIF
		f6=0
	LOOP
END PROCEDURE

PARALLEL PROCEDURE g8
	a6=0
	e2=0
	DO
		IF f8<>e2 THEN
			HOME
			INK YELLOW
			?"SCORE: ";e2
			f8=e2
		ENDIF
		8 f6=(JLEFT(0)OR KEY PRESSED(KEY A))-(JRIGHT(0) OR KEY PRESSED(KEY D))
		IF f5<>0 THEN
			y=y+((JUP(0)OR KEY PRESSED(KEY W))AND(y>8))-((JDOWN(0)OR KEY PRESSED(KEY Z))AND((y+16)<(b2)))
		ENDIF
	LOOP
END PROC

DO
	f9[a4,a3]
	a7=POINT(0,0)
	CLS
	f9[a4,a3]
	LOCATE,a2-2
	INK COLOR(2)
	CENTER"ACME, inc."
	PRINT
	PRINT
	PRINT
	PRINT
	PRINT
	INK COLOR(3)
	CENTER"PRESS FIRE"
	PRINT
	INK COLOR(0)
	f5=0
	9 CENTER"LAST: "+STR(e2)
	WAIT KEY OR FIRE
	FILL bx,ba,by
	SPAWN bt,g6
	b3=SPAWN g5
	g9=SPAWN g8
	g0=SPAWN g7
	e3=48+24*RND(4)
	DO
		DEC e3
		IF e3<=0 THEN
			IF ba(b4)=0 THEN
				ba(b4)=1
				ADD b4,1,0 TO a1-1
				e3=84+48*RND(4)
			ENDIF
		ENDIF
		RUN PARALLEL
		EXIT IF a6
	LOOP
	INK COLOR(2)
	LOCATE 0,ROWS/2
	CENTER"GAME OVER"
	f3[]
	WAIT w MILLISECOND
	KILL g0,g9,b3,bt
LOOP
