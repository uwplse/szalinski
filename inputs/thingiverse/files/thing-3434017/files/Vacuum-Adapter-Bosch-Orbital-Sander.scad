// Vacuum cleaner adapter for BOSCH GEX AVE orbital sander 

$fa=1*1;
$fs=0.25*1;

// wall thickness
wall_thickness=2.5;

// inner diameter of vacuum output section
vacuum_inner_diameter = 35.5;

// length of vacuum segment
vacuum_length = 50;

// length of reductor segment
reductor_length = 10;

// width of closer - the part where cable tie is attached
closer_width=8;

// height of closer - the part where cable tie is attached
closer_height=8;


// fixed (not editable) values
grip_length = 1.5 + 0; 
grip_inner_diameter = 26 + 0; 
grip_outer_diameter = 27.5 + 0; 

// computed values
segment_length = (13.9 - ( 2 + 2*0.5 ) * grip_length) / 3;
segment_offset = segment_length + grip_length;
tube_length=21.5 + grip_length/2;
vacuum_outer_diameter = vacuum_inner_diameter + 2*wall_thickness;

d_tmp = vacuum_outer_diameter/2 - grip_outer_diameter/2 - wall_thickness;




difference() {
    
    union() {
        // outer cylinder
        cylinder(tube_length, d=grip_outer_diameter+2*wall_thickness, center=false);
        
        translate([0, 0, tube_length])
            difference() {
                cylinder(reductor_length, d1=grip_outer_diameter+2*wall_thickness, d2=  vacuum_inner_diameter+2*wall_thickness);
                cylinder(reductor_length, d1=grip_outer_diameter, d2=vacuum_inner_diameter);
            }
        
            
        translate([0, 0, tube_length + reductor_length])
            difference() {
                cylinder(vacuum_length, d=vacuum_outer_diameter);
                cylinder(vacuum_length, d=vacuum_inner_diameter);
            }

        // closer element: grip
        difference() {
            translate([-closer_width/2, grip_outer_diameter/2+wall_thickness-1, 0])   
                cube([closer_width,closer_height, tube_length]);
            translate([-closer_width/2, grip_outer_diameter/2+wall_thickness+2, tube_length/2-5])   
                cube([closer_width, 3, 10]);
        }

        // closer element: vacuum
        difference() {
            translate([-closer_width/2, vacuum_outer_diameter/2-1, reductor_length+tube_length])   
                cube([closer_width,closer_height, vacuum_length]);
            translate([-closer_width/2, vacuum_outer_diameter/2+2, reductor_length+tube_length+vacuum_length/2-5])   
                cube([closer_width, 3, 10]);
        }
            
            
        translate([-closer_width/2, grip_outer_diameter/2+wall_thickness-1, tube_length])   
        rotate([0,90,0])
        linear_extrude(closer_width)
        polygon( points = [ [0, 0],
                 [-reductor_length, d_tmp],
                 [-reductor_length, d_tmp + closer_height],
                 [0, closer_height] ] );
    }
        
    // cylinder with grip diameter
    cylinder(tube_length, d=grip_inner_diameter, center=false);
    
    // non-grip segements
    for (i = [grip_length:segment_offset:22]) {
        translate([0, 0, i])
            cylinder(segment_length, d=grip_outer_diameter, center=false);
    }
    
    // cut open half tube
    translate([0, -vacuum_outer_diameter/2, tube_length+reductor_length])
        cube([vacuum_outer_diameter, vacuum_outer_diameter, vacuum_length]);
    
    // cut open half tube
    translate([0, -grip_outer_diameter/2-wall_thickness, 0])
        cube([vacuum_outer_diameter, grip_outer_diameter+2*wall_thickness, tube_length]);

    translate([0,0,tube_length])
    rotate([0,90,0])
    linear_extrude(vacuum_outer_diameter)
    polygon( points = [ [0, -grip_outer_diameter/2-wall_thickness],
             [-reductor_length, -vacuum_outer_diameter/2],
             [-reductor_length, vacuum_outer_diameter/2],
             [0, grip_outer_diameter/2+wall_thickness] ] );
}
