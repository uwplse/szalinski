// laptop camera privacy shield

// dimension variables in mm -- should fit a macbook air by default
lid_thickness = 5; // your laptop's lid thickness
width = 10; // the desired shield width
height = 15; // distance from edge to screen (or slightly less)
buldge = 2; //The distance from the bottom to top of the shield

rotate([0,90,90]) {

// main shield
difference() {
cube([width, height+3, lid_thickness+buldge], center=true);
translate(v=[0,-1,0]) cube([width+4, height+2, lid_thickness], center=true);
}

// tab
translate(v=[0,height-(height*0.34),0]) cube([width,5,2],center=true);

}