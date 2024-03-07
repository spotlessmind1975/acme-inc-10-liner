0 DEFINE SCREEN MODE UNIQUE

BITMAP ENABLE(128,192,16)

w=1000
CONST a0=6
CONST a1=8

CONST a2=ROWS/2
CONST a3= SCREEN HEIGHT/2
CONST a4= SCREEN WIDTH/2-8
DIM bx%(a1),by%(a1),a5%(a1),bf@(a1),ba@(a1)
DIM r@,a6@,a7@

CONST a8= SCREEN HEIGHT/8
CONST b9= SCREEN WIDTH-1
CONST b0= SCREEN HEIGHT-1
CONST b1= SCREEN WIDTH-16
CONST b2= SCREEN HEIGHT-8

DIM bt(a1) AS THREAD, b3 AS THREAD, b4@
CONST b5=8
CONST b6=8
DEFINE TASK C% a1+3

DEFINE STRING COUNT 32

DEFINE STRING SPACE 256

1 CONST STRING b7="({16}"+Z(36)+"{15}{0}{0}{240}{0}{0}{0}{3}{235}{239}{255}{2}{3}{255}{0}{0}{0}{0}{10}{170}}{178}{3}{240}{0}{0}{0}{0}{0}:{191}{255}{255}{252}{0}{0}{2}{184}{0}{191}{255}{255}{192}{0}{0}{3}{240}{10}{255}{170}{168}{0}{0}{0}{0}?{0}{2}{170}{160}({0}{0}{0}{0}{160}{0}{2}{128}{0}{0}{0}{0}{0}{2}{128}{0}{2}{128}{0}{0}{0}{0}{0}{2}{128}{0}{10}{0}{0}{0}{0}{0}{0}{14}{0}{0}{168}{0}{0}{0}{0}{0}{0}{2}{128}*{176}{0}{0}{0}{0}{0}{0}{0}{238}{168}"
CONST STRING c8="{16}{16}"+Z(34)+"{170}{252}{0}*{128}{15}{0}{168}{0}{2}{2}{128}{0}{3}{10}{128}{0}{8}{10}{0}{0}({14}{128}{2}{160}{2}{170}{170}"
CONST STRING c9="{2}{8}{0}{8}{8}{15}{208}{31}TV{159}{218}{175}{250}{167}{246}{149}{21}{244}{7}{240}{8}{8}{13}p=|{254}{191}Z{165}Z{165}{254}{191}=|{13}p"
2 CONST STRING c0="{8}{24}{3}{0}{14}{128}{8}{128}{10}{0}{10}{0}{11}{128}-@{171}{232}{170}B{3}{160}{11}{208}{15}{192}3{224}{240}{224}{15}{224}{11}{192}?{192}?{192}3{0}{3}{0}{3}{0}{3}{0}{3}{0}{15}{252}"
c1:=(IMAGE)b7
c2:=(IMAGE)c8
c3:=(IMAGES)c9
c4:=(IMAGE)c0
c5:=NEW IMAGE(8,24)
c6:=NEW IMAGE(40,16)
d7:=NEW IMAGE(8,8)

d8%=0
d9%=0

GLOBAL x,y,r,c4,c1,c2,d0,c5,c6
GLOBAL bx,by,a5,bf,c3,d7,ba,d9,b4,d1,d2,d3,a6,d8,d4,a7

a6=0
d4=-1
d1=0
3 d2=0
d3=0

PROCEDURE d5[cx,cy]
	PUT IMAGE c4 AT cx,cy
END PROCEDURE

PROCEDURE e6[cx,cy]
	PUT IMAGE d7 AT cx,cy
END PROCEDURE

PROCEDURE e7
	IF d3=0 THEN
		PUT Imc 5 AT 0,d0
		d3=d1
	ENDIF
	IF d0<>y THEN
		IF d0<>-1 THEN
			PUT IMAGE c6 AT 0,d0
		ENDIF
		d0=y
	ENDIF
	PUT IMAGE c1 AT 0,y
	IF r=1 THEN
		PUT Imc 2 AT 0,y
	ENDIF
