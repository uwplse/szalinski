/*
	Glass plate holder
	By Humberto Kelkboom
	Lark3D.nl
	
	Changed: Inserted adjustable side thikness.
*/

//The width of the triange
WidthOffTriagle=25;
//The width of the Sides
WithOffSides = 6;

module triangle(width,length,h)
{
	linear_extrude(height=h) 
	polygon([[0,0],[0,width],[length,0]]);
}

module PlateHolder(OOC){
difference(){
triangle(20,20,5);
translate([WithOffSides,WithOffSides,(OOC=="open"?-0.5:2)])triangle(10,10,6);
translate([3,3,2.5])cylinder(r=1.65, h=6, center=true,$fn=24);
}
};

PlateHolder("open");
translate([WidthOffTriagle +10,0,0])PlateHolder("open");
translate([0,WidthOffTriagle +10,0])PlateHolder("close");
translate([WidthOffTriagle +10,WidthOffTriagle +10,0])PlateHolder("close");