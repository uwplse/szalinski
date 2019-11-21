//
//  router pattern jig for concealed cabinet hinge mount
//
//  design by egil kvaleberg, 3 dec 2015
//
//  bug: 
//

// size of milling bit used on router
mill_dia = 9.5;  

// diameter of guide on router
guide_dia = 18.3; 

// jig main thickness 
guide_height = 6.0;

// width of support bar
guide_bar = 5.0; 

// chamfer of jig hole
guide_chamfer = 0.6; 

// hole in router plastic support plate, decides jig height
platform_dia = 60.0; 

// hole for hinge, usually 35, but 25 also exists
hinge_dia = 35.0; 

// hole centre offset to door edge, decides gap (20.5 to 24.5)
hinge_offset = 23.0; 

// hinge mount screw distance, usually 42, 45 or 48 
screw_dist = 45.0; 

// from hole centre, valid for 35mm hinge
screw_offset = 9.5; 

// for pilot drill and jig fixing screw, final hole should be approx 4.0
screw_dia = 3.1; 

// size of head of screw for temporary jig fixing
screw_head = 6.0; 

// width of notch indicating centre
index_notch = 1.0; 

/* [Hidden] */
tool_offset = (guide_dia-mill_dia)/2;
tool_dia = hinge_dia+tool_offset*2; // diameter of hole in tool
tool_height = max(platform_dia + hinge_dia + 6.0, hinge_dia+2*tool_offset+2*guide_bar); // make sure jig supports router plastic support plate
tool_width = hinge_offset+tool_dia/2+2*guide_height;

d = 0.01;

module tool() {
    translate([-tool_height/2, -guide_bar, 0]) cube(size=[tool_height, tool_width, guide_height]);
    translate([-tool_height/2, -guide_bar, -guide_height]) cube(size=[tool_height, guide_bar, guide_height+d]);
}

module hingehole() {
    translate([0, hinge_offset, -d]) {
        cylinder(d=tool_dia, h=guide_height+2*d, $fn=60);
        translate([0, 0, d+guide_height-guide_chamfer]) 
            cylinder(d1=tool_dia, d2=tool_dia+2*guide_chamfer, h=guide_chamfer+d, $fn=60);
    }
}

module screwholes() {
    recess = guide_height/5;
    for (s = [1, -1]) translate([s*screw_dist/2, hinge_offset+screw_offset, -d]) {
            cylinder(d=screw_dia, h=guide_height+2*d, $fn=30);
            translate([0, 0, guide_height-screw_head/2-recess]) cylinder(d1=0, d2=screw_head, h=screw_head/2+d, $fn=30);
            translate([0, 0, guide_height-recess]) cylinder(d=screw_head, h=recess+2*d, $fn=30);
    }
}

module index() {
    translate([0, hinge_offset, -d]) {
        for (a = [0, 90]) rotate([0, 0, a])
        cube(size=[index_notch, tool_dia+4*index_notch, guide_height], center=true); 
    }
}

rotate([180,0,0]) // for printing
difference () {
    tool();
    union () {
        hingehole();
        screwholes();
        index();
    }
}