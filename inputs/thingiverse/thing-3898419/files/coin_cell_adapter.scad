//Larger coin cell dia (in mm)
largecelld=24;
//Larger coin cell height (in 0.1mm)
largecellh=50;
//Smaller coin cell dia (in mm)
smallcelld=20;
//Smaller coin cell height (in 0.1mm)
smallcellh=32;

difference() {
    cylinder(largecellh/10,d=largecelld);
    union() {
        translate([0,(largecelld-smallcelld)/2,largecellh/10-smallcellh/10]) cylinder(smallcellh/10+1,d=smallcelld);
        translate([0,largecelld/2+smallcelld*.25,-0.01]) cylinder(largecellh/10+1,d=smallcelld);
    }
}