//---------------------------------------------------------------------
//  Spool holder for Prusa i3 with 6mm aluminium Frame   
//  (c)iPadNanito <@iPadNanito> , March-2013    
//  (c)Ying-Chun Liu (PaulLiu) <paulliu@debian.org>, January-2016
//---------------------------------------------------------------------

nut_diam = 6.5;  // M3 Nut diameter
screw_diam = nut_diam/2; // Nut hole for screw diameter
frame_thickness = 8; // aluminium frame thickness

module nut(nut_diam)
{	
	rotate([0,90,0])
	cylinder(r=nut_diam/2, h=3, $fn=6, center = true); //M3 nut body without screw hole
}

module frame(gap) {
    union() {
        cube([4,60,20]);
        translate([gap+4,0,0]) {
            cube([4,60,20]);
        }
        cube([4+gap+4,14,20]);
    }
}


difference() {
    frame(frame_thickness);

    translate([1+(frame_thickness-6)/2,6,2]) {
        cube([4+frame_thickness+4,6.25,15.5]); // Hole where inserts M8 nut 
    }

    translate([(4+frame_thickness+4)/2,7,10]) {
        rotate([90,0,0]) {
            cylinder(r=8/2, h=20, $fn=100); // M8 hole for threaded rod
        }
    }
    
    translate([1.5+4+frame_thickness+4-2.4,56,6]) {
        nut(nut_diam); // M3 nut 1
    }
    translate([-1,56,6]) {
        rotate([0,90,0]) {
            cylinder(r=screw_diam/2,h=frame_thickness+4+4+2, $fn=50); // Nut hole for screw 1
        }
    }
    
    translate([1.5+4+frame_thickness+4-2.4,56,14]) {
        nut(nut_diam); // M3 nut 2
    }
    translate([-1,56,14]) {
        rotate([0,90,0]) {
            cylinder(r=screw_diam/2,h=frame_thickness+4+4+2, $fn=50); // Nut hole for screw 2
        }
    }
    
    translate([1.5+4+frame_thickness+4-2.4,14+10,10]) {
        nut(nut_diam); // M3 nut 3
    }
    translate([-1,14+10,10]) {
        rotate([0,90,0]) {
            cylinder(r=screw_diam/2,h=frame_thickness+4+4+2, $fn=50); // Nut hole for screw 3
        }
    }

    translate([1.5+4+frame_thickness+4-2.4,14+30,10]) {
        nut(nut_diam); // M3 nut 4
    }
    translate([-1,14+30,10]) {
        rotate([0,90,0]) {
            cylinder(r=screw_diam/2,h=frame_thickness+4+4+2, $fn=50); // Nut hole for screw 4
        }
    }
}
