$fn = 50;

inches_to_mm = 25.4;

shell_thickness = 2;
sensor_width = 75.2;
sensor_depth = 13.2;
support_thickness = 1;
peg_square = 5;


finger_thickness = 1.5;
finger_offset = 8.73;
finger_center = 9.56;
finger_length = 6.32;
finger_height = 5.2-0.4;

shell_height = 7.8;
support_height = 5.2;

// ----- sensor arm parameters
spacer_thickness = 10.7;
arm_thickness = 5;
connector_height = 24;  //34
connector_thickness = 4;
bolt_spacing = 4;
sensor_connector_depth = 10;
peg_diameter = 3.5;
arm_height = 7;  //17
arm_spacing = 12;
arm_hole_clearance = 0.5;
arm_width = 4;
arm_length = 50;
robot_extra_size = 6;
robot_thickness = 4;
screw_head_clearance = 4;
screw_center = 0.5*inches_to_mm;
screw_hole_diameter = 0.185*inches_to_mm;
arm_clearance = 4;

// for printing
//union()
{
  //sensor_holder();
  //sensor_connector();
}

//sensor_arm();

//robot_arm_connector();

//arm_spacer();


// --------------------- construct the holder ---------------------------------

sensor_holder();
sensor_connector();

color("orange") translate([shell_thickness+sensor_width/2-spacer_thickness/2,-sensor_connector_depth/2,arm_height]) rotate([90,0,-90]) sensor_arm();
color("orange") translate([shell_thickness+sensor_width/2-spacer_thickness/2,-sensor_connector_depth/2,arm_height+arm_spacing]) rotate([90,0,-90]) sensor_arm();

color("orange") translate([shell_thickness+sensor_width/2+spacer_thickness/2,-sensor_connector_depth/2,arm_height]) rotate([-90,0,-90]) sensor_arm();
color("orange") translate([shell_thickness+sensor_width/2+spacer_thickness/2,-sensor_connector_depth/2,arm_height+arm_spacing]) rotate([-90,0,-90]) sensor_arm();

color("green") translate([shell_thickness+sensor_width/2-spacer_thickness/2,-sensor_connector_depth/2-arm_length,arm_height]) rotate([0,90,0]) arm_spacer();
color("green") translate([shell_thickness+sensor_width/2-spacer_thickness/2,-sensor_connector_depth/2-arm_length,arm_height+arm_spacing]) rotate([0,90,0]) arm_spacer();



color("blue") translate([shell_thickness+sensor_width/2, -sensor_connector_depth/2-arm_length, arm_height]) rotate([-90,0,-90]) translate([-robot_extra_size-screw_center/2, -(robot_thickness+arm_width+arm_clearance+peg_diameter/2+arm_spacing), -(2*robot_thickness+2*screw_head_clearance+screw_center)/2]) union()
{
  robot_arm_connector();

  translate([2*robot_extra_size+screw_center,0, 2*robot_thickness+2*screw_head_clearance+screw_center])rotate([0,180,0]) robot_arm_connector();
}

// --------------------modules-------------------------------

module sensor_connector()
{
  difference()
  {
    // main connector body
    translate([shell_thickness+sensor_width/2-spacer_thickness/2,-sensor_connector_depth, 0]) cube([spacer_thickness,sensor_connector_depth,connector_height]);
    // left side pegs
    translate([shell_thickness+sensor_width/2-spacer_thickness/2-1,-sensor_connector_depth/2,arm_height]) rotate([0,90,0]) cylinder(r=peg_diameter/2, h=spacer_thickness+2);
    translate([shell_thickness+sensor_width/2-spacer_thickness/2-1,-sensor_connector_depth/2,arm_height+arm_spacing]) rotate([0,90,0]) cylinder(r=peg_diameter/2, h=spacer_thickness+2);
  }
}

module arm_spacer()
{
  linear_extrude(height=spacer_thickness) difference()
  {
    circle(r= peg_diameter/2+arm_hole_clearance/2+arm_width/2);
    circle(r= peg_diameter/2+arm_hole_clearance/2);
  }
}

module robot_arm_connector()
{
  difference()
  {
    union()
    {
      cube([2*robot_extra_size+screw_center, robot_thickness, robot_thickness+2*screw_head_clearance]);
      cube([2*robot_extra_size+screw_center, robot_thickness+arm_width+arm_clearance+peg_diameter+arm_spacing+peg_diameter, robot_thickness]);
    }
    
    translate([robot_extra_size, robot_thickness/2, robot_thickness+screw_head_clearance]) rotate([90,0,0]) cylinder(r=screw_hole_diameter/2, h=robot_thickness+2, center=true);
    translate([robot_extra_size+screw_center, robot_thickness/2, robot_thickness+screw_head_clearance]) rotate([90,0,0]) cylinder(r=screw_hole_diameter/2, h=robot_thickness+2, center=true);
    
      // pegs
    translate([robot_extra_size+screw_center/2, robot_thickness+arm_width+arm_clearance+peg_diameter/2, -1]) cylinder(r=peg_diameter/2, h=robot_thickness+2);
    translate([robot_extra_size+screw_center/2, robot_thickness+arm_width+arm_clearance+peg_diameter/2+arm_spacing, -1]) cylinder(r=peg_diameter/2, h=robot_thickness+2);
  }
  
  
}

module sensor_arm()
{
  linear_extrude(height = arm_thickness) difference()
  {
    union()
    {
      translate([0,-arm_width/2]) square([arm_length, arm_width]);
      circle(r= peg_diameter/2+arm_hole_clearance/2+arm_width/2);
      translate([arm_length,0,0]) circle(r= peg_diameter/2+arm_hole_clearance/2+arm_width/2);    
    }
    
    circle(r= peg_diameter/2+arm_hole_clearance/2);
    translate([arm_length,0,0]) circle(r= peg_diameter/2+arm_hole_clearance/2);
  }
}

module sensor_holder()
{
  union()
  {
    // A
    linear_extrude(height=shell_height) difference()
    {
      square([2*shell_thickness+sensor_width,2*shell_thickness+sensor_depth]);
      translate([shell_thickness, shell_thickness]) square([sensor_width, sensor_depth]);
    }

    // B
    linear_extrude(height=support_height) union()
    {
      translate([shell_thickness, shell_thickness]) square([support_thickness, sensor_depth]);
      translate([shell_thickness+sensor_width-support_thickness, shell_thickness]) square([support_thickness, sensor_depth]);
      translate([shell_thickness,shell_thickness+sensor_depth-support_thickness]) square([sensor_width, support_thickness]);
    }

    // C
    linear_extrude(height=support_height) union()
    {
      translate([shell_thickness,shell_thickness]) square([peg_square, peg_square]);
      translate([shell_thickness+sensor_width-peg_square,shell_thickness]) square([peg_square, peg_square]);
    }

    // D
    //translatecircle(r=peg_diameter/2);

    // fingers
    linear_extrude(height = finger_height) for(i = [0:6])
    {
      translate([shell_thickness-finger_thickness/2+finger_offset+i*finger_center,shell_thickness+sensor_depth-finger_length-support_thickness]) square([finger_thickness, finger_length]);
    }
  }
}