// This is a one-inch ball mount with AMPs hole pattern.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfill the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2983209

/* [Main] */

// Number of facets (larger numbers provide better smoothing)
$fn=100;

// Define shape of object
shape=0;//[0:Full object,1:Hole Template]

// Ball diameter in mm
ball_diameter=25.0;

// Bolt hole diameter in mm
bolt_diameter=5.0;

// Cylinder diameter in mm
cylinder_diameter=10.0;

// Height of ball over base in mm
height01=10.0;

// Base plate thickness in mm
thickness=6.0;

// Corner radius in mm
radius=3.0;

// Base plate length in mm
length=50.8;

// Base plate width in mm
width=43.0;

// Hole horizontal offset from center in mm
hole_offset=22.5;

// Hole diagonal offset from center in mm
//diagonal_offset=14.5;

// Rotation correction in degrees
rotation_correction=2.0;

module slot(slot_width)
{
    hull()
    {
        #translate([slot_width/2,0,0])  cylinder(h=2*thickness,r=slot_width/2+0.2,center=true);
        #translate([-slot_width/2,0,0]) cylinder(h=2*thickness,r=slot_width/2+0.2,center=true);
    }
}

module corner(corner_height,corner_radius)
{
    translate([0,0,-corner_radius/2]) cylinder(h=corner_height-corner_radius,r=corner_radius,center=true);
    translate([0,0,0]) sphere(r=corner_radius,center=true);
}

module ball()
{
    translate([0,0,height01+ball_diameter/2]) sphere(r=ball_diameter/2,center=true);
}

module column()
{
    translate([0,0,height01/2]) cylinder(r=cylinder_diameter/2,h=height01+3,center=true);
}

module cone()
{
    translate([0,0,thickness/2+1]) cylinder(r1=cylinder_diameter/2+2,r2=cylinder_diameter/2,h=2,center=true);
}

module base()
{
    difference()
    {
        hull()
        {
            translate([(length/2-radius),(width/2-radius),0])   corner(thickness,radius);
            translate([(length/2-radius),-(width/2-radius),0])  corner(thickness,radius);
            translate([-(length/2-radius),(width/2-radius),0])  corner(thickness,radius);
            translate([-(length/2-radius),-(width/2-radius),0]) corner(thickness,radius);
        }
        // Drill holes
        rotate([0,0,atan(width/length)-rotation_correction])
        union()
        {
            #translate([hole_offset,0,0])  slot(bolt_diameter+0.2,center=true);
            #translate([-hole_offset,0,0]) slot(bolt_diameter+0.2,center=true);
        }
rotate([0,0,-atan(width/length)+rotation_correction])
        union()
        {
            #translate([hole_offset,0,0])  slot(bolt_diameter+0.2,center=true);
            #translate([-hole_offset,0,0]) slot(bolt_diameter+0.2,center=true);
        }
    }
}

if(shape==0) // Render full object
{
    union() // Draw shape
    {
        ball();
        column();
        cone();
        base();
    }
}

if(shape==1) // Render hole template
{
    difference()
    {
        base();
        #hull()
        {
            translate([length/4-2*radius,width/4-radius,0]) cylinder(r=radius,h=2*thickness,center=true);
            translate([length/4-2*radius,-width/4+radius,0]) cylinder(r=radius,h=2*thickness,center=true);
            translate([-length/4+2*radius,width/4-radius,0]) cylinder(r=radius,h=2*thickness,center=true);
            translate([-length/4+2*radius,-width/4+radius,0]) cylinder(r=radius,h=2*thickness,center=true);
        }
    }
}


