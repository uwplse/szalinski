// lowpolyfont v1_0
// GPLv2
// (c) 2013 TakeItAndRun
//
// v1_1: 
//

/*





*/
//*******************************************************
//
// Low polygon count font
//
//*******************************************************



//*******************************************************
//
// basic definitions
//
//*******************************************************


// small displacement to avoid parallel faces with zero volume
e=+0.02;

// unit vectors
xaxis=+[1,0,0];
yaxis=+[0,1,0];
zaxis=+[0,0,1];

//*******************************************************
//
// dimensions
//
//*******************************************************

/* [text] */

//number of lines
nl=4;//[1:4]

// Text (ONLY CAPITALS!)
text1="THE QUICK BROWN";
text2="FOX JUMBED OVER";
text3="THE LAZY DOG.";
text4="1234567890.:!?";



/* [type] */

//thickness of type
t=2;//[.1:10]

//height of type
h=10;//[1:50]

//width of type
w=5;//[1:50]

//spacing between letters
d=1;//[0.0:5.0]
dpos=d;

//conical shape
//pq=40;//[0:100]
//q=pq/100;

// spacing between lines
dl=4;//[0.0:10:0]

/* [sign] */

// sign
sign=!false;//[false:none,true:sign]
//length past type
dsx=3;//[0:10]
//height above type
dsy=3;//[0:10]
//thickness of the sign
sz=1;//[1:10]
// edge
edge=!false;//[false:none,true:sign]
// width of edge
we=1;//[0.1:10.0]


/* [Hidden] */

text=["",text1,text2,text3,text4];


//*******************************************************
//
// polygons of the letters:
//	Every letter is one element of the array fo:
// the first number is the width of the letter
//	then follows a list of polygons
//
//	the key to the (order of the) letters is the string str0
//
//*******************************************************

str0=" ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.:!?";

fo=
[
[
// space
2,
[],

],[
//A
2,
[[0,2],[1,4],[2,2]],
[[0,2+e],[2,2+e],[0,0]],
[[0,2+e],[2,2+e],[2,0]],
],[
//B
2,
[[0,4],[2,3],[0,1.5]],
[[0,2.5],[2,1],[0,0]],
],[
//C
2,
[[0,2],[2,4],[2,0]],
],[
//D
2,
[[0,4],[2,2],[0,0]],
],[
//E
2,
[[0,4],[2,4],[0,0]],
[[0,4],[2,0],[0,0]],
[[0,4],[2,2],[0,0]],
],[
//F
2,
[[0,4],[2,4],[0,0]],
],[
//G
2,
[[0,4],[2,4],[0,0]],
[[0,1],[2,2],[2,0],[0,0]],
],[
//H
2,
[[0,4],[.75,2],[0,0]],
[[1.25,2],[2,4],[2,0]],
[[0,2.25],[2,2.25],[2,1.75],[0,1.75]],
],[
//I
1,
[[0,4],[1,4],[1,0]],
],[
//J
1,
[[1,4],[1,0],[0,0]],
],[
//K
2,
[[0,4],[1,4],[0,0]],
[[0,1.5],[2,4],[2,3]],
[[0,2.5],[2,1],[2,0]],
],[
//L
2,
[[0,4],[2,0],[0,0]],
],[
//M
2,
[[0,4],[2,2],[2,0],[0,0]],
[[2,4],[2,0],[0,0],[0,2]],
],[
//N
2,
[[0,4],[2,3],[0,0]],
[[0,1],[2,4],[2,0]],
],[
//O
2,
[[0,4],[2,4],[2,0],[0,0]],
],[
//P
2,
[[1,4],[2,3],[0,2]],
[[0,4],[1,4],[0,0]],
],[
//Q
2,
[[0,4],[2,4],[2,1.25],[.75,0],[0,0]],
[[0,2],[2,.5],[2,0],[1.5,0]],
//[[1.5,1],[2,0],[1,.5]],
],[
//R
2,
[[0,4],[1,4],[0,0]],
[[0,2],[1,4],[2,3]],
[[0,2.5],[2,1],[2,0]],
],[
//S
2,
[[2,4],[2,1.5],[0,3]],
[[0,2.5],[2,1],[0,0]],
],[
//T
2,
[[0.5,4],[1.25,4],[1,0]],
[[0,4],[2,4],[0,3]],
],[
//U
2,
[[0,4],[1,0],[0,0]],
[[2,4],[2,0],[1,0]],
[[0,0],[0,1],[2,1],[2,0]],
],[
//V
2,
[[0,4],[2,4],[1,0]],
],[
//W
2,
[[0,4],[2,4],[2,0],[0,2]],
[[0,4],[2,4],[2,2],[0,0]],
],[
//X
2,
[[0,4],[1.5,2],[.5,2]],
[[2,4],[1.5,2],[.5,2]],
[[0,0],[.5,2],[1.5,2]],
[[2,0],[.5,2],[1.5,2]],
],[
//Y
2,
[[0,4],[2,4],[1,2]],
[[0.5,4],[1.25,4],[1,0]],
],[
//Z
2,
[[0,4],[2,4],[2,3]],
[[0,0],[0,1],[2,0]],
[[0,1],[1.5,4],[2,3],[.5,0]],
],[
//1
1,
[[0,0],[1,4],[1,0]],
[[0,4],[1,4],[1,3]],
],[
//2
2,
[[0,4],[2,3],[0,2]],
[[0,0],[0,1],[2,0]],
[[0,1],[1.5,3],[2,3],[0,0]],
],[
//3
2,
[[0,4],[2,3],[0,2]],
[[0,0],[0,2+e],[2,1]],
],[
//4
2,
[[1,0],[2,4],[2,0]],
[[0,4],[2,2],[0,2]],
],[
//5
2,
[[0,4],[2,4],[0,2]],
[[0,0],[0,2+e],[2,1]],
],[
//6
2,
[[1,0],[0,1],[1,2],[2,1]],
[[0,4],[1,4],[.25,1],[0,1]],
],[
//7
2,
//[[0,4],[2,4],[2,3.5],[0,3]],
//[[0,4],[1,4],[.25,1],[0,1]],
[[0,4],[2,4],[2,0]],
],[
//8
2,
[[1,0],[0,1],[1,2+e],[2,1]],
[[1,4],[2,3],[1,2],[0,3]],
],[
//9
2,
[[1,4],[2,3],[1,2],[0,3]],
[[1,0],[1.75,3],[2,3],[2,0]],
],[
//0
2,
[[1,0],[0,1],[0,3],[1,4],[2,3],[2,1]],
],[
//.
1,
[[0,0],[1,1],[1,0]],
],[
//:
1,
[[0,0],[1,1],[1,0]],
[[0,2],[1,3],[1,2]],
],[
//!
1,
[[0,0],[1,1],[1,0]],
[[0,4],[1,4],[.5,1+e]],
],[
//?
2,
[[0.5,0],[1.5,1],[1.5,0]],
[[1,4],[2,4],[1,1+e]],
[[0,4],[2,4],[0,3]],
],[

]
];


