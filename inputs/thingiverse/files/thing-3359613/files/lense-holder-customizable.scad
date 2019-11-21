$LENSE_DIAMETER         = 11;
$LENSE_RIM_THICKNESS    = 1.8;
$FRAME_RIM_HEIGHT       = 1.2;
$FRAME_RIM_WIDTH        = 1.2;
$FOOT_HEIGHT            = 2;
$FOOT_DEPTH             = 10;
$HEIGHT                 = 30;


$LENSE_RADIUS           = $LENSE_DIAMETER/2;
$FRAME_THICKNESS        = 2 * $FRAME_RIM_WIDTH + $LENSE_RIM_THICKNESS;
$FRAME_RADIUS           = $LENSE_RADIUS + 1;
$FOOT                   = [2 * $FRAME_RADIUS, $FOOT_HEIGHT, $FOOT_DEPTH];
$STAND_LENGTH           = $HEIGHT - $FOOT[1] - $LENSE_RADIUS;


module lense_cutout(){
    cylinder($LENSE_RIM_THICKNESS/2, $LENSE_RADIUS, $LENSE_RADIUS - $FRAME_RIM_HEIGHT);
    translate([0,0,-$LENSE_RIM_THICKNESS/2])
        cylinder($LENSE_RIM_THICKNESS/2, $LENSE_RADIUS - $FRAME_RIM_HEIGHT, $LENSE_RADIUS);
    cylinder($FRAME_THICKNESS, $LENSE_RADIUS - $FRAME_RIM_HEIGHT, $LENSE_RADIUS - $FRAME_RIM_HEIGHT, center = true);
    translate([0,$FRAME_RADIUS / 1.5, 0])
        cube([2 * $FRAME_RADIUS, $FRAME_RADIUS, $FRAME_THICKNESS], center=true);
}

module frame(){
    cylinder($FRAME_THICKNESS, $FRAME_RADIUS, $FRAME_RADIUS, center = true);
}

module pillar(){
    translate([0, - ($STAND_LENGTH/2 + $LENSE_RADIUS), 0])
        cube([$FRAME_THICKNESS, $STAND_LENGTH, $FRAME_THICKNESS], center = true);
}

module foot(){
    //foot
    translate([0,- ($HEIGHT - $FOOT[1]/2),0])
        cube($FOOT, center = true);
}

difference(){
    hull(){
        frame();
        pillar();
    }
    lense_cutout();
}

pillar();
foot();