END PROCEDURE

PROCEDURE e8
	IF d3>0 THEN
		PUT IMAGE c6 AT 0,d0
		d3=d1
	ENDIF
	4 IF d0<>y THEN
		IF d0<>-1 THEN
			PUT IMAGE c5 AT 0,d0
		ENDIF
		d0=y
	ENDIF
	d5[0,y]
END PROCEDURE

PARALLEL PROCEDURE e9
	CLS
	INK BLUE
	Br0,b2 TO b9,b0
	DO
		i=0
		REPEAT
			IF ba(i)=1 THEN
				WAIT VBL by(i)+16
				e6[a5(i),by(i)]
				PUT IMAGE c3 FRAME bf(i) AT bx(i),by(i)
				a5(i)=bx(i)
			ELSEIF ba(i)=2 THEN
				e6[bx(i),by(i)]
				ba(i)=0
			ENDIF
			INCi
		UNTIL i=a1
		IF d1=0 THEN
			e8[]
		ELSE
			5 e7[]
		ENDIF
	LOOP
END PROCEDURE

PARALLEL PROCEDURE e0

	DO
		WAIT UNTIL[ba]=1
		[bx]=b1
		[by]=8+6*(RND(a8))
		[a5]=[bx]
		REPEAT
			ADD [bx],-d1-4
			ADD [bf],1,0 TO 1
			WAIT UNTIL[bx]=[a5]
			a6=(POINT([bx]-4,[by])<>a7)OR(POINT([bx]-4,[by]+4)<>a7)OR(POINT([bx]-4,[by]+7)<>a7)
		UNTIL[bx]<=(8+d1)
		INC d8
		[ba]=2
	LOOP
END PROCEDURE

PARALLEL PROCEDURE e1
	x=0
	e2=-1
	6 d0=-1
	y=a3
	DO
		DO
			ADD r,1,0 TO 1
			EXIT IF d2<>0
		LOOP
		ADD d1,d2
		IF d1>a0 THEN
			d1=a0
		ELSEIF d1<0 THEN
			d1=0
		ENDIF
		d2=0
	LOOP
END PROCEDURE

PARALLEL PROCEDURE e3
	a6=0
	d8=0
	DO
		IF d4<>d8 THEN
			HOME
			INK BLUE
			PRINT "SCORE: ";d8
			d4=d8
		ENDIF
		d2=2*((JLEFT(0)OR KEY PRESSED(KEY A))-(JRIGHT(0) OR KEY PRESSED (KEY D)))
		IF d1<>0 THEN
			7 y=y+4*(((JUP(0) OR KEY PRESSED(KEY W))AND(y>8))-((JDOWN(0)OR KEY PRESSED(KEY Z))AND((y+16)<(b2))))
		ENDIF
	LOOP
END PROC

DO
	d5[a4,a3]
	a7=0
	CLS
	d5[a4,a3]
	LOCATE,a2-2
	INK RED
	CENTER"ACME, inc."
	PRINT
	PRINT
	PRINT
	PRINT
	PRINT
	INK YELLOW
	CENTER"PRESS FIRE"
	
	PRINT
	INK BLUE
	CENTER"LAST: "+STR(d8)
	WAIT KEY OR FIRE
	
	FILL bx, ba, by
	
	SPAWN bt, e0
	b3=SPAWN e9
	e4=SPAWN e3
	f5=SPAWN e1
	8 d9=24+8*RND(4)
	DO
		OP_DEC d9
		IF d9<=0 THEN
			IF ba(b4)=0 THEN
				ba(b4)=1
				ADD b4,1,0 TO a1-1
				d9=24+8*RND(4)
			ENDIF
		ENDIF
		RUN PARALLEL
		EXIT IF a6
	LOOP

	INK COLOR(2)
	LOCATE 0,ROWS/2
	CENTER"GAME OVER"
	WAIT w MILLISECOND
	KILL f5,e4,b3,bt
	RANDOMIZE TIMER
	d1=0
LOOP
9 REM just 9 lines! ^_^


