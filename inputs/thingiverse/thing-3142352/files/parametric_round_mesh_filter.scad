diameter = 145;
half_size = diameter / 2;
boundary_width = 5;
boundary_height = 1;
density = 4;

module bounds()
{
    difference()
    {
        translate([0,0,0.5]){cylinder(r = half_size, h = boundary_height);}
        translate([0,0,-0.5]){cylinder(r = half_size-boundary_width, h = 1.5+boundary_height);}
    }
}

module clipping()
{
    difference() {
        translate([-400,-400,-0.5]){cube([800,800,1]);}
        translate([0,0,-0.5]){cylinder(r = half_size, h = 1);};
        }
}

module mesh()
{
    difference() {
        union() {
            for (i = [0 : diameter/density]) {
                translate([-half_size,(i*density)-half_size,0]){cube([diameter,0.5,0.25]);}
            }
            for (i = [0 : diameter/density]) {
                translate([(i*density)-half_size,-half_size,0.2]){cube([0.5,diameter,0.25]);}
            }
        }
        clipping();
        }
}

module filter()
{
    difference()
    {
        union()
        {
            bounds();
            mesh();
        }
    }
}

filter();