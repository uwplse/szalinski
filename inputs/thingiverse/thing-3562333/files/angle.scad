//small angle for attaching LEDS
face_a_width  = 11;
face_b_width  = 9;
length = 368;
thickness = 3;
//Hole parameters
holes = true;
hole_diameter = 3.5;
hole_loc_from_end = 10;
angle_rotation = 0;


module make_angle(x,x1,y,z){
    difference()
    {
        union()
        {
            //generate face_a
            cube([x,y,z]);
            //generate face_b
            rotate([0,angle_rotation*-1,0])
            cube([z,y,x1]);
        }
        if (holes)
        {
            translate([((face_a_width-thickness)/2)+ thickness, hole_loc_from_end,-1])
                cylinder(z+2,hole_diameter/2,hole_diameter/2,$fn=50);
            translate([((face_a_width-thickness)/2)+ thickness, length/2,-1])
                cylinder(z+2,hole_diameter/2,hole_diameter/2,$fn=50);
            translate([((face_a_width-thickness)/2)+ thickness, length-hole_loc_from_end,-1])
                cylinder(z+2,hole_diameter/2,hole_diameter/2,$fn=50);
        }    
    }
}

make_angle(face_a_width,face_b_width,length,thickness);


