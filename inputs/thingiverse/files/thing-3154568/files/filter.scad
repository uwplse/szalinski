
// Outer diameter of your plughole, in mm
outer_diameter = 78;

// Inner diameter for the plug in mm, if you have a sold cap plug, set this to the same size
inner_diameter = 65;

// Height of whole assembly in mm
plug_height = 25;

// radius of inner knob, in mm
knob_r = 12.5/2;

// number of gaps to have, 8 works quite well
num_gaps = 8; // count

// size of gap, in degrees
hole_size =20; 

// -1 if your blades spin clockwise when looking from the top, +1 if they spin anti-clockwise
clockwise =-1;  

// Ignore these
plug_size = (360/num_gaps)-hole_size;
outer_radius=outer_diameter/2;
inner_radius=inner_diameter/2;
disc_h = plug_height/2;
$fn=100;

module filter(){    
        for(i=[0:num_gaps]) {
                rotate( a=(i*360)/num_gaps )
                    slice(inner_radius+1,hole_size,plug_size);
        }
    }


module lower() {
    difference() {
        cylinder(disc_h,outer_radius, outer_radius);
        cylinder(disc_h,inner_radius, inner_radius);
    }
        filter();
}

module ring(){
    translate([0,0,disc_h])     
    linear_extrude(height=disc_h){
difference(){
        circle(outer_radius);
        circle(inner_radius);
    }
}
}
union(){
    lower();
    ring();
    cylinder(1.5*disc_h, knob_r/2,knob_r/2);     
    translate([0,0,2*disc_h-knob_r]) sphere(knob_r);
}

module slice(rad=1, start=2, end=4){
                    linear_extrude(height=disc_h, slices=20, twist=clockwise * plug_size){
                difference(){
                    circle(rad);
                      rotate([0,0,start+end]) square(2*rad);
                      rotate([0,0,start+90]) square(2*rad);
                      rotate([0,0,start+180]) square(2*rad);
                      rotate([0,0,start+270]) square(2*rad);
                }
            }
        }
