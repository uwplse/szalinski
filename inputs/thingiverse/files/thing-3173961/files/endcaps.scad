width = 56.31;
depth = 7.05;
height = 7;

//single: w=28.31
//double: w=56.31
//triple: w=84.31

difference () {
    cube([width+2,depth+2,height]);
    translate([1,1,1]) cube([width,depth,height]);
};