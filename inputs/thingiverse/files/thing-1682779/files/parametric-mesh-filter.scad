fan_size = 140;
half_size = fan_size / 2;
hole_size = 7;
hole_dist = 7.5;

module hole()
{
    translate([half_size-hole_dist,half_size-hole_dist,-1]){cylinder(r=hole_size/2, h=3);}
}

module holes()
{
    for (i = [0 : 4])
        rotate([0,0,i*90]){hole();}
}

module corners()
{
    difference()
    {
        translate([-half_size,-half_size,0.4]){cube([fan_size,fan_size,0.25]);};
        cylinder(h = 3, r = (fan_size + 2) / 2, center = [-half_size,-half_size,-1]);
    }
}

module bounds()
{
    union()
    {
        for (i = [0 : 4])
        {
            rotate([0,0,i * 90]){translate([-half_size,-half_size,0.4]){cube([fan_size,5,0.25]);}}
        }
        corners();
    }
}

module mesh()
{
    difference() {
        union() {
            for (i = [0 : half_size]) {
                translate([-half_size,(i*2)-half_size,0]){cube([fan_size,0.5,0.25]);}
            }
            for (i = [0 : half_size]) {
                translate([(i*2)-half_size,-half_size,0.2]){cube([0.5,fan_size,0.25]);}
            }
        }
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
        holes();
    }
}

filter();