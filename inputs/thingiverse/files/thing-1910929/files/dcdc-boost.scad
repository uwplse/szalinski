// upgrade resolution
$fn = 100;

// dimensions
length = 32;
width = 19;
height = 10;
cornerRadius = 1;
rimHeight = 2;
lidHeight = 1;

// rounded hollow box
difference() {
    roundedBox(length+2, width+2, height+2, cornerRadius); 
    translate([1,1,1]) roundedBox(length, width, height+2, cornerRadius);

    // usb hole
    translate([(width-9)/2,-2,2]) cube([9,3,4]);

    // output wire hole
    translate([width/2,length+2,6]) rotate([90,90,0]) cylinder(d=3, h=3);

    // trimpot hole - screwdriver is 3mm diameter
    translate([-2,length-7,8]) rotate([90,0,90]) cylinder(d=3.5, h=3);
}

// lid
translate([0, length*2+5, 0]) {
    mirror([0,1,0]) {
        roundedBox(length+2, width+2, 1, cornerRadius);
        difference() {
            // rim on lid
            translate([1,1,0]) roundedBox(length,width,lidHeight+rimHeight,cornerRadius);
            translate([2,2,1]) roundedBox(length-2,width-2,lidHeight+rimHeight,cornerRadius);
        }
    }
}

// functions
module roundedBox(length, width, height, radius)
{
    dRadius = 2*radius;
    minkowski() {
        cube(size=[width-dRadius,length-dRadius, height]);
        cylinder(r=radius, h=0.01);
    }
}
