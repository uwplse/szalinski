/*
    Author: Kevin Lutzer
    Date Created: January 16 2018
    Description: A raspberry pi zero case. This file contains the meta information to be used with Makerbot/Thingiverse Customizer. ALL MEASUREMENTS ARE IN MILIMETERS
*/

/////////////////////////////////////////////////// Parameters /////////////////////////////////////////////////


/* [Case] */
//Is to select whether or not you want the top part of the case to have a cutout for header. It is recommend to not select this if you plan on using a fan mount. 
use_header = "no"; //[yes, no]
//Is to select whether or not you want the top side of the case to have vents on the side. The vents will be on the same side as the cutouts for the hdmi/usb ports on the bottom part of the case.
use_vents_on_the_side_of_the_top_case = "no"; //[yes, no]
//Is to select whether or not you want the bottom part of the case to have vents underneath the spot the raspberry pi will sit.
use_bottom_vents = "no"; //[yes, no]
//Is to slect whether or not you want some panel mounting tabs on the bottom part of the case.
use_panel_mounts = "yes"; //[yes, no]
//Is the part of the case to show in the customizer viewer and make an stl file from.
side_to_show = "both"; //[both, top, bottom]
//Is the user selected heat management for the top side of the case. Note that it is recommended to use atleast "vents". If "fan" is selected you can adjust the parameters in the fan section to match your fan specs. Note that the defaults are for the pi-fan from adafruit. If you want to mount the fan above the case you will have to drill a hole in the top of the case where you will pass the fan connector through.
case_top_heat_management = "vents"; //[none, fan, vents]
//Is the tolerance of the header width and length. This number will effect the tightness of the header in the top part case.
header_tolerance = 1; //[0, 0.5, 1, 1.5, 2]
//Is the tolerance of the raspberry pi pcb width and length. This number will effect the tightness of the raspberry pi pcb in the case.
pcb_tolerance = 1; //[0, 0.5, 1, 1.5, 2]
//Is the diameter of the standoffs used to secure the raspberry pi to the case.
pcb_standoff_radius = 2.5;
//Is the diameter of the srew hole in the standoffs that are used to secure the raspberry pi to the case.
pcb_standoff_screw_radius = 0.75;
//Is the width of the cavity added for extra space to store electronics and wires. It effects the total width of the case. This cavity is added to the header side of the case.
case_cavity_width = 0;
//Is the thickness of the walls of the case. This value is used for both the top and bottom parts of the case.
case_wall_thickness = 2;
//Is the height of the top portion of the case. This value represents the internal height of the top portion of the case. For example, if you want to add a perma proto hat from adafruit to your raspberry pi project set this number to 20 and you will have enough room for it in your case! If you want a minimalist case you could set this value to zero to have a flat top. 
case_top_height = 0;
//Is the radius of the standoffs used to secure the two parts of the case together.
case_standoff_radius = 3;
//Is the radius of the screw used to secure the two parts of the case together.
case_hole_radius = 1.5;
//Is the radius of the screw used to mount the case onto some panel. 
case_mount_radius = 3;
//Is the amount of segments used to make the vents for the bottom and top of the case. 
vent_segment_amount = 8;


/* [Fan] */
// Is the size of the fan. Assuming your fan is square, it represents the length between two parallel sides. 
fan_size = 30;
// Is the X-Y offset of the mounting holes reference to the nearest sides
fan_hole_spacing_from_corner = 3;
// Is the radius of the mounting holes for the fan
fan_hole_radius = 1.8;

/* [Hidden] */

