
// The Bottom Distance in X Direction for the Mount (see sketch)
TRIPOD_MOUNT_BOTTOM_DISTANCE_X = 44;
// The Bottom Distance in Y Direction for the Mount (see sketch)
TRIPOD_MOUNT_BOTTOM_DISTANCE_Y = 44;
// The Top Distance in X Direction for the Mount (see sketch)
TRIPOD_MOUNT_TOP_DISTANCE_X = 44;
// The Top Distance in Y Direction for the Mount (see sketch)
TRIPOD_MOUNT_TOP_DISTANCE_Y = 35;
// The Height of the Mount element (see sketch)
TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE = 9;

// The diameter of the central gear supporting structure.
MOUNT_DISC_DIA = 100;
// The height of the central gear supporting structure.
MOUNT_DISC_HEIGTH = 4;

//Choose custom or preset
presetValues = 3; // [1:Custom, 2:MindfabsAndoerTripod, 3:RolleiC50i]

/* [Hidden] */

//Choose an additional support for the mount disc
MOUNT_DISC_SUPPORT = 0; // use it when you know what you are doing :)

$main=0;
$fn=200;

ID_TRIPOD_MOUNT_BOTTOM_DISTANCE_X = 0;
ID_TRIPOD_MOUNT_BOTTOM_DISTANCE_Y = 1;
ID_TRIPOD_MOUNT_TOP_DISTANCE_X = 2;
ID_TRIPOD_MOUNT_TOP_DISTANCE_Y = 3;
ID_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE = 4;
ID_MOUNT_DISC_DIA = 5;
ID_MOUNT_DISC_HEIGTH = 6;
ID_MOUNT_DISC_SUPPORT = 7;

customConfig = [
    [ID_TRIPOD_MOUNT_BOTTOM_DISTANCE_X, TRIPOD_MOUNT_BOTTOM_DISTANCE_X ],
    [ID_TRIPOD_MOUNT_BOTTOM_DISTANCE_Y, TRIPOD_MOUNT_BOTTOM_DISTANCE_Y ],
    [ID_TRIPOD_MOUNT_TOP_DISTANCE_X, TRIPOD_MOUNT_TOP_DISTANCE_X],
    [ID_TRIPOD_MOUNT_TOP_DISTANCE_Y, TRIPOD_MOUNT_TOP_DISTANCE_Y],
    [ID_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE, TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE],
    [ID_MOUNT_DISC_DIA, MOUNT_DISC_DIA],
    [ID_MOUNT_DISC_HEIGTH, MOUNT_DISC_HEIGTH],
    [ID_MOUNT_DISC_SUPPORT, MOUNT_DISC_SUPPORT]
];

andoerConfig = [
    [ID_TRIPOD_MOUNT_BOTTOM_DISTANCE_X, 95 ],
    [ID_TRIPOD_MOUNT_BOTTOM_DISTANCE_Y, 50 ],
    [ID_TRIPOD_MOUNT_TOP_DISTANCE_X, 95 ],
    [ID_TRIPOD_MOUNT_TOP_DISTANCE_Y, 40 ],
    [ID_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE, 11 ],
    [ID_MOUNT_DISC_DIA, 102 ],
    [ID_MOUNT_DISC_HEIGTH, 6 ],
    [ID_MOUNT_DISC_SUPPORT, 4 ]
];

rolleic50iConfig = [
    [ID_TRIPOD_MOUNT_BOTTOM_DISTANCE_X, 50 ],
    [ID_TRIPOD_MOUNT_BOTTOM_DISTANCE_Y, 38 ],
    [ID_TRIPOD_MOUNT_TOP_DISTANCE_X, 50 ],
    [ID_TRIPOD_MOUNT_TOP_DISTANCE_Y, 30 ],
    [ID_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE, 7 ],
    [ID_MOUNT_DISC_DIA, 102 ],
    [ID_MOUNT_DISC_HEIGTH, 4 ],
    [ID_MOUNT_DISC_SUPPORT, 0 ]
];

module PanobotMounts(config = customConfig) {
    
