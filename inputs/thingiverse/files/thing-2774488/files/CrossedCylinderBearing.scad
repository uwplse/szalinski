/* [Bearing] */
// Which part would you like to see?
part = "Overview"; // [outer_ring_upper_part:Outer ring upper part,outer_ring_lower_part:Outer ring lower part,inner_ring:Inner ring,rollers:Roller,cage:Cage,overview:Overview]

// Outer diameter
d_outer = 65;

// Bore diameter
d_bore = 15;

// Width
width = 15;

// Chamfer size (WxH)
chamfer = 0.6;

// Spacing between rolling surfaces (tolerance)
t_roll = 0.02;

// Spacing between sliding surfaces (tolerance)
t_slide = 0.3;

// Roller diameter, select -1 for automatic calculation
d_roller = -1; 

// Resolution of circles
fn = 180;


/* [Screw holes] */
// Number of screw holes
screw_hole_count = 8;

// Screw hole diameter
screw_hole_diam = 4.1;

// Distance of screw holes from edge or the ring
screw_hole_edge_distance = 4;


/* [Hidden] */
dr_cage_space = 3;
roll_spacing = 2;

fn = 180/2;

cube_size = 10; // [1:100]
cylinder_size = 10; // [1:100]


// preview[view:north east, tilt:top diagonal]
print_part();


module print_part() {
	if (part == "outer_ring_upper_part") {
		outer_ring_upper_part(r2=d_outer/2, r1=d_bore/2, d_roller=d_roller, h=width);
	} else if (part == "outer_ring_lower_part") {
		outer_ring_lower_part(r2=d_outer/2, r1=d_bore/2, d_roller=d_roller, h=width);
	} else if (part == "inner_ring") {
		translate([0,0,width/2]) inner_ring(r2=d_outer/2, r1=d_bore/2, d_roller=d_roller, h=width);
	} else if (part == "rollers") {
		translate([0,0,(nominal_roller_diam(d_roller, width)-2*t_slide)/2]) 
            print_rollers(r2=d_outer/2, r1=d_bore/2, d_roller=d_roller, h=width);
	} else if (part == "cage") {
		translate([0,0,width/2-t_slide]) cage(r2=d_outer/2, r1=d_bore/2, d_roller=d_roller, h=width);
	} else {
        crossed_cylinder_bearing(r2=d_outer/2, r1=d_bore/2, d_roller=d_roller, h=width);
	}
}


module crossed_cylinder_bearing(r2, r1, d_roller, h)
{
    difference() {
        translate([0,0,width/2]) {
            difference() {
                translate([0,0,width/2]) rotate([180,0,0])outer_ring_upper_part(r2, r1, d_roller, h);
                translate([1000,0,0])cube(2000, center=true);
            }
            translate([0,0,-width/2]) outer_ring_lower_part(r2, r1, d_roller, h);
            inner_ring(r2, r1, d_roller, h);
        
            dk = nominal_roller_diam(d_roller, h);
            rc = (r2+r1)/2;
            N = number_of_rollers(rc, dk, h);

            for(i = [0 : 1 : N-1])
                rotate([0,0,i*360/N]) translate([0,rc,0]) 
                    rotate([-45+90*(i % 2),0,0]) 
                        roller(nominal_roller_diam(d_roller, width)-2*t_roll, 
                               nominal_roller_diam(d_roller, width)-2*t_slide, 
                               chamfer=chamfer);
            
            cage(r2=d_outer/2, r1=d_bore/2, d_roller=d_roller, h=width);
        }
        
        translate([1000,1000,0])cube(2000, center=true);
    }
}


function nominal_roller_diam(d_roller, h) = 
            d_roller <= 0 ? h*9/15 : d_roller;
function number_of_rollers(rc, d_roller, h) = 
            2*floor(3.14159265*rc / (nominal_roller_diam(d_roller, h)+2*t_slide+roll_spacing)+0.5);


module outer_ring_upper_part(r2, r1, d_roller, h)
{
    translate([0,0,h/2]) difference() {
        outer_ring_half(r2, r1, d_roller, h);
    }
}


module outer_ring_lower_part(r2, r1, d_roller, h)
{
    translate([0,0,h/2]) difference() {
        outer_ring_half(r2, r1, d_roller, h);
    }
}


module outer_ring_half(r2, r1, d_roller, h)
{
    dk = nominal_roller_diam(d_roller, h);
    rc = (r2+r1)/2;
    r_inside = rc + dr_cage_space/2;
    r_bp1 = rc + dk/2*sqrt(2);
    r_bm1 = rc - dk/2*sqrt(2);