//Length of the raspberry pi
pcb_length = 65;
//Width of the raspberry pi
pcb_width = 30;
//Length of the raspberry pi accounting for tolerances
pcb_length_with_tolerance = pcb_length + pcb_tolerance;
//Width of the raspberry pi accounting for tolerances
pcb_width_with_tolerance = pcb_width + pcb_tolerance;
//Radius of the four corners of the raspberry pi pcb
pcb_corner_radius = 3;
//Thickness of the raspberry pi pcb
pcb_thickness = 1.5;
//Height of the standoffs used to secure the raspberry pi to the case
pcb_standoff_height = 3;
//X-Y position of the center of the standoffs to the sides of the raspberry pi pcb
standoff_spacing_from_corner = 4;
//Width of the raspiberry pi (Y axis)
case_width = 2*case_wall_thickness + pcb_width_with_tolerance;
//Length of the raspberry pi (X axis)
case_length = 2*case_wall_thickness + pcb_length_with_tolerance;
//Length of the hdmi mini port on the raspberry pi (X axis)
hdmi_port_length = 12.5;
//Height of the hdmi mini port (Z axis)
hdmi_port_height = 3.5;
//X-Position of the center of the hdmi mini port reference to the edge of the pcb 
hdmi_port_offset = 12.4;
//X-Position of the center of the usb port closest to the htmi port, reference to the center of the hdmi port
usb_port_1_offset = 41.4;
//X-Position of the center of second usb port closest reference to the center of the hdmi port
usb_port_2_offset = 54;
//Length of the usb ports
usb_port_length = 9;
//Hight of the usb ports (Z axis)
usb_port_height = 3;
//Width of the raspberry pi camera connector
camera_zif_width = 20;
//Width of the sd card
sd_width = 12;
//Y-Position of the center of the SD card reference to the bottom left edge
sd_offset = 16.9;
//Y Dimension of the header
header_width = 5;
//X Dimension of the header
header_length = 51;
//Y position of the center of the header from the top side of the PCB
header_width_offset = 3.5;
//X position of the center of the header
header_length_offset = 29;
//Length of the header accounting for tolerances
header_length_with_tolerance = header_length + header_tolerance;
//Width of the header accounting for tolerances
header_width_with_tolerance = header_width + header_tolerance;
//The width of space between the top of the header and the edge of the board (Y axis)
header_spacing = header_width_with_tolerance/2 - header_width_offset; 
//The height of the bottom of the raspberry pi case (Z axis)
case_bottom_height = pcb_thickness + case_wall_thickness + pcb_standoff_height + hdmi_port_height;
//The width of the vents for the bottom portion of the case
vent_bottom_width = case_width - 6*pcb_standoff_radius;
//The width of the vents for the side of the top portion of the case
vent_top_side_width = (case_top_height - 4*case_wall_thickness);
//The width of the vents for the top portion of the case
vent_top_width = (case_width - 4*case_wall_thickness);
//The width of the vents for the top portion of the case assuming a spot for the header will be cutout as well. 
vent_top_width_for_header = vent_top_width + 10*header_spacing - header_width_with_tolerance;
//The total length of the vent. 
vent_length = case_length - 8*pcb_standoff_radius;
//The segment length of the vent. This is determined based on the amount of segments specified by the user
vent_segment_length = vent_length/vent_segment_amount;


/////////////////////////////////////////////////// Modules //////////////////////////////////////////////////

// represents the profile of the top and bottom surfaces of the case
module case_profile() {
  rounded_corner_rectangle(case_length, case_width, case_cavity_width, case_standoff_radius, 0);
}

// the profile of the case wall which is the difference between the base and case profiles
module case_wall_profile() {
  difference() {
    case_profile();
    // represents the profile of the raspbery pi pcb
    rounded_corner_rectangle(pcb_length_with_tolerance, pcb_width_with_tolerance, case_cavity_width, pcb_corner_radius, 0 );
  }
}

// The extruded case wall profile
module case_wall(height) {
  linear_extrude(height=height) {
    union() {
      case_wall_profile();
      mounting_holes(case_length, case_width, case_standoff_radius, case_hole_radius, case_cavity_width);
    }
  }
}

// The profile of the tab mounts used to secure the bottom part of the case to a panel. 
module case_mounts_profile() {
  // right mount
  translate([case_length/2, - 2*case_mount_radius + case_cavity_width/2, 0]) {
    difference() {
      square([4*case_mount_radius, 4*case_mount_radius]);
      translate([2*case_mount_radius, 2*case_mount_radius]) circle(r=case_mount_radius, $fn=100);
    }
  }
  // left mount
  translate([ -case_length/2 -4*case_mount_radius, - 2*case_mount_radius + case_cavity_width/2, 0]) {
    difference() {
      square([4*case_mount_radius, 4*case_mount_radius]);
      translate([2*case_mount_radius, 2*case_mount_radius]) circle(r=case_mount_radius, $fn=100);
    }
  }
}

