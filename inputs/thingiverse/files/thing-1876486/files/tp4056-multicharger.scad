// upgrade resolution
$fn = 100;

// dimensions
length = 68;
width = 51;
height = 10;
cornerRadius = 2;
rimHeight = 2;
lidHeight = 1;

// rounded hollow box
difference() {
    roundedBox(length+2, width+2, height+2, cornerRadius);
    translate([1,1,1]) roundedBox(length, width, height+2, cornerRadius);

    // usb+wire holes
    translate([2,-3,1]) cube([15,3,height+2]);
    translate([7,length-2,2]) cube([5,3,height+1]);
}

// lid
translate([0, length*2+5, 0]) {
    mirror([0,1,0]) {
        difference() {
            union() {
                roundedBox(length+2, width+2, 1, cornerRadius);
                difference() {
                    // rim on lid
                    translate([1,1,0]) roundedBox(length,width,lidHeight+rimHeight,cornerRadius);
                    translate([2,2,1]) roundedBox(length-2,width-2,lidHeight+rimHeight,cornerRadius);
                

                    // usb+wire+jumper holes
                    translate([4,-2,1]) cube([15,3,lidHeight+rimHeight+1]);
                    translate([7,length-3,1]) cube([5,4,lidHeight+rimHeight+1]);
                }
            }
            
            // jumper hole
            translate([20,11,-2]) cube([22,7,7]);
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
