// OpenSCAD Project NameYourBear by Marcel "C4rmel" Lahaye for use on http://www.thingiverse.com/
// This code generates a 3D mesh of a bear based on some characters of your name or any word you
// put into the "name" variable
// If you find any bugs or have any suggestion on how to improve the code write a mail to:
// lahaye.marcel@gmail.com

//Enter your name here.
name 			= 	"YourNameHere";

//Do you want it as keychain figurine?
keyChain = 1; //[1:Yes, 2:No]

// in OpenSCAD units
figurineSize	=	100;

// in OpenSCAD units
keyHoleSize		=	20;

/*[Hidden]*/
//Parameters
len_name		= 	len(name);
mid_name		=	round(len(name)/2)-1;

//factors for the calculations of the spheresizes
factor			=	0.019;
noseFactor		=	0.3;
handFactor		=	0.3;
earFactor		=	0.3;
maxSphereSize 	= 	400;

// Calculations which parse the name and adjust the spheresize based on characters in the name
// Going from about 50% - 100% of the maximum spheresize

//Radius of the head
headRad = (name[0] == "a" || name[0] == "A") ? maxSphereSize * factor	*	26	:	 
			(name[0] == "b" || name[0] == "B") ? maxSphereSize * factor	*	27	:
			(name[0] == "c" || name[0] == "C") ? maxSphereSize * factor	*	28	:
			(name[0] == "d" || name[0] == "D") ? maxSphereSize * factor	*	29	:
			(name[0] == "e" || name[0] == "E") ? maxSphereSize * factor	*	30	:
			(name[0] == "f" || name[0] == "F") ? maxSphereSize * factor	*	31	:
			(name[0] == "g" || name[0] == "G") ? maxSphereSize * factor	*	32	:
			(name[0] == "h" || name[0] == "H") ? maxSphereSize * factor	*	33	:
			(name[0] == "i" || name[0] == "I") ? maxSphereSize * factor	*	34	:
			(name[0] == "j" || name[0] == "J") ? maxSphereSize * factor	*	35	:
			(name[0] == "k" || name[0] == "K") ? maxSphereSize * factor	*	36	:
			(name[0] == "l" || name[0] == "L") ? maxSphereSize * factor	*	37	:
			(name[0] == "m" || name[0] == "M") ? maxSphereSize * factor	*	38	:
			(name[0] == "n" || name[0] == "N") ? maxSphereSize * factor	*	39	:
			(name[0] == "o" || name[0] == "O") ? maxSphereSize * factor	*	40	:
			(name[0] == "p" || name[0] == "P") ? maxSphereSize * factor	*	41	:
			(name[0] == "q" || name[0] == "Q") ? maxSphereSize * factor	*	42	:
			(name[0] == "r" || name[0] == "R") ? maxSphereSize * factor	*	43	:
			(name[0] == "s" || name[0] == "S") ? maxSphereSize * factor	*	44	:
			(name[0] == "t" || name[0] == "T") ? maxSphereSize * factor	*	45	:
			(name[0] == "u" || name[0] == "U") ? maxSphereSize * factor	*	46	:
			(name[0] == "v" || name[0] == "V") ? maxSphereSize * factor	*	47	:
			(name[0] == "w" || name[0] == "W") ? maxSphereSize * factor	*	48	:
			(name[0] == "x" || name[0] == "X") ? maxSphereSize * factor	*	49	:
			(name[0] == "y" || name[0] == "Y") ? maxSphereSize * factor	*	50	:
			(name[0] == "z" || name[0] == "Z") ? maxSphereSize * factor	*	51	:
			 maxSphereSize * 0.75;

