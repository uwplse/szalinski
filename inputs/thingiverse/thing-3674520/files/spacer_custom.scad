/* [Main Dimensions] */

// Hart-to-hart Distance between frames (35 - 38 are most used variations)
distance = 37;
// Frame size width (better set slightly larger than the actual width)
framesize = 23;
// Number of Frames
frames = 6;
// Thickness of spacer
Thickness = 1.6;
// Size of mount holes
holesize = 2;

/* [Hidden] */
leng = (frames)*distance;
wid = 26;
offset = 7;

echo("length=",leng);

module hole()
{
    hull()
    {
        translate([0,4,0])
            cube([framesize+2,1,Thickness],center=true);
        translate([0,-4,0])
            cube([framesize,1,Thickness],center=true);
    }
    translate([0,-4.5-3,0])
        cube([10,6,Thickness],center=true);
    hull()
    {
        translate([0,-4.5,0])
            cube([12,1,Thickness],center=true);
        translate([0,-4.5-5.5,0])
            cube([10,1,Thickness],center=true);
    }
}

difference()
{
    cube([leng,wid,Thickness],center=true);
    translate([-leng/2+distance/2,0,0])
    for(i=[0:frames-1])
    {
        translate([distance*i,wid/2-4,0])
            hole();
    }
    translate([-leng/2+distance,-offset,0])
    for(i=[0:frames-2])
    {
        translate([distance*i,0,0])
            cylinder(r=holesize/2,h=Thickness,$fn=50,center=true);
    }
    translate([-leng/2+holesize*2,-offset,0])
        cylinder(r=holesize/2,h=Thickness,$fn=50,center=true);
    translate([leng/2-holesize*2,-offset,0])
        cylinder(r=holesize/2,h=Thickness,$fn=50,center=true);
}
