
diameter=18.2; // measured : bar diameter
distance=52.2; // measured : distance between the bars (including bars)
thickness=4; // wall thickness
space_h=12; // front hook distance
shift_h=12; // front hook shift
height_h=6; // front hook height
alpha_t=210; // top hook angle
alpha_b=135; // bottom hook angle
$fn=60;
width=12; // width of the hook

radius=diameter/2;
distance_c=distance-2*radius;
radius_h=space_h/2;

module part_square(p_size,p_alpha) {
if (p_alpha < 0)
    mirror([0,1]) part_square(p_size,-p_alpha);
else if (p_alpha >= 360)
    part_square(p_size,p_alpha-360);
else if (p_alpha >= 180)
    union() {
        translate([-p_size,0]) square([2*p_size,p_size]);
        rotate(180) part_square(p_size,p_alpha-180);
    }
else if (p_alpha >= 90)
    union() {
        square([p_size,p_size]);
        rotate(90) part_square(p_size,p_alpha-90);
    }
else if (p_alpha > 45)
    difference() {
        square([p_size,p_size]);
        mirror([1,-1]) part_square(p_size,90-p_alpha);
    }
else
    polygon([[0,0],[p_size,0],[p_size,tan(p_alpha)*p_size]]);
}

module part_ring(p_radius,p_thickness,p_alpha){
    p_length=p_radius+p_thickness;
    intersection() {
        difference() {
            circle(p_length);
            circle(p_radius);
        }
        part_square(p_length,p_alpha);
    };
}

module all(){
linear_extrude(width){
    translate([0,distance_c]) part_ring(radius,thickness,alpha_t);
   translate([radius,0]) square([thickness,distance_c]);
    mirror([0,1]) part_ring(radius,thickness,alpha_b);
    translate([radius+radius_h+thickness,shift_h]) rotate(180) 
        part_ring(radius_h,thickness,180);
    translate([radius+2*radius_h+thickness,shift_h]) 
        square([thickness,height_h]);
}
}//remix ....turned the above code into a module called ... all

// remix added module below
module round2d(OR,IR){
    offset(OR)offset(-IR-OR)offset(IR)children();
}

// remix this bit does the internal fillet + external radius
// the round2d module will only work with 2D shapes so projection cuts the profile into 2D then internal and external rads are applied .... then extruded back to height.

linear_extrude(height=width){
round2d(OR=thickness/2-0.1,IR=thickness*1.475)
projection(cut=true) all();
}