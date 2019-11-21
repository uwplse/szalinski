/* [Global] */
/* [hook tuning] */
// The width of the hook
width = 10;
// The height / length of the hook
height = 60; //
/* [door specs] */
// The depth of the door mount. Use the depth of your door
doordepth = 9; //
// The heigth of the door mount
doorheight = 11; //

/* [Hidden] */
$fn = 96;

module aufhaenger(){
    difference(){
        square([doorheight+3, doordepth+2]);
        translate([3, 2])square([doorheight, doordepth]);
    }
    
}

module haken(){
    difference(){
        union(){
            translate([-height, 0])square([height, 5]);
            square([12.5, 20]);
            translate([12.5, 12])circle(12);
        }
        translate([0, 5])square([12.5, 15]);
        translate([12.5, 12.5])circle(7.5);
        translate([0, 23])square([40, 10]);
    }
}

module TuerHaken(){
    union(){
        linear_extrude(width)translate([-height, -doordepth-2])aufhaenger();
        linear_extrude(width)haken();
    }
}

TuerHaken();