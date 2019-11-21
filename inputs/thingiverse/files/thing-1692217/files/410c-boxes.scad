//
// Copyright (c) 2015 Lawrence King lawrencek52@gmail.com. All rights reserved.
//
//This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 United States License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/us/.

// Note: look below for what to Comment/Uncomment 
//     to build the various components of the boxes.

// This project is designed to fit the 410c DragonBoard from 96Boards. There are
// two variants of the box, the 'box' version places the screws that hold the box
// together outside the 410c, this is good for creating a large enough box to balance
// the 5" Waveshare display on. The 'micro' box holds the 410c and nothing else, this
// is useful for building a pocket size system.
//
// The 'box' can be extended vertically to hold a 2x16 LCD display, or a 5" HDMI display
// can be added in a seperate box. The seperate 5" LCD box can be mated to the 410c box
// with hinges or can be a standalone item only linked with the cables.
//
// A 75x75mm VESA mount can be added to the micro-box to allow easy mounting onto
// a VESA monitor.

// Generic setup parameters
fine_fn=30; // number of sides on a cylinder: 8 for development, 30 for printing
delta=0.01; // a little tweak so that touching items actually overlap and fuse together

//
// usb type a connector
//
typea_usb_width = 14.5;    // width of the usb connector
typea_usb_height = 7.3;    // height of the USB connectors off the board
typea_usb_depth = 14.2;    // depth of the USB connector body
typea_usb_clearance = 0.5;  // a little wiggle room

// 410c DragonBoard (db) Dimensions
db_length = 85;   // width of the PCB
db_depth = 54;      // depth of the PCB
db_thickness = 1;   // thickness of the PCB
db_radius = 0.1;    // radius of the corners of the PCB
db_standoff_height = 5;  //height of standoffs
db_top = 7.0;   // height of components topside
db_bottom = 3.0;   // height of components bottomside
db_clearance = 1; // a little space to wiggle side to side
        
db_hole_center_Y1 = 18.50;  // distance from front of board to the first row of mounting holes
db_hole_center_Y2 = 50.00;  // distance from front of board to the second row of mounting holes
db_hole_center_X1 = 4.00;   // distance from left of board to first column of mounting holes
db_hole_center_X2 = 81.00;  // distance from left of board to second column of mounting holes
db_hole_diameter = 2.5;     // diameter of the 4 mounting holes
db_hole_keepout_diameter = 5.0; // clearance for screw heads

db_components_height = 6.5; // keep out area for components on top of board
db_components_width = 85;
db_components_depth_offset = 18.5;
db_components_depth = 54-db_components_depth_offset;

db_hdmi_offset = 25.0;  //distance from left edge of board to center of connector
db_micro_sd_offset = 8.00;  // distance to center of the sdcard slot
db_micro_usb_offset = 41.74; // center of micro-usb connector
db_usb1_offset = 57.06; // distance from the center to the first USB connector
db_usb2_offset = 76.195;    // center of second USB connector
db_power_offset = 73.2; // distance to the pin

connector_extend = 5.0;    // extended area for cable clearance, this must be greater that the box wall thickness

// outer box
box_wall = 1.5;
box_radius = 3;
box_split = 6;       // change where the box gets split
db_freespace = box_radius;

// micro box dimensions. Basically the 410c plus a little bit.
ubox_wall = 1.5;
ubox_radius = 3;
ubox_length = db_length+2*ubox_wall;
ubox_depth = db_depth+2*ubox_wall;
ubox_height = typea_usb_height+2*ubox_wall+db_thickness+db_bottom;

//
// Uncomment one of these to build.
//      then do the following to generate the STL file
//          - press F5 to view the part
//          - press F6 to render the part
//          - File -> Export -> Export as STL...
//
//micro_410c_box_bottom(true);  // the bottom WITH a 75x75 mm VESA mount
//micro_410c_box_bottom(false); // the bottom for the micro-box
//micro_410c_box_top(false);    // the top for the micro box
//disp_case_bottom(true);     //lower VGA display box with display hinges
//disp_case_bottom(false);    //lower VGA display box without hinges
//disp_case_top(false);       //upper VGA display box
//box_top(false, false);       //upper 410c box without LCD display (mini_box, or system)
//box_top(false,true); db_freespace = 20; //upper 410c box with 2x16 lcd
//box_bottom(true, false);     //lower 410c box with hinges
//box_bottom(false, false);    //lower_410c box without hinges (the mini_box)

// Uncomment one of these for  testing the components used to build
// the above. uncomment the one you want to work with
micro_410c_box(false);         // the assembled box, note, you cannot print this and get the board into the box
//system();                 // everything in the right places for a VGA display and a box with hinges
//display_case(true);       // true if you want the upper hinges.
//410c_box(false,false);    //true(s) to add_hinges, add_2x16_lcd
//lcd_display(true);          // true to add clearance for the window
//db_blob();                // a blob used to cut out a volume for the 410c
//db(true,true); // first true to add component clearance, second true to add connector clearance
//db_standoffs(db_standoff_height);
//lcd_display_standoffs();
//screws(false);    // true if the screws are in the top, false if they are in the bottom
//rounded_cube(30,20,10,4,false,true,true); // vert, top, bottom
//micro_sd(true);
//micro_usb(true);
//display_hinge_upper();
//display_hinge_lower();
//vesa_75x75mount();    

