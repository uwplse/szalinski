use <utils/build_plate.scad>
/* [Important bits] */
//Some common battery sizes.
type = "AA";// ["AAA":AAA, "AA":AA, "C":C, "D":D, "custom":Custom]

//The number of cells this will hold
cells = 1;

//Length for custom cells (pre-set: CR2032)
custom_length = 3.2;
//Diameter for custom cells (pre-set: CR2032)
custom_diameter = 20;

/* [Tweaks] */

//The gap around the cell, adjust this for a tight fit.
space = 1.5;
// Thickness of the walls of the holder. You may want to adjust this for a thin wall thickness that works well with your printer.
wall = 1.2; 


/* [Build plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

if (type=="AAA"){
start(44.5,10.7);
};
if (type=="AA"){
start(50.5,14.5);
};
if (type=="C"){
start(50,26.2);
};
if (type=="D"){
start(61.5,34.2);
};
if (type=="custom"){
start(custom_length, custom_diameter);
};

module start(l,w){

length = l + space;
width = w + space;
translate([-((width+wall/2)*(cells-1)/2),0,width/2+wall/4])
holders (length,width);
}

module holders(length,width){
for(i = [0:cells-1]){
translate([(width+wall/2)*i,0,0])single();
}

module single(){
difference(){
cube ([width+wall, length+wall, width],center=true);
cube ([width*1.001, length*1.001 , width*1.001],center=true);
translate([0,0,width/1.2])rotate([0,45,0])cube ([width, (length+wall)*1.001, width],center=true);
translate([0,0,-width/1.2])rotate([0,45,0])cube ([width, (length+wall)*1.001, width],center=true);
}
translate([0,0,-width/2]) cube ([width+wall, length+wall, wall/2],center=true);
}
}

