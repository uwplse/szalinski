// The amount of adjustment to make to the X-axis
x_amount = 4;
// The thickness of the rest of the piece
th = 1.5;

// The piece on the MPSM that will hold this model.
module support(){
    cube([3.3, 22, 5]);
}

difference() {
    cube([x_amount+3.3+th, 22+th*2, 4]);
    translate([x_amount, th, -.5]) support();
}
