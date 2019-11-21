//Easter Egg Maker
// Copyright 2014 Richard Swika All Rights Reserved
//Revision C, April 15 2014 (Added solid option to remove internal geometry and make a solid core for infill)
//Revision: B, April 11 2014 (Added Hollow and Bisect)
//Revision: A, April 9 2014 (Added Array Decorator)
//Revision: Original April 4 2014 (Striped Egg Release)
//
/* [Global] */
//Length of the egg (mm)?.
egg_length=60; //[30:200]
//What shape egg? (use 7 for a hen egg; 0 for a sphere; 100 for a blimp)
egg_shape=7; //[0:100]
//What percentage of the interior should have no geometry.
interior=95; //[0:95]
//Do you want the interior to be solid? (so it will be infilled when printed).
solid="yes"; //[yes,no]
//How much should the decoration overhang? (>=5 for single extrusion; 0 for duel extrusion).
overhang=5; //[0..50]
//Do you want it bisected? (Yes for printing without support, no during preview.)
bisect="yes"; //[yes,no]

// Which parts would you like to see?
part = "All"; //[All:Both Egg and Decoration,Egg:Just Egg with no Decoration,Decoration:Just Decoration with no Egg]

/* [Array] */
//Choose how features are positioned.
style="rectangular"; //[polar,rectangular]
//Choose a feature to repeat?
feature="diamond"; //[star,dot,triangle,square,diamond,pentagon,hexagon,octagon]
//Set the relative size of the feature
size_of_feature=45; //[1:75]
//How much rotation over the length of the egg?
phase=360; //[0:720]
//Vary feature size?
proportional="yes"; //[yes,no]


//About how many rows?
number_of_rows=15; //[1:15] 
//About how many columns?
number_of_columns=5; //[1:15] 

/* [Stripes] */
//Where you want the stripes painted?
draw_axis="X"; //[X,Y,Z,XY,XZ,YZ,XYZ]
//About how many stripes do you want?
number_of_stripes=2; //[1:10] 
//How thick of a stripe do you want?
ratio=5; //[1:15]
//How can I tilt your stripes (degrees)?
tilt_angle=0; //[0,5,10,15,30,45]

/* [Hidden] */
preview_tab="Array";
nstripes=number_of_stripes;
function P2R(p)=[p[0]*cos(p[1]),p[0]*sin(p[1])];

/* main */
bisect() hollow_shell(interior/100) easter_egg(l=egg_length,c=egg_shape/10);

module easter_egg(l=60,c=0.7,
							ce="blue", cd="yellow"){
	union(){
		if (part=="All") color(ce) egg(l=l,c=c);
		scale(overhang/1000+1.001)
		if (part!="Egg"){
			 intersection(){
					color(cd) egg(l=l,c=c); decoration(l);}
		} else difference(){
					color(ce) egg(l=l,c=c); decoration(l);}
	}
}

module decoration(l=60){
	if (preview_tab=="Stripes") stripes(l=l);
	else if (preview_tab=="Array"){
		if (style=="rectangular"){
			 spin(n=number_of_columns) 
				row(n=number_of_rows,interval=l/number_of_rows)
				linear_extrude(height=l,twist=0,center=true,convexity=10){
					shape();	};
		}else /*if (style=="polar")*/{
				radiate(nr=number_of_rows,nc=number_of_columns)
				linear_extrude(height=l,twist=0,center=true,convexity=10){
					shape();
				}
			}
	}
}

module shape(){
  if (feature=="star"){star2D(r1=size_of_feature/10,r2=size_of_feature/20);}
  else if (feature=="dot"){circle(d=size_of_feature/10,$fn=32);}
  else if (feature=="triangle"){circle(size_of_feature/10,$fn=3);}
  else if (feature=="square"){square(size_of_feature/10,center=true);}
  else if (feature=="diamond"){rotate(45) square(size_of_feature/10,center=true);}
  else if (feature=="pentagon"){circle(size_of_feature/10,$fn=5);}
  else if (feature=="hexagon"){circle(size_of_feature/10,$fn=6);}
  else if (feature=="octagon"){circle(size_of_feature/10,$fn=8);}
}

