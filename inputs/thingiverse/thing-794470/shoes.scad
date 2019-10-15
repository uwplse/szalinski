//Set shoe width in mm
width=20;
length=width*1.5;

//Set shoe wall width in mm
wall=1.5;
holderheight=width;

//Set shoe holder in percent of the shoe length
holderplace=.3;

//Set gap for the holder so the paper is held tight in mm
holdergap=.5;


rotate([90,0,0])
union()
{
    cylinder(r=width/2,h=wall);
    translate([0,-width/2,0])
    {
        cube([length,width,wall]);

        //holders
        translate([length*holderplace,0,0])
            cube([wall,width,holderheight]);
        translate([length*holderplace+wall+holdergap,0,0])
            cube([wall,width,holderheight]);
    }
}