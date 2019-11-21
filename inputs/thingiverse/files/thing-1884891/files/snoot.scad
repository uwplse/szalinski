$fn = 140;

FILM = 16; //Film width
GATE = 16; //Gate width
SPROCKET = 4; //Sprocket width
FL_D = 27;	//Flashlight diameter
SLEEVE = 10;//Sleeve length
T = 3; 		//Snoot thickness
DIST = 25.4;//Slit distance
SLIT_VALUE = 1; //Slit width

module snoot (SLIT = 1) {
    //flashlight sleeve
  	difference () {
		cylinder(r = (FL_D / 2) + T, h = SLEEVE, center = true);
    	cylinder(r = (FL_D / 2), h = SLEEVE + 1, center = true);
	}
  
  	//tube
  	translate ([0, 0, -(SLEEVE / 2) - (DIST / 2) + (T / 2)]) {
    	difference () {
    		cylinder(r2 = (FL_D / 2) + T, r1 = (FILM / 2) + (T / 2), h = DIST - T, center = true);
      		cylinder(r2 = (FL_D / 2), r1 = (FILM / 2), h = DIST - T + .1, center = true);
            translate([0, 1, 0]) {
                cube([SLIT , FILM, T + 1], center = true);
            }
      	}
    }
  
    //tube + slit joiner
    translate ([0, 0, -(SLEEVE / 2) - DIST + T]) {
      difference () {
          cylinder(r = (FILM / 2) + (T / 2), h = T, center = true);
      	  translate([0, 0, 0]) {
        	cube([SLIT , FILM, T + 1], center = true);
        }
      }
    }
  
  	//slit
  	translate ([0, 1, -(SLEEVE / 2) - DIST + (T / 2) - 1]) {
    	difference () {
      		intersection () {
        		translate ([0, -1, 0]) cylinder(r = (FILM / 2) + (T / 2), h = T, center = true);
    			translate ([0, -3, 0]) cube([FILM + (T * 2), FILM + T, T], center = true);
                
        		translate ([0, 0, 0]) rotate([90, 0, 0]) {
          			scale([3, .6, 1]) cylinder(r = T / 1.2, h = FILM + T * 2, center = true);
          			translate ([0, 1.6, 0]) cube([(T / 1.2) * 2 * 3, (T / 1.2) * 2 * .6, FILM + T * 2], center = true);
          		}
        	}
            
        	translate([0, -1, 0]) cube([SLIT, FILM, T + 1], center = true); //slit
      
      		//sprocket
    		translate([0, (FILM / 2) - (SPROCKET / 2) + (T / 2) - 1, 0]) cube([SLIT + T * 6, SPROCKET, T + 1], center = true);
      		
    	}
	}
    difference () {
        union () {
            translate([0, (16 / 2) + 1.1, -SLEEVE - DIST + 9]) rotate([90, 0, 0]) {
                cylinder(r = 16 / 2, h = 2, center = true);
            }
            
            translate([0, -(16 / 2) - 1.1, -SLEEVE - DIST + 9]) rotate([90, 0, 0]) {
                cylinder(r = 16 / 2, h = 2, center = true);
            }
        }
        translate ([0, 0, -(SLEEVE / 2) - (DIST / 2) + (T / 2)]) {
            cylinder(r2 = (FL_D / 2), r1 = (FILM / 2), h = DIST - T + .1, center = true);
        }
    }
}

module flat_path () {
    L = .5;
    cube([L, 16, 3], center = true);
    translate([0, (16 / 2) - (3 / 2), 2]) cube([L, 3, 3], center = true);
    translate([0, -(16 / 2) + (3 / 2), 2]) cube([L, 3, 3], center = true);
    
    translate([0, (16 / 2) - (3 / 2), 3.5]) cube([L, 1.5, 3], center = true);
}

snoot(SLIT_VALUE);