    var_TRIPOD_MOUNT_BOTTOM_DISTANCE_X = lookup(ID_TRIPOD_MOUNT_BOTTOM_DISTANCE_X, config);
    var_TRIPOD_MOUNT_BOTTOM_DISTANCE_Y = lookup(
      ID_TRIPOD_MOUNT_BOTTOM_DISTANCE_Y,config);
    var_TRIPOD_MOUNT_TOP_DISTANCE_X = lookup(
      ID_TRIPOD_MOUNT_TOP_DISTANCE_X, config);
    var_TRIPOD_MOUNT_TOP_DISTANCE_Y = lookup(
      ID_TRIPOD_MOUNT_TOP_DISTANCE_Y, config);
    var_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE = lookup(
      ID_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE, config);
    var_MOUNT_DISC_DIA = lookup(
      ID_MOUNT_DISC_DIA, config);
    var_MOUNT_DISC_HEIGTH = lookup(
      ID_MOUNT_DISC_HEIGTH, config);
    var_MOUNT_DISC_SUPPORT = lookup(
      ID_MOUNT_DISC_SUPPORT, config);
    
    //+-25mm, 4mm mount screw distance
    var_MOUNT_SCREW_DISTANCE = 50;
    var_MOUNT_SCREW_DIA = 4;
    var_MOUNT_SCREW_SPACING = 10;
    var_MOUNT_SCREW_HEAD_HEIGTH = 5;
    
    var_MOUNT_SCREW_LENGTH = 100;
    
    var_MOUNT_DISC_SUPPORT_DISTANCE = 25;
    
    small_height = 0.0000000000001;
    
    module tools() {
        for(i=[-1,+1])translate([i*var_MOUNT_SCREW_DISTANCE/2,0,0])cylinder(d=var_MOUNT_SCREW_DIA,h=var_MOUNT_SCREW_LENGTH,center=true);
        for(i=[-1,+1])translate([i*var_MOUNT_SCREW_DISTANCE/2,0,var_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE/2+var_MOUNT_SCREW_HEAD_HEIGTH/2])cylinder(d=var_MOUNT_SCREW_SPACING,h=var_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE+var_MOUNT_SCREW_HEAD_HEIGTH+small_height,center=true);
        cylinder(d=20,h=var_MOUNT_SCREW_LENGTH,center=true);    
    }
    
    module assembly() {
        union() {
            color("green")hull() {
                cube([var_TRIPOD_MOUNT_BOTTOM_DISTANCE_X,var_TRIPOD_MOUNT_BOTTOM_DISTANCE_Y,small_height],center=true);
                translate([0,0,var_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE])cube([var_TRIPOD_MOUNT_TOP_DISTANCE_X,var_TRIPOD_MOUNT_TOP_DISTANCE_Y,small_height],center=true);
            }
            hull() {
                translate([0,0,var_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE])cube([var_TRIPOD_MOUNT_TOP_DISTANCE_X,var_TRIPOD_MOUNT_TOP_DISTANCE_Y,small_height],center=true);
                translate([0,0,var_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE+var_MOUNT_SCREW_HEAD_HEIGTH])cube([var_TRIPOD_MOUNT_TOP_DISTANCE_X,var_TRIPOD_MOUNT_TOP_DISTANCE_Y,small_height],center=true);
            }
            if (var_MOUNT_DISC_SUPPORT>0) {
                //add support to the sides of the mount, to make it more stable
                for(x=[-1,+1],y=[-1,+1])translate([x*var_MOUNT_DISC_SUPPORT_DISTANCE,y*var_TRIPOD_MOUNT_TOP_DISTANCE_Y/2,var_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE+var_MOUNT_SCREW_HEAD_HEIGTH-var_MOUNT_SCREW_HEAD_HEIGTH/2-var_MOUNT_DISC_SUPPORT/2])cylinder(d=20,h=var_MOUNT_DISC_SUPPORT + var_MOUNT_SCREW_HEAD_HEIGTH,center=true);
            }
            translate([0,0,var_TRIPOD_MOUNT_BOTTOM_TOP_DISTANCE + var_MOUNT_SCREW_HEAD_HEIGTH + var_MOUNT_DISC_HEIGTH/2-0.2])minkowski() {
                cylinder(d=var_MOUNT_DISC_DIA,h=small_height,center=true);
                sphere(d=var_MOUNT_DISC_HEIGTH,center=true);
            }
        }
    }
    
    difference() {
        assembly();
        #tools();
    }
}

if ($main!=1) {
    if (presetValues == 1) {
        PanobotMounts(customConfig);
    } else if (presetValues == 2) {
        PanobotMounts(andoerConfig);
    } else if (presetValues == 3) {
        PanobotMounts(rolleic50iConfig);
    }
}