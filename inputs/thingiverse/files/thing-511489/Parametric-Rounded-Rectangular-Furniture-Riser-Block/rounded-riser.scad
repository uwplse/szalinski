
// helper module for drawing rectangles with rounded borders
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

// 


/* [Riser] */

// Controls the resolution of the sloap from the bottom shape up to the top
steps_text_box = 20;
// Controls how thich the lip at the top of the part is
relief_thickness_text_box = 2;
// How tall the lip on top of part is, used to stop furniture from slipping off
relief_height_text_box = 2;
// Hight of the part, this is how far off the ground your furniture will be
height_text_box = 10;
// Width of bottom part
bottom_width_text_box = 35;
// Length of bottom part
bottom_length_text_box = 45;
// Bottom corner radius (adds to width and length of part)
bottom_corner_radius_text_box = 5;
// Width of top part
top_width_text_box = 25;
// Length of top part
top_length_text_box = 45;
// Top corner radius (adds to width and length of part)
top_corner_radius_text_box = 5;


/* [Hidden] */

module rounded_square(dim, corners=[10,10,10,10], center=false){
    w=dim[0];
    h=dim[1];
    if (center){
        translate([-w/2, -h/2])
        rounded_square_(dim, corners=corners);
    }else{
        rounded_square_(dim, corners=corners);
    }
}
module rounded_square_(dim, corners, center=false){
    w=dim[0];
    h=dim[1];
    render(){
        difference(){
            square([w,h]);
            if (corners[0])
                square([corners[0], corners[0]]);
            if (corners[1])
                translate([w-corners[1],0])
                square([corners[1], corners[1]]);
            if (corners[2])
                translate([0,h-corners[2]])
                square([corners[2], corners[2]]);
            if (corners[3])
                translate([w-corners[3], h-corners[3]])
                square([corners[3], corners[3]]);
        }
        if (corners[0])
            translate([corners[0], corners[0]])
            intersection(){
                circle(r=corners[0]);
                translate([-corners[0], -corners[0]])
                square([corners[0], corners[0]]);
            }
        if (corners[1])
            translate([w-corners[1], corners[1]])
            intersection(){
                circle(r=corners[1]);
                translate([0, -corners[1]])
                square([corners[1], corners[1]]);
            }   
        if (corners[2])
            translate([corners[2], h-corners[2]])
            intersection(){
                circle(r=corners[2]);
                translate([-corners[2], 0])
                square([corners[2], corners[2]]);
            }
        if (corners[3])
            translate([w-corners[3], h-corners[3]])
            intersection(){
                circle(r=corners[3]);
                square([corners[3], corners[3]]);
            }
    }
}

module square_funnel(steps, thickness, height, s_dim, s_oRadius, s_iRadius, e_dim, e_oRadius, e_iRadius, relief_height)
{
    // Calculate interpolation steps.
    extrude_length = height / steps;
    w_s = (e_dim[0] - s_dim[0]) / steps;
    l_s = (e_dim[1] - s_dim[1]) / steps;
    ir_s = (e_iRadius - s_iRadius) / steps;
    or_s = (e_oRadius - s_oRadius) / steps;
     
    // Starting stuff
    w = s_dim[0];
    l = s_dim[1];
    ir = s_iRadius;
    or = s_oRadius;
     
    // Join together a whole bunch of extrusions
    union()
    {
        for (i=[0:steps])
        {
            // Move up to the next step
            translate([0,0,i*extrude_length])
             
            // Extrude one section
            linear_extrude( height = extrude_length, center = true)
            
            rounded_square([w + (w_s*i) + 2*thickness, l + (l_s*i) + 2*thickness], [or + (or_s*i),or + (or_s*i),or + (or_s*i), or + (or_s*i)], true);
             
            
        }
        
        // Move up to the next step
        translate([0,0,(steps)*extrude_length+(relief_height/2)])
        
        color("red")
         
        // Extrude one section
        linear_extrude( height = relief_height, center = true)
        
        // Create a hollow rounded rect
        // Add the interpolation to each variable
			difference() {
            
				rounded_square([w + (w_s*steps) + 2*thickness, l + (l_s*steps) + 2*thickness], [or + (or_s*steps),or + (or_s*steps),or + (or_s*steps), or + (or_s*steps)], true);
            
				rounded_square([w + (w_s*steps), l + (l_s*steps)], [ir + (ir_s*steps),ir + (ir_s*steps),ir + (ir_s*steps),ir + (ir_s*steps)], true);
        }
    }
}

//square_funnel(steps, thickness, height, s_dim, s_oRadius, s_iRadius, e_dim, e_oRadius, e_iRadius, relief_height)
square_funnel(steps_text_box, relief_thickness_text_box, height_text_box, [bottom_width_text_box, bottom_length_text_box], bottom_corner_radius_text_box, bottom_corner_radius_text_box, [top_width_text_box, top_length_text_box], top_corner_radius_text_box, top_corner_radius_text_box, relief_height_text_box);

//translate([0, 0, height_text_box + 5]) color("green") cube([top_width_text_box, top_length_text_box, 10], center=true);