// 4-40 screw
screw_440_thread_diam = 2.4; // tap 4-40
screw_440_clear_diam = 3.5; // clearance for a 4-40 screw to pass through
screw_440_head_diam = 6;
screw_440_head_depth = 3;



box_top_height = box_wall+db_freespace+box_split;
box_bottom_height = db_standoff_height + db_thickness + db_top + box_wall-box_split;
box_length = db_length + db_clearance + (2*box_radius) + screw_440_head_diam*2+1; // space for the screws
box_depth = db_depth  + (2*box_wall);
screw_440_inset = box_radius+screw_440_head_diam/2;

module system()
{
    410c_box(true,false);
    translate([-box_length/2,disp_length/2-(hinge_tooth_thickness-3*hinge_tooth_play),box_bottom_height+box_top_height+2+disp_bottom])
        rotate([0,0,-90])
            display_case(true);
}

//
// display_hinge_upper
//      - a seperate part that gets screwed to the dicplay bottom box
hinge_depth = 6;
hinge_tooth_thickness = 2.1;  // thickness of each tooth
hinge_height_male = box_bottom_height-hinge_tooth_thickness;    // minimum hinge_depth
hinge_height_female = box_top_height+2+hinge_depth;    // minimum hinge_depth
hinge_tooth_play = 0.150;    // a small amount of play 
hinge_tooth_count = 4;      // on each side
hinge_width = (2*hinge_tooth_count-1)*(hinge_tooth_thickness+hinge_tooth_play)-hinge_tooth_play;

module display_hinge_lower()
{
    // the baseplate
    translate([0,-hinge_depth/2,0])
        cube([box_depth+2*hinge_width-2*box_wall, 2*hinge_depth, hinge_tooth_thickness]);
    translate([0,0,hinge_tooth_thickness]) {
        hinge_male(hinge_tooth_count, hinge_tooth_thickness, hinge_depth, hinge_height_male,hinge_tooth_play);
    }
    translate([box_depth+hinge_width-2*box_wall,0,hinge_tooth_thickness]) {
        hinge_male(hinge_tooth_count, hinge_tooth_thickness, hinge_depth, hinge_height_male,hinge_tooth_play);
    }
}
        
module hinge_male(count, thickness, depth, height, play)
{
    for (i = [0:(count-1)]) {
        hinge_tooth(i*2*(thickness+play), hinge_tooth_thickness, hinge_depth, hinge_height_male);
    }
}
module hinge_female(count, thickness, depth, height, play)
{
    for (i = [1:(count-1)]) {
        translate([0,depth,0])
            rotate([180,0,0])
                hinge_tooth(i*2*(thickness+play)-(thickness+play), hinge_tooth_thickness, hinge_depth, hinge_height_female);
    }
}
module hinge_tooth(offset, thickness, depth, height)
{
    translate([offset,0,0]){
        difference () {
            union() {
                // the base cube
                cube([thickness, depth, height-depth/2]); 
                // then the cylinder on top
                translate([0,depth/2,height-depth/2])
                    rotate([0,90,0])
                        cylinder(d=depth, h=thickness ,$fn=fine_fn); 
            }
            // then punch a hole through it
            translate([0-delta,depth/2,height-depth/2])
                    rotate([0,90,0])
                        cylinder(d=screw_440_clear_diam, h=thickness+2*delta ,$fn=fine_fn); 
        }
    }
}

module box_top(add_lower_hinge, add_2x16_lcd)
{
    difference()
    {
        410c_box(add_lower_hinge, add_2x16_lcd);
        translate([-box_length,-box_depth,-delta])
            cube([2*box_length,2*box_depth,box_bottom_height+2*delta]);
    }
}

module box_bottom(add_lower_hinge, add_2x16_lcd)
{
    difference()
    {
        410c_box(add_lower_hinge, add_2x16_lcd);
        translate([-box_length,-box_depth,-delta+(box_bottom_height)])
            cube([2*box_length,2*box_depth,2*box_top_height+2*delta]);
    }
}

