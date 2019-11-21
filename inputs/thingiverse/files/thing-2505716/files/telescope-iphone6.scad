/*
This is a quick and dirty iPhone 6 Adapter inspired by one from 
adafruit. (https://www.thingiverse.com/thing:353135).

Measurements from the Apple Case Design Guidelines.
(https://developer.apple.com/resources/cases/Case-Design-Guidelines.pdf)

I'm able to print this without supports I use a brim to stick it real good.

This work is licensed under the Creative Commons Attribution-ShareAlike 
3.0 Unported License. To view a copy of this license, visit 
http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to 
  Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

Listen to Craft Beer Radio http://craftbeerradio.com

Jeff Bearer <jeff@jeffbearer.com>
*/

walls = 1.75;

eyepiece_diameter = 34.2;         // Set this to the diameter of your telescopes eyepiece
eyepiece_radius = eyepiece_diameter / 2;
eyepiece_diameter_with_walls = eyepiece_diameter + walls * 2;
eyepeice_radius_with_walls = eyepiece_diameter_with_walls / 2;
eyepiece_collar_depth = 10.4;

phone_width = 67;                // Set this to the width of your phone
phone_thickness = 7.7;           // Set this to the thickness of your phone
phone_front_top_margin = 17;     // Set this to the width of the area from the top of the phone and the screen
phone_front_side_margin = 7.5;   // Set this to the width of the area from the side of the phone and the screen
phone_corner_radius = 10;

camera_diameter = 7.5;          // Set this to a little larger than the diameter of your camera lens
camera_x_from_left = 14.03;     // Set this to the distance of the center of the lens from the left side of the phone
camera_y_from_top = 7.2;        // Set this to the distance of the  center of the lens from the top side of the phone
camera_keepout_angle = 95;      // Set this to the keep out angle of the lens as specified by the manufacturer
camera_clearance = 0.8;         // Set this to the height that the camera extends beyond the back of the phone.


holder_height = eyepeice_radius_with_walls + camera_y_from_top - 1; 
holder_width = phone_width + walls * 2;
holder_thickness = phone_thickness + walls * 2;
holder_corner_radius = phone_corner_radius + walls;

// Calculate the Screen Cutout[ -0.87, -13.12, 6.90 ]
front_cutout_width = phone_width - phone_front_side_margin*2;
front_cutout_height = holder_height - phone_front_top_margin;
front_cutout_radius = phone_corner_radius - phone_front_side_margin;

// The holder obstructs the mute switch on the iphone 6.
// These are to add a cutout to clear the mute switch.
side_cutout_from_top = 17;
side_cutout_width = 5;
side_cutout_height = holder_height - 15;

$fn=128;
difference(){
    // Join the Phone Holder and the Eyepeice
    union(){
        holder_x_alignment = phone_corner_radius + camera_x_from_left - phone_width - walls/2;
        holder_y_alignment = phone_corner_radius-camera_y_from_top;
        translate([holder_x_alignment,holder_y_alignment,0])
        difference(){
            // Outside of Phone Holder
            hull(){
                cylinder(r=holder_corner_radius, h=holder_thickness);
                
                translate([phone_width - phone_corner_radius * 2,0,0]) 
                cylinder(r=holder_corner_radius, h=holder_thickness);
                
                translate([-holder_corner_radius,holder_height-phone_corner_radius,0]) 
                cube([1,1,holder_thickness]);
                
                translate([holder_width-holder_corner_radius-1,holder_height-phone_corner_radius,0]) 
                cube([1,1,holder_thickness]);
        }
            // Inside Hole in Phone Holder
            translate([0,0,walls])
            hull(){
                cylinder(r=phone_corner_radius, h=phone_thickness);
                
                translate([phone_width - phone_corner_radius * 2,0,0]) 
                cylinder(r=phone_corner_radius, h=phone_thickness);
                
                translate([-phone_corner_radius,holder_height-phone_corner_radius,0]) 
                cube([1,1,phone_thickness]);
                
                translate([phone_width-phone_corner_radius-1,holder_height-phone_corner_radius,0]) 
                cube([1,1,phone_thickness]);
            }
            
            // Screen Cutout
            translate([0,phone_front_top_margin-phone_corner_radius,0])
            hull(){
                cylinder(r=front_cutout_radius, h=phone_thickness);
                
                translate([phone_width - phone_corner_radius * 2,0,0]) 
                cylinder(r=front_cutout_radius, h=phone_thickness);
                
                translate([-front_cutout_radius,holder_height,0]) 
                cube([1,1,phone_thickness]);
                
                translate([phone_width - phone_corner_radius * 2 + front_cutout_radius -1,holder_height,0]) 
                cube([1,1,phone_thickness]);
            }
            
            // Mute Switch Cutout
            translate([-holder_corner_radius,side_cutout_from_top-phone_corner_radius,holder_thickness/2-side_cutout_width/2])
            cube([walls,side_cutout_height,side_cutout_width]);
      
        }
        
        // Eyepeice
        translate([0,0,holder_thickness])
        difference(){
            cylinder(r=eyepeice_radius_with_walls, h=eyepiece_collar_depth);
            // Eypeice Slot
            translate([0,0,walls])
            cylinder(r=eyepiece_radius,h=eyepiece_collar_depth);
        }
    }
    
    // Lens Cutout
    translate([0,0,holder_thickness-walls])
    hull(){
        cylinder(d=camera_diameter,h=camera_clearance);
        translate([0,holder_height,0])
        cylinder(d=camera_diameter,h=camera_clearance);
    }

    // Viewport for when mount is on but camera is not
    cylinder(d=camera_diameter,h=walls);  
    
    // Keepout area for camera field of view.
    keepoutheight = walls * 2 * 1.1;
    echo(keepoutheight);
    keepoutwide = camera_diameter + 1/sin(camera_keepout_angle/2) * keepoutheight * 2;
    echo(keepoutwide);
    translate([0,0,holder_thickness - walls])
    cylinder(d1=camera_diameter, d2=keepoutwide, h=keepoutheight);
}