// The full bottom portion of the case including the cutouts for ventalation and peripherals
module case_bottom() {
  difference() {
    union() {
        // The wall withitout the bottom mounting holes
        case_wall(case_bottom_height);
        
        // Bottom of the case / The base profile
        linear_extrude(height=case_wall_thickness) {
          case_profile();
        }
        
        // Standoffs to hold the rapsberry pi from the base
        linear_extrude(height=pcb_standoff_height + case_wall_thickness) {
          // represents the standoffs used to secure the raspberry pi pcb to the bottom of the case
          mounting_holes(pcb_length_with_tolerance - standoff_spacing_from_corner * 2, pcb_width_with_tolerance - standoff_spacing_from_corner * 2, pcb_standoff_radius, pcb_standoff_screw_radius, 0);
        }

        linear_extrude(height=pcb_standoff_height) {
          if(use_panel_mounts == "yes") {
            case_mounts_profile();
          }
        }
    }
    
    // Peripherals and other cutouts. 
    peripherals_case_bottom_cutout();
    if (use_bottom_vents == "yes") {
      vent_cutout(vent_bottom_width);
    }
 
  }
}

// The full top portion of the case including the cutouts for ventalation and peripherals
module case_top() {
  difference() {
    //The frame of the top portion of the case including the standoffs
    union() {
      linear_extrude(height=case_wall_thickness){
        case_profile();
      }
      case_wall(case_wall_thickness + case_top_height);
    }

    //Vent cutout if the user has selected it
    if (case_top_heat_management == "vents") {
      // Size and placement of the vent cutouts is dependant on if a header is present
      if (use_header == "yes") {
        // center vent in center of the case accounting for the cavity width
        translate([0,case_cavity_width/2 - header_width_with_tolerance + 3*header_spacing + case_wall_thickness,0]){vent_cutout(vent_top_width_for_header);}
      } else {
        // center vent in center of the case accounting for the cavity width
        translate([0,case_cavity_width/2,0]){vent_cutout(vent_top_width);}
      }
      
    }

    //Fan cutout if the user has selected it
    if (case_top_heat_management == "fan") {
      // center fant in center of the case accounting for the cavity width
      translate([0,case_cavity_width/2,0]){fan_cutout();}
    }

    if (use_header == "yes") {
      // Cutout for the header used to connect different "hats"
      header_cutout();
    }
    

    //Have side vent cutouts by default if they can fit
    if (use_vents_on_the_side_of_the_top_case == "yes") {
      translate([0,-pcb_width_with_tolerance/2, (case_top_height + case_wall_thickness)/2]){rotate([90,0,0]){vent_cutout(vent_top_side_width);}}
    }
  }
}

// The profile of an individual vent segment used for air flow in the case
module vent_segment_profie(width = 0) {
  translate([0,width/2,0]){circle(d=vent_segment_length/2, $fn=100);}
  translate([-vent_segment_length/4,-width/2,0]){square([vent_segment_length/2,width]);}
  translate([0,-width/2,0]){circle(d=vent_segment_length/2, $fn=100);}
}

// The base vent cutout. The length will always be constant, but the width can be passed in to adjust sizing for the portions of the case this vent cutout will be used on 
module vent_cutout(width = 0) {
    linear_extrude(height=case_wall_thickness) {
    for(i = [0:vent_segment_amount-1]) {
      translate([i*vent_segment_length - vent_length/2 + vent_segment_length/2, 0, 0]) {
        vent_segment_profie(width);
      }
    }
  }
}

