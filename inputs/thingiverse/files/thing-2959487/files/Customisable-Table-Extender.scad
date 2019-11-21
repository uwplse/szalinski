//-----------------------------------------------------------------------------
//
// Parameter Based Table Stacker by Matt Kidd
// A parameter based model for stacking tables which have square legs that
// screw in to the table such as LACK tables by IKEA.
//
// Dimensions are in mm unless otherwise specified.
//
//-----------------------------------------------------------------------------

//
// Variables - User modifiable
//

// Diameter of the hole to allow the leg to be screwed in to the base.
hole_dia = 12;

// Distance separating the top of the table surface and the bottom surface of the next table's leg.
extension_length = 100;

// Thickness of the table surface
table_thickness = 51;

// Depth of the recess to hold the table leg
table_leg_recess = 10;

// Thickness of the table legs
table_leg_thickness = 51.2;

// Thickness of the outer walls
outer_wall_thickness = 3;

// Thickness of the material sandwiched between bottom of table surface and top of table leg
connection_wall_thickness = 3;

// The amount by which the table surface overhangs the table feet with the tables standing on top of one another
table_leg_to_surface_edge = 2.4;

// Small value used to minimise face fighting
tol = 0.01;

// If this is turned off you will have a slimmer model designed to be printed upright.
easy_print_mode = true;

//
// Variables - Defined by other variables -
//

// Measurement for the recessed area
recess_wall_dimension = table_leg_thickness+outer_wall_thickness*2;

// Measurement for the table attachment area
outer_wall_dimension = table_leg_thickness+outer_wall_thickness+table_leg_to_surface_edge;

// Calculation to ensure that bevels connecting the parts have a 45 degree angle when printed vertically.
joint_height_overhang = outer_wall_thickness + table_leg_to_surface_edge;

module recess_part(){
    union(){
        cube([table_leg_recess,recess_wall_dimension,recess_wall_dimension],center=true);
        translate([outer_wall_thickness+table_leg_recess/2,0,0]) rotate([0,-90,0]) polyhedron(points=[[-table_leg_thickness/2,-table_leg_thickness/2,0],[-table_leg_thickness/2,+table_leg_thickness/2,0],[+table_leg_thickness/2,+table_leg_thickness/2,0],[+table_leg_thickness/2,-table_leg_thickness/2,0],[-recess_wall_dimension/2,-recess_wall_dimension/2,outer_wall_thickness],[-recess_wall_dimension/2,recess_wall_dimension/2,outer_wall_thickness],[recess_wall_dimension/2,recess_wall_dimension/2,outer_wall_thickness],[recess_wall_dimension/2,-recess_wall_dimension/2,outer_wall_thickness]],faces=[[3,2,1,0],[1,5,4,0],[2,6,5,1],[3,7,6,2],[0,4,7,3],[4,5,6,7]],convexity=10);
    }
}

module overhang_part(){
    difference(){
        union(){
            translate([(table_thickness+connection_wall_thickness)/2,(outer_wall_thickness+table_leg_to_surface_edge)/2,(outer_wall_thickness+table_leg_to_surface_edge)/2]) cube([table_thickness+connection_wall_thickness,outer_wall_dimension,outer_wall_dimension],center=true);
            translate([-joint_height_overhang,0,0]) rotate([0,-90,0]) polyhedron(
            points=[[-table_leg_thickness/2,-table_leg_thickness/2,0],
            [-table_leg_thickness/2,+table_leg_thickness/2,0],
            [+table_leg_thickness/2,+table_leg_thickness/2,0],
            [+table_leg_thickness/2,-table_leg_thickness/2,0],
            [-table_leg_thickness/2,-table_leg_thickness/2,-joint_height_overhang],
            [-table_leg_thickness/2,outer_wall_dimension-table_leg_thickness/2,-joint_height_overhang],
            [outer_wall_dimension-table_leg_thickness/2,outer_wall_dimension-table_leg_thickness/2,-joint_height_overhang],
            [outer_wall_dimension-table_leg_thickness/2,-table_leg_thickness/2,-joint_height_overhang]],
            faces=[[0,1,2,3],[0,4,5,1],[1,5,6,2],[2,6,7,3],[3,7,4,0],[7,6,5,4]],convexity=10);
        }
        translate([table_thickness/2,0-tol/2,0-tol/2]) cube([table_thickness,table_leg_thickness+outer_wall_thickness+tol,table_leg_thickness+outer_wall_thickness+tol],center=true);
        translate([table_thickness+connection_wall_thickness/2,0,0]) rotate([0,90,0]) cylinder(h=connection_wall_thickness+tol,d=hole_dia,$fn=128,center=true);
         translate([table_thickness+connection_wall_thickness/2,+outer_wall_thickness,outer_wall_thickness]) rotate([180,0,0]) difference(){
            translate([0,(recess_wall_dimension/2+1)/2,(recess_wall_dimension/2+1)/2]) cube([connection_wall_thickness+tol,recess_wall_dimension/2+1,recess_wall_dimension/2+1],center=true);
            rotate([0,90,0]) cylinder(h=connection_wall_thickness+tol*2, d=recess_wall_dimension, $fn=256, center=true);
        }
    }
}

module leg_extension(){
    difference(){
        union(){
            if(easy_print_mode){
                translate([-table_leg_recess/2,(outer_wall_thickness+table_leg_to_surface_edge)/2,(outer_wall_thickness+table_leg_to_surface_edge)/2]) cube([extension_length+table_leg_recess,outer_wall_dimension,outer_wall_dimension],center=true);
                translate([-extension_length/2-table_leg_recess/2,-table_leg_thickness/2-outer_wall_thickness/2,recess_wall_dimension/2+table_leg_to_surface_edge/2]) cube([table_leg_recess,outer_wall_thickness,table_leg_to_surface_edge],center=true);
                translate([-extension_length/2-table_leg_recess/2,table_leg_to_surface_edge/2+table_leg_thickness/2+outer_wall_thickness,outer_wall_thickness/2-recess_wall_dimension/2]) cube([table_leg_recess,table_leg_to_surface_edge,outer_wall_thickness],center=true);
            }
            else{
                cube([extension_length,table_leg_thickness,table_leg_thickness],center=true);
            }
            translate([-table_leg_recess/2-extension_length/2,0,0]) recess_part();
            translate([extension_length/2,0,0]) overhang_part();
        }
        rotate([0,90,0]) cylinder(h=extension_length+tol,d=table_leg_thickness-8,$fn=4,center=true);
        translate([-table_leg_recess/2-extension_length/2-tol/2,0,0]) cube([table_leg_recess+tol,table_leg_thickness,table_leg_thickness],center=true);
    }
}

translate([(table_thickness+connection_wall_thickness-table_leg_recess)/2,table_leg_to_surface_edge/2,table_leg_thickness/2+outer_wall_thickness+table_leg_to_surface_edge]) rotate([-90,0,180]) leg_extension();

