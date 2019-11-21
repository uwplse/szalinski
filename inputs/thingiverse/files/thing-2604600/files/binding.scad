/**** https://www.thingiverse.com/thing:2604600 ****/
/**** author: Svenny                            ****/

/* [HANDLEBAR PART] */
// handlebar diameter
tube_d = 26;
// affixer type - use bigger dillatation for one_part
tube_side_type = "two_parts"; // [two_parts, one_part]
// width of the opening gap
dillatation = 8;

/* [ARM] */
// arm type
arm_type = "X"; // [X, solid, two_parts]
// length (two_parts is 1 mm shorter)
arm_length = 10;
// thickness (X type only)
arm_x_thickness = 3.5;
// connecting tooth height (two_parts type only)
tooth_size = 3;

/* [HOLDER PARAMS] */
// main rails height (use the same as in mobile holder)
rail_height = 10;
// distance between main rails (use the same as in mobile holder)
rail_gauge = 20;

/* [PRECISION] */
// precision
$fn = 90;

rg_2 = rail_gauge-0.5;


module _halfcylinder(d, h, cube_rot=0) {
    cylinder(d=d, h=h, center=true);
    rotate(cube_rot)
    translate([d/4,0,0])
    cube([d/2,d,h], center=true);
}

module holder_side() {
    translate([0,0,-arm_length/2])
    difference() {
        hull() {
            translate([0,0,-3.5-rail_height/2])
            cube([rg_2,48,rail_height], center=true);
            translate([0,0,-5])
            cube([rg_2,rail_gauge-0.5,10], center=true);
        }
        
        translate([0,0,-3.5-rail_height/2]) {
            cube([2*rail_gauge, 11, rail_height+0.5], center=true);
        
            for(i = [-1, 1])
                translate([0, i*15, 0])
                rotate([0,90,0])
                cylinder(d=3.2, h=2*rail_gauge, center=true);
        }
    }
}

module arm() {
    difference() {
        translate([0,0,5])
        if(arm_type == "X")
            _X_arm(arm_length+10);
        else if(arm_type == "solid")
            _solid_arm(arm_length+10);
        else if(arm_type == "two_parts")
            _two_parts_arm(arm_length+10);
        
        // tube
        translate([0,0,(arm_length+tube_d)/2])
        rotate([90,0,90])
        cylinder(d=tube_d, h=2*rg_2, center=true);
    }
}

module _solid_arm(length) {
    cube([rg_2,rg_2,length], center=true);
}

module _X_arm(length) {
    intersection() {
        _solid_arm(length);
        
        for(angle=[-45,45])
            rotate(angle)
            cube([2*rg_2, arm_x_thickness, length], center=true);
    }
}

module _crossing_male(length) {
    tooth_side = sqrt(2)*tooth_size;
    intersection() {
        cube([rg_2, rg_2, length], center=true);

        translate([0, 0, -tooth_size/2-5])
        union() {
            translate([0,0,-length/4])
            cube([rg_2, rg_2, length/2], center=true);
            
            for(angle=[45:90:360]) {
                rotate([45,0,angle])
                cube([2*rg_2, tooth_side, tooth_side], center=true);
            }
        }
    }
}

module _two_parts_arm(length) {
    translate([0,0,0.5])
    difference() {
        cube([rg_2, rg_2, length], center=true);
        _crossing_male(length);
    }
    
    translate([0,0,-0.5])
    _crossing_male(length);        
}

module tube_side() {
    translate([0,0,(arm_length+tube_d)/2])
    if(tube_side_type == "two_parts")
        ts_1([-1,1]);
    else
        ts_1([1]);
}

module ts_1(iterator) {
    screwing = dillatation+3+5;
    rotate([90,0,90])
    difference() {
        union() {
            cylinder(d=tube_d+4, h=rg_2, center=true);
            
            hull()
            for(i=iterator)
                translate([i*(tube_d+4)/2, -1, 0])
                rotate([90,0,0])
                _halfcylinder(d=rg_2, h=screwing, cube_rot=90+i*90, center=true);
        }
        
        cylinder(d=tube_d, h=2*rg_2, center=true);
        
        for(i=iterator)
            translate([i*(tube_d+10)/2, 0, 0]) {
                // dillatations
                cube([1.5*tube_d, dillatation, 2*rg_2], center=true);
                
                // screws
                rotate([90,0,0]) {
                    cylinder(d=3.5, h=3*tube_d, center=true);
                    translate([0,0,dillatation/2+2])
                    cylinder(r1=3.1, r2=3.5, h=3.5, $fn=6);
                }
            }
    }
}

rotate([0,90,0])
difference() {
    union() {
        holder_side();
        arm();
        tube_side();
    }
    if(arm_type == "two_parts") {
        // screw
        cylinder(d=3.5, h=arm_length+10, center=true, $fn=30);
        // nut
        translate([0,0,arm_length/2-3])
        cylinder(r1=3.1, r2=3.5, h=3.5, $fn=6);
        // screw head
        translate([0,0,-arm_length/2-4])
        cylinder(d=6.5, h=4.5, $fn=30);
    }
}