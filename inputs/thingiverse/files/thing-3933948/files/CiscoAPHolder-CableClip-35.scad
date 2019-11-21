//AIR-AP1852i-E-K9
$fn=100;

$bolt_hole_diameter=5;
$x_bolt_distance=107.5;
$y_bolt_distance=66.5;
$x_offset=20;
$y_offset=35;



$base_rounding_diameter=5;
$base_thickness=8;
$base_reinforcement_thickness=12;
$holder_height=50.5;
$holder_thickness=6;

$clearance=0.5;

$tube1_diameter=30+$clearance;
$tube2_diameter=30;

$arm_x_length=50;
$arm_y_width=2*$y_offset+$y_bolt_distance-2-2*$base_rounding_diameter;

$retaining_bolt_diameter=5.4;
$retaining_bolt_z_offset=25;



$JointRoundingDiameter=$tube1_diameter-$tube2_diameter;
$JointRoundingOffset=$tube2_diameter/2+$holder_thickness;

$WallThickness=2;
$CutOutAngle=90;

$cable_diameter=6;

$JointThickness=5;

//**************TUBE CLIP************************************
rotate([0,0,$CutOutAngle/2]) translate([0,$tube1_diameter/2+$WallThickness/2,0])cylinder(d=1.5*$WallThickness,h=$JointThickness);
rotate([0,0,-$CutOutAngle/2]) translate([0,$tube1_diameter/2+$WallThickness/2,0])cylinder(d=1.5*$WallThickness,h=$JointThickness);
difference(){

sector($JointThickness, $tube1_diameter+2*$WallThickness, 90+$CutOutAngle/2, 360+$CutOutAngle/2);    
sector($JointThickness, $tube1_diameter, 90+$CutOutAngle/2, 360+$CutOutAngle/2);    
};
//**************CABLE CLIP***********************************
translate([0,-$tube1_diameter/2-$cable_diameter/2-$WallThickness,0])
rotate([0,0,180])
union()
{
    rotate([0,0,$CutOutAngle/2]) translate([0,$cable_diameter/2+$WallThickness/2,0])cylinder(d=1.5*$WallThickness,h=$JointThickness);
rotate([0,0,-$CutOutAngle/2]) translate([0,$cable_diameter/2+$WallThickness/2,0])cylinder(d=1.5*$WallThickness,h=$JointThickness);
difference(){

sector($JointThickness, $cable_diameter+2*$WallThickness, 90+$CutOutAngle/2, 360+$CutOutAngle/2);    
sector($JointThickness, $cable_diameter, 90+$CutOutAngle/2, 360+$CutOutAngle/2);    
};
};
//***********************************************************
module sector(h, d, a1, a2) {
    if (a2 - a1 > 180) {
        difference() {
            cylinder(h=h, d=d);
            translate([0,0,-0.5]) sector(h+1, d+1, a2-360, a1); 
        }
    } else {
        difference() {
            cylinder(h=h, d=d);
            rotate([0,0,a1]) translate([-d/2, -d/2, -0.5])
                cube([d, d/2, h+1]);
            rotate([0,0,a2]) translate([-d/2, 0, -0.5])
                cube([d, d/2, h+1]);
        }
    }
}  