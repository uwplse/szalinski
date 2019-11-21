/* [Mass] */
//Mass of material in the doser in grams
mass = 2.5;//g

/* [Additional] */
//Material density in kg/l [default is sugar]
density = 1.02;
inner_diameter = 12;

/* [Hidden] */
$fn = 50;
font = "Arial";

spoon( mass );
stick();

module spoon( mass = 1, wall = 1.6, funnel_height = 10, funnel_offset = -2, funnel_radius = 5, text_height = 5 ){
    //calculations
    inner_area = inner_diameter * inner_diameter / 4 * PI;
    inner_volume = mass / density * 1000;
    inner_height = inner_volume / inner_area;
    height = inner_height + wall + funnel_height;
            text_height = 5;
    //spoon
    difference(){
        cylinder( d = inner_diameter + 2 * wall, h = height );
        translate( [0, 0, wall] )
            cylinder( d = inner_diameter, h = height + 0.1 );
        translate( [0, funnel_offset, 0] )
        union(){
            translate( [- inner_diameter, funnel_radius, inner_height + wall])
                cube( [2 * inner_diameter, height, height] );
            translate( [- inner_diameter, 0, inner_height + wall +  funnel_radius])
                cube( [2 * inner_diameter, height, height] );
            translate( [-inner_diameter / 2 - wall - 0.1, funnel_radius, inner_height + wall + funnel_radius] )
                rotate( [0, 90, 0] )
                cylinder( r = funnel_radius, h = inner_diameter + 2 * wall + 0.2 );
        }
        difference(){
            translate( [0, -text_height / 2, inner_height] )
                rotate( [90, 0, 0] )
                linear_extrude(height = inner_diameter)
                text( str(mass, "g"), font = font, size = text_height, halign = "center");
            cylinder( d = inner_diameter + wall, h = height );
        }
    }
}

module stick( length = 60, diameter = 5, rounding = 2 ){
    //stick
    translate( [inner_diameter/2, 0, diameter / 2] )
        rotate( [0, 90, 0] )
        linear_extrude( height = length )
        minkowski(){
            square( diameter - 2 * rounding, center = true );
            circle( d = 2 * rounding );
        }
}

