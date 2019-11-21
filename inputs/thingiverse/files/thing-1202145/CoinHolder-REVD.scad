Length=85; //Credit Card Size
Width=53; //Credit Card Size
Thickness=2.25; //0.5mm thicker than thickest coin
NDia=21.19; //Canadian Nickle Diameter
NThick=1.81; //Canadian Nickle Thickness
DDia=18.01; //Canadian Dime Thickness
DThick=1.19; //Canadian Dime Thickness
QDia=23.88; //Canadian Quarter Thickness
QThick=1.58; //Canadian Quarter Thickness
WallWidth=3.75; //Hub Thickness for flexibimty and strength
$fn=40;


module CoinHole(Diameter){
	translate([0,0,-Thickness/2])cylinder(r1=Diameter*0.49,r2=Diameter*.51,h=Thickness/2);
	translate([0,0,0])cylinder(r1=Diameter*0.51,r2=Diameter*.49,h=Thickness/2);
	cylinder(r=Diameter*.49,h=Thickness*2,center=true);
}
module OutCoinHole(Diameter){
	translate([0,0,-Thickness/2])cylinder(r1=Diameter*0.49,r2=Diameter*.51,h=Thickness/2);
	translate([0,0,0])cylinder(r1=Diameter*0.51,r2=Diameter*.49,h=Thickness/2);
	//cylinder(r=Diameter*.49,h=Thickness*2,center=true);
}
module CutOut(Size){
	translate([-Size,0,-Thickness])cylinder(r=Size,h=Thickness*2,$fn=7,center=false);
}
module CoinCircle(XLoc,YLoc,Diameter,Rot){
	difference(){
		translate([XLoc,YLoc,0])OutCoinHole(Diameter+WallWidth*2); //Outside Circle
		translate([XLoc,YLoc,0])CoinHole(Diameter); //Inside Circle
		translate([XLoc,YLoc,0])rotate(a=[0,0,Rot])CutOut(Diameter); //Stress Notch
	}
}

intersection(){
	union(){
		CoinCircle(-24.9,14.05,QDia,-64); //Quarter 1
		CoinCircle(-24.9,-14.05,QDia,64); //Quarter 2
		CoinCircle(24.9,13.1,QDia,-134); //Quarter 3
		CoinCircle(23.5,-13.5,NDia,134); //Nickle 1
		CoinCircle(0,11.05,DDia,-90); //Dime 1
		CoinCircle(0,-11.05,DDia,90); //Dime 2
	}
	minkowski(){
			cube([Length-4,Width-4,Thickness],center=true);
			cylinder(r=2,h=Thickness/2,center=true);
	}
}