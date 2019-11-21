//Made by Timmytool


//variables
//diamiter of the centre hole, in mm
centreD=3.8;
//total hight of the centre spire 
centreH=10;
//steam vent diamiter
steamventD=1.6;
//distance between the centre hole and the steam vent hole (centre to centre), in mm
steamventT=54;
//steam vent hight, make higher then the centre hight, if to take you can clip it with plyers/standley knife 
steamventH=15;
//keeping this the same as the centre hight seems to work well
bowlsupportH=10;
//the larger this is the more stable the "pan",take in to consideration 3d printer platform space.
bowlsupportT=40;


layerhight=0.2+1-1;

//calculations
centreR=centreD/2;
steamventR=steamventD/2;
steamventE=steamventR*2;
mikiears=layerhight*6;

rotate([0,0,45]){

cylinder(centreH,centreR,centreR);	//centre

translate([steamventT,0,0]){			//steam vent
	cylinder(steamventH,steamventR,steamventR);
	cylinder(mikiears,steamventE,steamventE);}
	translate([0,-2,0])cube([54,4,3]);

rotate([0,0,45]){						//bowl support1
	translate([bowlsupportT,0,0]){
		cylinder(bowlsupportH,steamventD,steamventD);
		cylinder(mikiears,steamventD,steamventE);}
	translate([0,-2,0])cube([bowlsupportT,4,3]);}

rotate([0,0,165]){					//bowl support2
	translate([bowlsupportT,0,0]){
		cylinder(bowlsupportH,steamventD,steamventD);
		cylinder(mikiears,steamventD,steamventE);}
	translate([0,-2,0])cube([bowlsupportT,4,3]);}

rotate([0,0,285]){					//bowl support3
	translate([bowlsupportT,0,0]){
		cylinder(bowlsupportH,steamventD,steamventD);
		cylinder(mikiears,steamventD,steamventE);}
	translate([0,-2,0])cube([bowlsupportT,4,3]);}
}