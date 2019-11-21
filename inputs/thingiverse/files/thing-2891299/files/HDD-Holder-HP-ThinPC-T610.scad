$hdd_width=70;
$hdd_height=7;
$hdd_arm_length=20;
$hdd_arm_height=$hdd_height;
$hdd_arm_thickness=2;

$hdd_screw_hole_diameter=3.5;
$hdd_screw_hole_offset=10;

$board_mounting_offset=20;
$board_mounting_diameter=3.5;
$bed_mounting_diameter=10;

$board_mounting_arm_length=$board_mounting_offset-$bed_mounting_diameter/2-$hdd_arm_thickness;
$board_mounting_arm_width=20;
$board_mounting_arm_thickness=$hdd_arm_thickness;

$hdd_z_offset=9;
$hdd_y_offset=2;

$bed_mounting_thickness=$board_mounting_arm_thickness;


$fn=100;

difference(){
union(){
//HDD
translate([0,$hdd_width/2+$hdd_arm_thickness/2,0])cube([$hdd_arm_length,$hdd_arm_thickness,$hdd_arm_height], center=true);
translate([0,-$hdd_width/2-$hdd_arm_thickness/2,0])cube([$hdd_arm_length,$hdd_arm_thickness,$hdd_arm_height], center=true);
translate([$hdd_arm_length/2+$hdd_arm_thickness/2,0,0])cube([$hdd_arm_thickness,2*$hdd_arm_thickness+$hdd_width,$hdd_arm_height], center=true);
//board arm  
    translate([$hdd_arm_length/2+$board_mounting_arm_length/2+$hdd_arm_thickness,$hdd_y_offset,$hdd_arm_height/2-$board_mounting_arm_thickness/2]) cube([$board_mounting_arm_length,$board_mounting_arm_width,$board_mounting_arm_thickness],center=true);
//arm-boar-joint
    translate([$hdd_arm_length/2+$board_mounting_arm_length+$hdd_arm_thickness/2,$hdd_y_offset,-$hdd_z_offset/2]) cube([$hdd_arm_thickness,$bed_mounting_diameter,$hdd_z_offset+$hdd_arm_height],center=true);
//board_mounting    
    translate([$hdd_arm_length/2+$board_mounting_offset,$hdd_y_offset,-$hdd_z_offset-$hdd_arm_height/2+$bed_mounting_thickness/2]){
    
        translate([-$bed_mounting_diameter/4,0,0]) cube([$bed_mounting_diameter/2,$bed_mounting_diameter,$bed_mounting_thickness], center=true);
        cylinder(d=$bed_mounting_diameter, h=$bed_mounting_thickness, center=true);
    };
    
};
//hdd_mounting_hole
translate([$hdd_arm_length/2-$hdd_screw_hole_offset,0,0])rotate([90,0,0]) cylinder(d=$hdd_screw_hole_diameter,h=2*$hdd_arm_thickness+$hdd_width, center=true);
//board_mounting_hole
translate([$hdd_arm_length/2+$board_mounting_offset,$hdd_y_offset,0]) cylinder(d=$board_mounting_diameter,h=$hdd_width, center=true);

};

