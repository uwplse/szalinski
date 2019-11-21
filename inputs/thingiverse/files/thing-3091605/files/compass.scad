part = "print"; // [print,slider,carousel,foot]

// Depth of the hole for the cutter head
cutter_depth=3.1;
// Width of the hole for the cutter head
cutter_width=20.3;
// Depth of the hole for the roller of the cutter
cutter_roller_depth=5;
// Width of the hole for the roller of the cutter
cutter_roller_width=16;
// Cutter hole clearence
cutter_clearence = 0.15;

// Diameter of main horizontal rods
compass_rods_diameter=5;

foot_thickness = 3;
foot_screw_border = 3;
foot_diameter = 35;
foot_height = 10;
foot_screw_diameter = 5;
// Nut wrench size
foot_nut_size = 8;
foot_nut_height = 5;

// Minimum wall thickness
carousel_wall=3;

// Cutter holding screws size
slider_screw = 4;
// Cutter holding nut wrench size
slider_nut_size = 7;
slider_nut_height = 3.2;
// Minimum wall thickness
slider_wall=3;
// Minimum wall thickness for loaded wall
slider_thick_wall=5;

// Round holes clearence
hole_clearence = 0.2;
// Thickness of printing helper surface above the nut of the foot
layer_height = 0.2;
$chamfer = 0.5;

/* [Hidden] */

$fn = 64;

axis_distance=cutter_width/2+cutter_clearence+slider_wall+hole_clearence+compass_rods_diameter/2;

module chamfered_cylinder(d=1,h=1,center=false)
{
    translate([0,0,center?0:h/2]) {
        hull() {
            cylinder(d=d,h=h-2*$chamfer,center=true);
            cylinder(d=d-2*$chamfer,h=h,center=true);
        }
    }
}

module chamfered_cube(size=[1,1,1],center=false)
{
    translate(center?[0,0,0]:size/2) {
        hull() {
            cube([size.x,size.y-2*$chamfer,size.z-2*$chamfer],center=true);
            cube([size.x-2*$chamfer,size.y-2*$chamfer,size.z],center=true);
            cube([size.x-2*$chamfer,size.y,size.z-2*$chamfer],center=true);
        }
    }
}

module reflect(v)
{
    children();
    mirror(v)
        children();
}

function nut_dia(nut_size) = 2*nut_size/sqrt(3);

module foot()
{
    difference() {
        union() {
            chamfered_cylinder(d=foot_diameter,h=foot_thickness);
            chamfered_cylinder(d=foot_screw_diameter+2*hole_clearence+2*foot_screw_border,h=foot_height);
            cylinder(d=foot_diameter-2*$chamfer,h=foot_height-$chamfer);
        }

        rotate_extrude()
            translate([foot_diameter/2-$chamfer,foot_height-$chamfer])
                resize([2*(foot_diameter/2-foot_screw_border-foot_screw_diameter/2-hole_clearence-$chamfer),2*(foot_height-foot_thickness-$chamfer)])
                    circle(r=foot_height-foot_thickness-$chamfer);

        translate([0,0,-0.001])
            cylinder(d=nut_dia(foot_nut_size)+2*hole_clearence,h=foot_nut_height,$fn=6);
        translate([0,0,foot_nut_height+layer_height])
            cylinder(d=foot_screw_diameter+2*hole_clearence,h=foot_height-foot_nut_height+layer_height+0.001);
    }
}

carousel_zsize=2*carousel_wall+compass_rods_diameter+2*hole_clearence;
carousel_xsize=2*carousel_wall+foot_screw_diameter+2*hole_clearence;
carousel_ysize=carousel_zsize+2*axis_distance;

