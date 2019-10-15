//
//  
//
//  default camera dimensions are for Canon SD1400

// length of camera
camera_length = 93;
// measure from bottom of camera to center of lens
camera_lens_center_offset = 27;
// this needs to adjust based on lens offset...
camera_height = 56;
// distance from (rear) left edge of camera to center of mount screw hole
camera_screw_offset=39;
// thickness of camera...might tweak smaller for rounded bottoms
camera_thickness = 15;

//
camera_bar_width = camera_thickness;
// arbitrary...how thick you want it?
camera_bar_thickness = 5;

// stiffness matters, so does offset to inter-lens spacing
center_pillar_width = 7.0;
// center pillar is set to make sure lens centers line up,
// using math in case offset != 1/2 height
center_pillar_height = camera_height - ((camera_height - (camera_lens_center_offset * 2.0))/2);

// 1/4"-20 screw hole
screw_width=.25/2.0 * 25.4;

//arbitrary...width of bracing, should be enough to hold camera square, 
// but not interfere with buttons 
brace_width=15;
brace_length=60;

// include bracing???
include_corner_brace=true;
// include end pieces???
include_ends=false;

// lip for camera rail
module side_rail() {
        scale ([camera_length+center_pillar_width,2,camera_bar_thickness+2])
        cube(1);
}

// rail with 45 degree chamfer on top edge
module chamfered_side_rail() {
      difference (){
        side_rail();
        translate([0,1,camera_bar_thickness+2]) 
        scale([camera_length+center_pillar_width,1.5,3])
        rotate([-45,0,0])  
        cube(1);
    }
}

module camera_rail() 
{ 
    union() {
        difference (){
            scale([camera_length + center_pillar_width/2.0,camera_bar_width,camera_bar_thickness]) cube(1); 
            translate([camera_screw_offset+center_pillar_width/2.0+screw_width/2.0,camera_bar_width/2,2]) cylinder(h=camera_bar_width/2,r1=screw_width,r2=screw_width,center=true);
        }
        
        translate([-center_pillar_width/2,-2,0]) chamfered_side_rail() ;
        mirror([0,1,0])
    translate([-center_pillar_width/2,-camera_bar_width-2,0]) 
        chamfered_side_rail();
    }
    if (include_ends==true) {
        translate([center_pillar_width/2+camera_length,-2,0])
        scale([camera_bar_thickness,camera_thickness+4, center_pillar_height+camera_bar_thickness*2])
        cube(1);
    }
}

// center pillar
module center_pillar() {
    translate([-center_pillar_width/2,-2,0])
    scale([center_pillar_width,camera_bar_width+4,center_pillar_height+camera_bar_thickness*2]) cube(1);

}

// the whole assembly
module camera_z_bar() {
    union () {
        camera_rail();
        translate([0,0,center_pillar_height+camera_bar_thickness*2]) 
        rotate([0,180,0]) 
        camera_rail();
        center_pillar() ;
        if (include_corner_brace==true) {
            corner_brace();
            translate([0,0,center_pillar_height+camera_bar_thickness*2])
            rotate([0,180,0])
            corner_brace();
        }
    }
}

// corner bracing
module corner_brace() {
    union () {
        // corner bit
        difference () {
            translate([center_pillar_width/2,-2,camera_bar_thickness])
            scale([brace_width,2,center_pillar_height/3])
            cube(1);

            translate([brace_width*1.4,-3,center_pillar_height/10])
            rotate([0,-45,0])
            scale([brace_width+2,4,center_pillar_height/2])
            cube(1);
        }
        // horizontal bit
        difference() {
            translate([center_pillar_width/2,-2,camera_bar_thickness])
            scale([brace_length,2,center_pillar_height/8])
            cube(1);
            
            translate([brace_length + center_pillar_width/2,-3,camera_bar_thickness])
            scale([brace_length,4,brace_length])
            rotate([0,-45,0])
            cube(1);
        }
        // vertical bit
        difference() {
            translate([center_pillar_width/2,-2,camera_bar_thickness])
            scale([center_pillar_height/8,2,brace_length])
            cube(1);
            
            translate([brace_width,-3,brace_length-brace_width/2])
            scale([brace_length,4,brace_length])
            rotate([0,-45,0])
            cube(1);
        }
    }
}

// manifest it
rotate([90,0,0])
translate([0,2,0])
camera_z_bar();

