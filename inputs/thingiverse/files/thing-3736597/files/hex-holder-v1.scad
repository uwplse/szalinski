// Hex bit holder v1
// KBS3056 02.07.2019

slot_num                = 3;
bit_separate_space      = 1.5; 
holder_height           = 15.5;
side_wall_thickness     = 1.1;

//advanced
hole_diam               = 7.7; //for bit 6.33/7.14mm diameter. 4.9mm indentation diameter 
latch_thickness         = 1.6; 
latch_height            = 4;  
latch_width             = 3;
latch_pos_z             = 4.2; 
$fn                     = 60;
spring_thickness        = 1;

//no need to change
spring_length           = 5; 


union(){
    difference(){
        cube([slot_num * (hole_diam + bit_separate_space) + bit_separate_space, 2 * side_wall_thickness + hole_diam, holder_height]);
        translate([hole_diam / 2 + bit_separate_space, 0, 0])
            for(n = [0 : slot_num - 1])
                translate([n * (hole_diam + bit_separate_space), hole_diam / 2 + side_wall_thickness, -0.05])
                    cylinder(h = holder_height + 0.1, d = hole_diam);
//difference
        translate([hole_diam / 2 + bit_separate_space - latch_width / 2, 0, 0])           
        for(n = [0 : slot_num - 1])  
            
            if(n % 2 == 0)
                if(n == 0)
                    translate([n * (hole_diam + bit_separate_space) + latch_width, side_wall_thickness + hole_diam / 2 - 0.2, latch_pos_z + latch_height])
                        rotate([0, 180, 0])
                            cutter(latch_height, latch_width);
                else
                    translate([n * (hole_diam + bit_separate_space), side_wall_thickness + hole_diam / 2 - 0.2, latch_pos_z])
                        cutter(latch_height, latch_width);
            
            else
                translate([n * (hole_diam + bit_separate_space), side_wall_thickness + hole_diam / 2 + 0.2, latch_pos_z + latch_height])
                    rotate([0, 180, 180])
                        cutter(latch_height, latch_width);
    }   
    
//union
    translate([hole_diam / 2 + bit_separate_space - latch_width / 2, 0, 0])           
        for(n = [0 : slot_num - 1])  
            
            if(n % 2 == 0)
                translate([n * (hole_diam + bit_separate_space), side_wall_thickness, latch_pos_z])
                    latch(latch_height, latch_thickness);
            
            else
                translate([n * (hole_diam + bit_separate_space) + latch_width, side_wall_thickness + hole_diam, latch_pos_z])
                    rotate([0, 0, 180])
                        latch(latch_height, latch_thickness);
}   

module cutter(latch_height, latch_width) {
    union(){
        rotate([90, 0, 0])
            linear_extrude(side_wall_thickness + hole_diam / 2 )
                polygon([[0, 0], [latch_width, 0], [latch_width, latch_height], [0, latch_height], [0, latch_height + 0.7], [latch_width + 0.7, latch_height + 0.7], [latch_width + 0.7, -0.7], [0, -0.7]]);
        translate([ -spring_length + 0.05, - (side_wall_thickness + hole_diam / 2), -0.7])
            cube([spring_length, spring_thickness + 0.2, 0.7]);
        translate([ -spring_length + 0.05, - (side_wall_thickness + hole_diam / 2), latch_height])
            cube([spring_length, spring_thickness + 0.2, 0.7]);
        translate([ -spring_length, -(0.3 + hole_diam / 2 + side_wall_thickness - spring_thickness - 0.5), -0.7])
            cube([spring_length, 0.5, latch_height + 2 * 0.7]);
        translate([-0.7, -hole_diam / 2 - side_wall_thickness + spring_thickness + 0.2, -0.7])
            cube([0.7, side_wall_thickness + hole_diam / 2 , latch_height + 2 * 0.7]);
    }
}

module latch(latch_height, latch_thickness) {
    rotate([90, 0, 90])
        linear_extrude(latch_width)
            polygon([[0, 0], [0, latch_height], [latch_thickness, latch_height - latch_thickness * 0.9], [latch_thickness, latch_thickness * 0.9]]);
}

assert(!(latch_height / latch_thickness < 1.875)); //too large 'latch_thickness' or too small 'latch_height'
assert(!(side_wall_thickness < 1.0)); //too small 'side_wall_thickness'
assert(!(slot_num < 1.3)); //'slot_num' must be larger than "1"
assert(!(spring_thickness > side_wall_thickness)); //too large 'spring_thickness' or too small 'side_wall_thickness'
assert(!(spring_length / (hole_diam + bit_separate_space) > 0.58)); //too large 'spring_thickness' or too small 'side_wall_thickness'
assert(!( latch_height > holder_height - latch_pos_z - 1.5)); //too large 'latch_height' or too small 'holder_height'
assert(!( latch_width > hole_diam / 2)); //too large 'latch_width'
assert(!( 0> 1.3)); //'slot_num' must be larger than "1"