module 410c_box(add_lower_hinge, add_2x16_lcd)
{
    difference() {
        union() {
            //start with a rounded cube centered on the origin
            translate([-box_length/2, -box_depth/2, 0])
                rounded_cube( box_length, box_depth, box_top_height+box_bottom_height, box_radius, true, true, true );
            if (add_lower_hinge) {
                // add the hinge for the display
                translate([-(box_length/2-1.5*hinge_depth),-(box_depth/2+hinge_width-box_wall),0])
                    rotate([0,0,90])
                        display_hinge_lower();
            }
        }
        //then subtract the things we want to leave space for.
        translate([-((db_length+2*db_clearance)/2), -db_depth/2, db_standoff_height+box_wall])
            db_blob();
        screws(false);
        ends();
        if (add_2x16_lcd) {
            translate([-(lcd_main_pcb_length/2), -lcd_main_pcb_depth/2,
                (box_top_height+box_bottom_height) -(box_wall+lcd_crystal_thickness+lcd_pcb_thickness)])
                lcd_display(true);
        }
        if (add_lower_hinge) {
            // and drill a hole through the wall for the lock screws
            translate([-(box_length/2-1*hinge_depth),box_depth,hinge_height_male+hinge_tooth_thickness-hinge_depth/2])
                rotate([90,0,0])
                    cylinder(h=2*box_depth,d=screw_440_thread_diam,$fn=fine_fn);
        }
    }
   

    // add in the standoffs for the DragonBoard
    translate([-(db_length/2), -db_depth/2, db_standoff_height+box_wall-2*delta])
        db_standoffs(db_standoff_height);
    if (add_2x16_lcd) {
        // add in the standoffs for the small LCD display
        translate([-(lcd_main_pcb_length/2), -lcd_main_pcb_depth/2, 
            (box_top_height+box_bottom_height) -(box_wall+lcd_crystal_thickness+lcd_pcb_thickness-delta)])
            lcd_display_standoffs();
    } else {
        // add in a disk for the Snapdragon logo
        snapdragon_logo_diameter=39;
        snapdragon_logo_thickness = 1;
        difference () {
            // a cone
            translate([0,0,box_top_height+box_bottom_height-delta])
                cylinder(h=snapdragon_logo_thickness+2*delta,d1=snapdragon_logo_diameter+3, d2=snapdragon_logo_diameter+1 ,$fn=fine_fn);
            
            // with a hole in the center
            translate([0,0,box_top_height+box_bottom_height-delta])
                cylinder(h=snapdragon_logo_thickness+3*delta,d=snapdragon_logo_diameter ,$fn=fine_fn);
        }
    }
}


display_pcb_thickness = 1.6;
display_pcb_length = 121.15;
display_pcb_depth = 89.5;
display_pcb_radius = 2;
display_pcb_hole_diameter = 3;
display_pcb_hole_inset = 1.50+display_pcb_hole_diameter/2;
display_pcb_tab_width = 6.1;
display_pcb_slot_depth = 6.8;
display_component_height = 6+box_radius-box_wall;
display_crystal_thickness = 5.7;
display_crystal_length = 120.83;
display_crystal_depth = 76;
display_window_length = 113;
display_window_depth = 69;
display_hdmi_offset = (56.70+41.62)/2;
display_microusb1_offset = (20.51+12.98)/2;     // power only
display_microusb2_offset = (34.11+26.24)/2;     // touchscreen

module display_800x480(add_window)
{
    // first the main pcb
    difference() {
        // first the main pcb
        rounded_cube(display_pcb_length, display_pcb_depth, display_pcb_thickness, display_pcb_radius,true,false,false);
        // then punch holes in it for the screws
        for(x=[display_pcb_hole_inset,display_pcb_length-display_pcb_hole_inset]) {
            for(y=[display_pcb_hole_inset, display_pcb_depth-display_pcb_hole_inset]) {
                translate([x,y, -2*display_pcb_thickness])
                    cylinder(d=display_pcb_hole_diameter, h=6*display_pcb_thickness ,$fn=fine_fn);
            }
        }
        // and take out the notches on both sides
        translate([display_pcb_tab_width,-delta,-display_pcb_thickness])
            cube([display_pcb_length-2*display_pcb_tab_width,display_pcb_slot_depth,3*display_pcb_thickness]);
        translate([display_pcb_tab_width,display_pcb_depth-display_pcb_slot_depth+delta,-display_pcb_thickness])
            cube([display_pcb_length-2*display_pcb_tab_width,display_pcb_slot_depth,3*display_pcb_thickness]);
    }
    // add the crystal on the top
    translate([(display_pcb_length-display_crystal_length)/2, (display_pcb_depth-display_crystal_depth)/2, display_pcb_thickness-delta])
        cube([display_crystal_length, display_crystal_depth, display_crystal_thickness]);
    // and the HDMI connector
    translate([display_pcb_length,display_pcb_depth-display_hdmi_offset,0])
        rotate([0,180,90])
            fs_hdmi(true);
    // and the two micro usb connectors
    translate([display_pcb_length,display_pcb_depth-display_microusb1_offset,0])
        rotate([0,180,90])
            micro_usb(true);
    translate([display_pcb_length,display_pcb_depth-display_microusb2_offset,0])
        rotate([0,180,90])
            micro_usb(true);
    // and a space for components under the board
    translate([0,display_pcb_slot_depth,-display_component_height+delta])
        rounded_cube(display_pcb_length,display_pcb_depth-2*display_pcb_slot_depth,display_component_height,box_radius-box_wall,false, false, true);
    // and finally add a window if requested
    if (add_window) {
        translate([(display_pcb_length-display_window_length)/2,5.7+display_pcb_slot_depth,display_pcb_thickness+display_crystal_thickness-2*delta])
            rounded_cube(display_window_length,display_window_depth,connector_extend,1,true,false,false);
    }
}

