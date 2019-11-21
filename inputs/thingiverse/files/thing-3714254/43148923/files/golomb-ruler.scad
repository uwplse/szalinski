tick_positions = [0,1,4,6];
unit = 10;  // Unit of length between ticks
length = unit*max(tick_positions); // maximum length measured by the ruler
margin = 5; // spare room at each end of the ruler
width = 10; // width of the ruler
height = 2; // height of the ruler
taper = 1;  // thickness of the taper on the top
tick_width = 1; // width of the ticks
tick_depth = 1; // depth of the ticks
lip = 1;    // thickness of the taper on the bottom

in = true;  // if true, render the ruler with gaps for the ticks. If false, render just the ticks


module base() {
    d = sqrt(taper*taper+height*height);
    an = atan2(height,taper);
    tlength = length+2*margin;
    
    difference() {
        rotate([90,0,90])
            linear_extrude(tlength)
            polygon([
                [0,0],
                [width,0],
                [width-taper,height],
                [taper,height]
            ]);
    
        rotate([0,-an,0]) translate([0,0,0]) scale([d,width,height]) cube();
        scale([-1,1,1]) translate([-tlength,0,0]) rotate([0,-an,0]) translate([0,0,0]) scale([d,width,d]) cube();
        rotate([0,45,0]) translate([-lip,0,0]) scale([2*lip,width,lip]) cube(center=false);
        rotate([-45,0,0]) translate([0,-lip,0]) scale([tlength,2*lip,lip]) cube(center=false);
        translate([0,width,0]) rotate([45,0,0]) translate([0,-lip,]) scale([tlength,2*lip,lip]) cube(center=false);
        translate([tlength,0,0]) rotate([0,-45,0]) translate([-lip,0,0]) scale([2*lip,width,lip]) cube(center=false);
    }
}

module tick(x) {
    translate([unit*x+margin,width/2,height-tick_depth/2])
    scale([tick_width, width, tick_depth]) 
    #cube(center=true);
}
module ticks() {
    for(x=tick_positions) {
        tick(x);
    }
}

if(in) {
    difference() {
        base();
        ticks();
    }
} else {
    intersection() {
        base();
        ticks();
    }
}