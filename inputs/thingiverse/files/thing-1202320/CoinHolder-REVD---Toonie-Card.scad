Length=92; //Credit Card Size
Width=56; //Credit Card Size
NDia=21.19; //Canadian Nickle Diameter
NThick=1.81; //Canadian Nickle Thickness
DDia=18.01; //Canadian Dime Thickness
DThick=1.19; //Canadian Dime Thickness
QDia=23.88; //Canadian Quarter Thickness
QThick=1.58; //Canadian Quarter Thickness
LDia=26.48; //Canadian Loonie Diameter
LThick=1.92; //Candian Loonie Thickness
TDia=27.94; //Candian Toonie Diameter
TThick=1.67; //Candian Toonie Thickness
WallWidth=3.75; //Hub Thickness for flexibimty and strength
Thickness=LThick+0.5; //0.5mm thicker than thickest coin
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
		CoinCircle(0,-14,TDia,90); //Loonie 1
		CoinCircle(32,-14,TDia,135); //Loonie 2
		CoinCircle(-32,-14,TDia,45); //Loonie 3
		CoinCircle(16,14,TDia,-135); //Loonie 4
		CoinCircle(-16,14,TDia,-45); //Loonie 5
	}
	minkowski(){
			cube([Length-4,Width-4,Thickness],center=true);
			cylinder(r=2,h=Thickness/2,center=true);
	}
}