//*******************************************************
//
// routines
//
//*******************************************************

// make the i-th letter in the string str0
module letter(s){
	for(i=[1:len(fo[s])-1]){
// comment out the line with linear_extrude to get a 2-dim output for a dxf export
	linear_extrude(height=t)
		scale([w/2,h/4])polygon(fo[s][i]);
	}
}

// print one line of text 
// str: text to be printed (use only letters that are included in the string str0 (capital letters, numbers, some special characters)
module type(str,center=false){
	translate([(center)?-(pos(len(str),str)-dpos/2)/2:0,(center)?-h/2:0,0])
	for(i=[0:len(str)-1]){
		translate(pos(i,str)*xaxis)
		letter(index(str[i],str0));
	}
}


module sign(){
// calculate x,y-dimensions of the sign
	ssx=maximum(nl)+2*dsx+((edge)?4*we:0);
	ssy=nl*h+(nl-1)*dl+2*dsy+((edge)?4*we:0);

	color("yellow")
	translate((nl-1)*(h+dl)/2*yaxis+((sign)?sz:0)*zaxis)
	for (i=[1:nl]){
		translate(-(i-1)*(h+dl)*yaxis)
			type(text[i],true);
	}
	if (sign){
		color("blue")
		translate(sz/2*zaxis)
			cube([ssx,ssy,sz],true);
		color("yellow")
		translate((sz+t/2)*zaxis)
			for(m=[-1,1]){
				translate(m*(ssy-3*we)/2*yaxis)
					cube([ssx-2*we,we,t],true);
				translate(m*(ssx-3*we)/2*xaxis)
					cube([we,ssy-2*we,t],true);
			}
	}
}



// get the length of the longest line
function maximum(nl,i=1)=(i<nl)?
	max((pos(len(text[i]),text[i])-dpos/2),maximum(nl,i+1)):
	(pos(len(text[i]),text[i])-dpos/2)
;

// return index of a letter in the fo vector / string str0
function index(str)=
	search(str,str0)[0];


