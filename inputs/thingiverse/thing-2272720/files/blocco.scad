height=8;
radius=4.25;
difference(){
union(){
translate([-6,0,0]) cube([12,16,height],center=true);
cylinder(h=height,r=8, center=true, $fn=50);
}
translate([-10,0,0]) cube([20,1,height+4],center=true);
cylinder(h=30,r=radius, center=true, $fn=50);
translate([-7,0,0]) rotate([90,0,0]) cylinder(h=30,r=1.6, center=true, $fn=50);
}
