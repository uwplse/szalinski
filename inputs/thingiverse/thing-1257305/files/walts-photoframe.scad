// Rod Height
rod_height = 35; // [1:150]

// Rod Diameter
rod_diameter=5; // [2:20]

// Wall Cylinder Base Diameter
base_diameter = 20; // [10:100]

// Photo Frame Base Width
frame_width=60; // [10:150]

/* [Hidden] */

$fn=50;
rod_half=rod_height/2;

quarter_frame=(frame_width-(rod_diameter*3))/2;

difference()
{
    cube([frame_width,frame_width,1], center=true);
    cube([frame_width-(rod_diameter*2),frame_width-(rod_diameter*2),1], center=true);
}

cube([frame_width,rod_diameter,1], center=true);
cube([rod_diameter,frame_width,1], center=true);
cylinder(h=1, r=rod_diameter, center=true);

translate([0,0,rod_half]) 
{
    difference()
    {
        cylinder(h=rod_height, r=rod_diameter/2, center=true);
        cylinder(h=rod_height, r=rod_diameter/4, center=true);
    }
}

translate([0,0,rod_height])
{
    cylinder(h=1,r=base_diameter/2, center=true);
}