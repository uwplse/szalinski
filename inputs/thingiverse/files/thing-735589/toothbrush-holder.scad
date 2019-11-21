// Number of toothbrushes to hod
number_of_toothbrushes = 2;
// Distance the from the outer holders to the side
holder_side_cushion = 10;
// Distance between toothbrush holders
holder_cushion = 20;
// For the holder itself, the outer distance apart (before narrowing)
holder_max_width = 15;
// For the holder itself, the inner distance apart
holder_min_width = 9;
// Depth of the protruding toothbrush holder
holder_depth = 30;
width = (number_of_toothbrushes * holder_max_width) + (2 * holder_side_cushion) +((number_of_toothbrushes - 1) * holder_cushion);
base_width = width;
// Depth of the base
base_depth = 80;
// Height of the base
base_height = 3;
// Just to make OpenSCAD happy.
fudge = 0.01;
// Min height of the stem of a toothbrush that goes in (neck to bottom)
toothbrush_stem_height = 175;
// Thickness of backing plate.
backplate_thickness = 5;
// Split this into two pieces, with rods and holes for connecting?
split = true;
// Length of rods that will connect the two pieces
split_rod_length = 10;
// Distance between rods that will connect the two pieces
split_rod_cushion = 10;
// Tolerance in radius of rods/holes
split_rod_radius_tolerance = .5;
// Tolerance in length of rods/holes
split_rod_length_tolerance = 1;
split_rod_radius = (backplate_thickness / 2) - (2 *split_rod_radius_tolerance) - fudge;
// Height to split into pieces
split_at = 90;
base_cutout_radius = (min(base_depth,base_width) / 2) - 5;
back_cutout_radius = (min(width,split_at) / 2) - 5;
// Should we make circular cutouts?
apply_cutouts = true;
// If we're splitting it, distance between the two pieces
distance_between = 10;
text_depth=backplate_thickness / 2;
// Initials to place below the holders
initials = ["A","B"];

module base(){
    difference(){
        cube([base_width,base_depth,base_height]);
        if (apply_cutouts){
            translate([base_width / 2,(base_depth - backplate_thickness) / 2,0]) cylinder(r=base_cutout_radius,h=base_height);
        }
    }
}

module back(){
    translate([0,base_depth - backplate_thickness,base_height]){
        difference(){
            cube([base_width,backplate_thickness,toothbrush_stem_height]);
            if (apply_cutouts){
                translate([width / 2,backplate_thickness+(fudge/2),base_height+back_cutout_radius+15]) rotate([90,0,0]) cylinder(r=back_cutout_radius,h=(backplate_thickness+fudge));
            }
        }
    }
}

module initials(){
    for (i = [0 : number_of_toothbrushes]){
        x_offset = holder_side_cushion+((holder_max_width / 2)-4.5) + (i * (holder_cushion + holder_max_width));
        translate([x_offset,(base_depth - backplate_thickness)+text_depth,150]) rotate([90,0,0]) linear_extrude(height=text_depth){
            text(initials[i]);
        }
    }
}


module holder(){
    travel = (holder_max_width - holder_min_width)/2;
    piece_length = travel / sin(45);
    rotate([0,45,0]){
        cube([piece_length,holder_depth,1]);
    }
    translate([travel + holder_min_width,0,-travel]){
        rotate([0,-45,0]){
            cube([piece_length,holder_depth,1]);
        }
    }
}

module holders() {
    translate([holder_side_cushion,base_depth - (backplate_thickness + holder_depth),base_height + toothbrush_stem_height]){
        for (i = [0:number_of_toothbrushes - 1]){
            translate([(holder_max_width + holder_cushion)*i,0,0]){
                holder();
            }
        }
    }
}

module splitRod(isHole) {
    if (isHole){
        cylinder(r=(split_rod_radius+split_rod_radius_tolerance),h=(split_rod_length+split_rod_length_tolerance));
    } else {
        cylinder(r=split_rod_radius,h=split_rod_length);
    }
}

module fullThing(){
    difference(){
        union() {
            base();
            back();
            holders();
        }
        initials();
    }
}

module bottomPart(){
    difference(){
        union(){
            intersection(){
                fullThing();
                cube([width,base_depth,split_at]);
            }
            translate([split_rod_cushion,base_depth - (backplate_thickness / 2),split_at]){
                splitRod(false);
            }
            translate([width - split_rod_cushion,base_depth - (backplate_thickness / 2),split_at]){
                splitRod(false);
            }
        }
        translate([(split_rod_cushion*2)+(split_rod_radius*2),base_depth - (backplate_thickness / 2),split_at-split_rod_length]){
            splitRod(true);
        }
        translate([width - ((split_rod_cushion*2)+(split_rod_radius*2)),base_depth - (backplate_thickness / 2),split_at-split_rod_length]){
            splitRod(true);
        }
    }
}

module topPart(){
    top_height = base_height + toothbrush_stem_height;
    rotate([180,0,0]) translate([width+distance_between,-base_depth,-top_height]) difference(){
        union(){
            intersection(){
                fullThing();
                translate([0,0,split_at]) cube([width,base_depth,top_height - split_at]);
            }
            translate([(split_rod_cushion*2)+(split_rod_radius*2),base_depth - (backplate_thickness / 2),split_at-split_rod_length]){
                splitRod(false);
            }
            translate([width - ((split_rod_cushion*2)+(split_rod_radius*2)),base_depth - (backplate_thickness / 2),split_at-split_rod_length]){
                splitRod(false);
            }
        }
        translate([split_rod_cushion,base_depth - (backplate_thickness / 2),split_at]){
            splitRod(true);
        }
        translate([width - split_rod_length,base_depth - (backplate_thickness / 2),split_at]){
            splitRod(true);
        }
    }
}

if (split){
    bottomPart();
    topPart();
} else {
    fullThing();
}