module stripes(l=60){
	rotate([0,tilt_angle])
		repeat_on_axis(draw_axis)
			if (1){echo("stri");
					linear_extrude(height=2*l,twist=360*nstripes,center=true,convexity=6,slices=100*nstripes){
					translate([l/2,0,0]) circle(l/2,center=true,$fn=5);
				}
			} else {
				row(n=nstripes,space=(2*l/(2*(nstripes)-3))) 
					cube([0.1*ratio*l/(2*(nstripes)-1),l+1,l+1],center=true);
			}
}

module star2D(r1=100,r2=35,twist=0){
		d=360/10; 
		 points=[P2R([r1,d*0+twist]),P2R([r2,d*1]),
							P2R([r1,d*2+twist]),P2R([r2,d*3]),
							P2R([r1,d*4+twist]),P2R([r2,d*5]),
							P2R([r1,d*6+twist]),P2R([r2,d*7]),
							P2R([r1,d*8+twist]),P2R([r2,d*9])];
		color("yellow",0.5)  rotate(90) polygon(points=points,convexity=4);
}

//egg equation adapted from http://www16.ocn.ne.jp/~akiko-y/Egg
//(y^2 + z^2)^2=4z^3 + (4-4c)zy^2
// c=0.7 produces an almost perfect hen egg outline
// c=0 produces a perfect sphere
// c>1 produces an elongated egg shape
//z ranges from 0 to 1
function egg_outline(c,z)= z >=1 ? 0 : (sqrt(4-4*c-8*z+sqrt(64*c*z+pow(4-4*c,2)))*sqrt(4*z)/sqrt(2))/4;
module egg(l=60,c=0.7,fn=32){
  function z(p)=(1+sin(p*90))/2;	
	step=2/fn;
	union(){
		scale(l) 
		rotate([0,90,0]) //looks more stable like this
		for(p = [-1 : step : 1-step])	{
			assign(z1=z(p),z2=z(p+step)+0.0004){
				assign(r1=egg_outline(c,z1),r2=egg_outline(c,z2)){
					translate([0,0,z1-.5])
					cylinder(r1=r1,r2=r2,h=(z2-z1),$fn=fn);
				}
			}
		}
	}
}

//make a row of n objects along vector V; repeat an object every interval units
module row(n=2, interval=12, v=[1,0,0], vr=[phase/360,0,0]){
	translate((1-n)*(interval*v/2)){
	    for (i = [0:n-1]){
			assign(d=(proportional=="yes") ? 2.8*egg_outline(egg_shape/10,1/(2*n)+i/n) : 1 ){
				translate(i*interval*v) rotate(vr*i*180/n) scale([d,d,1]) child();}
		}
	}
}

module radiate(nr=4, nc=4){
	for (j=[0:nc-1], i = [0:nr-1]){
		assign(d=(proportional=="yes") ? ((0.5+abs(i/nc-0.5))):1){
			rotate([(j/nc-0.5)*180,(i+phase)*180/nr,phase]) scale([d,d,1]) child();}
	}
}

//repeat objects on any axis using any combination of X, Y, and Z
module repeat_on_axis(orient="X"){
	if (search("X",orient)) rotate([0,90,0]) child();
	if (search("Y",orient)) rotate([0,0,0]) child();
	if (search("Z",orient))  rotate([0,0,90]) child();
}

//repeat n objects rotated about axis v
module spin(n=6,v=[1,0,0]){
	for (i=[0:n-1]){rotate(v*i*180/n)child();}
}

//Makes a solid object into hollow shell of its former self
//the size of the inside is factor * size of outside 
module hollow_shell(factor=0.95){
	if ((factor<=0) ) child(0);
	else union(){
	  difference()  {
		translate([0,0,0.01])
		child(0);
		scale(factor) egg(c=egg_shape/10,l=egg_length);
	  }
	 if ((part!="Decoration") && (solid=="yes")) { //Add solid core back for infill
		scale(factor*1.01) egg(c=egg_shape/10,l=egg_length);
	  }
	}
}

//bisect object down the middle and postion the two halfs for printing
module bisect(){
	if (bisect=="yes"){
		difference(){
			rotate([0,90,0]) union(){
				translate([0,0,egg_length/2+1])child(0);
				translate([0,0,-egg_length/2-1]) rotate([0,0,180]) child(0);
			}
			translate([0,0,-1-egg_length/4])
				cube([egg_length*2.1,egg_length*1.05,2+egg_length/2],center=true);
		}
	}
	else {child(0);}
}

