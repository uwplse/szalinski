/*
	My workplace has a giant pegwall -- this allows me to
    print custom pegs with text at the bottom; it's not likely
    to be super useful for others, sorry.
    
    Created by Christopher Litsinger
    April 2019

*/


include <threads.scad>

/* [Customize] */
//do you want to render the base or the cap?
render_shape = "base"; //["base", "cap"]

/* [Text Settings] */
//Font
font_name = "Nunito"; // [Roboto,Bungee,Noto Sans,Nunito,Oswald]
//The text that appears in the center
center_text = "#3dprinting";
//Font size for center text
center_font_size=5.5;
//font size for the outer text
outer_font_size=4.1;
//Text for the top
top_text = "I OPEN AT";
//Size of the text arc in degrees
top_text_arch=130;
//Text for the bottom
bottom_text = "THE CLOSE";
//Size of the text arc in degrees
bottom_text_arch=140;
//Spacing from edge for curved text
arch_text_margin = 1.5;
//how deep should the text be
text_depth = 1.5;



/* [Model Geometry] */
//radius of the peg
peg_radius = 21.5;
//how high up should the threads start
unthreaded_height = 30.15;
//radius of the cap
cap_radius = 23.515;
//how thick should the walls be
wall_thickness=3.5;
//how much of the cap goes up straight
cap_straight_height = 15.5;
//overall cap height
cap_height=28;
//thead pitch for the screws
thread_pitch=3;
//overall thread height
thread_height = 10;

// Model - Start

bold_font_name = str(font_name,":style=Bold");

if (render_shape == "base") {
    base();
}
else {
    //cap_interior();
    cap();
}

module base() {
    difference() {
        union() {
            translate([0,0,30.15]) metric_thread (diameter=peg_radius*2, pitch=thread_pitch, length=thread_height, leadin=1, leadfac=1.25, square=false, internal=false);
            cylinder(r=peg_radius, h=unthreaded_height, $fn=128);
        }
        union() {
            translate([0,0,wall_thickness]) 
                cylinder(r=peg_radius-wall_thickness, h=unthreaded_height+thread_height, $fn=128);    
            write_text();
        }
    }
}

module write_text() {
    translate([0,0,-.01])
    linear_extrude(height = text_depth+.01)             
        rotate ([0,180,0]) {
            text(center_text, font = bold_font_name, halign="center", valign="center", size=center_font_size);
            arched_text(top_text, font_size=outer_font_size, font_name=bold_font_name, radius=peg_radius-outer_font_size-arch_text_margin, degrees=top_text_arch);
            rotate([0,0,180]) arched_text(bottom_text, font_size=outer_font_size, font_name=bold_font_name, radius=peg_radius-outer_font_size-arch_text_margin, degrees=bottom_text_arch);
            }
        }    

module arched_text(arched_text, font_size=20, font_name="Arial", radius=100, degrees=360, top=true){ 
        
    chars=len(arched_text)+1; 
        
    for (i = [1:chars]) { 
        rotate([0,0,(top?1:-1)*(degrees/2-i*(degrees/chars))]) 
        translate([0,(top?1:-1)*radius-(top?0:textsize/2),0]) 
        text(arched_text[i-1],halign="center",font=font_name,size=font_size); 
        } 
}

module cap() {
    difference() {
        union() {
            translate([0,0,cap_straight_height/2])
                cylinder(r=cap_radius, h=cap_straight_height, $fn=128, center=true);
            translate([0,0,cap_straight_height]) 
                    resize([cap_radius*2,cap_radius*2,cap_radius]) sphere(r=cap_radius, $fn=128);
        }
    
        cap_interior();
    }
}

module cap_interior() {
            union() {
            cylinder(r=peg_radius+.3, h=2, $fn=128);
            translate([0,0,2]) metric_thread (diameter=(peg_radius+.5)*2, pitch=thread_pitch, length=thread_height, square=false, internal=true);
            difference() {
                sphere(r=cap_radius+2.36, $fn=128);
                translate([0,0,-(cap_radius+2.36 - thread_height -2)]) cube((cap_radius+2.36)*2, center=true);

            }
        }
    }