
//Height of tray along Z axis (all units are in MM)
boxHeight = 20;
//X width of each compartment
boxWidthX = 50;
//Y width of each compartment
boxWidthY = 40;
//Thickness of walls
wallThickness = 3;
//Size of interior/exterior fillets. I recommend you make this less than or equal to 1/2 of wall thickness.
boxFillet = 1;
//How many rows of compartments do you want?
rows = 3;
//How many columns of compartments do you want?
columns = 2;

 
module compartmentExterior () {
    hull() {
        hull() {
            translate([boxWidthX - boxFillet, boxFillet, 0]) cylinder(boxHeight, r = boxFillet);
            translate([boxFillet, boxFillet, 0]) cylinder(boxHeight, r = boxFillet);
        }
        hull() {
            translate([boxWidthX - boxFillet, boxWidthY - boxFillet, 0]) cylinder(boxHeight, r = boxFillet);
            translate([boxFillet, boxWidthY - boxFillet,0]) cylinder(boxHeight, r = boxFillet);
        }
    }
}

module compartmentOpening () {
    hull() {
        hull() {
            translate([boxWidthX - boxFillet - wallThickness, boxFillet + wallThickness, 0 + wallThickness]) cylinder(boxHeight, r = boxFillet);
            translate([boxFillet + wallThickness, boxFillet + wallThickness, wallThickness]) cylinder(boxHeight, r = boxFillet);
        }
        hull() {
            translate([boxWidthX - boxFillet - wallThickness, boxWidthY - boxFillet - wallThickness, wallThickness]) cylinder(boxHeight, r = boxFillet);
            translate([boxFillet + wallThickness, boxWidthY - boxFillet - wallThickness, wallThickness]) cylinder(boxHeight, r = boxFillet);
        }
    }
}

module compartment () {
    difference () {
        compartmentExterior();
        compartmentOpening();
    }
}


union() {
    for (y = [1:rows]) {
        translate([0, (boxWidthY*(y-1))-(wallThickness*(y-1)), 0])
        for (x = [1:columns]) {
            translate([(boxWidthX*(x-1))-(wallThickness*(x-1)), 0, 0]) compartment();
        }
    }
}

