clamping_block_height = 38.2;
clamping_block_width = 10.54;
clamping_block_length = 10.54;
clamping_corner_radius = 2.5;
clamping_screw_diameter = 3.3;
clamping_screw_pos_front = 5.53;
clamping_screw_gap_front = 5.88;

bottom_block_width = 2;
bottom_block_length = clamping_block_length;
bottom_block_height = clamping_block_height;
bottom_block_gap_thickness = 2;

connector_plate_length = 4;
connector_plate_width = clamping_block_width + bottom_block_gap_thickness + bottom_block_width;
connector_plate_height = clamping_block_height;

module clampingBlock() {
    // clamp
    difference() {
        translate([0,clamping_block_length-0.001,0]) rotate([90]) linear_extrude(height=clamping_block_length) {
        translate([clamping_corner_radius,clamping_corner_radius]) offset(r=clamping_corner_radius, $fn=40) square([clamping_block_width-2*clamping_corner_radius,clamping_block_height-2*clamping_corner_radius]);
        square([clamping_block_width-clamping_corner_radius,clamping_block_height]);
        }
        // screw hole
        translate([clamping_block_width-clamping_screw_gap_front,clamping_screw_pos_front,0]) cylinder(d=clamping_screw_diameter,h=clamping_block_height, $fn=40);
    }
    
    // bottom block
    translate([clamping_block_width+bottom_block_gap_thickness,0,0]) cube([bottom_block_width,bottom_block_length,bottom_block_height]);
    
    // connector_plate
    translate([0,-connector_plate_length,0]) cube([connector_plate_width,connector_plate_length,connector_plate_height]);
}    

blower_connector_length = 61.5;
blower_connector_thickness = 4;
blower_connector_width = 9;
blower_connector_angle_mount = 45;
blower_connector_angle_airflow = 30;
blower_connector_screw_diameter = 3.1;
blower_connector_screw_distance = 58.18;
blower_connector_screw_pos_right = 2;
blower_connector_pos_bottom = 12;


blower_plate_1_b = blower_connector_width*tan(blower_connector_angle_mount);
blower_plate_1_height = sqrt(pow(blower_plate_1_b,2) + pow(blower_connector_width,2));
blower_plate_1_width = sqrt(pow(blower_connector_width,2) - pow(blower_plate_1_height/2,2));
echo("blower_plate_1_height: ",blower_plate_1_height);
echo("blower_plate_1_width: ",blower_plate_1_width);

blower_plate_2_a = blower_connector_thickness*tan(blower_connector_angle_airflow);
blower_plate_2_length = sqrt(pow(blower_plate_2_a,2) + pow(blower_connector_thickness,2));
blower_plate_2_width =  sqrt(pow(blower_connector_thickness,2) - pow((blower_connector_thickness*cos(blower_connector_angle_airflow)),2));

echo("blower_plate_2_a: ",blower_plate_2_a);
echo("blower_plate_2_length: ",blower_plate_2_length);
echo("blower_plate_2_width: ",blower_plate_2_width);

module blowerScrewHoles() {
    translate([blower_plate_1_width,0,blower_connector_pos_bottom]) rotate([0,360-blower_connector_angle_mount,0])   {
            translate([blower_connector_length-blower_connector_screw_diameter/2-blower_connector_screw_pos_right,0,blower_connector_width/2]) rotate([270,0,0]) cylinder(d=blower_connector_screw_diameter,h=blower_connector_thickness+0.01, $fn=40);
        translate([blower_connector_length-blower_connector_screw_diameter/2-blower_connector_screw_pos_right-blower_connector_screw_distance,0,blower_connector_width/2]) rotate([270,0,0]) cylinder(d=blower_connector_screw_diameter,h=blower_connector_thickness+0.01, $fn=40);
    }
}    

module blowerMountPlate() {
    cube([blower_connector_length, blower_connector_thickness, blower_connector_width]);
}    

module blowerConnector() {
    translate([blower_plate_2_width,0,0]) {
        rotate([0,0,blower_connector_angle_airflow]) {
            difference() {
            union() {
            translate([blower_plate_1_width,0,blower_connector_pos_bottom]) rotate([0,360-blower_connector_angle_mount,0])   blowerMountPlate();
            cube([blower_plate_1_width,blower_connector_thickness,blower_plate_1_height+blower_connector_pos_bottom]);
            }
            blowerScrewHoles();
            }
        }
        translate([-blower_plate_2_width,0,0]) cube([blower_plate_2_width,blower_plate_2_length,blower_plate_1_height+blower_connector_pos_bottom]);
    }    
}   


module cornerEnforcement(height, radius) {
    difference() {
        cube([radius,radius,height]);
        translate([radius+0.001,radius+0.001,0]) cylinder(d=2*radius, h=height, $fn=40);
    }
}    

translate([connector_plate_width,-connector_plate_length,0]) blowerConnector();

clampingBlock();