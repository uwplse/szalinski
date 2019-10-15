$fn = 0 + 0;
$fs = 0.1 + 0; // HQ cylinders
$fa = 4 + 0; // HQ spheres/hulls

// number of hooks wide
num = 6; // [1:18]

// width of the slots
paint_slot_width = 14.5;
// space between the slot centres
paint_slot_spacing = 31;

// space between the hook centres
hook_spacing = 31;

shelf_height = 6;
shelf_thickness = 2;
shelf_width = hook_spacing * num;

hook_width = 8.5;
hook_depth = 34.5;
hook_height = 1;

usable_shelf_width = shelf_width-(hook_width*1.5) -1;
usable_num_slots = round(usable_shelf_width/paint_slot_spacing);

num_slots = usable_num_slots;
shelf_centre = (shelf_width/2);
holes_width = (paint_slot_spacing * (num_slots-1)) ;
holes_centre = (shelf_centre - (holes_width/2));

module paint_slot(){
    hull(){
        cylinder(r=paint_slot_width/2, h=30);
            translate([0, hook_depth/4, 0])
                cylinder(r=paint_slot_width/2, h=30);
    }    
}

rotate([-90, 0, 0]){
//rotate([0, 0, 0]){

    difference(){
        cube([shelf_width, hook_depth, shelf_height]);

        //paint slots
        translate([holes_centre, 0, -10]){
            for(i=[0:num_slots-1]){
                translate([paint_slot_spacing*i, 0, 0])
                    paint_slot();
            }
        }

        //tilt neg
        rotate([-3.3, 0, 0]){
            translate([((hook_width*1.5)/2), 0-(1/2)-10, shelf_height])
                cube([shelf_width-(hook_width*1.5), hook_depth+1, shelf_height]);
            translate([((hook_width*1.5)/2), 0-(1/2)-10, 0-shelf_thickness ])
                cube([shelf_width-(hook_width*1.5), hook_depth+1, shelf_height]);
        }

        translate([0-(hook_width/2), 0-1, (shelf_height-hook_height)/2])
            cube([hook_width, hook_depth+(1*2), hook_height]);

        translate([shelf_width-(hook_width/2), 0-1, (shelf_height-hook_height)/2])
            cube([hook_width, hook_depth+(1*2), hook_height]);
    }
}

