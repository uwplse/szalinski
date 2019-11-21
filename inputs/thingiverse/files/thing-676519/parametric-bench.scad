/* Bench dimensions */
// (cm)
bench_length=242.0; // [0:1000]

// (cm)
seating_height=43; // [10:80]

// (cm)
seating_depth=35; // [10:80]

/* Wood */
// http://www.jumbo.ch/fileadmin/user_upload/bilder/services/jumbo_service_total/0714_Decoupe_planches_f.pdf
// (mm)
board_thickness=4; // [1:20]
boards_thickness=board_thickness/10;
feet_height=seating_height-boards_thickness;
// (Surfacic price of board used to build the bench. CHF per square meter. Total price displayed in terminal when file is opened in OpenScad)
board_surfacic_price=19.50; // [0:100]
// kg.m^.3 Total bench weight displayed in terminal when file is opened in OpenScad)
volumetric_mass_density=450; // kg.m^.3



// Feet dimensions

//Top
/* [Hidden] */
feet_top_spacing_ratio=.75; // Top-spacing of feet relative to seating_depth
feet_top_spacing=seating_depth*feet_top_spacing_ratio;
inside_feet_spacing=feet_top_spacing/3;

//Bottom
feet_bottom_spacing=seating_depth*(1+(1-feet_top_spacing_ratio));
inside_feet_bottom_spacing=feet_bottom_spacing-1.75*boards_thickness;

//Lenghts
outside_feet_length_x=(feet_bottom_spacing-feet_top_spacing)/2;
inside_feet_length_x=(inside_feet_bottom_spacing-inside_feet_spacing)/2;

outside_feet_length=sqrt(pow(outside_feet_length_x,2)+pow(feet_height,2));
inside_feet_length=sqrt(pow(inside_feet_length_x,2)+pow(feet_height,2));

outside_feet_angle=atan(feet_height/((feet_bottom_spacing-feet_top_spacing)/2));
inside_feet_angle=atan(feet_height/((inside_feet_bottom_spacing-inside_feet_spacing)/2));



//Seating board
color("yellow")
translate([0,0,(seating_height-boards_thickness/2)])
cube([seating_depth,bench_length,boards_thickness],center=true);


//Feet

// Right outside foot
color("green")
translate([(outside_feet_length_x+feet_top_spacing)/2,0,feet_height/2])
rotate([0,outside_feet_angle,0])
cube([outside_feet_length,bench_length,boards_thickness],center=true);

// Left outside foot
color("red")
translate([-(outside_feet_length_x+feet_top_spacing)/2,0,feet_height/2])
rotate([0,-outside_feet_angle,0])
cube([outside_feet_length,bench_length,boards_thickness],center=true);

// Right inside foot
color("blue")
translate([-(inside_feet_length_x+inside_feet_spacing)/2,0,feet_height/2])
rotate([0,-inside_feet_angle,0])
cube([inside_feet_length,bench_length,boards_thickness],center=true);

// Left inside foot
color("purple")
translate([(inside_feet_length_x+inside_feet_spacing)/2,0,feet_height/2])
rotate([0,inside_feet_angle,0])
cube([inside_feet_length,bench_length,boards_thickness],center=true);

// Cutting
board_width = seating_depth + 2*(outside_feet_length+inside_feet_length);

//translate([feet_bottom_spacing+board_width/2,0,0])
//square([board_width,bench_length],center=true);

//Surface, weight & price
surface = bench_length * board_width / 10000;
price = surface * board_surfacic_price;
volume = surface * boards_thickness /100;
weight = volume * volumetric_mass_density;

echo(Section_m=board_width/100);
echo(Surface_m2=surface);
echo(Price_fr=price);
echo(Weight_kg=weight);