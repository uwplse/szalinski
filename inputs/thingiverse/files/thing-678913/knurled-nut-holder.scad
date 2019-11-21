// Knurled hex nut holder
// Glyn Cowles Feb 2015

// Total diameter of knob
totd=30;
// Height of knob
height=8;
// Nut diameter (point to point not flat to flat)
nutd=18;
// Number of knurls
knurls=12;

difference() {
    cylinder(h=height,r=totd/2,$fn=25);
    cylinder(h=height,r=nutd/2,$fn=6);
    for (r=[0:360/knurls:360]) {
        rotate([0,0,r]) translate([totd/1.8,0,0]) cylinder(h=height,r=(totd/5)/2,$fn=15);
    }
}

