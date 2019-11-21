
//CUSTOMIZER VARIABLES

// space between back of cup and beginning of hook
hook_gap=15;

// height of hook clip
hook_height=3;

// total length of part (minimum 18)
overall_length=78;

//CUSTOMIZER VARIABLES END


translate([0,-23+hook_gap,0])
rotate([0,-90,0])
union() {
 difference() {
  translate([0,23-hook_gap,0]) cube([overall_length,7+hook_gap,50]);
  translate([-0.1,22.9-hook_gap,-0.1]) cube([overall_length+0.2,3.2,46-hook_height]);
  translate([-0.1,26-hook_gap,-0.1]) cube([overall_length+0.2,hook_gap,46]);
 }
 difference() {
  translate([0,30,0]) cube([overall_length,18,50]);
  translate([9,31,1]) cube([overall_length-18,16,49.1]);
  translate([9,39,1]) cylinder(r=8, h=49.1, $fn=50);
  translate([overall_length-9,39,1]) cylinder(r=8, h=49.1, $fn=50);
 }
}


//44.27