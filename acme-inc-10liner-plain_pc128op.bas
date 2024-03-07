0 DEFINE SCREEN MODE UNIQUE
DEFINE STRING COUNT 32
DEFINE STRING SPACE 256
BITMAP ENABLE (16)

w=1000 
CONST a3 = ROWS/2
CONST a4 = SCREEN HEIGHT/2
CONST a5 = SCREEN WIDTH/2-8
DIM bx%(10),by%(10),a6%(10),bf@(10),ba@(10)
DIM r@,a7@,a8@
CONST b9= SCREEN WIDTH-1
CONST b0= SCREEN HEIGHT-1
CONST b1= SCREEN HEIGHT-16
DIM bt(10) AS THREAD,b2@
DEFINE TASK COUNT 13
CONST e = "{0}{0}{0}{0}"
CONST f = "{0}{0}{0}{0}{0}"
CONST g = "{0}{0}{0}{0}{0}{0}"
1 CONST h = "{0}{0}{0}{0}{0}{0}{0}"
CONST STRING b4 = "{0}{16}{16}"+Z(34)+"{17}{34}{0}{1}{16}{0}{0}{17}{0}{0}{0}{16}{0}{0}{0}{16}"+f+"{1}{0}{16}{0}{17}{0}{17}{17}"+Z(35)+"{17} {0}{17}{0}{34}{0}{16}{0}{1}{1}{0}{0}{2}{17}{0}{0}{16}{17}{0}{0}{16}!{0}{1}{0}{1}{17}{17}"
CONST STRING b5 ="{2}{8}{0}{0}{8}{8}{0}{19}{3}33#{19}{34}{17}{34}{17}#{3}{17}{0}{17}{17}{0}{17}02{17}{34}{17}{34}123301{0}{0}{8}{8}{0}1{1}1{17}!3{34}3{34}{17}!{1}1{0}1{19}{0}{19}{16}{18}{17}{34}3{34}3{18}{17}{19}{16}{19}"
b7 := (IMAGE)b4
c8 := (IMAGES)b5
2 C# STRING b3 = "{0}({16}"+Z(39)+"{34}"+e+"!!{34}{0}{0}{34}"+f+"{17}1!{0}{34}"+f+"{2}{18}{17}{34}{34}{0}{0}{0}{18}{0}{18}{34}{34} {0}{0}{0}{34}{0}{34}{17}{17}"+e+"{2}{0}{0}{17}{17}{1}"+e+"{17}{0}{0}{16}"+g+"{16}{0}{0}{16}"+g+"{16}"+Z(11)+"{17}"+h+"{16}{1}{18}"+h+"!{17}"+Z(43)+"{17}"+g+"{2}{18}{34}{17}{1}{2}{34}"+e+"{17}{17}{19}{1}{2}"+g+"{17}{17}{34}{34} {0}{0}{1}{16}{0}{34}{34}{34}{0}{0}{0}{2}{0}{17}{34}{17}{16}"+e+"{34}{0}{1}{17}{0}{16}"+g+"{1}"+g+"{1}{0}{0}{1}"+g+"{1}{0}{0}{17}"+g+"!{0}{0}{16}"+g+"{1}{0}{17}"+Z(8)+"!{16}"
3 b6 := (IMAGE)b3
c9 := NEW IMAGE(40,16)
c0 := NEW IMAGE(8,8)
c1%=0 
c2%=0
PALETTE 0,$47d,$138,$2ef

GLOBAL x,y,r,b6,b7,c3,c9,bx,by,a6,bf,c8,c0,ba,c2,b2,c4,c5,c6,a7,c1,d7,a8

a7=0
d7=-1
c4=0
c5=0
c6=0

PROCEDURE d8[cx,cy]
	PUT IMAGE c0 AT cx,cy
END PROCEDURE

PROCEDURE d9
	4 IF c3<>y THEN
		IF c3<>-1 THEN
			PUT IMAGE c9 AT x,c3
		ENDIF
		c3=y
	ENDIF
	PUT IMAGE b6 AT x,y
	IF r=1 THEN
		PUT IMAGE b7 AT x,y
	ENDIF
