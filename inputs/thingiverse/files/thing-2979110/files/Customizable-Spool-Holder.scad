$fn=90;


// Minimum Diameter
$MinD=28;
// Maximum Diameter
$MaxD=80;
// Height
$H=30;
// body type, 1 == full, 2 == hollow
$BodyType=1;


// Bearing Diameter
$BearingD=22;
// Bearing Height
$BearingH=7;

// Bearing Wall
$BearingW=1.2;
// Bearing Wall Height
$BearingWH=0.6;

// Rod Diameter
$RodD=8.5;

// Thickness of the arms
$ArmThickness=3;
// Number of arms
$NumArms=3;
// Type of Arm, 1 == full arms, 2 == thin arms.
$ArmType=2;


// value of Pi
$Pi=4*atan2(1,1);


module bearing (diameter=22, height=7) {
    cylinder(h=height, d=diameter);    
    translate ([0,0,height]) cylinder(h=$BearingWH, d=diameter-2*$BearingW);    
}


module body (min_d, max_d, height) {
    cylinder(h=height, d=min_d, $fn=120);
    difference () {
        arms (min_d/2, max_d/2, height);
        if ( $ArmType == 2 )
            translate([0,0,-$ArmThickness]) cylinder(h=height-$ArmThickness, d1=max_d, d2=min_d, $fn=360);        
    }    
}

// hollow body
module hollowBody (max_d, height, bearing_h) {
    ncuts=$NumArms;
    cut_h=height-2*(bearing_h+3);
    cut_w=(max_d/2)*sin($Pi/ncuts);
    cut_l=max_d/2;
    cut_angle=360/ncuts;
    
    for ( ncut = [1:ncuts] ) {
        translate ([0, 0, height/2]) rotate(a=[0,0,cut_angle/2 + cut_angle*ncut]) { 
            translate([0, cut_l/2, 0]) cube([cut_w, cut_l, cut_h], center=true);
        }
    }
}


// hollow arm
module arm (diameter, length, height) {
    cube_l=length - diameter;
    
    difference () {
        translate ([0, diameter/2, 0]) {
            cylinder(h=height, d=diameter);
            translate([0, cube_l/2, height/2]) cube([diameter, cube_l, height], center=true);
            translate([0, length-diameter, 0]) cylinder(h=height, d=diameter, height);
        }
    
        h2=diameter/2;
        dia2=diameter-h2;
        len2=length-h2;
        cube_l2=len2-dia2;
        translate ([0, dia2/2+h2/2, 0]) {
            cylinder(h=height, d=dia2);
            translate([0, cube_l2/2, height/2]) cube([dia2, cube_l2, height], center=true);
            translate([0, len2-dia2, 0]) cylinder(h=height, d=dia2, height);
        }    
    }
}

module arms (diameter, length, height) {
    $ArmAngle=360/$NumArms;
    arm (diameter, length, height);
    for ( NArm = [1:$NumArms-1] ) rotate(a=[0,0,$ArmAngle*NArm]) { arm (diameter, length, height); }
}

// inverted mold to make model a cone.
module mold (min_d, max_d, height) {
    translate([0,0,$ArmThickness]) difference() {
        cylinder(h=height, d=max_d);
        cylinder(h=height-$ArmThickness, d1=max_d, d2=min_d, $fn=360);
    }
}


difference () {
    // center body
    body ($MinD, $MaxD, $H);
    
    // hollow body
    if ($BodyType == 2) hollowBody ($MinD, $H, $BearingH);
    
    // bottom bearing
    bearing($BearingD, $BearingH);
    
    // top bearing
    translate ([0,0,$H+0.1]) rotate(a=[0,180,0])  bearing($BearingD, $BearingH);

    // rod
    cylinder(h=$H, d=$RodD);

    // make mold just a little bigger to ensure it doesn't leave a slim wall    
    mold($MinD, $MaxD+2, $H);
}