//Radius of the body
bodyRad = (name[len_name-1] == "a" || name[len_name-1] == "A") ? maxSphereSize * factor	*	26	:	 
			(name[len_name-1] == "b" || name[len_name-1] == "B") ? maxSphereSize * factor	*	27	:
			(name[len_name-1] == "c" || name[len_name-1] == "C") ? maxSphereSize * factor	*	28	:
			(name[len_name-1] == "d" || name[len_name-1] == "D") ? maxSphereSize * factor	*	29	:
			(name[len_name-1] == "e" || name[len_name-1] == "E") ? maxSphereSize * factor	*	30	:
			(name[len_name-1] == "f" || name[len_name-1] == "F") ? maxSphereSize * factor	*	31	:
			(name[len_name-1] == "g" || name[len_name-1] == "G") ? maxSphereSize * factor	*	32	:
			(name[len_name-1] == "h" || name[len_name-1] == "H") ? maxSphereSize * factor	*	33	:
			(name[len_name-1] == "i" || name[len_name-1] == "I") ? maxSphereSize * factor	*	34	:
			(name[len_name-1] == "j" || name[len_name-1] == "J") ? maxSphereSize * factor	*	35	:
			(name[len_name-1] == "k" || name[len_name-1] == "K") ? maxSphereSize * factor	*	36	:
			(name[len_name-1] == "l" || name[len_name-1] == "L") ? maxSphereSize * factor	*	37	:
			(name[len_name-1] == "m" || name[len_name-1] == "M") ? maxSphereSize * factor	*	38	:
			(name[len_name-1] == "n" || name[len_name-1] == "N") ? maxSphereSize * factor	*	39	:
			(name[len_name-1] == "o" || name[len_name-1] == "O") ? maxSphereSize * factor	*	40	:
			(name[len_name-1] == "p" || name[len_name-1] == "P") ? maxSphereSize * factor	*	41	:
			(name[len_name-1] == "q" || name[len_name-1] == "Q") ? maxSphereSize * factor	*	42	:
			(name[len_name-1] == "r" || name[len_name-1] == "R") ? maxSphereSize * factor	*	43	:
			(name[len_name-1] == "s" || name[len_name-1] == "S") ? maxSphereSize * factor	*	44	:
			(name[len_name-1] == "t" || name[len_name-1] == "T") ? maxSphereSize * factor	*	45	:
			(name[len_name-1] == "u" || name[len_name-1] == "U") ? maxSphereSize * factor	*	46	:
			(name[len_name-1] == "v" || name[len_name-1] == "V") ? maxSphereSize * factor	*	47	:
			(name[len_name-1] == "w" || name[len_name-1] == "W") ? maxSphereSize * factor	*	48	:
			(name[len_name-1] == "x" || name[len_name-1] == "X") ? maxSphereSize * factor	*	49	:
			(name[len_name-1] == "y" || name[len_name-1] == "Y") ? maxSphereSize * factor	*	50	:
			(name[len_name-1] == "z" || name[len_name-1] == "Z") ? maxSphereSize * factor	*	51	:
			 maxSphereSize * 0.5;

//Radius of the nose
noseRad = 	(name[mid_name] == "a" || name[mid_name] == "A") ? maxSphereSize * noseFactor * factor	*	26	:	 
			(name[mid_name] == "b" || name[mid_name] == "B") ? maxSphereSize * noseFactor * factor	*	27	:
			(name[mid_name] == "c" || name[mid_name] == "C") ? maxSphereSize * noseFactor * factor	*	28	:
			(name[mid_name] == "d" || name[mid_name] == "D") ? maxSphereSize * noseFactor * factor	*	29	:
			(name[mid_name] == "e" || name[mid_name] == "E") ? maxSphereSize * noseFactor * factor	*	30	:
			(name[mid_name] == "f" || name[mid_name] == "F") ? maxSphereSize * noseFactor * factor	*	31	:
			(name[mid_name] == "g" || name[mid_name] == "G") ? maxSphereSize * noseFactor * factor	*	32	:
			(name[mid_name] == "h" || name[mid_name] == "H") ? maxSphereSize * noseFactor * factor	*	33	:
			(name[mid_name] == "i" || name[mid_name] == "I") ? maxSphereSize * noseFactor * factor	*	34	:
			(name[mid_name] == "j" || name[mid_name] == "J") ? maxSphereSize * noseFactor * factor	*	35	:
			(name[mid_name] == "k" || name[mid_name] == "K") ? maxSphereSize * noseFactor * factor	*	36	:
			(name[mid_name] == "l" || name[mid_name] == "L") ? maxSphereSize * noseFactor * factor	*	37	:
			(name[mid_name] == "m" || name[mid_name] == "M") ? maxSphereSize * noseFactor * factor	*	38	:
			(name[mid_name] == "n" || name[mid_name] == "N") ? maxSphereSize * noseFactor * factor	*	39	:
			(name[mid_name] == "o" || name[mid_name] == "O") ? maxSphereSize * noseFactor * factor	*	40	:
			(name[mid_name] == "p" || name[mid_name] == "P") ? maxSphereSize * noseFactor * factor	*	41	:
			(name[mid_name] == "q" || name[mid_name] == "Q") ? maxSphereSize * noseFactor * factor	*	42	:
			(name[mid_name] == "r" || name[mid_name] == "R") ? maxSphereSize * noseFactor * factor	*	43	:
			(name[mid_name] == "s" || name[mid_name] == "S") ? maxSphereSize * noseFactor * factor	*	44	:
			(name[mid_name] == "t" || name[mid_name] == "T") ? maxSphereSize * noseFactor * factor	*	45	:
			(name[mid_name] == "u" || name[mid_name] == "U") ? maxSphereSize * noseFactor * factor	*	46	:
			(name[mid_name] == "v" || name[mid_name] == "V") ? maxSphereSize * noseFactor * factor	*	47	:
			(name[mid_name] == "w" || name[mid_name] == "W") ? maxSphereSize * noseFactor * factor	*	48	:
			(name[mid_name] == "x" || name[mid_name] == "X") ? maxSphereSize * noseFactor * factor	*	49	:
			(name[mid_name] == "y" || name[mid_name] == "Y") ? maxSphereSize * noseFactor * factor	*	50	:
			(name[mid_name] == "z" || name[mid_name] == "Z") ? maxSphereSize * noseFactor * factor	*	51	:
			 maxSphereSize * 0.75 * noseFactor;

