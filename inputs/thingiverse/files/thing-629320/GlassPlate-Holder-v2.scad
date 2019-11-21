/*
	Glass plate holder
	By Humberto Kelkboom
	Lark3D.nl
	
	Changed: Inserted adjustable side thikness.
	
	Changed: inserted glass height and lowerd screw
*/

//The width of the triange
WidthOffTriagle=30;
//The width of the Sides
WithOffSides = 7;
//height of the glassplate
height = 6;

module triangle(width,length,h)
{
	linear_extrude(height=h) 
	polygon([[0,0],[0,width],[length,0]]);
}

module PlateHolder(OOC){
union(){
difference(){
union(){
triangle(WidthOffTriagle,WidthOffTriagle,height);
translate([4,4,height/2])cylinder(r=5, h=height, center=true,$fn=24);
}
translate([WithOffSides,WithOffSides,(OOC=="open"?-0.5:1)])triangle(WidthOffTriagle,WidthOffTriagle,height+2);
translate([4,4,height/2])cylinder(r=1.65, h=height, center=true,$fn=24);
translate([4,4,1.2])cylinder(r=3.5, h=2.4, center=true,$fn=24);
}
translate([4,4,2.6])cylinder(r=4, h=0.6, center=true,$fn=24);
}
};

PlateHolder("open");

translate([WidthOffTriagle +10,0,0])PlateHolder("open");
translate([0,WidthOffTriagle +10,0])PlateHolder("close");
translate([WidthOffTriagle +10,WidthOffTriagle +10,0])PlateHolder("close");
