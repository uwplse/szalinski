use <utils/build_plate.scad>
use <write/Write.scad>

//----------------------------------------------------------------------------
// Customize and print a custom seven segment display
// http://www.thingiverse.com/thing:937806
// 
// by Erwin Ried (2015-07-24)
// http://www.thingiverse.com/eried/things

//---[ USER Customizable Parameters ]-----------------------------------------

/* [Display] */

// External margin in mm
display_margin = 5;  //[1:50]

// Emboss depth in mm
display_digit_depth = 1;  //[0:5]

// Minimum layer height in mm (depends on the printer, used for the Screen layer and difusser setting)
display_digit_min_layer = 0.3 ; //[0.1:0.1:0.9]

// Main screen layer diffusser
display_digit_height = 1; // [0:None,1:Single,2:Double,3:Triple]

// Extra light difusser
display_digit_difusser_height = 0; // [0:None,1:Single,2:Double,3:Triple]

/* [Segments] */

// Length in milimiters
segment_length = 8 ; //[5:60]

// Width in milimiters
segment_width = 3 ; //[1:40]

// Segment style
//segment_style = 1; // [0:Square,1:Traditional,2:Octagon,50:Rounded]

/* [Leds] */

led_diameter = 5;  // [1.8:SMD (1.8 mm),3:Small (3 mm),5:Standard (5 mm),8:Large (8 mm)]

led_hole_tightness = 0.2; // [0.4:Loose,0.2:Normal,0:Tight,-0.2:Very tight]

// Flange hole extra depth (depth is based on led diameter)
led_hole_length = 0; //[-3:10]

// Flange tightness (affected by led hole tightness)
led_glue_area_tightness = 0; // [0.4:Very loose,0.2:Loose,0:Normal,-0.2:Tight]

// Glue surface depth in mm
led_glue_area_hole_length = 1; //[0:10]

//---[ Build Plate ]----------------------------------------------------------

/* [Build plate] */
//: for display only, doesn't contribute to final object
build_plate_selector = 2; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//: when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//: when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// preview[view:south, tilt:top]

//----------------------------------------------------------------------------

module draw_box()
{
    box_width = display_margin+segment_width*2+segment_length;
    box_height = display_margin+segment_width*3+segment_length*2;
    light_hole_depth = led_height(led_diameter); // mm
    
    // Led layer with the holes  
    difference()
    {
        union()
        {
            // First layer
            translate([-(box_width-display_margin)/2,-(box_height-display_margin)/2]) 
                draw_digit_box(box_width,box_height,display_digit_depth);
                
            // Screen difusser layer
            translate([0,0,display_digit_depth])
                cube([box_width,box_height,display_digit_height*display_digit_min_layer],true);    
                
            // Light holes layer
            translate([-(box_width-display_margin)/2,-(box_height-display_margin)/2,display_digit_depth]) 
                draw_digit_box(box_width,box_height,light_hole_depth);  
            
            // Additional diffuser layer
            diffuser_height = display_digit_difusser_height*display_digit_min_layer;
            translate([0,0,display_digit_depth+display_digit_min_layer+diffuser_height])
                cube([box_width,box_height,diffuser_height],true); 
           
            // Final cover
            translate([0,0,display_digit_depth+light_hole_depth])
                cube([box_width,box_height,1+led_hole_length],true);        
        }
        
        // Led holes
        translate([(box_width-display_margin)/2,-(box_height-display_margin)/2,display_digit_depth+light_hole_depth]) 
            rotate([0,180,0])  
                draw_digit(display_digit_depth+led_hole_length,true);
    }
}

// ----------------------------------------------------

// Logaritmic interpolation between diameter and led height
function led_height(d)=5.8728*ln(d)-1.4519;

// Quadratic interpolation between led diameter and flange size
function led_flange(d)=0.3020*d*d-1.3666*d+4.7812;

// Draws a led body with diameter d
module led(d)
{
    parametric_led(d+led_hole_tightness,led_height(d),led_flange(d)+led_glue_area_tightness+led_hole_tightness,2+led_hole_length);
}

// Draws a led body with specific diameter, height, flange diameter, flange size
// Based on Parametric OpenSCAD LED Module by Acarius10 (http://www.thingiverse.com/thing:38396)
module parametric_led(led_d,led_h,led_fd,led_fh)
{
    translate([0,0,led_fh])cylinder(led_h-(led_d/2)-led_fh,led_d/2,led_d/2, $fn=25);
    translate([0,0,led_h-(led_d/2)])sphere(led_d/2,  $fn=25);
    cylinder(led_fh,led_fd/2,led_fd/2, $fn=25);
}

// ----------------------------------------------------

// Draws a digit with the layer around
module draw_digit_box(box_width,box_height,h)
{
    difference()
    {
        translate([-display_margin/2,-display_margin/2])
            cube([box_width,box_height,h]);
        draw_digit(h);
    }
}

// Draws the seven segments (or required leds) from the origin with the specified height
module draw_digit(h,isLed=false)
{
    draw_segment(0,segment_width,h,false,isLed);
    draw_segment(0,segment_width*2+segment_length,h,false,isLed);
    draw_segment(segment_width+segment_length,0,h,true,isLed); 
    draw_segment(segment_width+segment_length,segment_length+segment_width,h,true,isLed);
    draw_segment(segment_width+segment_length,segment_length*2+segment_width*2,h,true,isLed);
    draw_segment(segment_width+segment_length,segment_width,h,false,isLed);
    draw_segment(segment_width+segment_length,segment_width*2+segment_length,h,false,isLed);
}

// Draws a single segment or led in an specified position
module draw_segment(x,y,h,isHorizontal=false,isLed=false)
{
    translate([x,y,0])
        rotate(isHorizontal?90:0)
        {
            if(isLed)
            {
                translate([segment_width/2,segment_length/2,-h])
                    led(led_diameter);
            }
            else
                cube([segment_width,segment_length,h]);
        }
}

// ----------------------------------------------------

// Let's draw!
draw_box();