 
difference() {
   hull() {
    translate([-10.5,0,0]) cylinder(d=6,h=7.25,$fn=30);
    translate([0,0,0]) cylinder(d=12,h=7.25,$fn=30);
    translate([10.5,0,0]) cylinder(d=6,h=7.25,$fn=30);
    }
translate([-9,0,0]) cylinder(d=3.4,h=7.25,$fn=30);
translate([9,0,0]) cylinder(d=3.4,h=7.25,$fn=30);
}