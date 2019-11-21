// Should be slightly larger than measured (~0.5 mm).
die_size = 16.28;

rounded_corners = "yes"; // [yes,no]

// Diagonal of a die (for dice with rounded corners). Should be slightly larger than measured (~0.5 mm). 
die_diagonal = 22.14;

// How far apart should the dice be?
die_gap = 3.7;

board_thickness = 5;

number_of_rows = 7; // [1:10]
number_of_columns = 7; // [1:10]

width = number_of_columns*(die_size+die_gap)+die_gap;
height = number_of_rows*(die_size+die_gap)+die_gap;

module die() {
    render() intersection() {
        cube(die_size, center=true);
        if (rounded_corners == "yes") {
            sphere(d=die_diagonal, $fn=60);
        }
    }
}

module dice() {
    for (x=[0:number_of_columns-1], y=[0:number_of_rows-1]) {
        translate([x*(die_size+die_gap),y*(die_size+die_gap),0])
            die();
    }
}

// center the board
translate([-width/2,-height/2,0])
    difference() {
        cube([width, height, board_thickness]);
        translate([die_size/2+die_gap,die_size/2+die_gap,die_size/2+board_thickness/2])
            dice();
    }