module display_standoffs()
{
    // then punch holes in it for the screws
    for(x=[display_pcb_hole_inset,display_pcb_length-display_pcb_hole_inset]) {
        for(y=[display_pcb_hole_inset, display_pcb_depth-display_pcb_hole_inset]) {
            difference() {
                //first put in the pillar
                translate([x,y, display_pcb_thickness])
                    cylinder(d=db_hole_keepout_diameter, h=display_crystal_thickness ,$fn=fine_fn);
                // then open up the hole
                translate([x,y, 0])
                    cylinder(d=screw_440_thread_diam, h=display_crystal_thickness + 2*display_pcb_thickness ,$fn=fine_fn);
            }
        }
    }
}

// The display box
disp_top = display_crystal_thickness+display_pcb_thickness+box_wall;
disp_bottom = display_component_height + box_wall;
disp_length = display_pcb_length + 2*box_wall;
disp_depth = display_pcb_depth  + 2*box_wall;

module disp_case_top(add_upper_hinges)
{
    difference()
    {
        display_case(add_upper_hinges);
        translate([-disp_length/2,-disp_depth/2,-2*disp_bottom+delta])
            cube([2*disp_length,2*disp_depth,2*disp_bottom]);
    }
}

module disp_case_bottom(add_upper_hinges)
{
    difference()
    {
        display_case(add_upper_hinges);
        translate([-disp_length/2,-disp_depth/2,-delta])
            cube([2*disp_length,2*disp_depth,2*disp_top]);
    }
}




module display_case(add_upper_hinges)
{
    // start with a big rectangle, then remove the window and connector_holes
    difference () {
        // the outer case
        translate([-box_wall,-box_wall,-disp_bottom])
            rounded_cube(disp_length, disp_depth,disp_top+disp_bottom,box_radius,true,true,true);
        // remove the display
        display_800x480(true);
        // hog out the top and bottom
        translate([display_pcb_tab_width-delta, 0, -display_component_height])
            rounded_cube(display_pcb_length-2*display_pcb_tab_width+2*delta,display_pcb_depth,display_component_height+display_pcb_thickness+display_crystal_thickness,box_radius-box_wall,true,true,true);
        // take out display screws
        for(x=[display_pcb_hole_inset,display_pcb_length-display_pcb_hole_inset]) {
            for(y=[display_pcb_hole_inset, display_pcb_depth-display_pcb_hole_inset]) {
                translate([x,y,-(disp_bottom+delta)]) {
                    cylinder(d=screw_440_head_diam,h=screw_440_head_depth,$fn=fine_fn);
                    cylinder(d=screw_440_clear_diam+delta,h=disp_bottom+display_pcb_thickness,$fn=fine_fn);
                    cylinder(d=screw_440_thread_diam,h=disp_bottom+disp_top-box_radius,$fn=fine_fn);
                }
            }
        }
    } 
    if (add_upper_hinges) {
        // add the hinge parts
        translate([disp_length/2-(box_depth/2+hinge_width),box_radius,-disp_bottom+delta]) {
            // the left hinge and a support block
            translate([0,0,0]) {
                hinge_female(hinge_tooth_count, hinge_tooth_thickness, hinge_depth, hinge_height_female,hinge_tooth_play);
            }
            // the left strengthening bock
            translate([hinge_tooth_thickness+hinge_tooth_play,0,-(hinge_height_female-2-hinge_depth)])
                cube([(hinge_tooth_count)*(hinge_tooth_thickness+hinge_tooth_play),hinge_depth,(hinge_height_female-2-hinge_depth)]);
            // and the right hinge
            translate([box_depth+hinge_width-2*box_wall,0,0]) {
               hinge_female(hinge_tooth_count, hinge_tooth_thickness, hinge_depth, hinge_height_female,hinge_tooth_play);
            }
            // the right strengthening bock
            translate([hinge_tooth_thickness+hinge_tooth_play+box_depth+hinge_width-2*box_wall,0,-(hinge_height_female-2-hinge_depth)])
                cube([(hinge_tooth_count)*(hinge_tooth_thickness+hinge_tooth_play),hinge_depth,(hinge_height_female-2-hinge_depth)]);
        }
    }
 }
module ends()
{
    l = box_length-2*box_wall;
    d = box_depth-(2*box_radius + 2*screw_440_head_diam +1);
    h = box_top_height+box_bottom_height-2*box_wall;
    translate([-l/2,-d/2,box_wall])
        rounded_cube(l, d, h, box_radius-box_wall,true,true,true);
}
module screws(top)
{
    if (top) {
        // screws are on the top of the box going down)
        rotate([180,0,0])

        for(x=[-(box_length/2)+(box_radius+screw_440_head_diam/2),
                (box_length/2)-(box_radius+screw_440_head_diam/2)]) {
            for(y=[-(box_depth/2)+(box_radius+screw_440_head_diam/2),
                (box_depth/2)-(box_radius+screw_440_head_diam/2)]) {
                translate([x,y,-(box_bottom_height+box_top_height+delta)]) {
                    cylinder(d=screw_440_head_diam,h=screw_440_head_depth,$fn=fine_fn);
                    cylinder(d=screw_440_clear_diam,h=box_top_height+1,$fn=fine_fn);
                    cylinder(d=screw_440_thread_diam-delta,h=box_bottom_height+box_top_height-box_radius,$fn=fine_fn);
                }
            }
        }
    }else{
        for(x=[-(box_length/2)+(box_radius+screw_440_head_diam/2),
            (box_length/2)-(box_radius+screw_440_head_diam/2)]) {
        for(y=[-(box_depth/2)+(box_radius+screw_440_head_diam/2),
            (box_depth/2)-(box_radius+screw_440_head_diam/2)]) {
                translate([x,y,-(delta)]) {
                    cylinder(d=screw_440_head_diam,h=screw_440_head_depth,$fn=fine_fn);
                    cylinder(d=screw_440_clear_diam,h=box_bottom_height+1,$fn=fine_fn);
                    cylinder(d=screw_440_thread_diam-delta,h=box_bottom_height+box_top_height-box_radius,$fn=fine_fn);
                }
            }
        }
    }
}

