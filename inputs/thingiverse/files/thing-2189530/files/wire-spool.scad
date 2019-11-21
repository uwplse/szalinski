// Parametric interlocking wire/filament spool
// by Garrett Goss, 3/19/2017, CC Attribution 4.0

// Both halves are identical!

// Thickness [mm] of spool walls
wall_thickness = 2;

// Diameter [mm] of the spool sides
outer_diameter = 60;

// Inside width [mm] of the spool (note: outer_width = inner_width + 2 * wall_thickness)
inner_width = 30;

// Diameter [mm] of the hole through the center of the spool
hole_diameter = 20;

// Width [mm] of the interlocking tabs/catches
tab_width = 10;

// Extent [mm] to which the tabs protrude from the half-spool
tab_height = 7;

// Diameter [mm] of the "wire hole"
wire_hole_diameter = 2.5;

// Facets (n, where circles are approximated as n-sided polygons): choose high numbers for smooth spools, low numbers for interesting effects
facets = 50;

show_two_halves = "yes"; // [yes,no]

/* [Sidewall holes] */

// Place holes in sidewalls to reduce weight and material use?
holes_on_sides = "no"; // [yes,no]

// Number of holes
number_of_side_holes = 6;

// Diameter [mm] of holes
side_hole_diameter = 10;


/* [Hidden] */
eps = 0.01;

outer_width = inner_width + 2 * wall_thickness;
catch_diameter = hole_diameter + 2 * wall_thickness;
inner_diameter = hole_diameter + 4 * wall_thickness;


module toroid(h, d_o, d_i, $fn=facets){
    difference(){
        cylinder(h=h, d=d_o, $fn=$fn);
        translate([0, 0, -eps]) cylinder(h=h+2*eps, d=d_i, $fn=$fn);
    }
}


module tab_polygon(){
    polygon([[catch_diameter/2, wall_thickness], [(catch_diameter/2)+(wall_thickness/2), 0], [catch_diameter/2, -wall_thickness]]);
}


module tabs($fn=facets){
    intersection(){
        union(){
            translate([0, 0, (inner_width/2)+tab_height]) rotate_extrude($fn=$fn) tab_polygon();
            toroid((outer_width/2)+tab_height, catch_diameter, hole_diameter);
        }
        translate([-tab_width/2, -outer_diameter/2, 0]) cube([tab_width, outer_diameter, outer_width]);
    }
}


module catches($fn=facets){
    intersection(){
        union(){
            translate([0, 0, (inner_width/2)-tab_height+2*wall_thickness]) rotate_extrude($fn=$fn) tab_polygon();
            translate([0, 0, 2*wall_thickness+(inner_width/2)-tab_height]) toroid(tab_height, (hole_diameter+2.25*wall_thickness), hole_diameter);
        }
        translate([-outer_diameter/2, -tab_width/2, 0]) cube([outer_diameter, tab_width, outer_width]);
    }
}


module half_spool(){
    difference(){
        union(){
            toroid(outer_width/2, inner_diameter, inner_diameter-2*wall_thickness);
            toroid(wall_thickness, outer_diameter, hole_diameter);
            tabs();
        }
        catches();
        translate([0, 0, wall_thickness+inner_width/4]) rotate([90, 0, 45]) cylinder(h=outer_diameter/2, d=wire_hole_diameter, $fn=25);
        
        if (holes_on_sides == "yes"){
            for (n = [1:number_of_side_holes]){
               rotate([0, 0, n * (360 / number_of_side_holes)]) translate([(inner_diameter/4+outer_diameter/4), 0, -eps]) cylinder(h=wall_thickness+2*eps, d=side_hole_diameter, $fn=facets);
            }
        }
    }
}


half_spool();

if (show_two_halves == "yes"){
    translate([0, 0, outer_width*2]) rotate([180, 0, 90]) half_spool();
}