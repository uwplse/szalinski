topAxleWidth = 4.7;
bottomAxleWidth = 5.9;

difference() {
    cylinder(h = 10, r1 = 3.75, r2 = 3.75, center = true);
    translate([0,0,-1.01]) {
        union() {
            cube(size = [bottomAxleWidth/3,bottomAxleWidth,8], center = true);
            cube(size = [bottomAxleWidth,bottomAxleWidth/3,8], center = true);
        }
    }
}
translate([0,0,8.75]) {
    cube(size = [topAxleWidth/3,topAxleWidth,7.5], center = true);
    cube(size = [topAxleWidth,topAxleWidth/3,7.5], center = true);
}