module carousel()
{
    translate([0,0,carousel_zsize/2]) {
        difference() {
            hull() {
                reflect([0,1,0])
                    translate([0,axis_distance,0])
                        rotate([0,90,0])
                            chamfered_cylinder(d=carousel_zsize,h=carousel_xsize,center=true);
                translate([0,0,-carousel_zsize/4])
                    chamfered_cube([carousel_xsize,carousel_ysize,carousel_zsize/2],center=true);
            }
    
            cylinder(d=foot_screw_diameter+2*hole_clearence,h=carousel_zsize+0.002,center=true);
            reflect([0,1,0])
                translate([0,axis_distance,0])
                    rotate([0,90,0])
                        cylinder(d=compass_rods_diameter+2*hole_clearence,h=carousel_xsize+0.002,center=true);
        }
    }
}    


slider_zsize=2*slider_wall+compass_rods_diameter+2*hole_clearence+slider_screw+2*hole_clearence;
slider_ysize=4*slider_wall+2*compass_rods_diameter+4*hole_clearence+cutter_width+2*cutter_clearence;
slider_xsize=2*slider_thick_wall+cutter_depth+cutter_roller_depth+2*cutter_clearence+slider_nut_height;

module slider()
{
    translate([0,0,slider_zsize/2]) {
        difference() {
            chamfered_cube([slider_xsize,slider_ysize,slider_zsize],center=true);
    
            // Cutter hole
            translate([(cutter_depth+2*cutter_clearence)/2-slider_xsize/2+slider_thick_wall+cutter_roller_depth,0,0])
                cube([cutter_depth+2*cutter_clearence,cutter_width+2*cutter_clearence,slider_zsize+0.002],center=true);
            // Cutter roller hole
            translate([(cutter_roller_depth+2*cutter_clearence)/2-slider_xsize/2+slider_thick_wall,0,0])
                cube([cutter_roller_depth+2*cutter_clearence,cutter_roller_width+2*cutter_clearence,slider_zsize+0.002],center=true);
    
            // X Clamp screw
            translate([slider_xsize/2+0.001,0,0])
                rotate([0,-90,0])
                    cylinder(d=slider_screw+2*hole_clearence,h=slider_nut_height+slider_thick_wall+0.002);
            // X clamp nut
            translate([slider_xsize/2-slider_thick_wall,0,0])
                rotate([0,-90,0])
                    rotate(30)
                        cylinder(d=nut_dia(slider_nut_size)+2*hole_clearence,h=slider_nut_height+0.001,$fn=6);
    
            // Clamp screw
            translate([(cutter_depth+2*cutter_clearence)/2-slider_xsize/2+slider_thick_wall+cutter_roller_depth,-slider_ysize/2-0.001,slider_zsize/2-slider_wall-hole_clearence-slider_screw/2])
                rotate([-90,0,0])
                    cylinder(d=slider_screw+2*hole_clearence,h=compass_rods_diameter+2*hole_clearence+2*slider_wall+0.002);
            // Clamp nut
            translate([(cutter_depth+2*cutter_clearence)/2-slider_xsize/2+slider_thick_wall+cutter_roller_depth,-slider_ysize/2+compass_rods_diameter+2*hole_clearence+2*slider_wall-slider_nut_height,slider_zsize/2-slider_wall-hole_clearence-slider_screw/2])
                rotate([-90,0,0])
                    cylinder(d=nut_dia(slider_nut_size)+2*hole_clearence,h=2*slider_nut_height+(cutter_width-cutter_roller_width)/2,$fn=6);
    
            // Axis
            reflect([0,1,0])
                translate([0,slider_ysize/2-slider_wall-hole_clearence-compass_rods_diameter/2,-slider_zsize/2+slider_wall+hole_clearence+compass_rods_diameter/2])
                    rotate([0,90,0])
                        cylinder(d=compass_rods_diameter+2*hole_clearence,h=slider_xsize+0.002,center=true);
        }
    }
}


module print()
{
    foot();
    translate([foot_diameter/2+3+slider_xsize/2,0,0])
        slider();
    translate([-foot_diameter/2-3-carousel_xsize/2,0,0])
        carousel();
}

if (part == "print")
    print();
else if (part == "slider")
    slider();
else if (part == "carousel")
    carousel();
else if (part == "foot")
    foot();
