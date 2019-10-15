fudge = 0.01;

//This is the S value, or the cell count of the battery
S = 4;

//This defines the number of pins for the jack.  This number is the S value or cell count of the 
//battery pack plus 1.  So a 3S battery will have 3+1 or 4 pins.
pins = S+1;

connector_wall_thickness = 0.8;
connector_base_thickness = 2;

pin_offset = 2.8;
pin_spacing = 2.5;
pin_width = 0.9;
pin_gap = pin_spacing-pin_width;

plug_width = 4.2;
plug_length = ((pins-1)*pin_spacing)+(pin_gap*2);
plug_height = 8;

connector_width = plug_width+(connector_wall_thickness*2);
connector_length = plug_length+(connector_wall_thickness*2);
connector_height = connector_base_thickness+plug_height;

start_offset_x = 1.75;
clip_edge_offset = 1.8;
clip_z_offset = 2.25;
clip_width = 2;
clip_height = plug_height-clip_z_offset;

difference() {
    //import("/home/dbemowsk/Downloads/balance_plug.STL");
    //translate([10, -fudge/2, -fudge/2]) cube([7, 7, 9]);
}


difference() {
    //Create the outer shell of the jack
    translate([start_offset_x, 0, 0]) cube([connector_length, connector_width, connector_height]);
    //Hollow out the inside of the jack for the connector
    translate([start_offset_x+connector_wall_thickness, connector_wall_thickness, connector_base_thickness]) cube([plug_length, plug_width, plug_height+fudge]);
    //Cut out the two alignment slots
    translate([start_offset_x+clip_edge_offset, -fudge/2, connector_base_thickness+clip_z_offset]) cube([clip_width, connector_wall_thickness+fudge, clip_height+fudge]);
    translate([start_offset_x+connector_length-clip_edge_offset-clip_width, -fudge/2, connector_base_thickness+clip_z_offset]) cube([clip_width, connector_wall_thickness+fudge, clip_height+fudge]);
    //Make the holes for the pins
    for(x=[0 : pins-1]) {
        translate([start_offset_x+connector_wall_thickness+pin_gap+(x*pin_spacing), connector_width/2, -fudge/2]) cube([pin_width, pin_width, 15], center=true);
    }
}
//Create the two clip catches
hull() {
    translate([start_offset_x+clip_edge_offset, 0, connector_height-connector_wall_thickness]) cube([fudge, connector_wall_thickness, connector_wall_thickness]);
    translate([start_offset_x+clip_edge_offset+0.35, 0, connector_height-(connector_wall_thickness/2)]) rotate([-90, 0, 0]) cylinder(connector_wall_thickness, d=0.5, $fn=72);
    translate([start_offset_x+clip_edge_offset, 0, connector_height-connector_wall_thickness-1]) cube([fudge, connector_wall_thickness, connector_wall_thickness]);
    translate([start_offset_x+clip_edge_offset+0.35, 0, connector_height-(connector_wall_thickness/2)-1]) rotate([-90, 0, 0]) cylinder(connector_wall_thickness, d=0.5, $fn=72);
}
hull() {
    translate([start_offset_x+connector_length-(clip_edge_offset+0.35), 0, connector_height-(connector_wall_thickness/2)]) rotate([-90, 0, 0]) cylinder(connector_wall_thickness, d=0.5, $fn=72);
    translate([start_offset_x+connector_length-clip_edge_offset, 0, connector_height-connector_wall_thickness]) cube([fudge, connector_wall_thickness, connector_wall_thickness]);
    translate([start_offset_x+connector_length-(clip_edge_offset+0.35), 0, connector_height-(connector_wall_thickness/2)-1]) rotate([-90, 0, 0]) cylinder(connector_wall_thickness, d=0.5, $fn=72);
    translate([start_offset_x+connector_length-clip_edge_offset, 0, connector_height-connector_wall_thickness-1]) cube([fudge, connector_wall_thickness, connector_wall_thickness]);
}
