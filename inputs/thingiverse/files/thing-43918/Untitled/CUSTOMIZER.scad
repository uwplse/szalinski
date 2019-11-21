resolution=16;//[2:128]
size=5;//[2:100]
pawn(size, resolution);
module pawn(s, res){
$fn=res;
translate([0, 0, 12/5*s])
sphere(r=s);
cylinder(h = s*4, r1 = s, r2 = 2/5*s, center = true);
translate([0, 0, 7/5*s])
cylinder(h = 1/5*s, r=s);
translate([0, 0, -2*s])
cylinder(h = 6/5*s, r1 = 7/5*s, r2 = s);
translate([0, 0, -11/5*s])
cylinder(h = 1/5*s, r= 8/5*s);
}