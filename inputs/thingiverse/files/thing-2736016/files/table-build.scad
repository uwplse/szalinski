/* [Hidden] */
offset = 0.5;

/* [Colours] */
//Table Top Color
top_colour = "SaddleBrown";
//Table Top Color
leg_colour = "SaddleBrown";
//Table Top Color
skirt_colour = "SaddleBrown";

/* [Table] */
//Table Length (mm)
top_x = 50;
//Table Width (mm)
top_y = 40;
//Table Top Thickness (mm)
top_z = 2;

/* [Legs] */
//Leg Width (mm)
leg_x = 3;
//Leg Depth (mm)
leg_y = 3;
//Leg Height (mm)
leg_z = 40;

/* [Skirt] */
//Skirt Thickness (mm)
skirt_x = 2;
//Skirt Offset from Edge (mm)
skirt_top_offset = 2;
//Skirt Height (mm)
skirt_z = 4;
union() {
    translate([0,0,leg_z + top_z + offset]) {
        rotate([0,180,0]) {
            top();
            legs();
            fullSkirt();
        }
    }
}
module fullSkirt() {
    //skirt y.1
    translate([skirt_top_offset, skirt_top_offset, top_z-offset]) {
        skirt(top_y);
    }

    //skirt y.2
    translate([top_x - skirt_x - skirt_top_offset, skirt_top_offset, top_z-offset]) {
        skirt(top_y);
    }

    //skirt x.1
    translate([top_x - skirt_top_offset, skirt_top_offset, top_z-offset]) {
        rotate([0,0,90]) {
            skirt(top_x);
        }
    }

    //skirt x.2
    translate([top_x - skirt_top_offset, top_y - skirt_top_offset - skirt_x, top_z-offset]) {
        rotate([0,0,90]) {
            skirt(top_x);
        }
    }
}
module legs() {
    //leg 1
    translate([0,0,top_z]) {
        leg();
    }

    //leg 2
    translate([(top_x-leg_x),0,top_z]) {
        leg();
    }

    //leg 3
    translate([(top_x-leg_x),(top_y-leg_y),top_z]) {
        leg();
    }

    //leg 4
    translate([0,(top_y - leg_y),top_z]) {
        leg();
    }
}
module leg() {
    color (leg_colour, 1.0) {
        cube ([leg_x,leg_y,leg_z + offset], false);
    }
}
module skirt(width) {
    color (skirt_colour, 1.0) {
        cube ([skirt_x, width-(skirt_top_offset * 2), skirt_z + offset], false);
    }
}
module top() {
    color (top_colour, 1.0) {
        cube ([top_x,top_y,top_z], false);
    }
}
