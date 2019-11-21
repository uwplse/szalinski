/*
	Token Generator 
	Basolur - 2018
*/

/* [Global] */

ProduceSet=1; //[0:One token, 1:Set of Token]

/* [Shape] */

//For one token Config
//Token shape
//Numbre of side for the shape (produce a valide Reuleux shape if odd)
side=5; // [2:12]
//Diameter of the shape in mm
diameter=20;
//thickness of the shape in mm (not the total thickness if you use the stackRing)
thick=4;

/* [String] */

// thickness of the pop - depth of the hole in mm
stringThick=0.8;

string="42";

// How big is the text relative to the diameter
fontRatio=0.55;

font="UnifrakturCook"; //[UnifrakturCook, Helvetica, Spicy Rice, Chela One, Permanent Marker]

popText=0; //[0:no, 1:yes]

/* [Stack Ring]*/
//Stackable param

//make stack ring
stackable=1; //[0:no, 1:yes]
//thickness of the ring
stackRingMulti=4;
//height of the ring in mm
ringSize=1.5;

/* [Printer Constant] */
//Syteme constant
tol=0.3;
nozzle=0.4;
$fn=100;

/* [Set] */

//Set config
// Diameter of the biggest piece of the set
pieceOffSet=26;
//Number of piece before changing line
maxX=3;

//The set to produce each piece is describe as [side, diameter, thickness, string thickness, string, font, font ratio, pop text, stack ring, stack ring thickness]
Set=[[3,20,4,0.8,"1","UnifrakturCook",0.84,false,4,true,1],[5,20,4,0.8,"6","UnifrakturCook",0.84,true,4,true,1],[7,20,6,0.8,"X","UnifrakturCook",0.84,false,4,true,1],[7,20,3,0.8,"£","Helvetica",0.84,false,4,false,1], [3,26,5,0.8,"42","Permanent Marker",0.60,false,4,true,1], [5,15,5,1.2,"#","UnifrakturCook",0.8,true,4,false,1]];
/*
//Set used for the exemple stl
Set=[[5,24,4,0.8,"1","Elric:style=Bold",0.84,false,4,true,1],
	 [5,24,4,0.8,"2","Elric:style=Bold",0.84,false,4,true,1],
	 [5,24,4,0.8,"3","Elric:style=Bold",0.84,false,4,true,1],
	 [5,24,4,0.8,"4","Elric:style=Bold",0.84,false,4,true,1],
	 [3,26,4,0.8,"X","Elric:style=Bold",0.84,false,4,false,1],
	 [7,26,4,0.8,"⚛","DejaVu Sans:style=Bold",1.1,false,4,true,1],
	 [5,26,4,0.8,"666","Elric:style=Bold",0.5,false,4,true,1],
	 [4,26,4,0.8,"♠","DejaVu Sans:style=Bold",0.9,false,4,false,1],
	 [9,26,4,1.2,"♞","DejaVu Sans:style=Bold",1.2,true,4,false,1],
	];
*/
function rayon(diameter, baseAngle) = diameter / (2*sin((360-baseAngle)/4));
function dot(baseAngle, nb, diameter) = rayon(diameter, baseAngle) * [-sin(baseAngle*nb),cos(baseAngle*nb)];

module reuleaux(side=3, diameter=10){
		dots = [for(i=[0:side-1])dot(360/side, i, diameter)];
		intersection_for(i=dots)
			translate(i)circle(r=diameter);
}

module stringPrep(stringThick=1, string="5", fontRatio=1, diameter=10, font){
	linear_extrude(stringThick)
		text(string, halign="center", valign="center", size=diameter*0.5*fontRatio, font=font);
}

module stackRing(side=3, diameter=10, bottom=false, ringSize=1, stackRingMulti=stackRingMulti){
	base=nozzle*stackRingMulti;
	if(!bottom){
		linear_extrude(ringSize)difference(){
			reuleaux(side, diameter-(base*2)-tol);
			reuleaux(side, diameter-(base*4)+tol);};
	}else{
		linear_extrude(ringSize+tol)difference(){
			reuleaux(side, diameter-(base*2)+tol);
			reuleaux(side, diameter-(base*4)-tol);};
	}
}

module B_token(thick=4, diameter=10, side=3, string="5",
			   stringThick=1, fontRatio=1, font, popText=false){

	if(popText){
		union(){
			linear_extrude(thick) reuleaux(side, diameter);
			translate([0,0,thick])
				stringPrep(diameter=diameter, stringThick=stringThick, fontRatio=fontRatio, font=font, string=string);
		}
	}else{
		difference(){
			linear_extrude(thick) reuleaux(side, diameter);
			translate([0,0,thick-stringThick])
				stringPrep(diameter=diameter, stringThick=stringThick, fontRatio=fontRatio, font=font, string=string);
		}
	}
}

module token(stackable=true,thick=4, diameter=10, side=3,
			 string="5", stringThick=1, fontRatio=1,
			 font, ringSize=1, popText=false, stackRingMulti=2){
	if(stackable){
		difference(){
			union(){
				B_token(thick=thick, diameter=diameter, side=side, string=string, stringThick=stringThick, fontRatio=fontRatio, font=font, popText=popText);
				translate([0,0,thick])stackRing(side=side, diameter=diameter, bottom=false, ringSize=ringSize, stackRingMulti=stackRingMulti);
			}
			stackRing(side=side, diameter=diameter, bottom=true, ringSize=ringSize, stackRingMulti=stackRingMulti);
		}
	}else{
		B_token(thick=thick, diameter=diameter, side=side, string=string, stringThick=stringThick, fontRatio=fontRatio, font=font, popText=popText);
	}
}

module TokenSet(set=Set){
	for(i=[0:len(set)]){
		translate([(i%maxX)*(pieceOffSet+2),floor(i/maxX)*(pieceOffSet+2),0]) token(side=set[i][0], diameter=set[i][1], thick=set[i][2], 
								   stringThick=set[i][3], string=set[i][4], font=set[i][5],
								   fontRatio=set[i][6], popText=set[i][7], stackRingMulti=set[i][8], stackable=set[i][9],
							       ringsize=set[i][10]);
	}
}



if(ProduceSet){
	TokenSet(set=Set);
}else { 
	token(stackable=stackable,thick=thick, diameter=diameter, side=side,
		  string=string, stringThick=stringThick, fontRatio=fontRatio,
	  	  font=font, ringSize=ringSize, stackRingMulti=stackRingMulti, popText=popText);
}

