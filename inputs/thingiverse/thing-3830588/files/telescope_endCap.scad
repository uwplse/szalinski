l = 180;
lens = 74.9;
lens_l = 11;
ocular_r = 31.7;
ocular_l = 23;
wall_t = 2.2;
screw =2.5;

difference(){
difference(){
cylinder(h = lens_l+2, r1 = lens/2+wall_t+2, r2 = lens/2+wall_t+2, center = false, $fn = 50);
translate([0,0,-1])
cylinder(h = ocular_l+2, r1 = lens/2-1, r2 = lens/2-1, center = false, $fn = 50);
}




//Principal body
translate([0,0,12])
difference(){
//External body
union(){
translate([0,0,-lens_l])
cylinder(h = lens_l+3, r1 = lens/2+wall_t, r2 = lens/2+wall_t, center = false, $fn = 50);

}

//Internal hole
translate([0,0,-ocular_l])
cylinder(h = ocular_l+3, r1 = lens/2, r2 = lens/2, center = false, $fn = 50);
}
}