//Radius of the ears
earChar=	(len_name > 1) ? 1 : 0;
earRad = 	(name[earChar] == "a" || name[earChar] == "A") ? maxSphereSize * factor	* earFactor *	26	:	 
			(name[earChar] == "b" || name[earChar] == "B") ? maxSphereSize * factor	* earFactor *	27	:
			(name[earChar] == "c" || name[earChar] == "C") ? maxSphereSize * factor	* earFactor *	28	:
			(name[earChar] == "d" || name[earChar] == "D") ? maxSphereSize * factor	* earFactor *	29	:
			(name[earChar] == "e" || name[earChar] == "E") ? maxSphereSize * factor	* earFactor *	30	:
			(name[earChar] == "f" || name[earChar] == "F") ? maxSphereSize * factor	* earFactor *	31	:
			(name[earChar] == "g" || name[earChar] == "G") ? maxSphereSize * factor	* earFactor *	32	:
			(name[earChar] == "h" || name[earChar] == "H") ? maxSphereSize * factor	* earFactor *	33	:
			(name[earChar] == "i" || name[earChar] == "I") ? maxSphereSize * factor	* earFactor *	34	:
			(name[earChar] == "j" || name[earChar] == "J") ? maxSphereSize * factor	* earFactor *	35	:
			(name[earChar] == "k" || name[earChar] == "K") ? maxSphereSize * factor	* earFactor *	36	:
			(name[earChar] == "l" || name[earChar] == "L") ? maxSphereSize * factor	* earFactor *	37	:
			(name[earChar] == "m" || name[earChar] == "M") ? maxSphereSize * factor	* earFactor *	38	:
			(name[earChar] == "n" || name[earChar] == "N") ? maxSphereSize * factor	* earFactor *	39	:
			(name[earChar] == "o" || name[earChar] == "O") ? maxSphereSize * factor	* earFactor *	40	:
			(name[earChar] == "p" || name[earChar] == "P") ? maxSphereSize * factor	* earFactor *	41	:
			(name[earChar] == "q" || name[earChar] == "Q") ? maxSphereSize * factor	* earFactor *	42	:
			(name[earChar] == "r" || name[earChar] == "R") ? maxSphereSize * factor	* earFactor *	43	:
			(name[earChar] == "s" || name[earChar] == "S") ? maxSphereSize * factor	* earFactor *	44	:
			(name[earChar] == "t" || name[earChar] == "T") ? maxSphereSize * factor	* earFactor *	45	:
			(name[earChar] == "u" || name[earChar] == "U") ? maxSphereSize * factor	* earFactor *	46	:
			(name[earChar] == "v" || name[earChar] == "V") ? maxSphereSize * factor	* earFactor *	47	:
			(name[earChar] == "w" || name[earChar] == "W") ? maxSphereSize * factor	* earFactor *	48	:
			(name[earChar] == "x" || name[earChar] == "X") ? maxSphereSize * factor	* earFactor *	49	:
			(name[earChar] == "y" || name[earChar] == "Y") ? maxSphereSize * factor	* earFactor *	50	:
			(name[earChar] == "z" || name[earChar] == "Z") ? maxSphereSize * factor	* earFactor *	51	:
			 maxSphereSize * 0.75 * earFactor;

