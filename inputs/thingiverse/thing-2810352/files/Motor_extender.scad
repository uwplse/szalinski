// ------------------------------ CONFIGURATION ------------------------------
//motor dimension
motor_diameter = 28;
plate_height = 9;

//center hole
hole_diameter = 11;

//motor cable connectors
connector_height = 8;
connector_width = 4;

// ------------------------------ CALCULATIONS ------------------------------

plate_radius = motor_diameter/2;
hole_radius = hole_diameter/2;

// ------------------------------ DRAWING ------------------------------
difference(){
    //main plate
    cylinder($fn = 50, plate_height, plate_radius, plate_radius, true);
    //center hole
    cylinder($fn = 50, plate_height+2, hole_radius, hole_radius, true);
    //cable connectors
    translate([plate_radius-connector_width/2, 0, 0]){
        cube([connector_width, connector_height, plate_height+2], true);
    }
        translate([-plate_radius+connector_width/2, 0, 0]){
        cube([connector_width, connector_height, plate_height+2], true);
    }
    //air ventilation holes
    difference(){
        cylinder($fn = 50, plate_height+2, plate_radius-connector_width-1, plate_radius-connector_width-1, true);
        cylinder($fn = 50, plate_height+2, hole_radius+1, hole_radius+1, true);
    }
}

//cross
difference(){
    cube([2*(plate_radius-connector_width)-1, hole_radius, plate_height], true);
    //center hole
    cylinder($fn = 50, plate_height+2, hole_radius, hole_radius, true);
}
difference(){
    cube([hole_radius, 2*(plate_radius-connector_width)-1, plate_height], true);
    //center hole
    cylinder($fn = 50, plate_height+2, hole_radius, hole_radius, true);
}

