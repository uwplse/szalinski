

/* [Overall Size] */
thickness = 15; // [10:30]
width = 50;  // [45:90]
depth = 25;  // [15:50]

/* [Ruler Size] */
ruler_width = 25.4; // [10:40]
ruler_thickness = 2.4; // [1:5]

/* [bolt_size]*/
bolt_dia = 4;  // [3:6]
bolt_head = 10; // [8:12]

/* [Hidden] */
$fn=48;


difference() {
    br = bolt_dia /2;
    hr = bolt_head /2;
    t = .5; // thread allowance
    
    //overall dimensions
    cube([width, thickness, depth], center = true);
    
    //slot for ruler
    cube([ruler_width, ruler_thickness, depth+.1], center = true);
    
    //1mm slot to clamp with
    translate([width/4,0,0]) 
        cube([width/2+.1,1,depth+.1], center = true);

    //screw shank and head
    translate([(ruler_width+width)/4,-1,0]) rotate([90,0,0]){
        cylinder(10, br+t, br+t);
        translate([0,0,-thickness/2]) cylinder(thickness/2, br, br);
        translate([0,0,-thickness/2]) cylinder(3, hr, br);
        translate([0,0,-3-thickness/2]) cylinder(3, hr, hr);
    }
}