//Radius of the hands
handChar=	(len_name > 2) ? len_name-2 : 0; 
handRad =	(name[handChar] == "a" || name[handChar] == "A") ? maxSphereSize * factor	* handFactor * 26	:	 
			(name[handChar] == "b" || name[handChar] == "B") ? maxSphereSize * factor	* handFactor * 27	:
			(name[handChar] == "c" || name[handChar] == "C") ? maxSphereSize * factor	* handFactor * 28	:
			(name[handChar] == "d" || name[handChar] == "D") ? maxSphereSize * factor	* handFactor * 29	:
			(name[handChar] == "e" || name[handChar] == "E") ? maxSphereSize * factor	* handFactor * 30	:
			(name[handChar] == "f" || name[handChar] == "F") ? maxSphereSize * factor	* handFactor * 31	:
			(name[handChar] == "g" || name[handChar] == "G") ? maxSphereSize * factor	* handFactor * 32	:
			(name[handChar] == "h" || name[handChar] == "H") ? maxSphereSize * factor	* handFactor * 33	:
			(name[handChar] == "i" || name[handChar] == "I") ? maxSphereSize * factor	* handFactor * 34	:
			(name[handChar] == "j" || name[handChar] == "J") ? maxSphereSize * factor	* handFactor * 35	:
			(name[handChar] == "k" || name[handChar] == "K") ? maxSphereSize * factor	* handFactor * 36	:
			(name[handChar] == "l" || name[handChar] == "L") ? maxSphereSize * factor	* handFactor * 37	:
			(name[handChar] == "m" || name[handChar] == "M") ? maxSphereSize * factor	* handFactor * 38	:
			(name[handChar] == "n" || name[handChar] == "N") ? maxSphereSize * factor	* handFactor * 39	:
			(name[handChar] == "o" || name[handChar] == "O") ? maxSphereSize * factor	* handFactor * 40	:
			(name[handChar] == "p" || name[handChar] == "P") ? maxSphereSize * factor	* handFactor * 41	:
			(name[handChar] == "q" || name[handChar] == "Q") ? maxSphereSize * factor	* handFactor * 42	:
			(name[handChar] == "r" || name[handChar] == "R") ? maxSphereSize * factor	* handFactor * 43	:
			(name[handChar] == "s" || name[handChar] == "S") ? maxSphereSize * factor	* handFactor * 44	:
			(name[handChar] == "t" || name[handChar] == "T") ? maxSphereSize * factor	* handFactor * 45	:
			(name[handChar] == "u" || name[handChar] == "U") ? maxSphereSize * factor	* handFactor * 46	:
			(name[handChar] == "v" || name[handChar] == "V") ? maxSphereSize * factor	* handFactor * 47	:
			(name[handChar] == "w" || name[handChar] == "W") ? maxSphereSize * factor	* handFactor * 48	:
			(name[handChar] == "x" || name[handChar] == "X") ? maxSphereSize * factor	* handFactor * 49	:
			(name[handChar] == "y" || name[handChar] == "Y") ? maxSphereSize * factor	* handFactor * 50	:
			(name[handChar] == "z" || name[handChar] == "Z") ? maxSphereSize * factor	* handFactor * 51	:
			 maxSphereSize * 0.75 * handFactor;

// Parameters to adjust how the ears and hands are aligned on head and body
// Play around with them to adjust the alignment
earMoveFactor 	= 0.6; 	//from 0 - 1
handMoveFactor	= 0.9;	//from 0 - 1
handAngle = 50;
xScaleFactor = bodyRad/len_name/3;
yScaleFactor = bodyRad/14;


