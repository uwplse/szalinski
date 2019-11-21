
// Summit 1/16 wheel size: 103mm
// WLToys A979 wheel size: 71mm
// ERevo 1/16 wheel size: 82mm

// preview[view:north west, tilt:top diagonal]
// Wheel diameter
wheel_diameter = 70; // [25:150]

// Width of the hanger
width = 20; // [15:40]

// Diameter of the mount holes
hole_diameter = 4;

// Diameter of the mount hole insets
hole_inset_diameter = 8.4;

// Mount hole count
hole_count = "three"; // [one: One, three:Three]

// Which one would you like to see?
part = "left"; // [left:Left only,right:Right only,both:Left and right]



/* [Hidden] */
wheel_radius = wheel_diameter / 2;
outer_radius = wheel_radius + 2;
_t = 3;
_screw_head_radius = hole_inset_diameter/2;
_screw_hole_radius = hole_diameter/2;
_w = width;

// translate([0,0,-_w/2]) %cylinder(r=wheel_radius,_w*2);

if (part == "left") {
    tire_holder();
} else if (part == "right") {
    mirror([0,1,0])
    tire_holder();
} else if (part == "both") {
    //translate([wheel_diameter/2,0,0]) rotate([0,0,-70]) 
    translate([0,wheel_diameter/2+10,0]) tire_holder();
    translate([0,-wheel_diameter/2-10,0]) mirror([0,1,0]) tire_holder();
}


module tire_holder() {

    $fn=100;
    difference() {
        union() {
            translate([-(outer_radius+_t),-(outer_radius+_t)-_t,0])
                cube([(outer_radius+_t)*2,_t*2,_w]);
            /*
            translate([-(outer_radius+_t),-(outer_radius+_t),0])    
                cube([(outer_radius+_t)*2,(outer_radius+_t),_t]);
            */
            difference() {
                union() {
                    // Main holder "clamp"
                    cylinder(r=outer_radius+_t,_w);
                    // Printable edge to improve rigidity of the clamp
                    translate([0,0,_w-4])
                        cylinder(r1=outer_radius+_t,r2=outer_radius+_t+2,4);
                    // Bottom edge for improved adhesion and rigidity
                    cylinder(r1=outer_radius+_t+2,r2=outer_radius+_t,4);
                    
                    translate([-(outer_radius+_t),-(outer_radius+_t),0])    
                        cube([(outer_radius+_t)*2,(outer_radius+_t),_t]);
                }
                translate([0,0,-1]) cylinder(r=outer_radius,_w+2);
                rotate([0,0,30]) translate([-(outer_radius+_t)*1.5,0,-1]) 
                    cube([(outer_radius+_t)*3,(outer_radius+_t)*3,_w*4]);
            }
        }
        
        translate([0,0,_w/2])
        rotate([90,0,0]) {
            if (hole_count == "three") {
                translate([(outer_radius+_t)/2,0,0]) cylinder(r=_screw_hole_radius,h=(outer_radius+_t)*2);
                translate([(outer_radius+_t)/2,0,0]) cylinder(r=_screw_head_radius,h=(outer_radius+_t)-_t);
                translate([-(outer_radius+_t)/2,0,0]) cylinder(r=_screw_hole_radius,h=(outer_radius+_t)*2);
                translate([-(outer_radius+_t)/2,0,0]) cylinder(r=_screw_head_radius,h=(outer_radius+_t)-_t);                
                translate([0,0,0]) cylinder(r=_screw_hole_radius,h=(outer_radius+_t)*2);
                translate([0,0,2]) cylinder(r=_screw_head_radius,h=(outer_radius+_t)-_t);
            } else if (hole_count == "one") {
                translate([0,0,0]) cylinder(r=_screw_hole_radius,h=(outer_radius+_t)*2);
                translate([0,0,2]) cylinder(r=_screw_head_radius,h=(outer_radius+_t)-_t);                
            }

        }
    }
    
}


/*
difference() {
    resize([0,0,(outer_radius+_t)*3]) {
        difference() {
            sphere(r=outer_radius+_t,$fn=50);
            sphere(r=outer_radius,$fn=50);
        }
    }
    translate([-(outer_radius+_t),-(outer_radius+_t),_w]) cube([(outer_radius+_t)*2,(outer_radius+_t)*2,(outer_radius+_t)*3]);
    translate([-(outer_radius+_t),-(outer_radius+_t),-(outer_radius+_t)*3-_w]) cube([(outer_radius+_t)*2,(outer_radius+_t)*2,(outer_radius+_t)*3]);
    
    rotate([90,0,0])
    hull() {
        rotate([0,10,0]) cylinder(r=4,h=(outer_radius+_t)*3);
        rotate([0,-10,0]) cylinder(r=4,h=(outer_radius+_t)*3);
    }
} */

