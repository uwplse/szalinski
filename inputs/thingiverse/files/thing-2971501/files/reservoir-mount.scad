// This is a one-inch ball mount for brake or clutch reservoirs.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfill the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2971501

/* [Main] */

// Define shape of object
shape=0;//[0:Full object,1:Hole Template]

// Define location and number of holes
pattern=3;//[0:Two holes centered on sides,1:Two diagonal holes on corners,2:Four diagonal holes on corners,3:Six holes]

// Number of facets (larger numbers provide better smoothing)
$fn=100;

// Ball diameter in mm
ball_diameter=25.4;

// Bolt hole diameter in mm
bolt_diameter=4.0;

// Height of ball over base in mm
height01=14.0;

// Base plate thickness in mm
thickness=6.0;

// Corner radius in mm
radius=3.0;

// Base plate length in mm
length=55.0;

// Base plate width in mm
width=38.0;

// Horizontal distance between holes in mm
horizontal_offset=40.0;

// Diagonal distance between holes in mm
diagonal_offset=45.0;

rotation_correction = 4.2;

angle = atan(width/length);

fudge_factor = 45 - atan(width/length);


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

module cone()
{
    translate([0,0,3*thickness/2]) cylinder(r1=ball_diameter/2,r2=ball_diameter/4,h=3*thickness,center=true);
}

module base(l,w,h)
{
    difference()
    {
        hull()
        {
            translate([(l/2-radius),(w/2-radius),0])   corner(h,radius);
            translate([(l/2-radius),-(w/2-radius),0])  corner(h,radius);
            translate([-(l/2-radius),(w/2-radius),0])  corner(h,radius);
            translate([-(l/2-radius),-(w/2-radius),0]) corner(h,radius);
        }
        // Drill holes
        if(pattern==0)
        {
            translate([horizontal_offset/2,0,0])  slot(bolt_diameter+0.2,center=true);
            translate([-horizontal_offset/2,0,0]) slot(bolt_diameter+0.2,center=true);
        }
        if(pattern==1)
        {
            rotate([0,0,angle-rotation_correction]) union()
            {
                #translate([diagonal_offset/2,0,0])  rotate([0,0,fudge_factor]) slot(bolt_diameter+0.2,center=true);
                #translate([-diagonal_offset/2,0,0]) rotate([0,0,fudge_factor]) slot(bolt_diameter+0.2,center=true);
            }
        }
        if(pattern==2)
        {
            rotate([0,0,angle-rotation_correction]) union()
            {
                #translate([diagonal_offset/2,0,0])  rotate([0,0,fudge_factor]) slot(bolt_diameter+0.2,center=true);
                #translate([-diagonal_offset/2,0,0]) rotate([0,0,fudge_factor]) slot(bolt_diameter+0.2,center=true);
            }

            rotate([0,0,-angle+rotation_correction]) union()
            {
                #translate([diagonal_offset/2,0,0])  rotate([0,0,-fudge_factor]) slot(bolt_diameter+0.2,center=true);
                #translate([-diagonal_offset/2,0,0]) rotate([0,0,-fudge_factor]) slot(bolt_diameter+0.2,center=true);
            }
        }
        if(pattern==3)
        {
            translate([horizontal_offset/2,0,0])  slot(bolt_diameter+0.2,center=true);
            translate([-horizontal_offset/2,0,0]) slot(bolt_diameter+0.2,center=true);

            rotate([0,0,angle-rotation_correction]) union()
            {
                #translate([diagonal_offset/2,0,0])  rotate([0,0,fudge_factor])  slot(bolt_diameter+0.2,center=true);
                #translate([-diagonal_offset/2,0,0]) rotate([0,0,fudge_factor]) slot(bolt_diameter+0.2,center=true);
            }

            rotate([0,0,-angle+rotation_correction]) union()
            {
                #translate([diagonal_offset/2,0,0])  rotate([0,0,-fudge_factor]) slot(bolt_diameter+0.2,center=true);
                #translate([-diagonal_offset/2,0,0]) rotate([0,0,-fudge_factor]) slot(bolt_diameter+0.2,center=true);
            }
        }
    }
}

if(shape==0) // Render full object
{
    union()
    {
        ball();
        cone();
        base(length,width,thickness);
    }
}

if(shape==1) // Render hole template
{
    difference()
    {
        base(length,width,3.1);
        #hull()
        {
            translate([length/4-radius,width/4,0]) cylinder(r=radius,h=thickness+1,center=true);
            translate([length/4-radius,-width/4,0]) cylinder(r=radius,h=thickness+1,center=true);
            translate([-length/4+radius,width/4,0]) cylinder(r=radius,h=thickness+1,center=true);
            translate([-length/4+radius,-width/4,0]) cylinder(r=radius,h=thickness+1,center=true);
        }
    }
}
