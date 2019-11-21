// Universal quadpod
// central part 
// OK1CDJ 2015

$fn=50;
base_width = 25; // lenght of each base arm
base_thickness = 20; // thickness of the base
holder_wall = 15; // wall thickness arroud mast
hole_dia = 42; // size of the hole for the center mast
screw_dia=6;   // hole for screw
arm_width=20; // with of arm
spacer=3;     // space in arm

module holder()
{
	difference(){
		union(){
			translate([hole_dia/2+holder_wall-2,-arm_width/2,0])
			cube([base_width,arm_width,base_thickness],center=false);
		   rotate([0,0,180])translate([hole_dia/2+holder_wall-2,-arm_width/2,0])
			cube([base_width,arm_width,base_thickness],center=false);
			rotate([0,0,90])translate([hole_dia/2+holder_wall-2,-arm_width/2,0])
			cube([base_width,arm_width,base_thickness],center=false);
			rotate([0,0,270])translate([hole_dia/2+holder_wall-2,-arm_width/2,0])
			cube([base_width,arm_width,base_thickness],center=false);
			
       	cylinder(h = base_thickness , d =hole_dia+holder_wall*2, center = false);
			
            
           
	}
  		
		cylinder(h = base_thickness+50, d= hole_dia, center=true);
		translate([0,0,base_thickness/2])rotate([90,0,0])
	
		
		translate([-(hole_dia/2+holder_wall+base_width/2),0,0])cylinder(h=100,d=5,center=true);
        translate([0,0,base_thickness/2])rotate([90,0,0])
        translate([(hole_dia/2+holder_wall+base_width/2),0,0])cylinder(h=100,d=5,center=true);
		
		translate([0,(hole_dia/2+holder_wall+base_width/2),base_thickness/2])rotate([90,0,90])
		cylinder(h=100,d=5,center=true);
		translate([0,-(hole_dia/2+holder_wall+base_width/2),base_thickness/2])rotate([90,0,90])
		cylinder(h=100,d=5,center=true);
		rotate([0,0,90]) translate([hole_dia/2-2,-1,-2])
			cube([hole_dia/2+holder_wall+base_width,spacer,base_thickness+4],center=false);
	}
}

union()
{
holder();
}