END PROCEDURE

PARALLEL PROCEDURE d0
	CLS
	COLOR BORDER BROWN
	INK BROWN
	GET IMAGE c0 FROM 0,0
	GET IMAGE c9 FROM 0,0
	BAR 0,b1 TO b9,b0
	DO
		i=0
		REPEAT
			IF ba(i)=1 THEN
				d8[a6(i),by(i)]
				PUT IMAGE c8 FRAME bf(i) AT bx(i),by(i)
				a6(i)=bx(i)
			5 ELSEIF ba(i)=2 THEN
				d8[bx(i),by(i)]
				ba(i)=0
			ENDIF
			INC i
		UNTIL i=10
		d9[]
		WAIT VBL
	LOOP
END PROCEDURE

PARALLEL PROCEDURE d1
	DO
		WAIT UNTIL[ba]=1
		[bx]= SCREEN WIDTH-8
		IF RND(100)>50 THEN
			[by]=y+4
		ELSE
			[by]=8+6*(RND(SCREEN HEIGHT/8))
		ENDIF
		[a6]=[bx]
		REPEAT
			ADD [bx],-c4-4
			ADD [bf],1,0 TO 1
			IF [bx]<0 THEN
				6 bx=0
			ENDIF
			WAIT UNTIL[bx]=[a6]
			IF [bx]>4 THEN
				a7=(POINT([bx]-4,[by])<>a8)OR (POINT([bx]-4,[by]+4)<>a8)OR (POINT([bx]-4,[by]+7)<>a8)
			ENDIF
		UNTIL [bx]<=(4+c4)
		INC c1
		[ba]=2
	LOOP
END PROCEDURE

PARALLEL PROCEDURE d2
	x=0
	d3=-1
	c3=-1
	y=a4
	DO
		DO
			ADD r,1,0 TO 1
			EXIT IF c5<>0
		LOOP
		ADD c4,c5
		IF c4>6 THEN
			c4=6
		ELSEIF c4<0 THEN
			c4=0
		7 ENDIF
		c5=0
	LOOP
END PROCEDURE

PARALLEL PROCEDURE d4
	a7=0
	c1=0
	d7=-1
	DO
		IF d7<>c1 THEN
			HOME
			INK COLOR(3)
			PRINT "SCORE: ";c1
			d7=c1
		ENDIF
		c5=(KEY PRESSED(KEY A))-(KEY PRESSED(KEY D))
		y=y + 4*((KEY PRESSED(KEY W)AND(y>8))-(KEY PRESSED(KEY Z)AND((y + 16)<(b1))))
	LOOP
END PROCEDURE

DO
	a8=POINT(0,0)
	
	COLOR BORDER BLACK
	CLS BLACK
	x=a5-12
	y=a4:d9[]
	LOCATE,a3-2
	8 INK COLOR(3)
	CENTER "ACME, inc."
	PRINT
	PRINT
	PRINT
	PRINT
	PRINT
	INK COLOR(2)
	CENTER "PRESS FIRE"
	PRINT
	INK COLOR(1)
	CENTER "LAST: "+STR(c1)
	WAIT KEY
	
	FILL bx,ba,by
	
	SPAWN bt,d1
	d5=SPAWN d0
	e6=SPAWN d4
	e7=SPAWN d2
	
	c2=48+4*RND(4)
	DO
		DEC c2
		IF c2<=0 THEN
			IF ba(b2)=0 THEN
				ba(b2)=1
				ADD b2,1,0To9
				c2=48+4*RND(4)
			ENDIF
		ENDIF
		RUN PARALLEL
		EXIT IF a7
	LOOP
	INK COLOR(3)
	
9 
	LOCATE 0,ROWS/2
	CENTER"GAME OVER"
	WAIT w MILLISECOND
	KILL e7,e6,d5,bt
	RANDOMIZE TIMER
	c4=0
LOOP