// buid the Dragonboard with stubs standing out for the connectors
// we will eventually subtract this from the box. In addition to the detailed
// board we also have a 'blob' version that has lot's of clearance for putting the board in and out
module db_blob()
{
    // build a cube, then add the detailed board (to get the connector stubs)
    translate([0,0,-db_standoff_height]) 
        rounded_cube(db_length+2*db_clearance, db_depth, db_standoff_height+db_thickness+db_top+db_freespace, box_radius-box_wall, false, true, true);
    // and put the dragonboard with connectors into the blob
    translate(0,db_standoff_height, 0) db(true, true);
}

module db(add_comp_clearance, add_cables)
{
 
    // The PCB
    color("Green", 1);
    translate([0,0,0])
        rounded_cube(db_length,db_depth,db_thickness,db_radius,true,false,false);
    
    if (add_comp_clearance) {
        //The clearance above the board for the components
        translate([0,0,db_thickness-delta])
            rounded_cube(db_components_width,db_depth, db_components_height, box_radius-box_wall, true, true, false);
    
        //The clearance for components under the board does not include the standoffs
        translate([0,0,-db_bottom+delta])
            rounded_cube(db_length, db_depth, db_bottom, box_radius-box_wall, true, false, true);
    }
    
    // the micro_sd card
    translate([db_micro_sd_offset,0,db_thickness-delta])
        micro_sd(add_cables);
    // HDMI connector (cable clearance)
    translate([db_hdmi_offset, 0, db_thickness-delta])
            fs_hdmi(add_cables);
    // micro-usb connector (cable clearance)
    translate([db_micro_usb_offset, 0, db_thickness-delta])
            micro_usb(add_cables);
    // two usb type connectors
    translate([db_usb1_offset, 0, db_thickness-delta])
            typea_usb(add_cables);
    translate([db_usb2_offset, 0, db_thickness-delta])
            typea_usb(add_cables);

    // the power connector
     translate ([db_power_offset, db_depth, db_thickness-delta]) 
        rotate([0,0,180]) 
            power_connector(add_cables);
    
}
module db_standoffs(height)
{
   color("MintCream",1) {
	   for(x=[db_hole_center_X1,db_hole_center_X2]) {
	    for(y=[db_hole_center_Y1, db_hole_center_Y2]) {
		difference() {
		    translate([x,y, -height])
			cylinder(d=db_hole_keepout_diameter, h=height ,$fn=fine_fn);
		    translate([x,y, -(height+delta)])
			cylinder(d=screw_440_thread_diam-delta, h=height+2*delta ,$fn=fine_fn);
		    }
		}
	    }
    }
}
//
// the 2x16 character LCD Display Module
//
lcd_pcb_thickness = 1.6;
lcd_main_pcb_length = 80;
lcd_main_pcb_depth = 36;
lcd_serial_pcb_length = 50;
lcd_serial_pcb_depth = 27;  
lcd_serial_pcb_gap = 2.54;  // distance between the main pcb and the serial PCB
lcd_serial_pcb_offset = 24.75;  // offset in the length direction
lcd_serial_pcb_components = 6.75;
lcd_main_pcb_hole_diameter = 3;
lcd_main_pcb_hole_inset = 0.78+lcd_main_pcb_hole_diameter/2;
lcd_crystal_lenght = 71.35;
lcd_crystal_depth = 24.2;
lcd_crystal_thickness = 7.35;
lcd_crystal_offset_length = 4.1;
lcd_crystal_offset_depth = 6.5;
lcd_bezel_depth = 4;
lcd_bezel_length = 3;

