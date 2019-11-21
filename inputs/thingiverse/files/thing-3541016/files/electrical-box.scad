// terminal block connection box, original design by Hussein Suleman 31/03/2018
// remix by Simon John 04/04/2019

height = 15; // height of the box
width = 25; // width of the box
length = 40; // length of the box (distance between grommets)
glength = 10; // grommet length
cable_in = 7.8; // cable inner diameter
cable_out = 7.8; // cable outer diameter
wall = 2;
floors = 2;
radius = 3;
$fn = 100;

// create rounded box with recessed inner surface
module roundbox (w, h, d, rimw, rimr, base)
{
    difference ()
    {
        union ()
        {
            translate ([0,rimr,0]) cube ([w,h-(2*rimr),d]);
            translate ([rimr,0,0]) cube ([w-(2*rimr),h,d]);
            translate ([rimr,rimr,0]) cylinder (r=rimr,h=d,$fn=100);
            translate ([rimr,h-rimr,0]) cylinder (r=rimr,h=d,$fn=100);
            translate ([w-rimr,rimr,0]) cylinder (r=rimr,h=d,$fn=100);
            translate ([w-rimr,h-rimr,0]) cylinder (r=rimr,h=d,$fn=100);
        }

        translate ([rimw,rimr,base]) cube ([w-(2*rimw),h-(2*rimr),d-base+1]);
        translate ([rimr,rimw,base]) cube ([w-(2*rimr),h-(2*rimw),d-base+1]);
        translate ([rimr,rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=100);
        translate ([rimr,h-rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=100);
        translate ([w-rimr,rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=100);
        translate ([w-rimr,h-rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=100);
    }
}

// adjust height if grommets do not fit
height1 =  (cable_in+8 > height) ? cable_in+8 : height;
height2 =  (cable_out+8 > height1) ? cable_out+8 : height1;

// create box
difference ()
{
    union ()
    {
        // main box
        translate ([-width/2,-length/2,0]) roundbox (width, length, height2, wall, radius, floors);

        // grommet1
        translate ([0,-length/2,height2/2]) rotate ([90,0,0])
        {
            cylinder(d=cable_in+8, h=glength);
            translate([-(cable_in+8)/2,-(cable_in+8)/2,0]) cube([cable_in+8, cable_in, glength]);
        }

        // grommet2
        rotate ([0,0,180]) translate ([0,-length/2,height2/2]) rotate ([90,0,0])
        {
            cylinder (d=cable_out+8, h=glength);
            translate([-(cable_out+8)/2,-(cable_out+8)/2,0]) cube([cable_out+8, cable_out, glength]);
        }

        // screw pillars
        translate ([-width/2+wall+wall, -length/2+wall+wall, 0]) cylinder (h=height2, d=6);
        translate ([width/2-wall-wall, length/2-wall-wall, 0]) cylinder (h=height2, d=6);
    }

    // grommet holes
    rotate ([0,0,0]) translate ([0,-length/2+3,height2/2]) rotate ([90,0,0]) cylinder (d=cable_in, h=glength+4);
    rotate ([0,0,180]) translate ([0,-length/2+3,height2/2]) rotate ([90,0,0]) cylinder (d=cable_out, h=glength+4);

    // screw pillar holes
    translate ([-width/2+wall+wall, -length/2+wall+wall, 5]) cylinder (h=height2-4, d=2);
    translate ([width/2-wall-wall, length/2-wall-wall, 5]) cylinder (h=height2-4, d=2);
}

// create lid
translate ([width+5,0,0])
{
    difference ()
    {
        union ()
        {
            translate ([-width/2,-length/2,0]) roundbox (width, length, 2, wall, radius, floors);
            translate ([-width/2+wall+0.25,-length/2+wall+0.25,2]) roundbox (width-wall-wall-0.5, length-wall-wall-0.5, 1, 1, radius, 0);
        }

        translate ([-width/2+wall+wall, -length/2+wall+wall, 2]) cylinder (h=4, d=7);
        translate ([width/2-wall-wall, length/2-wall-wall, 2]) cylinder (h=4, d=7);
        translate ([-width/2+wall+wall, length/2-wall-wall, 2]) cylinder (h=4, d=7);
        translate ([width/2-wall-wall, -length/2+wall+wall, 2]) cylinder (h=4, d=7);
        translate ([-width/2+wall+wall, length/2-wall-wall, -1]) cylinder (h=4, d=2);
        translate ([width/2-wall-wall, -length/2+wall+wall, -1]) cylinder (h=4, d=2);
    }
}
