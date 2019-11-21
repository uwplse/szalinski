slot_width=1.5;
max_slot_length=30;
box_height=100;
box_width=100;
box_depth=40;
wall_thickness=2;
vertical_orientation=0; // [0:false, 1:true]

module make_panel(width, height) {
    // expect to be tiled overlapping with other panels, so has wall thickness for border
    thickness=wall_thickness;
    border=thickness*2;
    divider=thickness;
    panel_count=ceil((height-border*2+divider)/(max_slot_length+divider));
    panel_slot_height=(height-border*2+divider)/panel_count-divider;
    _slot_count=ceil((width-border*2)/slot_width/2);
    slot_count=(_slot_count+1);
    panel_slot_width=(width-border*2)/(slot_count*2+1);
    
//    translate([0,-10,0]) text(str(panel_count));
//    translate([40,-10,0]) text(str(panel_slot_height));
//    translate([0,-30,0]) text(str(slot_count));
//    translate([40,-30,0]) text(str(panel_slot_width));

    difference() 
    {
        cube([width, height, thickness]);
        translate([border,border,-thickness/2])
        for (x = [0 : slot_count]) {
            for (y = [0 : panel_count - 1]) {
                translate([panel_slot_width*2*x,(divider+panel_slot_height)*y,0]) 
                    cube([panel_slot_width,panel_slot_height,thickness*2]);
            }
        }
    }
}

module panel(width, height) {
    if (vertical_orientation == 0) {
        translate([0,0,wall_thickness])
        rotate([0,180,-90])
            make_panel(height, width);
    } else {
        make_panel(width, height);
    }
}

module box() {
    union() {
        // front and back
        translate([0,wall_thickness,0]) rotate([90,0,0]) {
            panel(box_width, box_height - wall_thickness);
            translate([0,0,-box_depth+wall_thickness]) 
                panel(box_width, box_height - wall_thickness);
        }
        // bottom
        rotate([0,0,180]) mirror([1,1,0]) panel(box_depth, box_width);
        // sides
        rotate([90,0,90]) panel(box_depth, box_height - wall_thickness);
        translate([box_width-wall_thickness,0,0]) rotate([90,0,90]) 
            panel(box_depth, box_height - wall_thickness);
    }
}

module lid() {
    difference() 
    {
        scale([1,1,1.5]) panel(box_depth, box_width);
        
        translate([-wall_thickness,-wall_thickness,wall_thickness/2]) {
            cube([wall_thickness*2,box_width*2,wall_thickness*2]);
        }
        
        translate([box_depth-wall_thickness,-wall_thickness,wall_thickness/2]) {
            cube([wall_thickness*2,box_width*2,wall_thickness*2]);
        }
        
        translate([-wall_thickness,-wall_thickness,wall_thickness/2]) {
            cube([box_depth*2,wall_thickness*2,wall_thickness*2]);
        }
        
        translate([-wall_thickness,box_width-wall_thickness,wall_thickness/2]) {
            cube([box_depth*2,wall_thickness*2,wall_thickness*2]);
        }
    }
}

box();

translate([0,box_depth*1.5,0]) rotate([0,0,180]) mirror([1,1,0])
lid();