module lcd_display(add_window)
{
    // first the main PCB minus the mounting holes
    difference() {
        union() {
            cube([lcd_main_pcb_length, lcd_main_pcb_depth, lcd_pcb_thickness]);
            // add some components under the main-pcb
            translate([lcd_main_pcb_hole_inset,lcd_main_pcb_hole_inset,-lcd_serial_pcb_gap])
                cube([lcd_main_pcb_length-2*lcd_main_pcb_hole_inset, 
                    lcd_main_pcb_depth-2*lcd_main_pcb_hole_inset, 
                    lcd_serial_pcb_gap]);
        }
        for(x=[lcd_main_pcb_hole_inset,lcd_main_pcb_length-lcd_main_pcb_hole_inset]) {
            for(y=[lcd_main_pcb_hole_inset, lcd_main_pcb_depth-lcd_main_pcb_hole_inset]) {
                translate([x,y, -2*lcd_pcb_thickness])
                    cylinder(r=lcd_main_pcb_hole_diameter/2, h=6*lcd_pcb_thickness ,$fn=fine_fn);
            }
        }
    }
    // add the crystal on top of the PCB
    translate([lcd_crystal_offset_length,lcd_crystal_offset_depth,lcd_pcb_thickness])
        cube([lcd_crystal_lenght, lcd_crystal_depth, lcd_crystal_thickness]);
    // then the serial daughter card
    translate([lcd_serial_pcb_offset,0,-(lcd_serial_pcb_gap+lcd_pcb_thickness)])
        cube([lcd_serial_pcb_length, lcd_serial_pcb_depth, lcd_pcb_thickness]);
    // and the connectors on the serial daughter card
     translate([lcd_serial_pcb_offset,0,-(lcd_serial_pcb_gap+2*lcd_pcb_thickness)])
        cube([lcd_serial_pcb_length, lcd_serial_pcb_depth, lcd_serial_pcb_components]);


    if (add_window) {
        // extend a rectangle out the window
        translate([lcd_crystal_offset_length+lcd_bezel_length,lcd_crystal_offset_depth+lcd_bezel_depth,lcd_pcb_thickness+lcd_crystal_thickness-delta])
            cube([lcd_crystal_lenght-2*lcd_bezel_length, lcd_crystal_depth-2*lcd_bezel_depth, connector_extend]);
        
    }
}
//
// lcd_display_standoffs
//
module lcd_display_standoffs()
{
    for(x=[lcd_main_pcb_hole_inset,lcd_main_pcb_length-lcd_main_pcb_hole_inset]) {
        for(y=[lcd_main_pcb_hole_inset, lcd_main_pcb_depth-lcd_main_pcb_hole_inset]) {
            translate([x,y,lcd_pcb_thickness])
            difference() {
                cylinder(r=db_hole_keepout_diameter/2, h=lcd_crystal_thickness ,$fn=fine_fn);
                translate([0,0,-delta])
                    cylinder(d=screw_440_thread_diam, 
                        h=lcd_crystal_thickness+2*delta ,$fn=fine_fn);

            }
            }
        }
 
}
//
// the power connector and cable
//
power_width = 9.0;
power_depth = 12.7;
power_thickness = 6.25;
power_pin_offset_width = 5.1;
power_pin_offset_height = power_thickness/2;
power_connector_barrel = 5.00 + 1;  // diameter of the barrel plus clearance
power_connector_body = 10.00;       // diameter of the body
power_connector_body_offset = 1.5;    // distance from the connector to the body when mated

module power_connector(cable)
{
    // the power connector and cable
    // latteraly centered on the pin

    // the connector body
    color("Gray",1);
    translate([-power_pin_offset_width,0])
        cube([power_width,power_depth, power_thickness]);
    // the metal part of the connector barrel
    if (cable) {
        color("LightGrey",1);
        translate([0, -connector_extend+delta, power_pin_offset_height ]) 
            rotate([-90,0,0]) 
                cylinder(h=connector_extend, r=power_connector_barrel/2, $fn=fine_fn);
        // and the body of the connector
        color("Black",1);
        translate([0, -connector_extend-power_connector_body_offset, power_pin_offset_height ]) 
            rotate([-90,0,0]) 
                cylinder(h=connector_extend-power_connector_body_offset, 
                    r=power_connector_body/2, $fn=fine_fn);
    }
    
}

module typea_usb(cable)
{
    // the body of the connector
    color("Gray",1);
    translate([-typea_usb_width/2,0,0])
        cube([typea_usb_width,typea_usb_depth,typea_usb_height]);
    // and a clearance for the cable
    if (cable) {
        color("LightGrey",1);
        translate([-(typea_usb_width/2+typea_usb_clearance),-connector_extend,-typea_usb_clearance])
            cube([typea_usb_width+2*typea_usb_clearance, connector_extend+delta, typea_usb_height+2*typea_usb_clearance]);
    }
}
//
//micro_sdcard slot
//
micro_sd_width = 14;    // width of the connector body
micro_sd_height = 1.7;  // height of the connector body
micro_sd_depth = 15.5;  // depth of the connector body
micro_sd_card_width = 11.2; // width of the card
micro_sd_card_thickness = 1.0; // thickness of the card
micro_sd_card_clearance = 0.4;  // space around the card so you can get it in and out
micro_sd_slot_offset = 3;   // the width of the switch

module micro_sd(micro_card)
{
    // the body of the connector
    color("Gray",1);
    translate([-(micro_sd_width-micro_sd_slot_offset)/2,0,-delta])
        cube([micro_sd_width,micro_sd_depth,micro_sd_height]);
    // and a clearance for the card to slide in/out (add clearance all around)
    // the card slot is NOT centered in the connector body
    if (micro_card) {
        color("LightGrey",1){
        w=micro_sd_width-micro_sd_slot_offset+2*micro_sd_card_clearance;
        translate([-w/2, -connector_extend+delta,-micro_sd_card_clearance])
            cube([w, connector_extend, micro_sd_height+2*micro_sd_card_clearance]);
        }
    }
}

