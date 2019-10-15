// Designed specifically to hold McCormick spice bottles
// designed by noimjosh


// number of polygons to use to approximate a circle (higher is smoother)
circle_polys = 100; // [30:200]
// (mm) measure the grip-point on the item to be captured.
inner_diameter = 41.5;
// (mm) Set equal to the inner diameter if not desired, otherwise specify a value if you desire a lip at the top.
lip_diameter = 36.5;
// (mm) both the height of the lip and the thickness of the clip
thick = 1.5;
// (mm) extra spacing between clips (added 2 thicknesses)
clip_space = 0;
// multiplied by thickness to achieve nib diameter
nib_ratio = 1.5; //[1:0.1:4]
// (mm) the overall clip height
height = 10;
// the number of clips to attach to one backplate
num_clips = 3;  // [1:15]


/* [Hidden] */
$fn=circle_polys;

outer_diameter = inner_diameter+2*thick;
max_diameter_diff = (outer_diameter-lip_diameter)/2;
width = outer_diameter + thick*2 + clip_space;
total_width = width * num_clips;
clip_at = outer_diameter/4;
nib_diameter = thick * nib_ratio;
nib_angle = asin((clip_at-nib_diameter/2)/((outer_diameter+inner_diameter)/4));
fillet_angle = asin((clip_at-max_diameter_diff/2)/((outer_diameter+inner_diameter)/4));

back_plane();

for (i = [0:(num_clips-1)]){
translate([0, -total_width/2+width*i + width/2, 0]) make_clip();
}

module back_plane(){
    translate([-outer_diameter/2,-total_width/2, 0])cube([thick, total_width, height]);
}

module make_clip(){
    difference(){
        difference() {
            // make initial cylinder with end removed
            cylinder(d=outer_diameter, h=height);
            translate([clip_at,-outer_diameter/2,-0.5]) cube(outer_diameter);
        }
        // cut out lip
        translate([0,0,-0.5]) cylinder(d=lip_diameter, h=height);
        // cut out inner cylinder
        translate([0,0,thick]) cylinder(d=inner_diameter, h=height+1);
        make_fillets();
    }
    
    // Add the holding nibs at the ends...
    rotate(-fillet_angle,0,0)translate([0,outer_diameter/2-nib_diameter/2,0]) cylinder(d=nib_diameter, h=height);
    rotate(fillet_angle,0,0)translate([0,-outer_diameter/2+nib_diameter/2,0]) cylinder(d=nib_diameter, h=height);
}

module make_fillets(){
    if (inner_diameter == lip_diameter) {
        // Add fillet 1
        rotate(-fillet_angle,0,0) translate([0,(outer_diameter+inner_diameter)/4,-0.5]) difference(){
                translate([0,(outer_diameter-inner_diameter)/2,0])rotate([0,0,-90])cube(height+1);
                cylinder(d=max_diameter_diff, h=height+1);
            }
        // Add fillet 2        
        rotate(fillet_angle,0,0) translate([0,-(outer_diameter+lip_diameter)/4,-0.5]) difference(){
                translate([0,(outer_diameter-lip_diameter)/2,0])rotate([0,0,-90])cube(height+1);
                cylinder(d=max_diameter_diff, h=height+1);
            }
    } else {
        // Add fillet 1
        rotate(-fillet_angle,0,0) translate([0,(outer_diameter+lip_diameter)/4,-0.5]) difference(){
                translate([0,(inner_diameter-lip_diameter)/2,0])rotate([0,0,-90])cube(height+1);
                cylinder(d=max_diameter_diff, h=thick+0.5);
            }
        // Add fillet 2        
        rotate(fillet_angle,0,0) translate([0,-(outer_diameter+lip_diameter)/4,-0.5]) difference(){
                translate([0,(inner_diameter-lip_diameter)/2,0])rotate([0,0,-90])cube(height+1);
                cylinder(d=max_diameter_diff, h=thick+0.5);
            }
        }
}