// Drawing of the whole bear with the given parameters
rotate(a = [90,0,0]){
scale(1/(bodyRad*0.8+bodyRad+headRad+sqrt(pow(headRad,2)-pow(headRad*earMoveFactor,2))+earRad)*figurineSize) //scale the whole bear to the correct size
{

// The head
sphere(headRad);

//Attach the keychain holder or remove a lower part from the body such that the bear can stand
if(keyChain)
{	
	translate([0,headRad*1.05, -maxSphereSize *0.1 /2])
	linear_extrude(height = maxSphereSize*0.1)
	difference()
	{
		circle(keyHoleSize*1.6);
		circle(keyHoleSize);
	}
	translate([0,-(headRad+bodyRad*0.8),0])
	sphere(bodyRad);
}
else
{	

	translate([0,-(headRad+bodyRad*0.8),0])
	difference()
	{
		sphere(bodyRad);
	translate([0,-bodyRad-bodyRad*0.8,0])cube(bodyRad*2,bodyRad*0.2,bodyRad*2, center=true);
	}
}

// The nose
translate([0, 0, headRad+noseRad*0.5])
sphere(noseRad);

// The right ear of the bear
translate([headRad * earMoveFactor, sqrt(pow(headRad,2)-pow(headRad*earMoveFactor,2)), 0])
sphere(earRad);

// The left ear of the bear
translate([-(headRad * earMoveFactor), sqrt(pow(headRad,2)-pow(headRad*earMoveFactor,2)), 0])
sphere(earRad);

// The right hand of the bear
rotate(a = [0,360-handAngle,0])
translate([bodyRad * handMoveFactor, -(headRad+bodyRad*0.8)+sqrt(pow(bodyRad,2)-pow(bodyRad*handMoveFactor,2)), 0])
sphere(handRad);

// The left hand of the bear
rotate(a = [0,handAngle,0])
translate([-(bodyRad * handMoveFactor), -(headRad+bodyRad*0.8)+sqrt(pow(bodyRad,2)-pow(bodyRad*handMoveFactor,2)), 0])
sphere(handRad);

// The nameplate
translate([-len_name*3*xScaleFactor-xScaleFactor/2,-(headRad+bodyRad*0.8)+sqrt(pow(bodyRad,2)-pow(bodyRad*handMoveFactor,2)),(bodyRad * handMoveFactor)*sin(handAngle)+handRad-maxSphereSize/40])
scale([bodyRad*2,bodyRad/2,maxSphereSize/20])
cube(1,1,1);

// The name on the nameplate
translate([-len_name*3*xScaleFactor,-(headRad+bodyRad*0.8)+sqrt(pow(bodyRad,2)-pow(bodyRad*handMoveFactor,2)),(bodyRad * handMoveFactor)*sin(handAngle)+handRad+maxSphereSize/40])
scale([xScaleFactor,yScaleFactor,maxSphereSize/20])
drawtext(name);
}
}



// OpenSCAD 3D Text Generator by pgreenland under Creative Common License 3.0
// http://www.thingiverse.com/pgreenland/about
// http://www.thingiverse.com/thing:59817
// http://creativecommons.org/licenses/by-sa/3.0

