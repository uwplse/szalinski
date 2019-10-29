$fn = 50;
hexdiam = 4.1; // hexbit diameter
wall = 4; // gap around bits
boxheight = 12; // depth of hole for bit
rows = 11;
cols = 8;

translate([0,cols*(hexdiam+wall),0])
{
    toolbox();
}

for (k=[0:cols-1])
{
    translate([0,k*(hexdiam+wall),-(boxheight-boxheight)])
    {
        cube([rows*(hexdiam+wall),hexdiam+wall,k*(boxheight/2)]);
    }

    translate([0,k*(hexdiam+wall),k*(boxheight/2)])
    {
        hexbox();
    }
}

module hexbox()
{
    for (k=[0:rows-1])
    {
        translate([k*(hexdiam+wall),0,0])
        {
            difference()
            {
                cube([hexdiam+wall,hexdiam+wall,boxheight],center=false);
                translate([(hexdiam+wall)/2,(hexdiam+wall)/2,wall])
                {
                    cylinder(h=boxheight, d=hexdiam, center=false, $fn=6);
                }
            }
        }
    }
}

module toolbox()
{
    difference()
    {
        cube([rows*(hexdiam+wall),30,cols*(boxheight/2)+boxheight],center=false);

        union()
        {
            // flex rod - 9mm wide, 150mm tall
            translate([10,15,wall])
            {
                cylinder(h=150, d=10, center=false);
            }

            // long screwdriver - 20mm at widest, 150mm tall
            translate([30,15,wall])
            {
                cylinder(h=150, d=21, center=false);
            }
            
            // extension - 4mm wide, 120mm tall
            translate([50,15,wall])
            {
                cylinder(h=120, d=hexdiam, center=false, $fn=6);
            }
            
            // short screwdriver - 22mm at widest, 81mm tall
            translate([70,15,wall])
            {
                cylinder(h=81, d=23, center=false);
            }
        }
    }
}
