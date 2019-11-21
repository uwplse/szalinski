/* [Global] */
// How many holes?
Pens = 12; // [6, 7, 8, 9, 10, 11, 12]

Hole_Diameter = 10; // [8.5:Small,10:Medium,11.5:Large]

// Create a center hole?
CenterHole = "no"; // [yes,no]

// Create a center bowl?
CenterBowl = "no"; // [yes,no]

// How deep should the center bowl be?
Bowl_Depth = 10; // [5:15]

/* [Hidden] */
$fn=100;

difference() {
    union() {
        cylinder(h = 70, r = 26.4, center = true);
        
        difference() {
        translate([0,0,-70.15])
            sphere(r = 48.2);
        translate([0,0,-95])
            cube(size = [100,100,90], center = true);
        }
        
        difference() {
        translate([0,0,70.15])
            sphere(r = 48.2);
        translate([0,0,95])
            cube(size = [100,100,90], center = true);
        }
    }
    
    rotate_extrude(convexity = 10)
        translate([74.5,0,0])
            resize(newsize=[135,85,0])
                circle(d = 135);

    difference() {
    translate([0,0,43.7])
        rotate_extrude(convexity = 10)
            translate([35.7,0,0])
                square(8.48);
    translate([0,0,46.7])
        rotate_extrude(convexity = 10)
            translate([35.7,0,0])
                circle(d = 10.95);
    }

    difference() {
    translate([0,0,-52.14])
        rotate_extrude(convexity = 10)
            translate([35.7,0,0])
                square(8.48);
    translate([0,0,-46.7])
        rotate_extrude(convexity = 10)
            translate([35.7,0,0])
                circle(d = 10.95);
    }

for ( i = [0 : Pens-1] )
{
    rotate( i * 360 / Pens, [0, 0, 1])
    translate([28,0,3])
    cylinder(h = 102, d = Hole_Diameter, center = true);
}

if (CenterHole == "yes")
{
    cylinder(h = 102, r = 4.5, center = true);
}

if (CenterBowl == "yes")
{
    translate([0,0,50.1-Bowl_Depth/2])
    cylinder(h = Bowl_Depth, r = 18, center = true);
}
}