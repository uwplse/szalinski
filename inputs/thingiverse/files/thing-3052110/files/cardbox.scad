// card width
card_x = 70; // [45: 120]

//card height
card_y = 100; // [45: 120]

// wall thickness
thickness = 2.5; // [1.5:0.1:3.5]

// box inner height
inner_h = 40; // [20:100]

image_file = "image.png"; // [image_surface:150x150]

module card_box(card_x, card_y, thickness, inner_height) {
    p1 = [0,0];
    p2 = p1 + [0, inner_height];
    p3 = p2 + [-thickness, 0];
    p4 = p3 + [-thickness, thickness];
    p5 = p4 + [thickness, thickness];
    p6 = p5 + [-thickness, 0];
    p7 = p6 + [-thickness, -thickness];
    p8 = p7 + [0, -thickness];
    p9 = p8 + [2*thickness, -2*thickness];
    p10 = p9 + [0, -inner_height+(3*thickness)];
    p11 = p10 + [-thickness*0.8, -thickness*1.1];
    p12 = p10 + [0, -1.8*thickness];
    p13 = p12 + [thickness+card_x/2,0];
    p14 = p13 + [0, thickness*0.8];

    p=[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14];
    difference() {
        union() {
            linear_extrude(height = card_y+2*thickness, center=true) {
                union() {
                    translate([-card_x/2,0,0]) polygon(points=p);
                    mirror([1,0,0]) translate([-card_x/2,0,0]) polygon(points=p);
                }
            }
            translate([0,inner_height/2,-card_y/2-thickness/2]) cube(size=[card_x, inner_height, thickness], center=true);
            translate([0,inner_height/2,card_y/2+thickness/2]) cube(size=[card_x, inner_height, thickness], center=true);
            translate([card_x/2+thickness/2, inner_height-1.25, (-card_y/2)*0.85]) rotate([0,90,0]) cylinder(h=thickness*0.5, r=2, center=true, $fn=10);
            translate([-card_x/2-thickness/2, inner_height-1.25, (-card_y/2)*0.85]) rotate([0,90,0]) cylinder(h=thickness*0.5, r=2, center=true, $fn=10);
        }
        translate([card_x/2+thickness/2, -2.2, (-thickness*1.01)+(-card_y/2)*0.925]) cube([thickness*0.6,2,(card_y/2)*0.15], center=true);
        translate([card_x/2+thickness/2, -2.2, (-card_y/2)*0.85]) cube([thickness,4,5.1], center=true);
        translate([-card_x/2-thickness/2, -2.2, (-thickness*1.01)+(-card_y/2)*0.925]) cube([thickness*0.6,2,(card_y/2)*0.15], center=true);
        translate([-card_x/2-thickness/2, -2.2, (-card_y/2)*0.85]) cube([thickness,4,5.1], center=true);
    }
}

module card_box_cap(card_x, card_y, thickness) {
    p1 = [0,0];
    p2 = p1 + [0,thickness];
    p3 = p2 +  [-thickness, 0];
    p4 = p3 + [-thickness*0.8, -thickness*1.1];
    p5 = p3 + [0, -1.8*thickness];
    p6 = p5 + [thickness+card_x/2,0];
    p7 = p6 + [0, thickness*0.8];
    
    p = [p1,p2,p3,p4,p5,p6,p7];
    
    difference() {
        union() {
            linear_extrude(height = card_y+2*thickness, center=true) {
                union() {
                    translate([-card_x/2,0,0]) polygon(points=p);
                    mirror([1,0,0]) translate([-card_x/2,0,0]) polygon(points=p);
                }
            }

            scale([0.4,thickness*0.8,0.4]) rotate([-90,0,0])  surface(file=image_file, center=true, invert=true);
        }
        translate([card_x/2+thickness/2, -2.2, (-thickness*1.01)+(-card_y/2)*0.925]) cube([thickness*0.6,2,(card_y/2)*0.15], center=true);
        translate([card_x/2+thickness/2, -2.2, (-card_y/2)*0.85]) cube([thickness,4,5.1], center=true);
        translate([-card_x/2-thickness/2, -2.2, (-thickness*1.01)+(-card_y/2)*0.925]) cube([thickness*0.6,2,(card_y/2)*0.15], center=true);
        translate([-card_x/2-thickness/2, -2.2, (-card_y/2)*0.85]) cube([thickness,4,5.1], center=true);
    }
}
rotate([90,0,0]) {
    card_box(card_x, card_y, thickness, inner_h);
    translate([card_x +30,0,0]) card_box_cap(card_x, card_y, thickness);
}