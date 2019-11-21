//
// Parametric wire holder by MattKi
// v1.1 22/01/2019
// Dimensions in mm unless otherwise specified
//

//CUSTOMIZER VARIABLES

// The outer diameter for the spool

flange_spool_sides_diameter = 82; // Must be larger than id (inner diameter)

// Barrel Diameter - The inner diameter around which wire is wound. The central hole will be flange_wall_thickness*2 + barrel_to_side_wall_thickness*2 smaller in diameter than this value.

barrel_winding_section_diameter = 32; // Must be smaller than flange_spool_sides_diameter (outer diameter) but greater than two times st (thickness of the barrel) plus two times the thickness of the slot in walls barrel_to_side_wall_thickness (join thickness).

// The width or "traverse" of the barrel. How long is the part that the wire is wound around between spools.

traverse_barrel_length = 45; // No limit but must be greater than zero.

// The thickness of the barrel's walls around which the wire is wound

barrel_wall_thickness = 2;  // You will probably want a value of 2 or greater for all but the tiniest of spools.

// The thickness of the side walls (flange) of the spool.

flange_wall_thickness = 3;  // Again for all but tiny spools you'll probably want a value of 2 or greater.

// The thickness of the walls of the inner barrel used to join the sides of the spool together.

barrel_to_side_wall_thickness = 2;  // You'll likely want at least the same as the barrel wall thickness to maintain finished part strength.

// Offset of the indent in the spool sides (flange) from the edges

offset_flange_recess = 2;  // There is a recess of 0.75mm into the flange on the interior.

// Small tolerance used in difference operations to clear face fighting

tol = 0.05; 

// The length of the inner barrel used to connect the two spool parts.

overlap_barrel_to_inner_barrel = 10; // Increase for thicker barrel in the finished part. Decrease if you are making really tiny spools.

// Holes in the spool sides (flange) - how many holes should appear in a column along the recess in the flange?

holes_per_section = 4; // Set this to a sensible value (1 or more) based upon the side of wire being wound and the space available in the recess of the flange.

// Holes in the spool sides (flange) - how many sets of holes should be created (these will be equally spaced around the recess of the flange.

count_hole_sections = 6; // 1 or more.

// Holes in the spool sides (flange) - The diameters of the holes in the flange to feed wire through when winding.

wire_hole_dia = 2.5; // This should be at least 0.8mm greater than the diameter of the wire. Use larger values for really thick wire.

// Add a rotation in degrees for each hole in a column. This can help ensure that there is always a hole nearby to tie off the end of the winding.

holes_rotation_degrees = 5; // Should be less than 360 divided by the number of sets of holes divided by the number of holes in each column. If this is set to a greater value there may be overlap between the holes in each of the columns.

// An approximation of Pi to approximate spool capacity calculations.

pi = 3.1415926535; // You can make it more accurate if you want to?

// The diameter of wire which will be wound onto the spool

wire_diameter = 1.7; // Only used for spool capacity so an accurate outer diameter measurement including insulation should be suitable.

//CUSTOMIZER VARIABLES END

// Variable used for calculation of the approximation of the number of layers of winding we can achieve on the spool. Would not recommend changing though this calculation is not currently very accurate!

count_layers = (((flange_spool_sides_diameter-barrel_winding_section_diameter)/2-offset_flange_recess)-((flange_spool_sides_diameter-barrel_winding_section_diameter)/2-offset_flange_recess)%wire_diameter)/wire_diameter;

module spool_side(){
    difference(){
        cylinder(h=flange_wall_thickness,d=flange_spool_sides_diameter-flange_wall_thickness*2,$fn=256,center=true);
        translate([0,0,flange_wall_thickness/2-0.375]) cylinder(h=0.75+tol,d2=flange_spool_sides_diameter-flange_wall_thickness*2-offset_flange_recess*2,d1=flange_spool_sides_diameter-flange_wall_thickness*2-offset_flange_recess*2-1.5,$fn=256,center=true);
    }
    translate([0,0,flange_wall_thickness/2-0.25]) cylinder(h=1,d2=barrel_winding_section_diameter,d1=barrel_winding_section_diameter+barrel_wall_thickness*2,$fn=256,center=true);
    rotate_extrude($fn=256){translate([flange_spool_sides_diameter/2-flange_wall_thickness,0,0]) rotate([0,0,30]) circle(d=flange_wall_thickness,$fn=6);
    }
}

module main_side(){
    difference(){
        union(){
            translate([0,0,traverse_barrel_length/2+flange_wall_thickness-0.5]) cylinder(h=traverse_barrel_length,d=barrel_winding_section_diameter,$fn=256,center=true);
            translate([0,0,flange_wall_thickness/2]) spool_side();
        }  
        translate([0,0,traverse_barrel_length/2+flange_wall_thickness/2]) cylinder(h=traverse_barrel_length+flange_wall_thickness+tol,d=barrel_winding_section_diameter-barrel_wall_thickness*2,$fn=256,center=true);
        holes();
    }
    translate([0,0,overlap_barrel_to_inner_barrel/2]) difference(){
        cylinder(h=overlap_barrel_to_inner_barrel,d=barrel_winding_section_diameter-barrel_wall_thickness*2,$fn=256,center=true);
        cylinder(h=overlap_barrel_to_inner_barrel+tol,d=barrel_winding_section_diameter-barrel_wall_thickness*2-barrel_to_side_wall_thickness*2,$fn=256,center=true);
    }
}

module other_side(){
    difference(){
        union(){
            translate([0,0,flange_wall_thickness/2]) spool_side();
        }
        translate([0,0,overlap_barrel_to_inner_barrel/2+flange_wall_thickness-0.75]) cylinder(h=overlap_barrel_to_inner_barrel,d=barrel_winding_section_diameter,$fn=256,center=true);
        translate([0,0,overlap_barrel_to_inner_barrel/2+flange_wall_thickness/2]) cylinder(h=overlap_barrel_to_inner_barrel+flange_wall_thickness+tol,d=barrel_winding_section_diameter-barrel_wall_thickness*2-0.4,$fn=256,center=true);
        holes();
    }
    translate([0,0,overlap_barrel_to_inner_barrel/2]) difference(){
        cylinder(h=overlap_barrel_to_inner_barrel,d=barrel_winding_section_diameter-barrel_wall_thickness*2-0.4,$fn=256,center=true);
        cylinder(h=overlap_barrel_to_inner_barrel+tol,d=barrel_winding_section_diameter-barrel_wall_thickness*2-barrel_to_side_wall_thickness*2-0.4,$fn=256,center=true);
    }
}

module holes(){
    for (i=[0:count_hole_sections]){
        for (e=[1:holes_per_section]){
            rotate([0,0,360/count_hole_sections*i+e*holes_rotation_degrees]) translate([0,barrel_winding_section_diameter/2+((flange_spool_sides_diameter-flange_wall_thickness-barrel_winding_section_diameter)/2-flange_wall_thickness/2-offset_flange_recess*2)/holes_per_section*e,flange_wall_thickness/2]) cylinder(h=flange_wall_thickness+tol,d=wire_hole_dia,$fn=24,center=true);
        }
    }
}

main_side();
translate([0,flange_spool_sides_diameter+4,0]) other_side();
echo(str("This spool would hold approx ",(pi*count_layers*(count_layers+barrel_winding_section_diameter)*traverse_barrel_length)/(wire_diameter*wire_diameter)/1400,"m cable of the specified diameter. (Not accurate!!!)"));
