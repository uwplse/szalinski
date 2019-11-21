$width=86;
$height=86;
$thickness=3;
$xy_offset=10;
$inner_xy_offset=5;
$z_offset=1;
$outer_rounding_radius=5;

$fn=100;
difference(){
//frame    
translate([0,0,$thickness/2]){
minkowski() {
cube([$width-2*$outer_rounding_radius+2*$xy_offset,$height-2*$outer_rounding_radius+2*$xy_offset,$thickness], center= true);
cylinder(r=$outer_rounding_radius,h=1);
};
};
//offset
translate([0,0,$thickness-$z_offset+($thickness-$z_offset)/2])cube([$width,$height,$thickness-$z_offset], center= true);

//hole
translate([0,0,$thickness/2])cube([$width-2*$inner_xy_offset,$height-2*$inner_xy_offset,$thickness], center= true);
};


