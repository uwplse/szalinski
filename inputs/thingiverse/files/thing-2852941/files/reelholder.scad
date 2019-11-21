$fn=48;

peg=7.44;
pegClearance=0.3;
pegHole=peg+pegClearance;

pegHeight=10;
pegRidgeBottom=7;
pegRidgeTop=4;
pegRidgeDiameter=6.5;
pegRidgeSpace=6.5;

handleDiameter=30;


module handle()
{difference() {
	union() {
		cylinder(d1=handleDiameter,d2=handleDiameter*0.33,h=pegHeight);
		translate([0,0,pegHeight])
			cylinder(d1=handleDiameter*0.33,d2=handleDiameter*0.66,h=pegHeight*0.5);
	}
	translate([0,0,-0.01])
	peg();
	pegSpace();
}}

module peg()
{difference() {
	cylinder(d=pegHole,h=pegHeight);
	translate([0,0,pegHeight-pegRidgeBottom+1])
		donut(i=pegRidgeDiameter,o=pegHole*2,h=1);
	
}}


module pegSpace()
{difference() {
	cylinder(d=pegHole,h=pegHeight);
	translate([(pegRidgeSpace/2),-pegHole,-0.01])
		cube([pegHole,pegHole*2,pegHeight*2]);
	
	translate([(-pegHole-pegRidgeSpace*0.5),-pegHole,-0.01])
		cube([pegHole,pegHole*2,pegHeight*2]);
	
}}

module donut(i,o,h)
{difference(){
	cylinder(d=o,h=h);
	cylinder(d=i,h=h*2);
}}

handle();