    difference() {
        union() {
            rotate([180,0,0]) 
                difference() {
                    cylinder(r=r2, h=h/2, center=false, $fn=fn);
                    cylinder(r=r_inside, h=h, center=false, $fn=fn);
                    translate([0,0,-r_bp1]) cylinder(r1=2*r_bp1, r2=0, h=2*r_bp1, center=false, $fn=fn);
                }
            
            translate([0,0,-h/8]) difference() {
                cylinder(r=r_bp1+sqrt(0.5)*chamfer,h=h/4, center=true, $fn=fn);
                cylinder(r=r_bp1-sqrt(0.5)*chamfer,h=h, center=true, $fn=fn);
            }
        }
        
        // Chamfer
        cylinder_inside_chamfer_cutout(2*r_inside, h/2, chamfer, 0.5*fn);
        rotate([180,0,0]) cylinder_inside_chamfer_cutout(2*r_inside, h/2, chamfer, 0.5*fn);

        // Screw holes
        M = screw_hole_count;
        for(i = [0 : 1 : M-1])
            rotate([0,0,i*360/M]) translate([r2-screw_hole_edge_distance, ,0]) 
                cylinder(d=screw_hole_diam, h=2*h,center=true,$fn=0.25*fn);
    }
}


module inner_ring(r2, r1, d_roller, h)
{
    dk = nominal_roller_diam(d_roller, h);
    rc = (r2+r1)/2;   
    r_outside = rc-dr_cage_space/2;
    r_bp1 = rc + dk/2*sqrt(2);
    r_bm1 = rc - dk/2*sqrt(2);
 
    union() {
        difference() {
            cylinder(r=r_outside, h=h, center=true, $fn=fn);
            cylinder(r=r1, h=2*h, center=true, $fn=fn);
             difference() {
                cylinder(r=rc, h=1.5*h, center=true, $fn=fn);
                translate([0,0,-r_bm1]) cylinder(r1=2*r_bm1, r2=0, h=2*r_bm1, center=false, $fn=fn);
                rotate([180,0,0]) translate([0,0,-r_bm1]) cylinder(r1=2*r_bm1, r2=0, h=2*r_bm1, center=false, $fn=fn);
                difference() {
                    cylinder(r=r_bm1+sqrt(0.5)*chamfer,h=h/4, center=true, $fn=fn);
                    cylinder(r=r_bm1-sqrt(0.5)*chamfer,h=2*h, center=true, $fn=fn);
                }
            }
           
            // Chamfer
            cylinder_chamfer_cutout(2*r_outside, h/2, chamfer, 0.5*fn);
            rotate([180,0,0]) cylinder_chamfer_cutout(2*r_outside, h/2, chamfer, 0.5*fn);

            // Screw holes
            M = screw_hole_count;
            for(i = [0 : 1 : M-1])
                rotate([0,0,i*360/M]) translate([r1+screw_hole_edge_distance, ,0]) 
                    cylinder(d=screw_hole_diam, h=2*h,center=true,$fn=0.25*fn);
        }

    }
}


module roller(d, h, chamfer)
{
    difference() {
        cylinder(d=d, h=h, center=true, $fn=0.5*fn);
        
        // Chamfer
        cylinder_chamfer_cutout(d, h/2, chamfer, 0.5*fn);
        rotate([180,0,0]) cylinder_chamfer_cutout(d, h/2, chamfer, 0.5*fn);
    }
}


module print_rollers(r2, r1, d_roller, h)
{
    dk = nominal_roller_diam(d_roller, h);
    rc = (r2+r1)/2;
    N = number_of_rollers(rc, dk, h);
    echo(d_roller=d_roller, h=h, N=N);
    
    m = floor(sqrt(N)+0.5);

    for(i = [0 : 1 : N-1]) {
        y = floor(i/m);
        x = i  - m*y;
        translate([(dk+roll_spacing)*x, (dk+roll_spacing)*y,0]) 
            roller(nominal_roller_diam(d_roller, width)-2*t_roll, 
                   nominal_roller_diam(d_roller, width)-2*t_slide, 
                   chamfer=chamfer);
    }
}


module cage(r2, r1, d_roller, h)
{
    dk = nominal_roller_diam(d_roller, h);
    rc = (r2+r1)/2;       
    N = number_of_rollers(rc, dk, h);
    echo(required_number_of_rollers=N);

    difference() {
        union() {
            difference() {
                cylinder(r=rc+dr_cage_space/2-2*t_slide, h=h-2*t_slide, center=true, $fn=fn);
                cylinder(r=rc-dr_cage_space/2+2*t_slide, h=2*h, center=true, $fn=fn);
            }
        }
        
        for(i = [0 : 1 : N-1])
            rotate([0,0,i*360/N]) translate([0,rc,0]) 
                rotate([-45+90*(i % 2),0,0]) roller(dk+3*t_slide, dk, chamfer);
    }
}


module cylinder_chamfer_cutout(d, h, b, fn)
{
    difference() {
        translate([0,0,h-b]) cylinder(d=2*d, h=3*b, center=false, $fn=fn); 
        translate([0,0,-d/2+h-b]) cylinder(d1=2*d, d2=0, h=d , center=false, $fn=fn); 
    }
}


module cylinder_inside_chamfer_cutout(d, h, b, fn)
{
    translate([0,0,-d/2+h-b]) cylinder(d1=0, d2=2*d, h=d , center=false, $fn=fn); 
}
