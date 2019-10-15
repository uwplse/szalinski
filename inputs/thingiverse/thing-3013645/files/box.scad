length = 200;
width = 200;
height = 20;
wall_thickness = 2;
hex_spacing = 2;
hex_radius = 4;

include_dividers = "yes"; // [no, yes]
x_dividers = 1;
y_dividers = 1;

module hex(length, width, height, radius, spacing) {
    i_step = 3 * radius + sqrt(3) * spacing;
    j_step = sqrt(3) * radius + spacing;
    for (i=[0:i_step:(length + 2 * radius) * 1.1], j=[0:j_step:width + radius]) {
        translate([i, j, 0]) cylinder(h=height, r=radius, $fn=6);
        translate([i + i_step / 2, j + j_step / 2, 0]) cylinder(h=height, r=radius, $fn=6);
       
    }
}

module face(length, width) {
  difference(){
    cube([length + 2 * wall_thickness, width + 2 * wall_thickness, wall_thickness]);
    intersection() {
      translate([wall_thickness, wall_thickness, -0.001])
        cube([length, width, wall_thickness + 2 * 0.001]);
      translate([- (3 * hex_radius + sqrt(3)), 0, -0.001])
        hex(length + 2 * wall_thickness, width + 2 * wall_thickness, wall_thickness + 2 * 0.001, hex_radius, hex_spacing);
    }
  }
}

module dividers() {
    x_spacing = length / (x_dividers + 1);
    doffset = wall_thickness / 2;
    for (x = [x_spacing:x_spacing:x_spacing * x_dividers]) {
        translate([x + doffset, 0, 0]) rotate([90, 0, -270]) face(width, height);
    };
            
    y_spacing = width / (y_dividers + 1);
    for (y = [y_spacing:y_spacing:y_spacing * y_dividers]) {
        translate([0, y + wall_thickness + doffset, 0]) rotate([90, 0, 0]) face(length, height);
    };
};

module box() {
    union() {
        cube([length + 2 * wall_thickness, width + 2 * wall_thickness, wall_thickness]);
        rotate([90, 0, -270]) face(width, height);
        translate([0, wall_thickness, 0]) rotate([90,0,0]) face(length, height);    
        translate([0, width + 2 * wall_thickness, 0]) rotate([90,0,0]) face(length, height);
        translate([length + wall_thickness, 0, 0]) rotate([90, 0, -270]) face(width, height);
        
        if (include_dividers == "yes") {
            dividers();
        };
    }
}

box();