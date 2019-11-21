// The length of the base, measured parallel with the gamepiece that will be inserted into it.
base_length = 19;

// The height of the base.
base_height = 13;

// The width of the base, measured perpendicular with gamepiece that will be inserted into it.
base_width = 19;

// The thickness of the gamepiece that will be inserted into the base.
insert_thickness = 1.7;

// The thickness of the walls of the base.
wall_thickness = 1.2;

module game_piece_base(
    base_length=0,
    base_height=0,
    base_width=0,
    insert_thickness=0,
    wall_thickness=0
    ) {
        $fs = .1;
        $fa = .1;
        
        insert_opening = insert_thickness * .85;
        
        linear_extrude(height=base_length) difference() {
            union() {
                // Base
                square([wall_thickness, base_width]);
                
                // Left side
                rotate([0, 0, 90]) square([wall_thickness, base_height * .3]);
                // Right side
                translate([0, base_width - wall_thickness, 0])
                    rotate([0, 0, 90]) square([wall_thickness, base_height * .3]);
               
                roof_angle = atan((base_height * .7) / (base_width / 2));
                roof_length = sqrt( pow(base_height * .7, 2) + pow( base_width / 2, 2 ) );
                
                // Left roof
                intersection() {
                    translate([-base_height * .3, 0, 0]) rotate([0, 0, roof_angle]) square([wall_thickness, roof_length]);
                    translate([-base_height, 0, 0]) square([base_height, base_width / 2]);
                }
                // Right roof
                intersection() {
                    translate([-base_height * .3, base_width, 0]) rotate([0, 0, -roof_angle]) translate([0, -roof_length, 0]) square([wall_thickness, roof_length]);
                    translate([-base_height, base_width/2, 0]) square([base_height, base_width / 2]);
                }
                
                // Sides of the insert cutout
                translate([-base_height, (base_width - ((insert_opening) + (2 * wall_thickness)))/ 2, 0]) square([base_height * .666, insert_opening + (2 * wall_thickness)]); 
                
                // Bottom left circle fillet
                translate([0, wall_thickness, 0]) circle(r=wall_thickness);
                
                // Bottom right circle fillet
                translate([0, base_width - wall_thickness, 0]) circle(r=wall_thickness);
                
                // Circles at the bottom of the insert supports.
                translate([-base_height * .333, (base_width / 2)-wall_thickness-(insert_opening/2), 0]) circle(r=wall_thickness);
                translate([-base_height * .333, (base_width / 2)+wall_thickness+(insert_opening/2), 0]) circle(r=wall_thickness);
            }
            
            // Insert cutout
            translate([0, (base_width - (insert_opening)) / 2, 0]) rotate([0, 0, 90]) square([insert_opening, base_height]);
            
            diamond_cutout_hypotenuse = (wall_thickness * 2) + (insert_opening);
            diamond_cutout_side_length = sqrt( pow( diamond_cutout_hypotenuse, 2) / 2 );
            
            // Top angled cutout
            translate([-base_height, base_width / 2 - (diamond_cutout_hypotenuse/2), 0]) rotate([0, 0, 45]) square([diamond_cutout_side_length, diamond_cutout_side_length]);
        }
}

game_piece_base(
    base_length=base_length,
    base_height=base_height,
    base_width=base_width,
    insert_thickness=insert_thickness,
    wall_thickness=wall_thickness
);