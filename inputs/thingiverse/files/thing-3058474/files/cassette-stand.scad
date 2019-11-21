width = 116;
height = 25;
length = 25;
width_small = 15;
thick = 1.5;
n = 5;

module block(x,y,end) {
    translate([x,0,0])
    union() {
        translate([0,0,0]) cube([thick, width_small, height]);
        translate([0,width-width_small+thick,0]) cube([thick, width_small, height]);
        if (end) {
            translate([length-thick,0,0]) cube([thick, width_small, height]);
            translate([length-thick,width-width_small+thick,0]) cube([thick, width_small, height]);
        }
        cube([length, width, thick]);
        cube([length, thick, height]);
        translate([0,width,0]) cube([length, thick, height]);
    }
}

//cube([thick, width, height]);
end = false;
for(c = [0:1:n-1]) {
    block(c*length,0,c==n-1);
}
//translate([n*length-thick,0,0]) cube([thick, width, height]);