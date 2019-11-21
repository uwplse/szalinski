// Crown Radius
cr = 12; // [4:100]
// Crown Height
ch = 25; // [10:50]
// Saddle Radius
sr = 15; // [8:30]
// Saddle Width
sw = 5; // [2:15]
// Thickness
th = 2; // [2:6] 

difference() {
    cylinder(ch, r=cr);
    cylinder(ch-th, r=cr-th);
}

translate([-(sw/2),0,ch+sr-th + 0.01]) {
    rotate(a=[0,90,0]) {
        difference() {
            cylinder(sw, r=sr);
            translate([0,0,-1])
            cylinder(sw+2, r=sr-th);
            translate([-(sr),0,0])
            cube(sr*2, center=true); 
        }
    }
}
