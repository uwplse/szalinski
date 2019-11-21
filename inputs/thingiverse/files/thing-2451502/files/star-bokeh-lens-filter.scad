// could be changed
lens_outer_radius=52;
star_size_factor=0.014;
wall_thickness=3;
shaft_leght=8;

//don`t change!
star_scale=lens_outer_radius*star_size_factor;

module flat_star() {
rotate([0, 0, 0])circle(10,$fn=3);
rotate([0, 0, 180])circle(10,$fn=3);
}

difference()
{
    translate([0,0,0])cylinder(wall_thickness+shaft_leght,d=lens_outer_radius+wall_thickness);
    translate([0,0,wall_thickness])cylinder(shaft_leght,d=lens_outer_radius);

    linear_extrude(height=wall_thickness) 
    scale([star_scale,star_scale,star_scale])flat_star();
}


