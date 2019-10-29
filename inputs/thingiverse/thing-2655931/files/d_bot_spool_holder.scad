//Spinder Holder w/ Bearings
//Default settings for eSun spools

//Number of Faces/How Smooth
$fn=50; //[15:360]

//Brim Radius
brim_radius = 2.5;
//Brim Thickness/Height
brim_thickness = 2;

//Spool Hole Radius
spool_hole_radius = 26.8;
//Spool Hole Thickness/Depth
spool_hole_thickness = 9;


//Bearing Insert Radius
bearing_outer_radius = 5.10;
//Bearing Insert Thickness
bearing_thickness = 5;


//Center Hole Size
center_hole_size=3.5; //Will fit an M5


module bearing_hole() {
    cylinder(h=(bearing_thickness+1),
            r=bearing_outer_radius);
}

module spool_holder() {
    cylinder(h=(brim_thickness+spool_hole_thickness),
        r=spool_hole_radius);
}

module brim() {
    cylinder(h=brim_thickness,
            r=(brim_radius+spool_hole_radius));
}

difference() {
    union() {
        spool_holder();
        brim();
    };
    
    translate([0,0,-1]) {
        bearing_hole();
    }
    
    translate([0,0,((brim_thickness+spool_hole_thickness)-bearing_thickness)]) {
        bearing_hole();
    }
    
    translate([0,0,1]) {
        cylinder(h=brim_thickness+spool_hole_thickness+1,
            r=center_hole_size);
    }
}
        