// Drain Strainer
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

/* [Strainer] */
strainer_type = "square"; // [square: Square,circle: Circle]
strainer_x_mm = 3.0; //[1.0:10.0]
strainer_y_mm = 3.0; //[1.0:10.0]
strainer_thickness_mm = 1.0; //[1.0:3.0]
strainer_grid_spacing_mm = 2.0; //[0.5:3.0]

/* [Drain] */
drain_diameter_mm = 42.5; //[5.0:150.0]
drain_depth_mm = 10.0; //[0.0:50.0]
drain_sleeve_thickness = 1.0; //[0.5:3.0]

/* [Skirt] */
skirt_diameter_mm = 52.5; //[5.0:200.0]
skirt_upper_diameter_mm = 48.5; //[5.0:200.0]
skirt_thickness_mm = 2.0; //[1.0:3.0]

/* [Hidden] */
skirt_z_offset = drain_depth_mm - skirt_thickness_mm;
circle_strainer_resolution = 10;
drain_sleeve_difference = drain_sleeve_thickness * 2;

module drain_sleeve() {
    difference() {
        cylinder(h=drain_depth_mm, d=drain_diameter_mm);
        cylinder(h=drain_depth_mm, d=drain_diameter_mm-drain_sleeve_difference);
    }
}

module strainer_square() {
    x_size = strainer_x_mm + strainer_grid_spacing_mm;
    x_total = ceil(drain_diameter_mm / x_size) * x_size;
    x_offset = (x_total - strainer_grid_spacing_mm) / 2;
    y_size = strainer_y_mm + strainer_grid_spacing_mm;
    y_total = ceil(drain_diameter_mm / y_size) * y_size;
    y_offset = (y_total - strainer_grid_spacing_mm) / 2;

    translate([-x_offset, -y_offset, 0]) {
        for (x = [0:x_size:drain_diameter_mm]) {
            translate([x,0,0])
            for (y = [0:y_size:drain_diameter_mm]) {
                translate([0, y, 0])
                    cube([strainer_x_mm, strainer_y_mm, strainer_thickness_mm]);
            }
        }
    }
}

module strainer_circle() {
    x_size = strainer_x_mm + strainer_grid_spacing_mm;
    x_total = ceil(drain_diameter_mm / x_size) * x_size;
    x_offset = (x_total) / 2;
    y_size = strainer_y_mm + strainer_grid_spacing_mm;
    y_total = ceil(drain_diameter_mm / y_size) * y_size;
    y_offset = (y_total) / 2;

    translate([-x_offset, -y_offset, 0]) {
        for (x = [0:x_size:drain_diameter_mm]) {
            translate([x,0,0])
            for (y = [0:y_size:drain_diameter_mm]) {
                translate([0, y, 0])
                    cylinder(h=strainer_thickness_mm, d=strainer_x_mm, $fn=circle_strainer_resolution);
            }
        }
    }
}

module strainer() {
    union() {
        difference() {
            cylinder(h=strainer_thickness_mm, d=drain_diameter_mm);
            cylinder(h=strainer_thickness_mm, d=drain_diameter_mm-drain_sleeve_difference);
        }
        difference() {
            cylinder(h=strainer_thickness_mm, d=drain_diameter_mm);

            if (strainer_type == "square") {
                strainer_square();
            } else if (strainer_type == "circle") {
                strainer_circle();
            }
        }
    }
}

module skirt() {
    difference() {
        cylinder(h=skirt_thickness_mm, d1=skirt_diameter_mm, d2=skirt_upper_diameter_mm);
        cylinder(h=skirt_thickness_mm, d=drain_diameter_mm);
    }
}

union() {
    drain_sleeve();
    strainer();
    translate([0, 0, skirt_z_offset])
        skirt();
}
