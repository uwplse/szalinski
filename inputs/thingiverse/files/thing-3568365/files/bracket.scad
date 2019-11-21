// position of first screw, in respect to card base
A =  7.3;

// distance between the 2 screw centers
B = 46.57;

// distance of the screw from pci bracket
C = 8.0;

// M3 hole diameter
M3= 2.4;

/* [Hidden] */
h_pci_cutout = 66.27;

module plate() {
thick = 1.75;
plug_bottom  =-13.24;
board_bottom =  0.0;
w_pci_cutout = 18.42;
w_connector  = 10.38;
w_margin     =  3.16 + 0.5;
points = [  [plug_bottom, w_margin], 
            [board_bottom, w_margin],
            [board_bottom, 0], 
            [h_pci_cutout, 0],
            [h_pci_cutout, w_pci_cutout],
            [board_bottom, w_pci_cutout],
            [-5, w_margin + w_connector], 
            [ plug_bottom, w_margin + w_connector] ];

translate([ 0, 0, -thick])
linear_extrude(height = thick) {
    polygon( points);
}

}

// fix plate


module fix() {
    half   =  4;
    length = 14;
    thick  =  2;
difference() {
    translate([ -half, -length, 0]) cube( size=[ 2*half, length, thick] );
    translate([ 0, -C, 0]) 
    cylinder (h = 10, r=M3/2, center = true, $fn=100);
}
}




module pci() {
    M4 = 4.0;

    width  = 12.40 + 3;
    length = 18.70;
    thick  =  2;
    shift  = 4.22;
translate([ -( length + shift), 0, 0])
difference() {
    cube( size=[ length, width, thick] );

    translate([ 0, width/2 + 0.6, 0])
    hull() {
        cylinder (h = 10, r=M4/2, center = true, $fn=100);
        translate([ 5, 0, 0])
        cylinder (h = 10, r=M4/2, center = true, $fn=100);
    }
}
}



// make plate front side
color("SkyBlue")
rotate( [ 90, 0, 0]) plate();

// fix plate
color("red") {
translate([ A, 0, 0]) fix();
translate([ A + B, 0, 0]) fix();
}

// pci holder
color("green")
translate([ h_pci_cutout, 0, 0])
rotate( [ 0, 90, 0]) pci();
