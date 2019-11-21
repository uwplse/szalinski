// Created by Carl0sgs
// Derived from Small Calibration Pyramid by LawrenceJohnston (http://www.thingiverse.com/thing:22340)
// Parametric positioning of the peg-top fixed by Obijuan, thank you!
use <utils/build_plate.scad>

diameter = 40; //[10:100]

side_number = 4; //[3:7]

pole_length_percent = 36; //[0:100]

pole_thickness_percent = 12; //[0:100]

corner_bevel_size_percent = 55; //[0:100]
edge_bevel_size_percent = 10; //[0:100]

printing_angle_limit = 55; //[10:80]

// preview[view:south, tilt:top diagonal]

//for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 50; //[50:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 50; //[50:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

radius = diameter/2;

//y = sqrt(2*radius*radius);
//x = sqrt(y*y-radius*radius/4);

//-- Calculate the height of the proyected polygon (on the z=0 plane)
// This is the distance from the center to a side
h1 = radius * cos (360 / (2*side_number));




// Calculate height of the pyramid, adjusting it to the limit of the max printing angle
// Tedious trigonometry going on here. Check http://mathforum.org/library/drmath/view/55203.html
// The idea is to set the angle between the faces of the pyramid, the radius, and obtain the height.
t = 360/side_number;

R2 = radius*radius;
cost = cos(t);
cosA = cos(180+printing_angle_limit);

height = sqrt( (-R2-R2*cost-R2*cosA-R2*cost*cosA) / (2*(cosA+cost)) );




// Previous failed attempts to do the same thing.
// Left here to remind me not to try to do mathematician's job.
//height = radius/1.6;
//a = sqrt(radius*radius + height*height);
//m = (radius*radius)/height;
//n = (a*a)/height;
//h2 = sqrt(m*n);
//alfa = 360/side_number;
//h2 = radius/tan(printing_angle_limit);

//beta = 45+45-alfa;
//height = radius*tan(beta);

//r2 = radius*cos(alfa-90);
//h2 = radius/tan(printing_angle_limit);

//height = pow(radius,2)/sqrt(pow(h2,2)-pow(radius,2));

//beta2 = (180-alfa)/2;
//beta3 = 2*beta2;
//beta4 = (180-beta3)/2;
//height = 10*abs(cos(-alfa/2+printing_angle_limit));




//-- calculate the angle between the side paralell to the y-axis and the z=0 plane
angle = atan(height/h1);

//-- calculate the rotation angle around z so that there is always a side along the y-axis
rotz = (side_number % 2 == 0) ? 360/(2*side_number) : 0;

// Dimensions of the pole in order to keep 50⁰ angle
pole_length = pole_length_percent*0.01*height*2;
spindle_rtop = pole_thickness_percent*0.01*diameter/4;
spindle_rbase_tmp = spindle_rtop+pole_length*tan(180+angle-(90-printing_angle_limit));
// Avoid generating the pole with a thinner
spindle_rbase = (spindle_rbase_tmp > spindle_rtop) ? spindle_rbase_tmp : spindle_rtop;

module spin_top(height) {
    tinyValue = 0.001;
    translate([0,0,h1*cos(-90+angle)]) // Position on Z=0
    rotate([0,180+angle,0])  //-- Fixed!  :-)
    rotate([0,0, rotz])
    union() {
      intersection() {
        hull() {
          cylinder(r=radius, h=tinyValue, center=false, $fn=side_number);
          translate([0, 0, height]) cylinder(r=tinyValue, h=tinyValue, center=false, $fn=side_number);
        }

        // Intersection to create beveled corners
        // Again, crappy way to create the desired bevels
        rotate([0,0,360/(side_number*2)]) cylinder(r1=tinyValue, r2=radius*4*(1-0.01*corner_bevel_size_percent), h=height*2, center=true, $fn=side_number);
		  cylinder(r1=tinyValue, r2=radius*2*(1-0.01*edge_bevel_size_percent), h=height*2, center=true, $fn=side_number);
      } // End of intersection

      rotate([180,0,0]) {
        cylinder(r1=spindle_rbase, r2=spindle_rtop, h=pole_length, center=false, $fn=60);
        translate([0,0,pole_length]) sphere(r=spindle_rtop, $fn=30);
      }
    } //  End of union
}

spin_top(height);
