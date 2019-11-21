/*
Customizable Center Bed Support, by ggroloff 9.10.2018

Use this to generate a center bed support model of any height which mounts between the y-carriage and bed, using the mount points of the y-belt holder.

You can then adjust the height at the four corners of the bed to raise or lower the center support relative to the corners.

Works well with a hard foam spacer to insulate the part from the heat if using a heated bed. Adjust height accordingly.

CAUTION: Using this will fix the center of your bed in place, so a head crash will be much worse. Use at your own risk.

Example values for my Anet A8 stock y carriage, using a 12.5 mm thick, 30 mm x 30 mm hard foam spacer.

** The foam covered a thermistor on my heat bed, however I didn't notice any heating issues after installing.
*/

//All units in mm

//sets total height of support
height=13;

//sets thickness of mount plate
mount_thickness=3;

//sets length of mount plate on x-axis
mount_plate_x = 22;

//sets length of mount plate on y-axis
mount_plate_y = 30;

//sets diameter of mount plate screws (oversize if you don't want to take your y belt off)
screw_diameter=4;

//sets distance between mount screw centers on x-axis
x_mount_distance = 12;

//sets distance between mount screw centers on y-axis
y_mount_distance = 20;

//sets support post base diameter (watch the overhang)
base_diameter = 11;

//sets support post top diameter
top_diameter = 30;





/*[Hidden]*/
//code starts here

//defines mount points
module mount_points() {
    translate ([-x_mount_distance/2,-y_mount_distance/2,0]) cylinder(d=screw_diameter, h=mount_thickness+.1, center=true, $fn=100);
    translate ([-x_mount_distance/2,y_mount_distance/2,0]) cylinder(d=screw_diameter, h=mount_thickness+.1, center=true, $fn=100);
    translate ([x_mount_distance/2,-y_mount_distance/2,0]) cylinder(d=screw_diameter, h=mount_thickness+.1, center=true, $fn=100);
    translate ([x_mount_distance/2,y_mount_distance/2,0]) cylinder(d=screw_diameter, h=mount_thickness+.1, center=true, $fn=100);
};
//mount_points();

//defines mount plate shape
module mount_plate() {
    cube ([mount_plate_x, mount_plate_y, mount_thickness], center=true);
};
//mount_plate();
 
//defines support pillar shape
module support_pillar() {
    translate([0,0, mount_thickness/2]) cylinder (r1=base_diameter/2, r2=top_diameter/2, h=height-mount_thickness, $fn=100);
};
//support_pillar();

//defines final center bed support shape
module center_bed_support() {
union(){
support_pillar(); //create support pillar
difference(){
    mount_plate(); //create mount plate
    mount_points(); //drill out mount holes
    };
};
};
center_bed_support(); //renders center bed support model