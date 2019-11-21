use <../utils/build_plate.scad>
use <MCAD/2dShapes.scad>;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);


   //////////////////
  //  Parameters  //
 //////////////////

/* [Global] */
//thickness of side walls and bottom (mm)
Dicke  = 4;
Dicke2  = 1.3;
Laenge = 50;
Breite = 20;
Breite2= 4;
Winkel= 15;
dScrew=5.5;

/* [Hidden] */

//sets openSCAD resolution for nice, round holes
$fa=1;
$fs=0.5;


module Plate() {
	difference() {
		union(){
			cube(size=[Breite,Laenge,Dicke],center=false);		
			color("red")
			translate([Breite/2-Breite2/2,0,Dicke])
			cube(size=[Breite2,Laenge,Dicke2],center=false);		
			}
		//Bohrlöcher
		translate([Breite/2,10,-1])
		cylinder(h = Dicke+4, r=dScrew/2);
		translate([Breite/2,Laenge-10,-1])
		cylinder(h = Dicke+4, r=dScrew/2);
		}
	}	

	translate([0,-Laenge,0])
	union() {
		Plate();		
		translate([0,Laenge,0])
		rotate([0,0,Winkel])
		Plate();

		translate([0,Laenge,0])
		linear_extrude(height=Dicke)
		pieSlice(20,0,Winkel);
		}
