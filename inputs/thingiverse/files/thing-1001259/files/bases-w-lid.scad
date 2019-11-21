/////   BASES with lid  \\\\\
//// for tabletop gaming \\\\

//// v1.1 - now with customizer


/* [Size] */


// Choose a size
size = 30; //[00:Custom,30:Small,40:Medium,50:Large]

/* [Custom Settings] */
BaseDiameter = 40; 
LidWidth = 4.2;
Height = 3.9;
SunkenPodest = 0.8;

/* [Holes] */

// Info: z_offset is measured from the bottom to the top of the subtracted shape. If z_offset > (Height - Sunken_Podest), the hole will be going through the whole base. If z_offset > (Height - 1), then the hole will start to have a bottom. This can be used to mount magnets from the top.

// Shape 1
Shape1 = "none"; // [none,circle,rectangle]
// [pos_r, pos_angle, z_offset, diameter] or [pos_r, pos_angle z_offset, x, y]
Shape1_Parameters = [8,90,3,2.5,0];

// Shape 2
Shape2 = "none"; // [none,circle,rectangle]
// [pos_r, pos_angle, z_offset, diameter] or [pos_r, pos_angle z_offset, x, y]
Shape2_Parameters = [0,0,4.5,28,3];

// Shape 3
Shape3 = "none"; // [none,circle,rectangle]
// [pos_r, pos_angle, z_offset, diameter] or [pos_r, pos_angle z_offset, x, y]
Shape3_Parameters = [8,-45,3,2.5,0];



if (size == 30) {
    translate([0,0,0]) base(15,3,3.8,0.8); // 30mm - Small Base
    }
if (size == 40) {
    translate([0,0,0]) base(20,4.2,3.9,0.8); // 40mm - Medium Base
    }
if (size == 50) {
    translate([0,0,0]) base(25,4.5,4.6,0.8); // 50mm - Large Base
    }    
if (size == 00) {
    translate([0,0,0]) base(BaseDiameter/2,LidWidth,Height,SunkenPodest); // ?? Custom Variables
    }

module base(outer_rad,height,lid_rad,sunken_podest) { 

	difference() 
        {
		union() 
            {
			translate([0,0,height-lid_rad])
			rotate_extrude(convexity = 10, $fn = 100)
				translate([outer_rad-lid_rad, 0, 0])
				circle(r = lid_rad, $fn = 100);
			cylinder(r=outer_rad-lid_rad-0.1,h=lid_rad+1,$fn=100);
			cylinder(r=outer_rad,h=height-lid_rad,$fn=100);

            } 

		translate([0,0,height-sunken_podest])
			cylinder(r=outer_rad-lid_rad,h=lid_rad+5,$fn=100);
		translate([0,0,-lid_rad*2])
			cylinder(r=outer_rad+lid_rad,h=lid_rad*2,$fn=100);
		
        if (Shape1 == "circle") {
            rotate([0,0,Shape1_Parameters[1]]) translate([Shape1_Parameters[0],0,Shape1_Parameters[2]-height-1]) 
            cylinder($fn=128,r=Shape1_Parameters[3]/2, h=height+1);
            }    
        if (Shape2 == "circle") {
            rotate([0,0,Shape2_Parameters[1]]) translate([Shape2_Parameters[0],0,Shape2_Parameters[2]-height-1]) 
            cylinder($fn=128,r=Shape2_Parameters[3]/2, h=height+1);
            }    
        if (Shape3 == "circle") {
            rotate([0,0,Shape3_Parameters[1]]) translate([Shape3_Parameters[0],0,Shape3_Parameters[2]-height-1]) 
            cylinder($fn=128,r=Shape3_Parameters[3]/2, h=height+1);
            }                
 
         if (Shape1 == "rectangle") {
            rotate([0,0,Shape1_Parameters[1]]) translate([Shape1_Parameters[0],0,Shape1_Parameters[2]-(height+1)/2]) 
            cube([Shape1_Parameters[3],Shape1_Parameters[4],height+1],center = true);
            }    
         if (Shape2 == "rectangle") {
            rotate([0,0,Shape2_Parameters[1]]) translate([Shape2_Parameters[0],0,Shape2_Parameters[2]-(height+1)/2]) 
            cube([Shape2_Parameters[3],Shape2_Parameters[4],height+1],center = true);   
            }
         if (Shape3 == "rectangle") {
            rotate([0,0,Shape3_Parameters[1]]) translate([Shape3_Parameters[0],0,Shape3_Parameters[2]-(height+1)/2]) 
            cube([Shape3_Parameters[3],Shape3_Parameters[4],height+1],center = true);
            }   
            
		}


	}
    
module 30mm_base() {
	outer_rad	= 15;
	lid_rad		= 3;
	height		= 3.8;

	difference() {
		union() {
			translate([0,0,height-lid_rad])
			rotate_extrude(convexity = 10, $fn = 100)
				translate([outer_rad-lid_rad, 0, 0])
				circle(r = lid_rad, $fn = 100);
			cylinder(r=outer_rad-lid_rad-0.2,h=lid_rad+2,$fn=100);
			cylinder(r=outer_rad,h=height-lid_rad,$fn=100);
			}

		translate([0,0,height-0.8])
			cylinder(r=outer_rad-lid_rad,h=lid_rad+5,$fn=100);
		translate([0,0,-lid_rad])
			cylinder(r=outer_rad+lid_rad,h=lid_rad,$fn=100);
		
		}


	}    
    
    
module 40mm_base() {
	outer_rad	= 20;
	height		= 4.2;
	lid_rad		= 3.9;

	difference() {
		union() {
			translate([0,0,height-lid_rad])
			rotate_extrude(convexity = 10, $fn = 100)
				translate([outer_rad-lid_rad, 0, 0])
				circle(r = lid_rad, $fn = 100);
			cylinder(r=outer_rad-lid_rad-0.1,h=lid_rad+1,$fn=100);
			cylinder(r=outer_rad,h=height-lid_rad,$fn=100);
			}

		translate([0,0,height-0.8])
			cylinder(r=outer_rad-lid_rad,h=lid_rad+5,$fn=100);
		translate([0,0,-lid_rad])
			cylinder(r=outer_rad+lid_rad,h=lid_rad,$fn=100);
		
		}


	}
    
 module 50mm_base() {
	outer_rad	= 25;
	lid_rad		= 4.5;
	height		= 4.6;

	difference() {
		union() {
			translate([0,0,height-lid_rad])
			rotate_extrude(convexity = 10, $fn = 100)
				translate([outer_rad-lid_rad, 0, 0])
				circle(r = lid_rad, $fn = 100);
			cylinder(r=outer_rad-lid_rad-0.1,h=lid_rad+1,$fn=100);
			cylinder(r=outer_rad,h=height-lid_rad,$fn=100);
			}

		translate([0,0,height-0.8])
			cylinder(r=outer_rad-lid_rad,h=lid_rad+5,$fn=100);
		translate([0,0,-lid_rad])
			cylinder(r=outer_rad+lid_rad,h=lid_rad,$fn=100);
		
		}


	}   