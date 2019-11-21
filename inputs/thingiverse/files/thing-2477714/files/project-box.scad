//Procedural Project Box v1
//CudaTox, 2017

inside_width = 32;
inside_length = 75;
inside_height = 35;
thickness = 2;                  //Wall thickness
radius = 2;                     //Fillet radius. Should not be larger than thickness
extra_lid_thickness = 0.5;      //Extra lid thickness above thickness. 
                                //You may wan to tweak this to account for large chamfer radius.

outside_width = inside_width + thickness * 2;
outside_length = inside_length + thickness * 2;


module rounded_box(x,y,z,r){
    translate([r,r,r])
    minkowski(){
        cube([x-r*2,y-r*2,z-r*2]);
        sphere(r=r, $fs=0.1);
    }
}

module main_box(){
    difference(){
        //cube([outside_width, outside_length, inside_height + thickness * 2]);
        difference(){
            rounded_box(outside_width, outside_length, inside_height + thickness + 2, radius);
            translate([0,0,inside_height + thickness])
            cube([outside_width, outside_length, inside_height + thickness * 2]);
        }
        translate([thickness, thickness, thickness])
        cube([inside_width, inside_length, inside_height + thickness]);
    }
}

module lid(){
//Lid.
difference(){
    rounded_box(outside_width, outside_length, thickness * 4, radius);
    translate([0,0, thickness + extra_lid_thickness])
        cube([outside_width, outside_length, inside_height + thickness * 4]);
}
//Lip
lip_tol = 0.5;
lip_width = inside_width - lip_tol;
lip_length = inside_length - lip_tol;
translate([(outside_width - lip_width)/2,(outside_length - lip_length)/2, thickness + 0.5])
    difference(){
        cube([lip_width, lip_length, 2]);
        translate([thickness, thickness, 0])
            cube([lip_width-thickness*2, lip_length-thickness*2, 2]);
    }

}

main_box();
translate([-outside_width-2,0,0])
    lid();


