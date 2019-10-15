
$fn=100;
difference() {
translate([1.15,-1.9,-2]) { cube([2,3.8,4]); }

cylinder(d=4, h=4.1, center=true);
translate([4.3,0,0]) {
  cylinder(d=4, h=4.1, center=true);
rotate([0, 90, 0]) cylinder(d=.8, h=40, center=true);  
}
union () {
translate([2.15,2,0]) cylinder(d=1.1, h=4.1, center=true);
translate([2.15,-2,0]) cylinder(d=1.1, h=4.1, center=true);
}

}


