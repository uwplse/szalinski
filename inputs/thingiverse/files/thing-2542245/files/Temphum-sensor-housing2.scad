// Which part would you like to see?
part = "box"; // [box:box only,front:front only]

// Heigth of box in mm (Inside).
height = 100; 

// Width of box in mm (Inside).
width = 65;

// Depth of box in mm (Inside).
depth = 40;

// Wall thicknes of box in mm.
thickness = 2; 

// Diameter of screw hole in mm.
diameter_hole = 4;

// Length of the slats in mm.
length_slats = 8;

// Pointed or flat roof?
roof = "flat"; // [pointed:pointed roof, flat:flat roof]

module housing(){
    cube([height,width+2*thickness,thickness]);
    rotate([0,-90,0])
        translate([0,0,-height-thickness])
            cube([depth+2*thickness,width+2*thickness,thickness]);
    if (roof == "flat") {
        rotate([0,0,90])
            cube([width+2*thickness,thickness,depth+3*thickness]);
        } else {
            rotate([0,0,90])
                cube([width+2*thickness,width,depth+3*thickness]);
        }
    for (a=[-1:5:height-5])
        translate([a,width+thickness+1,0])
            rotate([90,0,50])
                cube([length_slats,depth+thickness,1.5]);
    for (b=[0:5:height-5])
        translate([b,thickness,0])
            rotate([90,0,-50])
                cube([length_slats,depth+thickness,1.5]);
    translate([0,0,depth])
        cube([height,thickness,thickness]);
    translate([0,width+thickness,depth])
        cube([height,thickness,thickness]);
    translate([0,0,depth/2])
        cube([height,thickness,thickness]);
    translate([0,width+thickness,depth/2])
        cube([height,thickness,thickness]);
    translate([height/3,0,depth+thickness])
        cube([height/3,thickness,thickness]);
    translate([height/3,width+thickness,depth+thickness])
        cube([height/3,thickness,thickness]);
}

module cutouthousing(){
    translate([height/5,width/2+thickness,-1])
        cylinder(h=thickness+2, r=diameter_hole/2);
    rotate([0,-90,0])
        translate([0,-width/2,-height-2*thickness])
            cube([depth+2*thickness,2*width,thickness]);
    translate([0,-1,depth+5*thickness])
        rotate([270,0,115])
            cube([width+thickness,depth+6*thickness,100]);
    translate([0,width+2*thickness+1,-thickness])
        rotate([90,0,-115])
            cube([width+4*thickness,depth+6*thickness,100]);   
}

module front(){
    cube([height,width+2*thickness,thickness]);    
}

module cutoutfront(){
    translate([height/3,0,0])
        cube([height/3,thickness,thickness]);
    translate([height/3,width+thickness,0])
        cube([height/3,thickness,thickness]);
}
    

$fn=50;

module box(){
    difference(){
        housing();
        cutouthousing();
    }
}

module door(){
    difference(){
        front();
        cutoutfront();
    }
}

print_part();

module print_part() {
	if (part == "box") {
		translate([-height/2-thickness,-width/2-thickness,0]) box();
	} else if (part == "front") {
		translate([-height/2,-width/2,0]) door();
	} 
}