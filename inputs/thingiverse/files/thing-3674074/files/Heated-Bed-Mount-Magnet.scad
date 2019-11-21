//Magnetic bed mount for Folgertech 2020 i3 remixed from sonnylove's https://www.thingiverse.com/thing:1377107

//Input the size of your magnet in mm (This should be larger than zero)
diameter=6.15; //My magnets are ~ 6 mm wide, so I added a little factor of safety to the diameter
thickness=3; // My magnets are 3 mm thick


//Taking the difference allows us to put in a new hole for a magnet of our choosing.
difference(){

translate([1,0,0])

union(){

//The original Magnetic Corner Bracket File
import("Magnetic Corner Bracket.STL");

//Filling in the hole from the original file    
translate([12,12,0])
        cube([10,10,4.4]);
};

//Magnet hole
translate([16.5,20,4.4-thickness]) //Total thickness of the part is 4.4 mm; I'm using the last term (4.4-thickness) to make sure the magnet lies flush with the surface 
    cylinder(d=diameter,h=4.4,$fn=360); //This is the code that creates the actual hole
};



//Added a mirrored copy so you don't have to manually do it. Comment out the appropriate section if you only want one of the mounts.
mirror([1,0,0])
    //Taking the difference allows us to put in a new hole for a magnet of our choosing.
difference(){

translate([1,0,0])

union(){

//The original Magnetic Corner Bracket File
import("Magnetic Corner Bracket.STL");

//Filling in the hole from the original file    
translate([12,12,0])
        cube([10,10,4.4]);
};

//Magnet hole
translate([16.5,20,4.4-thickness]) //Total thickness of the part is 4.4 mm; I'm using the last term (4.4-thickness) to make sure the magnet lies flush with the surface 
    cylinder(d=diameter,h=4.4,$fn=360); //This is the code that creates the actual hole
};