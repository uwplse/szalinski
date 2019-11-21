// rounding variable. smaller numbers increase rounding of cylinders and spheres
$fa=2;

// top internal diameter. how wide the hole is at the top of the holder. This determines the widest glass you can fit
top_id = 73;

// top external diameter. how wide the holder will be at the top, just before the lip. this should be set to however wide the hole is you have in the table / desk / what have you
top_od = 80;

// bottom internal diameter. how wide the hole is at the bottom. this determines the largest glass that will fit all the way to the bottom. bottom outer diameter is determined by
bottom_id= 69;

// inner length. how deep the hole will be in the holder
il = 85;

// how many millimeters the lip extends past the top of the holder
lip_overhang = 4;
// how tall the lip is
lip_height = 5;



// calculated variables
wall_thickness = top_od - top_id;
ol = il + wall_thickness;
lip_od = top_od + lip_overhang * 2;
slant_amount = top_id - bottom_id;
slant_rate = (top_id - bottom_id) / il;

// the lip of the holder
module lip() {
    difference() {
        cylinder(d1=lip_od, d2=top_od, h=lip_height);
        // .001 is slop
        cylinder(d1=top_id, d2=top_id + slant_rate * lip_height, h=lip_height);
    }
}


// the part that actually holds the glass
module cup() {
    difference() {
      // no bottom od so the cup holds to the sides
      cylinder(d1=top_od - 2, d2=top_od, h=ol);
      translate([0,0,wall_thickness]) cylinder(d1=bottom_id, d2=top_id, h=il);
    }
}

// the whole shebang
module drink_holder() {
    cup();
    translate([0,0,ol]) lip();
}

drink_holder();
