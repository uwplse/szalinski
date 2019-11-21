
 
/* [Dimensions] */
// Prop hub to tip along the x-axis
prop_dia_in = 12.0;

// Theoretical distance traved in one revelution
prop_pitch_in = 22.0;

// Width of rectangular block
block_width_in = 2.5;

/* [Options] */ 
// Cross Sections
xsection="curved";  // [curved:Circular,flat:Flat]

// Radius of curcved cross section
camber_radius_in = 10.0;

// Divisions between root and tip
sections = 50;
 
/* [Hidden] */
mm = 25.4;
$fn = 192;

prop_dia = prop_dia_in * mm;
prop_pitch = prop_pitch_in * mm;
block_width = block_width_in *mm;
camber_radius = camber_radius_in * mm;

// https://indoornewsandviews.files.wordpress.com/2012/10/inav_121_press.pdf
// From page 22, Indoor Props - Practice
function t_block(d, p, w) = p*w/(3.14159*d);

// Determine the height of an enclosing block given the above formula 
block_height =  t_block(prop_dia, prop_pitch, block_width);

// Fill in the basic block shape
linear_extrude(block_height) polygon([[0,0],[prop_dia/2, block_width], [0, block_width]]);

// Iterate over the blade cross sections
for(i=[0:sections-1]) {
    hull() {
        blade_section(i, block_width, block_height, sections, camber_radius, xsection);
        blade_section(i+1, block_width, block_height, sections, camber_radius, xsection);
    }
}


module circular_segment(R, c)
{
    // see https://en.wikipedia.org/wiki/Circular_segment
    d = sqrt(R*R-(c*c)/4);
    linear_extrude(0.1) difference() {
        translate([-d,0,0]) circle(R);
        translate([-R,0,0]) square(2*R, center=true);
    }
}


 module blade_section(i, width, height, sections, camber_rad=125, xsection)
 {
    width_i = i*width/sections;
    chord_i = sqrt(height*height+width_i*width_i);
    angle_i = atan(width_i / height);

    translate([(i/sections)*prop_dia/2,0,0]) {
        // generate and orient the circular segments
        if (xsection == "curved") {
            rotate([-angle_i,0,0]) 
                translate([0, 0, chord_i/2]) 
                    rotate([90, 0, -90]) circular_segment(camber_rad, chord_i);
        }
        // generate trianble to 'support' the circular segments
        rotate([0,-90,0]) linear_extrude(1.1) 
            polygon([[0,0], [0, width_i], [height, width_i]]);
    }      
}

