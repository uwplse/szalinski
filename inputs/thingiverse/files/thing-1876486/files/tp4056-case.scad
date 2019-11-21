// upgrade resolution
$fn = 100;

// dimensions
length = 27;
width = 18;
height = 6;
cornerRadius = 1;
rimHeight = 2;
lidHeight = 1;

// rounded hollow box
difference() {
    roundedBox(length+2, width+2, height+2, cornerRadius); 
    translate([1,1,1]) roundedBox(length, width, height+2, cornerRadius);

    // usb+wire holes
    translate([4,-2,1]) cube([9,3,height+2]);
    translate([6,length-1,2]) cube([5,3,height+1]);
}

// lid
translate([0, length*2+5, 0]) {
    mirror([0,1,0]) {
        roundedBox(length+2, width+2, 1, cornerRadius);
        difference() {
            // rim on lid
            translate([1,1,0]) roundedBox(length,width,lidHeight+rimHeight,cornerRadius);
            translate([2,2,1]) roundedBox(length-2,width-2,lidHeight+rimHeight,cornerRadius);

            // usb+wire holes
            translate([4,-1,1]) cube([9,3,3]);
            translate([6,length-2,1]) cube([5,3,3]);
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
