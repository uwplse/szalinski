/****************************************************************\
|***                                                          ***|
|***      Customizable Kite Parachute Releaser by Svenny      ***|
|***                                                          ***|
|***         https://www.thingiverse.com/thing:2546550        ***|
|***                                                          ***|
\****************************************************************/

/* [MAIN] */
// what to print?
what = "all"; // [bottom, top, all]

/* [SIZE] */
// minimal width of parts
basic_width = 2.6;
// part height
height = 20;

/* [HOLES] */
// wire diameter (add ~1mm so the wire can move freely)
wire_d = 2;
// kiting line
rope_d = 3.2; // [1:0.2:7]
// wooden stick - a
stick_a = 3;
// wooden stick - b
stick_b = 5;
// height of twisted part of line-lock
twist_height = 6;
/*/ wing stick (top_wing and wing only)
wing_stick_d = 3.2;*/

/* [OFFSETS] */
// wire from line
wire_offset = 12;
// stick from wire
stick_offset = 10;
// second wire from stick
wire_2_offset = 12;

/* [OTHERS] */
$fn=60;

spejle_offset = wire_offset+stick_offset+stick_b/2;
wire_offset_2 = spejle_offset+wire_2_offset;

module rope_lock(height, length, width) {
    cube_len = length;
    difference() {
        union() {
            cylinder(d=width, h=height, center=true);
            
            translate([0,cube_len/2,0])            
            cube([basic_width, cube_len, height], center=true);
            
            // wires and sticks
            translate([0, wire_offset, 0])
            cylinder(d=wire_d+2, h=height, center=true);
            
            translate([0, spejle_offset, 0])
            cube([stick_a+2, stick_b+2, height], center=true);
        }
        cylinder(d=rope_d, h=2*height, center=true);
        for(i=[0,180])
            rotate([i,0,0])
            translate([0,0,-height/2-0.1])
            cylinder(r1=rope_d/2+0.7, r2=rope_d/2, h=1);
        
        translate([0,0.8,0])
        dividing(height);            
        
        // holes for wires and sticks
        translate([0, wire_offset, 0])
        cylinder(d=wire_d, h=2*height, center=true);
        
        translate([0, spejle_offset, 2])
        cube([stick_a, stick_b, height], center=true);
    }
}

module __twist() {
    linear_extrude(twist_height, twist=-270, slices=100)
    rotate(45)
    translate([0,rope_d])
    square([1,2*rope_d], center=true);
}

module dividing(height) {
    if(height < 2*twist_height) {
        translate([0,0,-twist_height/2]) __twist();
        
        for(i=[-1,1])
            rotate(-i*45)
            translate([0,rope_d,i*twist_height])
            cube([1,2*rope_d,twist_height], center=true);
    } else {
        rest_h = (height-2*twist_height)/3;
        
        translate([0,0,rest_h/2]) __twist();
        mirror([0,0,1]) translate([0,0,rest_h/2]) __twist();
        
        rotate(45)
        translate([0,5,0])
        cube([1,10,rest_h], center=true);
        
        for(i=[-1,1])
            rotate(-45)
            translate([0,rope_d,i*height/2])
            cube([1,2*rope_d,2*rest_h], center=true);
    }
}

module bottom_part() {

    difference() {
        union() {
            rope_lock(height, wire_offset_2, rope_d+3);
            
            translate([0, wire_offset_2, 0])
            cylinder(d=wire_d+2, h=height, center=true);
        }
        
        translate([0, wire_offset_2, 0]) {
            cylinder(d=wire_d, h=2*height, center=true);
            
            translate([0,2,0])
            rotate([0,90,0])
            cylinder(d=14, h=100, center=true, $fn=6);
        }
    }
}

module top_part(with_wing=false) {
    width = basic_width+3;
    kloub_offset = spejle_offset+height/2+2*stick_a;
    difference() {
        union() {
            rope_lock(height, spejle_offset, rope_d+3);
            
            if(with_wing) {
                translate([0, kloub_offset, -height/2+5])
                rotate([0,90,0])
                cylinder(d=10, h=width, center=true);
                
                hull() {
                    translate([0, kloub_offset, -height/2+5])
                    rotate([0,90,0])
                    cylinder(d=10, h=basic_width, center=true);
                    
                    translate([0, spejle_offset+stick_b/2+1, 0])
                    cube([basic_width, 0.01, height], center=true);
                }
            }
        }
        
        translate([0, kloub_offset, -height/2+5])
        rotate([0,90,0])
        cylinder(d=6, h=2*height, center=true);
    }
    
    if(with_wing)
        translate([0,kloub_offset,-height/2+5])
        wing();
}

module wing() {
    width = 50;
    small_height = wing_stick_d+2;
    body_z_offset = -(10-small_height)/2;
    
    difference() {
        union() {
            translate([0, small_height/2, body_z_offset])
            hull() {
                cube([width, small_height, small_height], center=true);
                translate([0,40,0])
                cube([small_height, 3, small_height], center=true);
            }
            
            rotate([0,90,0])
            cylinder(d=10, h=basic_width+12, center=true);
        }
        
        cube([basic_width+4, 10+3, 100], center=true);
        
        // holes for sticks
        for(i=[-1,1])
            translate([0, 11, body_z_offset])
            rotate([0,i*90,i*-19])
            translate([0,0,2])
            cylinder(d=wing_stick_d, h=40);
        
        translate([0, 20, body_z_offset])
        rotate([-90,0,0])
        cylinder(d=wing_stick_d, h=40);
    }
    
    rotate([0,90,0])
    cylinder(d=5, h=14, center=true);
}

if(what == "bottom")
    bottom_part();
//else if(what == "top_wing")
//    top_part(true);
else if(what == "top")
    top_part(false);
//else if(what == "wing")
//    wing();
else if(what == "all") {
    top_part(false);
    translate([30,0,0])
    bottom_part();
}
else
    text("unknown option");