//
// Full Size HDMI connector
//
fs_hdmi_width = 15.1;       // width of HDMI connector
fs_hdmi_height = 7.36-1.0;  //height of hdmi connector
fs_hdmi_depth = 9.6;        // depth of the connector body
fs_hdmi_clearance = 0.5;    // some space around the connector

module fs_hdmi(cable)
{
    // the body of the connector
    color("Gray",1);
    translate([-fs_hdmi_width/2,-delta,0])
        cube([fs_hdmi_width,fs_hdmi_depth,fs_hdmi_height]);
    // and a clearance for the cable
    if (cable) {
        color("LightGrey",1);
        translate([-(fs_hdmi_width/2+fs_hdmi_clearance),-connector_extend,-fs_hdmi_clearance])
            cube([fs_hdmi_width+2*fs_hdmi_clearance, connector_extend+delta, fs_hdmi_height+2*fs_hdmi_clearance]);
    }
}
//
// usb mini connector (T shape)
//
mini_usb_width = 9;
mini_usb_height = 4.25;
mini_usb_offset = 10.5;
mini_usb_tabthickness = 0.5;
mini_usb_tabwidth = 2;

module mini_usb()
{
    color("Gray",1);
    translate([-0.5*mini_usb_width,-connector_extend,0])
        cube([mini_usb_width,connector_extend*2,mini_usb_height]);
    color("LightGrey",1);
    translate([-0.5*mini_usb_width-mini_usb_tabwidth,-connector_extend,-mini_usb_tabthickness])
        cube([mini_usb_width+(2*mini_usb_tabwidth),connector_extend+delta,2*mini_usb_tabthickness]);
}
//
// micro usb connector
//
micro_usb_width = 7.9;      // width of connector
micro_usb_depth = 6;        // depth of connector
micro_usb_height = 3.00;        // height of connector
micro_usb_clearance = 0.4;  // tweak it a little larger
micro_usb_underhang = 1.0-0.7;  // the connectors hang under the edge of the board a wee bit

module micro_usb(cable)
{
    color("Gray",1);
    // The body of the connector on the board
    translate([-micro_usb_width/2,0,-delta])
        cube([micro_usb_width,micro_usb_depth, micro_usb_height]);
    if ( cable) {
        color("LightGrey",1) {
        translate([-(micro_usb_width/2+micro_usb_clearance),delta-connector_extend,-(micro_usb_clearance+micro_usb_underhang)])
            cube([micro_usb_width+2*micro_usb_clearance,connector_extend, micro_usb_height+2*micro_usb_clearance]);
        }
    }
}

//
// rounded_cube, builds a cube of dimension x,y,z and
//      optional rounds the corners
//  te - round corners on the top edge
//  ve - round the corners on the vertical edges
//  be - round the corners on the bottom edge
//
// The cube will have one corner at [0,0,0]
module rounded_cube(xx,yy,zz,rr,ve,te,be)
{
    z1 = be ? rr : 0;           // move central cube up by rr if we are rounding the bottom
    z2 = te ? zz-rr-z1 : zz-z1;   // shorten central cube by rr if we are rounding the top
    x1 = ve ? xx-(2*rr) : xx;      // shorten the central cube of we are rounding the vertical edges
    y1 = ve ? yy-(2*rr) : yy;      // shor


    if( ve ) {
        // put in 4 vertical cylinders
        for(x=[rr,xx-rr])
            for(y=[rr,yy-rr])
                translate([x,y,z1])
                    cylinder(r=rr,h=z2,$fn=fine_fn);
        // then fill in the sides with two cubes
        translate([0,rr,z1])
            cube([xx,y1,z2]); // the left/right cube
        translate([rr,0,z1])
            cube([x1,yy,z2]); // the front/back cube
        
    } else {
        // fill in a cube with square corners
        translate([0,0,z1])
            cube([xx,yy,z2]);
    }
    
    if( te ) {
      // put 4 spheres in the top corners
        for(x=[rr,xx-rr])
            for(y=[rr,yy-rr])
                translate([x,y,zz-rr])
                    sphere(r=rr,$fn=fine_fn);
        // put 4 cylinders around the top
        for(x=[rr,xx-rr])
            translate([x,yy-rr,zz-rr]) rotate([90,0,0])
                cylinder(r=rr,h=yy-2*rr,$fn=fine_fn);   // the front-to back cylinders
        for(y=[rr,yy-rr])
            translate([rr,y,zz-rr]) rotate([0,90,0])
                cylinder(r=rr,h=xx-2*rr,$fn=fine_fn);
        // and fill in the top
        translate([rr,rr,0])
            cube([xx-2*rr,yy-2*rr,zz]);
    }
    
