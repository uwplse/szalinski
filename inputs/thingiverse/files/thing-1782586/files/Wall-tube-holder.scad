// Custom wall tube holder
// By Magonegro SEP-2016

// Inner diameter:
DIAMETER=30;
// Height:
HEIGHT=20;
// Thickness:
THICKNESS=5;
// Aperture angle (typ. 140º):
ANGLE=135;
// Hole diameter (mm):
HOLEDIAMETER=4;
// # Holders:
HOLDERS=1;
// Resolution
FACETS=50;

/* [Hidden] */
module arc( height, depth, radius, degrees ) 
{
    render() 
    {
        difference() 
        {
            rotate_extrude(angle=360,$fn = FACETS)
                translate([radius - height, 0, 0])
                    square([height,depth]);
            translate([0,-(radius+1),-.5]) 
                cube([radius+1,(radius+1)*2,depth+1]);
            rotate([0,0,180-degrees]) 
                translate([0,-(radius+1),-.5]) 
                    cube([radius+1,(radius+1)*2,depth+1]);
        }
    }
}

// Some variables
R2=(THICKNESS/2)*1.8; // Gripper radius
R=(DIAMETER/2)+R2; // Radius for the center of the grippers
XX=R*sin(ANGLE/2); // X coordinate of the center of the grippers
YY=R*cos(ANGLE/2); // Y coordinate of the center of the grippers

union()
{
    for (holder=[0:HOLDERS-1])
    {
        translate([((XX+R2)*1.2*2-0.1)*holder,0,0])
        difference()
        {
            union()
            {
                difference()
                {
                    rotate([0,0,ANGLE/2]) 
                        difference()
                        {
                        cylinder(r=DIAMETER/2+THICKNESS,h=HEIGHT,$fn=FACETS);
                        translate([0,0,-1]) cylinder(r=DIAMETER/2,h=HEIGHT+2,$fn=FACETS);
                        }
                    rotate([0,0,ANGLE/2]) 
                        translate([0,0,-1]) 
                            arc(THICKNESS+2,HEIGHT+2,DIAMETER/2+THICKNESS+1,ANGLE);
                }
                translate([-XX,-YY,0]) cylinder(r=R2,h=HEIGHT,$fn=FACETS);
                translate([XX,-YY,0]) cylinder(r=R2,h=HEIGHT,$fn=FACETS);
                // Support to wall
                translate([-(XX+R2)*1.2,(DIAMETER+THICKNESS)/2,0]) 
                    cube([(XX+R2)*1.2*2,THICKNESS,HEIGHT]);
            }
            // Screw holes allowing for the screw head
            translate([0,(DIAMETER+THICKNESS)/2+THICKNESS+0.5,HEIGHT/2])
            rotate([90,0,0])
            union()
            {
                cylinder(r=HOLEDIAMETER/2,h=HEIGHT,$fn=FACETS);
                translate([0,0,THICKNESS]) 
                    cylinder(r=HOLEDIAMETER,h=HEIGHT,$fn=FACETS);
            }
        }
    }
}