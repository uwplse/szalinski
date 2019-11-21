$fa = .1;
$fn = 100;

//Heigth of the main cylinder
Heigth = 10.0;
//Radius of the main cylinder
RadiusCylinder = 11.54/2;
//Radius of the Pie part
RadiusPie = 17.6/2;
//heigth of the Pie part
HeigthPie = 3.63;
//Width if the Pie piece in degrees
PiePieceWidth = 54;
//Width of the hole in the main cylinder
widthHole = 3.6;
//Length of the hole in the main cylinder
lengthHole = 6.44; 

module pie_slice(r, a, h, q=90){
  intersection(){
    cylinder(h=h, r=r);
    cube([r, r, h]);
    rotate(a-q) cube([r, r, h]);
  }
}

module ding(){
	cylinder(h = Heigth, r = RadiusCylinder);
	pie_slice(r=RadiusPie,a=PiePieceWidth,h=HeigthPie);
	rotate(180) pie_slice(r=RadiusPie,a=PiePieceWidth,h=HeigthPie);
}

difference(){
	ding();
	rotate(90 + PiePieceWidth/2) cube([lengthHole, widthHole, Heigth*2+0.1], center=true);
}

