// upgrade resolution
$fn = 200;

// dimensions
length = 50;
width = 95;
height = 20;
cornerRadius = 10;

// lid with rim
mirror([0,1,0]) {
    roundedBox(length, width, 1, cornerRadius);
    difference() {
        translate([1,1,0]) {
            roundedBox(length-2,width-2,4,cornerRadius);
        }
        translate([2,2,0]) {
            roundedBox(length-4,width-4,4,cornerRadius);
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
