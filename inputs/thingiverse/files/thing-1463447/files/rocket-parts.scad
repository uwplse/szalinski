$fn=90;

/* Global */

// Rocket Body Diameter (mm)
rocket_diameter = 44;

// Which part to print?
part = "nose cone"; // [nose cone, connector, fins]

/* [Nose Cone] */

// Nose Cone Length (mm)
nose_cone_length    = 150; // [40:200]

/* [Fins] */

// Fin Thickness (mm)
fin_thickness = 4;  // [3:6]

// Fin Width (mm)
fin_width = 20;// [10:60]

// Fin Height - Outer (mm)
fin_height_outer = 10; // [20:150]

// Fin Height - Inner (mm)
fin_height_inner = 65; // [40:300]

// Number of Fins
num_fins = 5;  // [3, 4, 5, 6]

print_part();

module print_part() {
    if(part == "fins")
        fins();
    if(part == "connector")
        connector();
    if(part=="nose cone")
        rotate([180,0,0]) nose_cone();
}

module nose_cone() {
    cylinder(r1=(rocket_diameter/2)-1,r2=(rocket_diameter/2)-1.5,h=20);
    difference() {
        scale([1,1,nose_cone_length/(rocket_diameter/2)]) sphere(d=rocket_diameter);
        cylinder(r=rocket_diameter/2,h=nose_cone_length);
    }

}

module connector() {
    difference() {
        union() {
            translate([0,0,25/2]) cylinder(r1=(rocket_diameter/2)-1,r2=(rocket_diameter/2)-1.5,h=25, center=true);
            translate([0,0,-25/2]) cylinder(r1=(rocket_diameter/2)-1.5,r2=(rocket_diameter/2)-1,h=25, center=true);
            cylinder(r=rocket_diameter/2,h=10, center=true);
        }
        cylinder(r=(rocket_diameter/2)-3,h=50, center=true);
    }
    
}

module fin() {
   polyhedron
    (points = [
	       [0,fin_thickness/2,0], [0,fin_thickness/2,fin_height_inner], [fin_width,fin_thickness/2, fin_height_outer], [fin_width,fin_thickness/2,0],
               [0,-fin_thickness/2,0], [0,-fin_thickness/2,fin_height_inner], [fin_width,-fin_thickness/2, fin_height_outer], [fin_width,-fin_thickness/2,0]
    ],
     faces = [
                [0,1,2],[0,2,3],
                [0,4,5],[0,5,1],
                [4,7,6],[4,6,5],
                [2,1,5],[2,5,6],
                [3,2,6],[3,6,7],
                [0,3,7],[0,7,4]
            ]
     );
}
module fins() {
    difference() {
        union() {
            cylinder(r1=(rocket_diameter/2)-1,r2=(rocket_diameter/2)-1.5,h=fin_height_inner+20);
            cylinder(r=rocket_diameter/2,h=fin_height_inner);
        }
        cylinder(r=(rocket_diameter/2)-3,h=fin_height_inner+30);
    }

        for( pos = [0:360/num_fins: 360] ) {
           rotate([0,0,pos]) translate([rocket_diameter/2,0,0]) fin();
        }
}
