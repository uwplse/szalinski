//coin diameter (mm)
coin1=17.91;
//coin diameter (mm)
coin2=19.05;
//coin diameter (mm)
coin3=24.26;
//coin diameter (mm)
coin4=24.26;
//coin diameter (mm)
coin5=19.05;
//coin diameter (mm)
coin6=21.21;
//Thickness (thicker than thickest coin) (mm)
Thickness=2.25;
//Hub width (separation) (mm)
WallWidth=3.75;

/* [Hidden] */
Length=85; //Credit Card Size
Width=53; //Credit Card Size
//NDia=21.21; //US Nickle Diameter
//NThick=1.95; //US Nickle Thickness
//DDia=17.91; //US Dime Diameter
//DThick=1.35; //US Dime Thickness
//QDia=24.26; //US Quarter Diameter
//QThick=1.75; //US Quarter Thickness
//PDia=19.05; //US Penny Diameter
//PThick=1.52; //US Penny Thickness
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
Separation=WallWidth * 1.1;
intersection(){
union(){
		CoinCircle(-((coin1/2)+(coin2/2)+Separation),(coin1/2)+(Separation/2),coin1,-64); //coin 1, upper left
		CoinCircle(0,(coin2/2)+(Separation/2),coin2,-90); //coin 2, upper middle
		CoinCircle(((coin2/2)+(coin3/2)+Separation),(coin3/2)+(Separation/2),coin3,-135); //coin 3, upper right
		CoinCircle(-((coin4/2)+(coin5/2)+Separation),-((coin4/2)+(Separation/2)),coin4,65); //coin 4, lower left
		CoinCircle(0,-((coin5/2)+(Separation/2)),coin5,90); //coin 5, lower middle
		CoinCircle(((coin5/2)+(coin6/2)+Separation),-((coin6/2)+(Separation/2)),coin6,135); //coin 6, lower right
}
minkowski(){
cube([Length-4,Width-4,Thickness],center=true);
cylinder(r=2,h=Thickness/2,center=true);
}
}