module drawtext(text) {
	//Characters
	chars = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}";

	//Chracter table defining 5x7 characters
	//Adapted from: http://www.geocities.com/dinceraydin/djlcdsim/chartable.js
	char_table = [ [ 0, 0, 0, 0, 0, 0, 0],
                  [ 4, 0, 4, 4, 4, 4, 4],
                  [ 0, 0, 0, 0,10,10,10],
                  [10,10,31,10,31,10,10],
                  [ 4,30, 5,14,20,15, 4],
                  [ 3,19, 8, 4, 2,25,24],
                  [13,18,21, 8,20,18,12],
                  [ 0, 0, 0, 0, 8, 4,12],
                  [ 2, 4, 8, 8, 8, 4, 2],
                  [ 8, 4, 2, 2, 2, 4, 8],
                  [ 0, 4,21,14,21, 4, 0],
                  [ 0, 4, 4,31, 4, 4, 0],
                  [ 8, 4,12, 0, 0, 0, 0],
                  [ 0, 0, 0,31, 0, 0, 0],
                  [12,12, 0, 0, 0, 0, 0],
                  [ 0,16, 8, 4, 2, 1, 0],
                  [14,17,25,21,19,17,14],
                  [14, 4, 4, 4, 4,12, 4],
                  [31, 8, 4, 2, 1,17,14],
                  [14,17, 1, 2, 4, 2,31],
                  [ 2, 2,31,18,10, 6, 2],
                  [14,17, 1, 1,30,16,31],
                  [14,17,17,30,16, 8, 6],
                  [ 8, 8, 8, 4, 2, 1,31],
                  [14,17,17,14,17,17,14],
                  [12, 2, 1,15,17,17,14],
                  [ 0,12,12, 0,12,12, 0],
                  [ 8, 4,12, 0,12,12, 0],
                  [ 2, 4, 8,16, 8, 4, 2],
                  [ 0, 0,31, 0,31, 0, 0],
                  [16, 8, 4, 2, 4, 8,16],
                  [ 4, 0, 4, 2, 1,17,14],
                  [14,21,21,13, 1,17,14],
                  [17,17,31,17,17,17,14],
                  [30,17,17,30,17,17,30],
                  [14,17,16,16,16,17,14],
                  [30,17,17,17,17,17,30],
                  [31,16,16,30,16,16,31],
                  [16,16,16,30,16,16,31],
                  [15,17,17,23,16,17,14],
                  [17,17,17,31,17,17,17],
                  [14, 4, 4, 4, 4, 4,14],
                  [12,18, 2, 2, 2, 2, 7],
                  [17,18,20,24,20,18,17],
                  [31,16,16,16,16,16,16],
                  [17,17,17,21,21,27,17],
                  [17,17,19,21,25,17,17],
                  [14,17,17,17,17,17,14],
                  [16,16,16,30,17,17,30],
                  [13,18,21,17,17,17,14],
                  [17,18,20,30,17,17,30],
                  [30, 1, 1,14,16,16,15],
                  [ 4, 4, 4, 4, 4, 4,31],
                  [14,17,17,17,17,17,17],
                  [ 4,10,17,17,17,17,17],
                  [10,21,21,21,17,17,17],
                  [17,17,10, 4,10,17,17],
                  [ 4, 4, 4,10,17,17,17],
                  [31,16, 8, 4, 2, 1,31],
                  [14, 8, 8, 8, 8, 8,14],
                  [ 0, 1, 2, 4, 8,16, 0],
                  [14, 2, 2, 2, 2, 2,14],
                  [ 0, 0, 0, 0,17,10, 4],
                  [31, 0, 0, 0, 0, 0, 0],
                  [ 0, 0, 0, 0, 2, 4, 8],
                  [15,17,15, 1,14, 0, 0],
                  [30,17,17,25,22,16,16],
                  [14,17,16,16,14, 0, 0],
                  [15,17,17,19,13, 1, 1],
                  [14,16,31,17,14, 0, 0],
                  [ 8, 8, 8,28, 8, 9, 6],
                  [14, 1,15,17,15, 0, 0],
                  [17,17,17,25,22,16,16],
                  [14, 4, 4, 4,12, 0, 4],
                  [12,18, 2, 2, 2, 6, 2],
                  [18,20,24,20,18,16,16],
                  [14, 4, 4, 4, 4, 4,12],
                  [17,17,21,21,26, 0, 0],
                  [17,17,17,25,22, 0, 0],
                  [14,17,17,17,14, 0, 0],
                  [16,16,30,17,30, 0, 0],
                  [ 1, 1,15,19,13, 0, 0],
                  [16,16,16,25,22, 0, 0],
                  [30, 1,14,16,15, 0, 0],
                  [ 6, 9, 8, 8,28, 8, 8],
                  [13,19,17,17,17, 0, 0],
                  [ 4,10,17,17,17, 0, 0],
                  [10,21,21,17,17, 0, 0],
                  [17,10, 4,10,17, 0, 0],
                  [14, 1,15,17,17, 0, 0],
                  [31, 8, 4, 2,31, 0, 0],
                  [ 2, 4, 4, 8, 4, 4, 2],
                  [ 4, 4, 4, 4, 4, 4, 4],
                  [ 8, 4, 4, 2, 4, 4, 8] ];

	//Binary decode table
	dec_table = [ "00000", "00001", "00010", "00011", "00100", "00101",
  	            "00110", "00111", "01000", "01001", "01010", "01011",
  	            "01100", "01101", "01110", "01111", "10000", "10001",
  	            "10010", "10011", "10100", "10101", "10110", "10111",
	            "11000", "11001", "11010", "11011", "11100", "11101",
	            "11110", "11111" ];

	//Process string one character at a time
	for(itext = [0:len(text)-1]) {
		//Convert character to index
		assign(ichar = search(text[itext],chars,1)[0]) {
			//Decode character - rows
			for(irow = [0:6]) {
				assign(val = dec_table[char_table[ichar][irow]]) {
					//Decode character - cols
					for(icol = [0:4]) {
						assign(bit = search(val[icol],"01",1)[0]) {
							if(bit) {
								//Output cube
								translate([icol + (6*itext), irow, 0])
									cube([1.0001,1.0001,1]);
							}
						}
					}
				}
			}
		}
	}
}