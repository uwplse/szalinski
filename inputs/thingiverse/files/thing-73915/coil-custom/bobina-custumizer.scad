//////////////DICHIARAZIONI///////////////////////

r=44;//minimo 8mm massimo 100mm
depth=24;//spessore bobina
height=24;//altezza bobina
distance=r-1;
distance2=r+depth+3;

///////////////////////////////////////////////////
$fn=80;

module A()//scanalature 
{
if (r>15){ hull(){
	translate([0, distance,0])cylinder(height/2+3,3,3);
	translate([0,distance2+depth,0])cylinder(height/2+3,3,3);		
					}} 
else { hull(){		
	translate([0, distance,0])cylinder(height/2+3,2,2);
	translate([0,distance2,0])cylinder(height/2+3,2,2);
					}}
}

module incastro()//giunzione
		{
		translate([1.5,-1.5,height/2+2])rotate([90,0,45])cylinder(r,1.5,1.5);		
		translate([1.5,1.5,height/2+2])rotate([90,0,135])cylinder(r,1.5,1.5);	
translate([-1.5,-1.5,height/2+2])rotate([90,0,-45])cylinder(r,1.5,1.5);	
translate([-1.5,1.5,height/2+2])rotate([90,0,-135])cylinder(r,1.5,1.5);		
		}
module coil()
{
difference()
	{
	union()
		{
		cylinder(2,r+depth+2,r+depth); //disco maggiore 
		cylinder(height/2+2,r+2,r+2); //disco minore
		}
		cylinder(height/2+3,3,3); //foro centrale
		incastro();
		rotate([0,0,0])		A();
		rotate([0,0,90])		A();
		rotate([0,0,180])	A();
		rotate([0,0,270])	A();
}
}

coil();
translate([r*2+depth*2+8,0,0])coil();
incastro();







