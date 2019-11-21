$fn = 50;

inches_to_mm = 25.4;

mounting_hole_diameter = 0.150*inches_to_mm;
mounting_tab_width = 8;

wall_thickness = 2;
box_size = 8;
shroud_height = 13;
baffle_height = 12;

cds_wire_centers = 3.4;
cds_wire_diameter = 1;

led_diameter = 5;

sensor_centers =7;

arm_width = 4;
arm_length =  50;

robot_mounting_tab_width = 12;
robot_mounting_tab_thickness = 4;

// -------------------------- parts -----------------

//color("red") color_sensor();
//color("blue") sensor_arm();
//color("green") robot_mount();

// ----------------- assembly --------------

color("red") color_sensor();
color("blue") translate([wall_thickness+box_size+wall_thickness, wall_thickness+box_size+wall_thickness+mounting_tab_width/2, (wall_thickness+shroud_height)/2]) rotate([90,0,90]) sensor_arm();
color("green") translate([wall_thickness+box_size+wall_thickness, wall_thickness+box_size+wall_thickness+mounting_tab_width/2+arm_length, (wall_thickness+shroud_height)/2]) rotate([-90,0,-90]) translate([-robot_mounting_tab_width/2, -robot_mounting_tab_width/2,-robot_mounting_tab_thickness]) robot_mount();

// ---------------------- modules -------------------

module color_sensor()
{
  // outer shell
  linear_extrude(height = wall_thickness+shroud_height) difference()
  {
    square([2*wall_thickness+wall_thickness+2*box_size, 2*wall_thickness+box_size]);
    translate([wall_thickness, wall_thickness]) square([wall_thickness+2*box_size, box_size]);
  }
  
  // bottom
  linear_extrude(height = wall_thickness) difference()
  {
    square([2*wall_thickness+wall_thickness+2*box_size, 2*wall_thickness+box_size]);
    // LED
    translate([wall_thickness+box_size+wall_thickness+box_size/2, wall_thickness+box_size/2]) circle(r = led_diameter/2);
    
    // cds photocell
    translate([wall_thickness+box_size/2, wall_thickness+box_size/2]) union()
    {
      translate([0,cds_wire_centers/2]) circle(r=cds_wire_diameter/2);
      translate([0,-cds_wire_centers/2]) circle(r=cds_wire_diameter/2);
    }
  }
  
  // baffle
  linear_extrude(height = wall_thickness+baffle_height) translate([wall_thickness+box_size, wall_thickness]) square([wall_thickness, box_size]);
  
  // mounting tab
  translate([wall_thickness+box_size, 2*wall_thickness+box_size,0]) rotate([90,0,90]) linear_extrude(height=wall_thickness) difference()
  {
    square([mounting_tab_width, wall_thickness+shroud_height]);
    translate([mounting_tab_width/2, (wall_thickness+shroud_height)/2]) circle(r=mounting_hole_diameter/2);
  }
}

module sensor_arm()
{
  linear_extrude(height = wall_thickness) difference()
  {
    union()
    {
      translate([0,-arm_width/2]) square([arm_length, arm_width]);
      circle(r= mounting_hole_diameter/2+arm_width/2);
      translate([arm_length,0,0]) circle(r= mounting_hole_diameter/2+arm_width/2);    
    }
    
    circle(r= mounting_hole_diameter/2);
    translate([arm_length,0,0]) circle(r= mounting_hole_diameter/2);
  }
}

module robot_mount()
{
  linear_extrude(height = robot_mounting_tab_thickness) difference()
  {
    square([robot_mounting_tab_width,robot_mounting_tab_width+robot_mounting_tab_thickness]);
    translate([robot_mounting_tab_width/2, robot_mounting_tab_width/2]) circle(r=mounting_hole_diameter/2);
  }
  
  translate([0,robot_mounting_tab_width,0,]) rotate([-90,0,0]) linear_extrude(height = robot_mounting_tab_thickness) translate([0,-robot_mounting_tab_width-robot_mounting_tab_thickness]) difference()
  {
    square([robot_mounting_tab_width,robot_mounting_tab_width+robot_mounting_tab_thickness]);
    translate([robot_mounting_tab_width/2, robot_mounting_tab_width/2]) circle(r=mounting_hole_diameter/2);
  }
}