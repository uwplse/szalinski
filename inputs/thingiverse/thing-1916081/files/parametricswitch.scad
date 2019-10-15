$fn = 60;

//switch size
switch = 12.5;

//screw size
screw = 5.5;

//extrusion size
extrusion = 20;

//plate thickness
thickness = 5;

//sides (2 = side by side, 3 = L shaped, 4 = square) 
side = 3;

difference()
{
    cube([extrusion,extrusion,thickness]);
    translate([extrusion/2, extrusion/2, 0]) cylinder(r = switch/2, h = thickness);    
}

translate([extrusion,0,0])
{
    difference()
    {
        cube([extrusion,extrusion,thickness]);
        translate([extrusion/2, extrusion/2, 0]) cylinder(r = screw/2, h = thickness); 
    }
}

if (side >= 3 )
    {
        translate([0,extrusion,0])
        {
            difference()
            {
            cube([extrusion,extrusion,thickness]);
            translate([extrusion/2, extrusion/2, 0]) cylinder(r = screw/2, h = thickness); 
            }
        }
    }
    
if (side == 4)
    {
        translate([extrusion,extrusion,0])
        {
            difference()
            {
               cube([extrusion,extrusion,thickness]);
               translate([extrusion/2, extrusion/2, 0]) cylinder(r = screw/2, h = thickness); 
            }
        }
    }
    