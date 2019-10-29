$fn=50;
$base_thickness=2.8;
$base_lenght=32;
$base_width=16;
$base_screw_hole_diameter=2;
$base_fixing_pin_diameter=4.3;
$base_fixing_pin_height=4.3;
$base_fixing_ring_diameter=7;
$base_fixing_ring_height=1.5;


difference(){
    union(){
//-------------base        
translate([-$base_width/2,0,0]) cylinder(d=$base_width,h=$base_thickness, center=true);
translate([$base_width/2,0,0]) cylinder(d=$base_width,h=$base_thickness, center=true);
cube([$base_width,$base_width,$base_thickness], center=true);
//----------fixing pin
translate([0,0,$base_thickness]) cylinder(d=$base_fixing_pin_diameter,h=$base_fixing_pin_height, center=true);
}
//------------ screw holes
translate([-$base_width/2,0,0]) cylinder(d=$base_screw_hole_diameter,h=$base_thickness, center=true);
translate([$base_width/2,0,0]) cylinder(d=$base_screw_hole_diameter,h=$base_thickness, center=true);
//----------fixing ring
translate([0,0,$base_thickness/2-$base_fixing_ring_height/2]) difference(){ cylinder(d=$base_fixing_ring_diameter,h=$base_fixing_ring_height, center=true);
    cylinder(d=$base_fixing_pin_diameter,h=$base_fixing_ring_height, center=true);
    };

}

