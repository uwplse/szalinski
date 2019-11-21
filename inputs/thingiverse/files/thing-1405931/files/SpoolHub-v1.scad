/****************************************************************
    Customizable parameters (shown as parameters in customizer)
****************************************************************/

//Spool width or "length" of the spool hole, eSUN 1kg is 62mm
spool_width = 62;

//The diameter of the spool hole, eSUN is about 52mm, valid range is about 30 - 65
spool_hole_diameter = 52;

//Outer bearing diameter, 608 is 22mm diameter, valid range is about 16-30mm
bearing_outer_diameter = 22;

//Affects the central hole, 608 is 8mm
bearing_inner_diameter = 8;

//Width of bearing, 608 is 7mm
bearing_width = 7;

//Depth of the faceplate / front depth (default: 2)
front_thickness = 2;

//Width of the faceplate flaps that prevent the whole hub from travelling inside the spool hole
flaps_width = 1.5;

//How thick the edge grippers are (3 or 2 recommended)
gripper_width = 3;

//How much the tensioners at the end of the gripper rods protrude. Increasing this should make the hub grip the spool harder.
tension_width = 0.5;

//How deep the edge grippers go. Set to zero for default (halfway inside the spool hole)
gripper_length = 0;

/****************************************************************
    Calculated vars (not shown)
****************************************************************/

//Set gripper depth to default value if not chosen
gripper_depth = gripper_length == 0 ? (spool_width/2 - 1) : gripper_length;

//Convenience vars
bearing_outer_radius = bearing_outer_diameter/2;
bearing_inner_radius = bearing_inner_diameter/2;
spool_hole_radius = spool_hole_diameter/2;



//Mockup of spool
module spool_mock(hole_radius=spool_hole_diameter, width=spool_width) {
    color([0.6,0.6,0.6]) difference() {
        //Spool
        cylinder(h=width, r=90);
        
        //Hole in spool
        translate([0,0,-1]) cylinder(h=width+2, r=hole_radius, $fn=256);
    }
}

//Mockup of a rod
module rod_mock() {
    translate([0,0,-50]) cylinder(h=130, r=4);
}

//Mockup of a bearing
module bearing_mock() {
    color([1,0.3,0.3]) difference() {
        translate([0,0,front_thickness]) cylinder(h=7, r=11);
        cylinder(h=10, r=4);
    }
}

module spokes() {
    step = 360/5;
    for(i=[1:5]) {
        rotate([0, 0, step * i]) translate([13,0,0]) rotate([0,0,40]) scale([0.8,2,1]) cylinder(gripper_depth, 6, 6,$fn=3);
        rotate([0, 0, step * i]) translate([18,11,0]) rotate([0,0,270]) scale([1,3,1]) cylinder(gripper_depth, 6, 6,$fn=3);
    }
}

module center_cap() {
    difference() {
        rotate([0,0,0]) cylinder(front_thickness, 11, 11 ,$fn=5);
        translate([0,0,-1]) cylinder(h=20, r=bearing_inner_radius+1);
    }
}

module base_shape() {
    difference() {
        union() {
            spokes();
            center_cap();
        }
        central_cutout();
    }   
}

/* This is the shape of the empty space to be removed from the inside */
module central_cutout() {
    main_cutout_radius = spool_hole_radius - gripper_width;
    difference() {
        //Main cutout
        translate([0,0,front_thickness]) cylinder(80, main_cutout_radius, main_cutout_radius ,$fn=256);
        
        //Support for edge spool grippers
        difference() {
            translate([0,0,front_thickness]) cylinder(5, main_cutout_radius, main_cutout_radius ,$fn=256);
            translate([0,0,front_thickness-0.01]) cylinder(5.02, main_cutout_radius-6, main_cutout_radius ,$fn=256);
        }
        
        //Removed from main cutout:
        difference() {
            //Main bearing holder ring
            translate([0,0,front_thickness]) cylinder(bearing_width+2, bearing_outer_radius+6, bearing_outer_radius+1);
            
            //"Re-added": Top bearing holder edge
            translate([0,0,front_thickness + bearing_width]) cylinder(h=0.6, r=bearing_outer_radius-0.15);
            
            //This cone shape guides the bearing inside when pushing it in.
            translate([0,0,front_thickness + bearing_width + 0.6]) cylinder(1.5, bearing_outer_radius-0.15, bearing_outer_radius+0.7);
        }
    }
    //Bearing slot
    translate([0,0,front_thickness]) cylinder(h=bearing_width, r=bearing_outer_radius+0.1, $fn=256);   
    
    //Bottom bearing bevelled edge (to make inner cylinder spin freely) 608zz inner spinning cylinder is 12mm diameter
    translate([0,0,-0.01]) cylinder(front_thickness+0.02, bearing_inner_radius+1, bearing_inner_radius+2.5);   
}

//Tensioning flaps at end of gripper rods
module tensioner_chisel() {
    translate([0,0,gripper_depth-2]) difference() {
        cylinder(h=2, r=90);
        translate([0,0,-0.01]) cylinder(h=2.02, r1=spool_hole_radius+tension_width, r2=spool_hole_radius, $fn=256);
    }
    
    translate([0,0,gripper_depth-4]) difference() {
        cylinder(h=2, r=90);
        translate([0,0,-0.01]) cylinder(h=2.02, r1=spool_hole_radius, r2=spool_hole_radius+tension_width, $fn=256);
    }
}

module main() {
    difference() {
        base_shape();
        
        tensioner_chisel();
        
        //Main radius adjustment
        translate([0,0,1.6]) spool_mock(spool_hole_radius, gripper_depth-5);
        
        //This cuts the face plate flaps that prevent the whole item from travelling too far inside the spool hole.
        translate([0,0,-1]) scale([1,1,2]) spool_mock(spool_hole_radius+flaps_width);
        
        //Makes the flaps angled for easier removal from build plate
        difference() {
            cylinder(h=1, r=spool_hole_radius+flaps_width+0.01, $fn=256);
            cylinder(h=1, r=spool_hole_radius, $fn=256);
            translate([0,0,-0.01]) cylinder(h=1.02, r1=spool_hole_radius, r2=spool_hole_radius+flaps_width, $fn=256);
        }   
    }
}

main();

