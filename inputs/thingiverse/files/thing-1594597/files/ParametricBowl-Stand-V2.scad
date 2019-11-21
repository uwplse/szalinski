// To my college friends back home, the first to hopefuly many
// openSCAD designs to better aid our fellow men and women


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
// OVERALL STAND DIMENSIONS // 
// Overall Height of Stand
height = 50;
// This is the overall height of the stand
// to find out how high you need to make your stand
// measure the distance from where you want your bowl
// to be resting on from the ground
// then measure the diameter of the bowl at that point
// and enter that value into the diameter value
// Top diameter of stand
top_diameter = 25;
// this is where you enter the value from the previous step

// Bottom diameter of stand
base_diameter = 35;
// this is just an eyeballed value, a wider base is more stable
// but will take more time to print beause of more material and
// more support material

// Offset thickness of top ring
topring_offset = 2;
// this is the offeset for the generating the outside diameter of
// the top and bottom rings
// any positive value will work
// Offset thickness of bottom ring
botring_offset = 2.5;
// I'd recommend at least 2 for topring_offset and 2.5 or more for botring_offset



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
// RECTANGULAR CUTS DIMENSIONS //
// Spacing from cuts to the ends
end_thickness = 8;
// this will determine how tall your rectangular cuts are compared the 
// the height
// How many cuts
cuts = 4;
// this is how many cuts you will have on your stand
// how wide the cuts are
cut_width = 7;
// this is how wide your rectangular cuts will be on the stand
// too big and your stand will have no supporting beams
// Turn fillets on/off
fillet = "true"; //[false,true]
// set to true if you want fillets on the corners of the
// bowl stand cuts



top_radius = top_diameter/2;
base_radius = base_diameter/2;

module bowlStand2() {
    difference() {
        difference() {
            cylinder(h = height, r1 = base_radius+botring_offset, r2 = top_radius+topring_offset, center = true);
            scale([1,1,1.01])
            cylinder(h = height, r1 = base_radius, r2 = top_radius, center = true);
        }
        
        union() {
            for (i = [0:cuts]) {
                rotate([0,0,i*360/cuts]) 
                RoundedSquareCut();
            }
        }
    }
}

module RoundedSquareCut() {
    cut_height = (height - (end_thickness + cut_width/4));
    rotate([90,0,0]) 
    linear_extrude((base_radius+top_radius)*2)
        
    if (fillet == "true") {
        offset(cut_width/4)
        // translate([0,0,0]) 
        square([cut_width,cut_height], center = true);
    } else {
        // translate([0,0,0]) 
        square([cut_width,cut_height], center = true);
    }
}

bowlStand2();

