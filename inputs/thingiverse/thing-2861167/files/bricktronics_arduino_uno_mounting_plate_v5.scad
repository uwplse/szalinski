
lego_hole_dia_mm = 4.8; // laser cutter SVG had 4.8mm
small_hole_dia_mm = 3.163; // originally 3.163 (for M3 nylon bolts)
thickness_mm = 3; // originally cut from 1/8" ~= 3mm plywood
custom_fn = 32;

difference() {
    
// main rectangle
cube([88.187,72.187,thickness_mm]);

// cut off corners
rotate([0,0,45]) cube([3,5,thickness_mm*3], center=true);
translate([88.187,0,0]) rotate([0,0,45]) cube([5,3,thickness_mm*3], center=true);
translate([0,72.187,0]) rotate([0,0,45]) cube([5,3,thickness_mm*3], center=true);
translate([88.187,72.187,0]) rotate([0,0,45]) cube([3,5,thickness_mm*3], center=true);

// lego holes
for (i = [0:10]) {
  translate([4.093+8*i,4.093,0]) cylinder(h=thickness_mm*3,d=lego_hole_dia_mm,center=true,$fn=custom_fn);
  translate([4.093+8*i,68.093,0]) cylinder(h=thickness_mm*3,d=lego_hole_dia_mm,center=true,$fn=custom_fn);
}
for (i = [0:6]) {
  translate([4.093,12.093+8*i,0]) cylinder(h=thickness_mm*3,d=lego_hole_dia_mm,center=true,$fn=custom_fn);
  translate([84.093,12.093+8*i,0]) cylinder(h=thickness_mm*3,d=lego_hole_dia_mm,center=true,$fn=custom_fn);
}

// small holes
translate([23.819,12.020,0]) cylinder(h=thickness_mm*3,d=small_hole_dia_mm,center=true,$fn=custom_fn);
translate([25.086,60.168,0]) cylinder(h=thickness_mm*3,d=small_hole_dia_mm,center=true,$fn=custom_fn);
translate([75.769,17.088,0]) cylinder(h=thickness_mm*3,d=small_hole_dia_mm,center=true,$fn=custom_fn);
translate([75.769,44.964,0]) cylinder(h=thickness_mm*3,d=small_hole_dia_mm,center=true,$fn=custom_fn);
};