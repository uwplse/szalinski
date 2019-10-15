holedia = 13; // diameter of the hole for the jack
holeheight=22.5; // height of hole center from bottom
pedalheight=34; // total pedal height
thickness=4; // desired material thickness
boardthick=12; // board thickness
width=holedia+thickness;

// vertical part
difference() 
{
    translate([0,0,-boardthick]) cube([thickness,width,pedalheight+boardthick]);
    translate([-thickness, width/2, holeheight]) 
    {
        rotate([0,90,0])
        {
            cylinder(h=thickness*3, r=holedia/2);
        }
    }
}

// top part
translate([0,0,pedalheight]) cube([thickness*3,width,thickness]);

// bottom part
translate([0,-width/2,-boardthick-thickness*2,]) cube([thickness*2,width*2,thickness*2]);