// Calculate the position of the i-th letter as sum of the
// width plus spacing of all the letters before it.
// This function looks so witty because OpenSCAD does not
// allow re-assignment of variables during run time.
// The idea for this function (somewhat simplified) I took from
// http://www.thingiverse.com/thing:22730
// by Bernhard -HotKey- Slawik, http://www.bernhardslawik.de
// This function is defined only for 80 characters. You may 
// expand it if you need more than 80 characters per line.
function pos(i,str)=
	w/2*(
	(i==0)?0:i*dpos*2/w
	+((i>=1)?fo[index(str[0])][0]:0)
	+((i>=2)?fo[index(str[1])][0]:0)
	+((i>=3)?fo[index(str[2])][0]:0)
	+((i>=4)?fo[index(str[3])][0]:0)
	+((i>=5)?fo[index(str[4])][0]:0)
	+((i>=6)?fo[index(str[5])][0]:0)
	+((i>=7)?fo[index(str[6])][0]:0)
	+((i>=8)?fo[index(str[7])][0]:0)
	+((i>=9)?fo[index(str[8])][0]:0)
	+((i>=10)?fo[index(str[9])][0]:0)
	+((i>=11)?fo[index(str[10])][0]:0)
	+((i>=12)?fo[index(str[11])][0]:0)
	+((i>=13)?fo[index(str[12])][0]:0)
	+((i>=14)?fo[index(str[13])][0]:0)
	+((i>=15)?fo[index(str[14])][0]:0)
	+((i>=16)?fo[index(str[15])][0]:0)
	+((i>=17)?fo[index(str[16])][0]:0)
	+((i>=18)?fo[index(str[17])][0]:0)
	+((i>=19)?fo[index(str[18])][0]:0)
	+((i>=20)?fo[index(str[19])][0]:0)
	+((i>=21)?fo[index(str[20])][0]:0)
	+((i>=22)?fo[index(str[21])][0]:0)
	+((i>=23)?fo[index(str[22])][0]:0)
	+((i>=24)?fo[index(str[23])][0]:0)
	+((i>=25)?fo[index(str[24])][0]:0)
	+((i>=26)?fo[index(str[25])][0]:0)
	+((i>=27)?fo[index(str[26])][0]:0)
	+((i>=28)?fo[index(str[27])][0]:0)
	+((i>=29)?fo[index(str[28])][0]:0)
	+((i>=30)?fo[index(str[29])][0]:0)
	+((i>=31)?fo[index(str[30])][0]:0)
	+((i>=32)?fo[index(str[31])][0]:0)
	+((i>=33)?fo[index(str[32])][0]:0)
	+((i>=34)?fo[index(str[33])][0]:0)
	+((i>=35)?fo[index(str[34])][0]:0)
	+((i>=36)?fo[index(str[35])][0]:0)
	+((i>=37)?fo[index(str[36])][0]:0)
	+((i>=38)?fo[index(str[37])][0]:0)
	+((i>=39)?fo[index(str[38])][0]:0)
	+((i>=40)?fo[index(str[39])][0]:0)
	+((i>=41)?fo[index(str[40])][0]:0)
	+((i>=42)?fo[index(str[41])][0]:0)
	+((i>=43)?fo[index(str[42])][0]:0)
	+((i>=44)?fo[index(str[43])][0]:0)
	+((i>=45)?fo[index(str[44])][0]:0)
	+((i>=46)?fo[index(str[45])][0]:0)
	+((i>=47)?fo[index(str[46])][0]:0)
	+((i>=48)?fo[index(str[47])][0]:0)
	+((i>=49)?fo[index(str[48])][0]:0)
	+((i>=50)?fo[index(str[49])][0]:0)
	+((i>=51)?fo[index(str[50])][0]:0)
	+((i>=52)?fo[index(str[51])][0]:0)
	+((i>=53)?fo[index(str[52])][0]:0)
	+((i>=54)?fo[index(str[53])][0]:0)
	+((i>=55)?fo[index(str[54])][0]:0)
	+((i>=56)?fo[index(str[55])][0]:0)
	+((i>=57)?fo[index(str[56])][0]:0)
	+((i>=58)?fo[index(str[57])][0]:0)
	+((i>=59)?fo[index(str[58])][0]:0)
	+((i>=60)?fo[index(str[59])][0]:0)
	+((i>=61)?fo[index(str[60])][0]:0)
	+((i>=62)?fo[index(str[61])][0]:0)
	+((i>=63)?fo[index(str[62])][0]:0)
	+((i>=64)?fo[index(str[63])][0]:0)
	+((i>=65)?fo[index(str[64])][0]:0)
	+((i>=66)?fo[index(str[65])][0]:0)
	+((i>=67)?fo[index(str[66])][0]:0)
	+((i>=68)?fo[index(str[67])][0]:0)
	+((i>=69)?fo[index(str[68])][0]:0)
	+((i>=70)?fo[index(str[69])][0]:0)
	+((i>=71)?fo[index(str[70])][0]:0)
	+((i>=72)?fo[index(str[71])][0]:0)
	+((i>=73)?fo[index(str[72])][0]:0)
	+((i>=74)?fo[index(str[73])][0]:0)
	+((i>=75)?fo[index(str[74])][0]:0)
	+((i>=76)?fo[index(str[75])][0]:0)
	+((i>=77)?fo[index(str[76])][0]:0)
	+((i>=78)?fo[index(str[77])][0]:0)
	+((i>=79)?fo[index(str[78])][0]:0)
	+((i>=80)?fo[index(str[79])][0]:0)
	)
//	+((i>=4)?fo[index(str[4])][0]:0)

;


//*******************************************************
//
// main program
//
//*******************************************************



// one line of text
//str="THE QUICK BROWN FOX JUMBED OVER THE LAZY DOG.";
//str=str0;
//type(str,!true);

// sign with up to 4 lines of text (if sign=true, else just the text)
sign();