// cutout for the usb, hdmi, camera, sd card slots
module peripherals_case_bottom_cutout() {
  translate([0, 0, case_bottom_height-hdmi_port_height]) {
    union() {
      
      // USB ports
      translate([pcb_tolerance/2,0,-1]){
        linear_extrude(height=hdmi_port_height + 1) {
          translate([usb_port_1_offset - usb_port_length/2 -pcb_length_with_tolerance/2, -case_width/2, 0]) { square([usb_port_length, case_wall_thickness]); }
          translate([usb_port_2_offset - usb_port_length/2 -pcb_length_with_tolerance/2, -case_width/2, 0]) { square([usb_port_length, case_wall_thickness]); }
        }
      }
      
      // Zif (Camera) connector and SD card connector slots
      linear_extrude(height=hdmi_port_height) { 
        translate([hdmi_port_offset - hdmi_port_length/2 -pcb_length/2, -case_width/2, 0]) { square([hdmi_port_length, case_wall_thickness]); }
        translate([case_length/2 - case_wall_thickness, - camera_zif_width/2]) { square([case_wall_thickness, camera_zif_width]); }
        translate([-case_length/2, -pcb_width/2 + sd_offset - sd_width/2, 0]) { square([case_wall_thickness, sd_width]); }
      }
    } 
  }
}

// Cutout for the header used to mount hats and other accessories.
module header_cutout() {
  linear_extrude(height = case_wall_thickness) {
    translate([ -header_length_with_tolerance/2, -header_width_with_tolerance/2 + pcb_width_with_tolerance/2 - header_width_offset, 0]){square([header_length_with_tolerance, header_width_with_tolerance]);}
  }
}

// extruded fan profile used for the fan cutout on the top of the case
module fan_cutout() {
    linear_extrude(height=case_wall_thickness) {
        fan_profile();
    }
}

// simple fan profile 
module fan_profile() {
  // Get the negative of the structure 
  difference() {
    // Base fan profile
    rounded_corner_rectangle(fan_size, fan_size, 0, fan_hole_radius, 0 );
    union() {
     difference() {
     // Base fan profile
     rounded_corner_rectangle(fan_size, fan_size, 0, fan_hole_radius, 0 );
      
      // Mounting Holes
    mounting_holes(fan_size - fan_hole_spacing_from_corner*2, fan_size - fan_hole_spacing_from_corner*2, fan_hole_radius, 0, 0);
      
      // Concentric circles for fan grill
      donut(12, 10);
      donut(8, 6);
      donut(4, 2); 
     }
   
     // Cross for extra stability
     translate([0,0,0]) {
        translate([-fan_size/2, -1]){square([fan_size, 2]);}
        translate([-1, -fan_size/2]){square([2, fan_size]);}
     }
     
   }
 }
}

// Creates a donut 
module donut(outer_radius, inner_radius) {
  difference() {
    circle(r=outer_radius, $fn=100);
    circle(r=inner_radius, $fn=100);
  }
}

// Used for making all the 2D profiles with rounded corners
module rounded_corner_rectangle(length = 0, width = 0, top_offset = 0, corner_radius = 0, corner_spacing = 0 ) {
  hull()
  {
   // top left
   translate([-length/2 + corner_radius, width/2 - corner_radius + top_offset, 0]) { donut(corner_radius, 0);}

   // bottom left
   translate([-length/2 + corner_radius, -width/2 + corner_radius, 0]) { donut(corner_radius, 0);}
   
   // top right
   translate([length/2 - corner_radius, width/2 - corner_radius + top_offset, 0]) { donut(corner_radius, 0);}
   
   // bottom right
   translate([length/2 - corner_radius, corner_radius -width/2, 0]) { donut(corner_radius, 0);}
  }
}

// Used for creating the 2D representation of a 4x4 standoff set
module mounting_holes(grid_length=0, grid_width=0, standoff_radius=0, screw_radius=0, top_offset=0) {
   // top left
   translate([-grid_length/2, grid_width/2 + top_offset, 0]) { donut(standoff_radius, screw_radius);}

   // bottom left
   translate([-grid_length/2, -grid_width/2, 0]) { donut(standoff_radius, screw_radius);}
   
   // top right
   translate([grid_length/2, grid_width/2 + top_offset, 0]) { donut(standoff_radius, screw_radius);}
   
   // bottom right
   translate([grid_length/2, -grid_width/2, 0]) { donut(standoff_radius, screw_radius);}
} 


/////////////////////////////////////////////////// Prototypes /////////////////////////////////////////////////

if (side_to_show == "both") {
  translate([0,case_width/2 + case_cavity_width + case_standoff_radius*4, 0]){case_top();}
  translate([0,-case_width/2, 0]){case_bottom();}
}

if (side_to_show == "top") {
  case_top();
}

if (side_to_show == "bottom") {
  case_bottom();
}
