
// Label shows on the bottom of the organiser
label = "Label";
// Tolerance if coins arnt fitting right adjust this its in mm
tolerance = .5; //[0.2:0.1:1]
// Single coin diameter in mm
coin_diameter = 20.2; 
// Single coin height in mm
coin_height = 1.7;
// How many coins do you want in a single SET before next offset
coins_in_set = 5; 
// Number of sets in the entire organiser
sets = 10;
// mm offset after each set
offset = 3;
// Border allows for a bit of structural integrity
border = 1;
$fn = 256;

combined = (coin_height * coins_in_set) + tolerance;
combine_diam = (coin_diameter + tolerance );
coin_rad = combine_diam/2;


translate([-coin_rad, - coin_rad - border, -7]) {
    difference() {
        cube([(coin_rad) + border, (combine_diam + offset) + (border * 2), 6]);
      
        color("Black") 
            translate([ coin_rad, 12, 3.5])
                rotate([90, 0, 90]) 
                    linear_extrude(height = 1.5) 
                        text(label, size = 4, halign = "center", valign = "center");
    }
}

difference() {

    translate([
        - coin_rad,
        - coin_rad - border,
        - border
    ]){
        cube([
            coin_rad + border, 
            (combine_diam + offset) + (border * 2),
            ( combined * sets) + (border * 2)
        ]);
    }
        
    for ( $i = [1 : sets] ) {
        color("White")
            translate([ 0, ($i%2==0)?offset:0, combined * ($i-1) ])
                cylinder(d = combine_diam, h = combined);
    }
    
}