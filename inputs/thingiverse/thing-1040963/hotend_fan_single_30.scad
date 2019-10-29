include <configuration.scad>;

barrel_radius = hotend_radius - 2;
barrel_height = 30;
fan_offset = 18;
include_fan_bracket = false;

module hotend_fan() { 
    difference() {
    union() {
        if(include_fan_bracket) {
            translate([0, 2 - fan_offset, 15])
                cube([35, 35, 30], center=true);
        }
/*		
        if(!include_fan_bracket) {
            translate([0, 6 - fan_offset,groove_height / 2])
                cube([26, 6, groove_height], center=true);
        }		
*/        
		//translate([0, 2 - fan_offset, 0])
        //  cylinder(r=17, h=30, $fn=6);
        translate([0, 0, groove_height/2]) {
            cube([26, 25, groove_height], center=true);
        }
        
		translate([0,12.5,0])
            hull() {
                translate([10,0,0])
                    cylinder(r=3, h=groove_height, $fn=50);
                translate([-10,0,0])
                    cylinder(r=3, h=groove_height, $fn=50);
            }
         translate([0,-12.5,0])
            hull() {
                translate([10,0,0])
                    cylinder(r=3, h=groove_height, $fn=50);
                translate([-10,0,0])
                    cylinder(r=3, h=groove_height, $fn=50);
            }
    }
    
    // Opposite side cutaway (outgoing airflow).
    translate([0, 40, groove_height + 0.01])
        rotate([0, 0, 30])
            cylinder(r=40, h=200, $fn=6);

    // Keep printed plastic away from the hotend.
    translate([0, -15,15])
		rotate([-75,0,0])
            cylinder(r=8, h=20);
	
	//notch for heater blocks
	translate([0,-5,30])
		cube([40,13,6], center=true);

	//remove point between barrels
	translate([0,0,10])
		cube([20,53,6], center=true);
		
	//remove point between barrels
	translate([0,-5,25])
		cube([nozzle_distance,10,6], center=true);
	
	translate([0,0,0]){
        // Groove mount.
        cylinder(r=groove_radius+1, h=200, center=true, $fn=50);
        // J-Head barrel.
        translate([0, 0, groove_height + 0.02])
          cylinder(r=barrel_radius + 1, h=100, $fn=24);
            // Groove mount insert slot.
            rotate([0,0,-90])
                translate([0, 10, 0])
                    cube([2*groove_radius+2, 20, 20], center=true);
    }
/*
	translate([-nozzle_distance / 2,0,0]) {
        // Groove mount.
        cylinder(r=groove_radius, h=200, center=true, $fn=24);
        // J-Head barrel.
        translate([0, 0, groove_height + 0.02])
          cylinder(r=barrel_radius + 1, h=100, $fn=24);

	
        // Groove mount insert slot.
        rotate([0,0,45])
            translate([0, 10, 0])
                cube([2*groove_radius, 20, 20], center=true);
	}
*/
	if(include_fan_bracket)	{
        // Fan mounting surface and screws.
        translate([0, -50 - fan_offset, 0])
            cube([100, 100, 100], center=true);
        for (x = [-12, 12]) {
            for (z = [-12, 12]) {
                translate([x, -fan_offset, z+15]) 
                    rotate([90, 0, 0]) #
                        cylinder(r=m3_radius, h=16, center=true, $fn=12);
            }
        }
        // Vertical inner space.
        intersection() {
            cube([22, 100, 100], center=true);
            translate([0, -12, groove_height])
                cylinder(r=16, h=10, $fn=6);
        }
        // Air funnel.
        difference() {
            translate([0, -1 - fan_offset, 15])
                rotate([-90, 0, 0])
                    cylinder(r1=15, r2=10, h=12, $fn=36);
        }
	}
   
        // viti e bulloni
		union(){
            rotate([0, 0, -150]) translate([0, 12.5, 5]) {
                cylinder(r=m3_nut_radius, h=4, center=true, $fn=6);
                cylinder(r=m3_radius, h=12, center=true, $fn=50);
            }

            rotate([0, 0, -180]) translate([0, 12.5, 5]) {
               cylinder(r=m3_radius+1, h=12, center=true, $fn=50);
            }

            rotate([0, 0, -210]) translate([0, 12.5, 5]) {
                cylinder(r=m3_nut_radius, h=4, center=true, $fn=6);
                cylinder(r=m3_radius, h=12, center=true, $fn=50);
            }

            rotate([0, 0, -30]) translate([0, 12.5, 5]) {
                cylinder(r=m3_nut_radius, h=4, center=true, $fn=6);
                cylinder(r=m3_radius, h=12, center=true, $fn=50);
            }

            rotate([0, 0, 30]) translate([0, 12.5, 5]) {
                cylinder(r=m3_nut_radius, h=4, center=true, $fn=6);
                cylinder(r=m3_radius, h=12, center=true, $fn=50);
            }

            translate([0, 12.5, 5]) {
                cylinder(r=m3_radius+1, h=12, center=true, $fn=50);
            }
        }

  }
  
  // Supporto ventola destra
  translate([-5,15,0]) cube([10,10,4.5]);
  translate([-5,25,0]) rotate([30,0,0]) difference() {
      cube([10,10,5]);
      translate([5,7.5,2.5]) rotate([0,90,0]) cylinder(r=1.6, h=12, center=true, $fn=50);
  }
  
  // Supporto ventola sinistra
  translate([-5,-25,0]) cube([10,10,4.5]);
  translate([-5,-22.5,4.3]) rotate([150,0,0]) difference() {
      cube([10,10,5]);
      translate([5,7.5,2.5]) rotate([0,90,0]) cylinder(r=1.6, h=12, center=true, $fn=50);
  }
}


hotend_fan();
//hotend();

module hotend() {
    // Hotend barrel.
    translate([0, 0, groove_height]) %
      cylinder(r=barrel_radius, h=barrel_height);
    /*
    translate([-nozzle_distance / 2, 0, groove_height]) %
      cylinder(r=barrel_radius, h=barrel_height);
    */
     translate([0, 0, groove_height + barrel_height -1]) %
    cube([20,20,10], center=true);
    //translate([-nozzle_distance / 2, 0, groove_height + barrel_height -1]) %
    //cube([20,20,10], center=true);

    if(include_fan_bracket) {
        // 30mm fan.
        translate([0, -5 - fan_offset, 15]) % difference() {
          cube([30, 10, 30], center=true);
          rotate([90, 0, 0,]) cylinder(r=14, h=20, center=true);
        }
    }
}