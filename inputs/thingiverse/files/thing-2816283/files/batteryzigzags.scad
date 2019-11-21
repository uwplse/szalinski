module column(batdiam, batlen, angle, ziga, totheight, pos)
{
    // Compute the actual height of the truncated part: length of a battery plus enough to truncate it
    h=(totheight-2*2-batlen*sin(angle))*cos(angle);
    oneheight = batdiam*sin(ziga);
    nb = floor(h/oneheight-2)+1;
    nbodd = (nb % 2 == 0);
    translate([batlen, pos, batdiam/2])
        rotate([0, -90+angle, 0])
            difference()
            {
                union()
                {
                    // The first battery of the series: make a hole there to be able to take it out!
                    translate([batdiam*sin(ziga)*nb, nbodd ? 0 : -batdiam*cos(ziga), -10])
                        rotate([0, 0, nbodd ? 270-ziga : 90+ziga])
                            cylinder(h=batlen*2, r=batdiam/2);
                    difference()
                    {
                        union()
                        {
                            // The battery column itself
                            linear_extrude(height=batlen+h*sin(angle))
                                union()
                                {
                                    circle(r=batdiam/2);
                                    for (i = [1:nb])
                                    {
                                        odd = (i % 2 == 0);
                                        translate([batdiam*sin(ziga)*i, odd ? 0 : -batdiam*cos(ziga), 0])
                                            rotate([0, 0, odd ? 270-ziga : 90+ziga])
                                                union()
                                                {
                                                    translate([0, -batdiam/2]) square([batdiam, batdiam]);
                                                    circle(r=batdiam/2);
                                                }
                                    }
                                }
                        }
                        union()
                        {
                            // truncate the top part that will be on the front
                            translate([-batdiam/2-4, -batdiam*2, 0])
                                rotate([0, 90-angle, 0])
                                    cube([h*sin(angle), batdiam*4, h/cos(angle)]);
                        }
                    }
                    difference()
                    {
                        // The + pole that comes out of the battery
                        translate([0, 0, -3]) linear_extrude(height=batlen+h*sin(angle))
                            union()
                            {
                                circle(r=batdiam/4);
                                for (i = [1:nb])
                                {
                                    odd = (i % 2 == 0);
                                    translate([batdiam*sin(ziga)*i, odd ? 0 : -batdiam*cos(ziga), 0])
                                        rotate([0, 0, odd ? 270-ziga : 90+ziga])
                                            union()
                                            {
                                                translate([0, -batdiam/4]) square([batdiam, batdiam/2]);
                                                circle(r=batdiam/4);
                                            }
                                }
                            }
                        // truncate the top part that will be on the front
                        translate([-batdiam/2+5, -batdiam*2, 0])
                            rotate([0, 90-angle, 0])
                                cube([h*sin(angle)+3, batdiam*4, h/cos(angle)]);
                    }
                }
                union()
                {
                    // truncate the bottom part that will end up as the deepest part in the holder
                    translate([h-batdiam/2+batlen*sin(angle), -batdiam*2, batlen+h*sin(angle)])
                        rotate([0, -90-angle, 0])
                            cube([h*sin(angle), batdiam*4, h/cos(angle)+batlen*sin(angle)]);
                }
            }
}

module prism(l, w, h)
{
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

$fn=50;
// Standard AA
aadiam=15.5;
aalen=50;
// Standard AAA
aaadiam=11.5;
aaalen=43;

// The battery diameter
batdiam=aaadiam;
// The battery length
batlen=aaalen;
// The angle of the batteries inside the holder for them not to slip out
angle=8;
// The angle of the zigzags
ziga=50;
// The minimum width of the walls between two columns
distance=3;
// Number of batteries per column
nbbat = 12;

// Number of columns
nbcol=5;

// The total height of the holder
totheight=distance*2+batdiam+batdiam*(nbbat-1)*sin(ziga)+batlen*sin(angle);

// The interval between two columns
interval=batdiam/2/sin(ziga)+(batdiam/2+distance)/sin(ziga);

// The total width of the whole holder
totlarg=nbcol*interval+distance+batdiam/2*cos(ziga);

// The length needed to fit a battery when it is at an angle
batlen2 = batlen+batdiam*sin(angle);

holder_only = false;

nbodd = (nbbat % 2 == 0);

//rotate([0, -90, 0])
union()
{
    difference()
    {
        union()
        {
            cube([batlen2*0.9, totlarg, totheight]);
            if (!holder_only)
                translate([batlen2*0.9, 0, batdiam/cos(angle)*(nbbat-1.6)*sin(ziga)-1]) cube([batlen2*0.2+2, totlarg, batdiam]);
        }
        union()
        {
            translate([3, 0, 0]) union()
            {
                for (i = [0:nbcol-1])
                {
                    posy = interval*i+batdiam/2+batdiam*cos(ziga)+distance;
                    column(batdiam, batlen2+2, angle, ziga, totheight, posy);
                }
            }
            if (holder_only)
                for (i = [0:nbcol-1])
                {
                    posy = interval*i+batdiam/2+batdiam*cos(ziga)+distance + batdiam*(nbodd ? -cos(ziga)*1.4 : 0.25);
                    translate([batlen2*0.9, posy, batdiam/cos(angle)*(nbbat-1.1)*sin(ziga)-1]) rotate([0, -90, 0]) cylinder(h=5, r1=2, r2=1);
                }
            else
                cube([batlen2*0.9, totlarg, totheight]);
        }
    }
    if (!holder_only)
        for (i = [0:nbcol-1])
        {
            posy = interval*i+batdiam/2+batdiam*cos(ziga)+distance + batdiam*(nbodd ? -cos(ziga)*1.4 : 0.25);
            translate([batlen2*0.9, posy, batdiam/cos(angle)*(nbbat-1.1)*sin(ziga)-1]) rotate([0, -90, 0]) cylinder(h=5, r1=1.6, r2=0.6);
        }
}
