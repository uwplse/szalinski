l = 135;
lens = 75;
lens_l = 11;
ocular_r = 36;
ocular_l = 23;
wall_t = 2;
screw =2.5;
fn = 200;


union(){
//Principal body
difference(){
//External body
union(){
cylinder(h = l, r1 = lens/2+wall_t, r2 = ocular_r/2+wall_t, center = false, $fn = fn);
translate([0,0,-lens_l])
cylinder(h = lens_l, r1 = lens/2+wall_t, r2 = lens/2+wall_t, center = false, $fn = fn);

}

//Internal hole
translate([0,0,5])
union(){
cylinder(h = l, r1 = lens/2, r2 = ocular_r/2, center = false, $fn = fn);
translate([0,0,l])
cylinder(h = ocular_l+2, r1 = ocular_r/2, r2 = ocular_r/2, center = false, $fn = fn);
translate([0,0,-ocular_l])
cylinder(h = ocular_l, r1 = lens/2, r2 = lens/2, center = false, $fn = fn);
}

}

//Vixen mount
translate([0,0.1,0])
difference(){
translate([27,-55,l/2])
union(){
difference(){
import("vixen.stl", convexity = fn);
translate([-45,15.5,-5])
cube(size = [35,5,50], center = false);
}
translate([-37.5,15.5,0])
cube(size = [20,50,41], center = false);
}
cylinder(h = l, r1 = lens/2+wall_t, r2 = ocular_r/2+wall_t, center = false, $fn = fn);
}

//Focuser
translate([0,0,l-ocular_l])
import("focuser.stl", convexity = fn);


//lens holder test
*translate([0,0,-13])
difference(){
import("telescope_endCap.stl", convexity = fn);
*translate([0,-45,-0.1])
cube(size = [80,90,20], center = false);
}

//focuser tube test
*translate([0,0,l-ocular_l+8])
import("focuser_tube.stl", convexity = fn);

}