    if( be ){
        // and 4 spheres in the bottom corners
        for(x=[rr,xx-rr])
            for(y=[rr,yy-rr])
                translate([x,y,rr])
                    sphere(r=rr,$fn=fine_fn);
        // put 4 cylinders around the bottom
        for(x=[rr,xx-rr])
            translate([x,rr,rr]) rotate([-90,0,0])
                cylinder(r=rr,h=yy-2*rr,$fn=fine_fn);   // the side-to-side cylinders
        for(y=[rr,yy-rr])
            translate([rr,y,rr]) rotate([0,90,0])
                cylinder(r=rr,h=xx-2*rr,$fn=fine_fn);   // the front to back cylinders
        translate([rr,rr,0])
            cube([xx-2*rr,yy-2*rr,zz]);
    }
}


//
// micro_box - the smallest possible box for the dragonboard 410c
//
module micro_410c_box(vesa)
{
    difference() {
        union() {
            difference() {
                translate([-ubox_wall, -ubox_wall, -(ubox_wall+db_bottom)])
                    rounded_cube(ubox_length, ubox_depth, ubox_height , ubox_radius, true, true, !vesa);
                // and put the dragonboard with connectors into the box     
                translate(0,0, 0)
                    db(true, true);
            }
            // add in the standoffs for the DragonBoard, at the top of the case.
            translate([0, 0, db_top+db_thickness+delta])
                db_standoffs(db_top);
            // and the standoffs at the bottom of the case
            translate([0, 0, -delta])
                ubox_standoffs(db_bottom);
            if(vesa) 
                translate([ubox_length/2+(ubox_length-plate_dimension),ubox_depth/2,-(plate_thickness+db_bottom+delta)]) 
                    vesa_75x75mount();
        }
//    }
        // And leave space for the screws
        if(vesa) 
            translate([0,0,-(plate_thickness+ubox_wall+db_bottom)-2*delta])
                ubox_screws();
        else
            translate([0,0,-(ubox_wall+db_bottom)-2*delta])
                ubox_screws();
    }
}

module ubox_standoffs(height)
{
   color("MintCream",1) {
	   for(x=[db_hole_center_X1,db_hole_center_X2]) {
            for(y=[db_hole_center_Y1, db_hole_center_Y2]) {
            union() {
                translate([x,y, -height])
                cylinder(d=db_hole_keepout_diameter, h=height ,$fn=fine_fn);
                translate([x,y, -(height+delta)])
                cylinder(d=screw_440_head_diam+2*ubox_wall, h=height-db_bottom/3+2*delta ,$fn=fine_fn);
                }
            }
	    }
    }
}


module micro_410c_box_top(vesa)
{
    difference()
    {
        micro_410c_box(vesa);
        translate([-ubox_length/2,-ubox_depth/2,db_thickness-2*ubox_height])
            cube([2*ubox_length,2*ubox_depth,2*ubox_height]);
    }
}


module micro_410c_box_bottom(vesa)
{
    difference()
    {
        micro_410c_box(vesa);
        translate([-ubox_length/2,-ubox_depth/2,db_thickness])
            cube([2*ubox_length,2*ubox_depth,2*ubox_height+2*delta]);
    }
}




// Vesa Mount
vesa_spacing = 75;
vesa_hole = 4.5; 
plate_thickness = box_radius;
plate_dimension = vesa_spacing+2*vesa_hole;


module vesa_mount_top()
{
    difference()
    {
        vesa_75x75mount();
        translate([-box_length,-box_depth,-box_bottom_height-delta])
            cube([2*box_length,2*box_depth,2*box_bottom_height+2*delta]);
    }
}


module vesa_mount_bottom()
{
    difference()
    {
        vesa_75x75mount();
        translate([-box_length,-box_depth,-delta+(box_bottom_height)])
            cube([2*box_length,2*box_depth,2*box_top_height+2*delta]);
    }
}

module vesa_75x75mount()
{
    difference () {
        union() {
            translate([0,0, plate_thickness-ubox_wall]){
                difference() {
                    // the Vesa mounting plate
                    translate([-plate_dimension/2, -plate_dimension/2, -plate_thickness+delta+ubox_wall])
                        cube([plate_dimension,plate_dimension,plate_thickness]);
                    // Subtract the 4 Vesa mounting holes
                    for (x = [-vesa_spacing/2, vesa_spacing/2])
                        for (y = [-vesa_spacing/2, vesa_spacing/2])
                            translate([x,y,-plate_thickness])
                                cylinder(d=vesa_hole, h=3*plate_thickness);
                    // Subtract 2 screw holes in the box from the plate
                    }
                }
            }
    }
}

module ubox_screws()
{
screw_440_head_depth_thin=1.8;
    
	   for(x=[db_hole_center_X1,db_hole_center_X2]) {
	    for(y=[db_hole_center_Y1, db_hole_center_Y2]) {
                translate([x,y,-(delta)]) {
                    cylinder(d=screw_440_head_diam,h=screw_440_head_depth_thin,$fn=fine_fn);
                    cylinder(d=screw_440_clear_diam,h=db_bottom+db_thickness+ubox_wall,$fn=fine_fn);
                    cylinder(d=screw_440_thread_diam,h=db_bottom+db_thickness+typea_usb_height,$fn=fine_fn);
                }
            }
        }
}

