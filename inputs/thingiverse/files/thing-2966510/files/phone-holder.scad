/* [Device] */

// Device width
device_width = 58;

// Device height
device_height = 124;

// Device thickess
device_thickness = 7.5;

/* [Charger] */

// Make charger holes or not
charger_holes = "yes"; // [yes,no]

// Charger plug width
charger_width = 8;

// Charger plug height + wire length 
charger_height = 40;

// Charger thickness
charger_thickness = 5;

// Charger position X factor
charger_position_factor_x = 0.5; // [0:0.01:1]

// Charger position Y factor
charger_position_factor_y = 0.5; // [0:0.01:1]

/* [Misc] */

// Thickness of holder
holder_thickness = 2.88;

// Fillet radius for base and foot parts
holder_fillet = 10;

// Holder angle
holder_angle = 30; // [0:0.5:80]

// Factor to cut the base
holder_cut_factor = 0; // [0:0.01:1]

// Arc radius
arc_radius = "default";

// Foot length
foot_length = "default";

/* [Shelf] */

// Shape of shelf 
shelf_shape = "darc"; // [darc,arc,tri]

// Additional shelf height
shelf_additional_height = "default";

// Height of front support (set to zero if you dont want front support)
front_support_height = 5;

// Front support fillet radius
front_support_fillet = "default";

/* [Patterns] */

// Outline for base part
base_pattern_outline = "default";

// Outline for foot part
foot_pattern_outline = "default";

// Base part pattern preset
base_pattern_preset = 0; // [0:1:33]

// Foot part pattern preset
foot_pattern_preset = 0; // [0:1:33]


module holder() {

    charger_position_factors = [charger_position_factor_x, charger_position_factor_y];
    device_dimensions = [device_width,device_height,device_thickness];
    charger_dimensions = [charger_width, charger_height, charger_thickness]; // include wire bending in height

    // Additional height for shelf (if you want flat shelf - set it to 0)
    front_support_fillet_val = front_support_fillet != "default" ? front_support_fillet : front_support_height / 2;
    shelf_additional_height_val = shelf_additional_height != "default" ? shelf_additional_height : device_dimensions[2] + holder_thickness;
    arc_radius_val = arc_radius != "default" ? arc_radius : (charger_dimensions[1] - (holder_thickness + shelf_additional_height_val)) * sin(45 - holder_angle / 2) / sin(45 + holder_angle / 2);
    foot_length_val = foot_length != "default" ? foot_length : (device_dimensions[1] + (holder_thickness + shelf_additional_height_val) - arc_radius_val * sin(90 - holder_angle) / sin(holder_angle)) * cos(90 - holder_angle) + holder_thickness * cos(holder_angle);

    // outline for pattern
    pattern_outlines = [
        base_pattern_outline != "default" ? base_pattern_outline : holder_thickness, 
        foot_pattern_outline != "default" ? foot_pattern_outline : holder_thickness
        ];
    pattern_presets = [base_pattern_preset, foot_pattern_preset];

    module concentric_pattern(d, t) {
        center = [d[0]/2, d[1]/2];
        translate(center, $fa=2, $fs=0.1) {
            for (i = [t:t * 2:max(d[0],d[1])]) {
                difference() {
                    circle(i + t);
                    circle(i);
                }
            }
        }
    }


    module place_grid(d, grid, offsets=true, hex=false) {
        off = offsets ? grid : [d[0] / grid[0], d[1] / grid[1]];
        cnt = [ceil(d[0]/off[0]) + 2, ceil(d[1]/off[1]) + (hex ? 3 : 2)];
        start = [d[0] / 2 - cnt[0]*off[0] / 2, d[1] / 2 - cnt[1]*off[1] / 2];
        for (xi = [0:cnt[0]-1], yi = [0:cnt[1]-1]) {
            translate([xi * off[0] + start[0] + off[0] / 2, yi * off[1] + start[1] + off[1] / 2 - (xi % 2 != 0 && hex ? off[1]/2 : 0)])
                children(); 
        }
    }

    module place_circular(d, r, min_angle) {
        
        c = [d[0]/2,d[1]/2];
        cnt = max(d[0],d[1])/r;
        
        for (ri = [0:cnt-1]) {
            if (ri == 0) {
                
                translate(c) 
                    children();
                
            } else {
                
                rf = ri * r;
                steps = arc_step_count(rf, 360);
                step = 360/steps;
                
                for (a = [0:steps-1])
                    translate([cos(a * step) * rf + c[0], sin(a * step) * rf + c[1]])
                        children();
            }
        }
    }

    module profile(thickness) {
        difference() {
            offset(delta = thickness)
                children();
            children();
        }
    }


    pattern_preset_modes = [
        "n", 
        // ngons + cirle (offset y)    
        "d", "d", "d", "d", "d", "d", "d", "d",
        // ngons + circle (no y offset)
        "d", "d", "d", "d", "d", "d", "d", "d",

        // ngons + cirle (offset y)    
        "i", "i", "i", "i", "i", "i", "i", "i", 
        // ngons + circle (no y offset)
        "i", "i", "i", "i", "i", "i", "i", "i", 
        // concentric
        "i"
    ];
    pattern_preset_thickness = [
        0,
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,
        0.4
    ];

    // i - intersection, d - difference
    pattern_modes = [pattern_preset_modes[pattern_presets[0]], pattern_preset_modes[pattern_presets[1]]]; 

    // useful for text
    pattern_thickness = [pattern_preset_thickness[pattern_presets[0]], pattern_preset_thickness[pattern_presets[1]]];

    module pattern(part, dim) {   
        preset = pattern_presets[part];
        if (preset >= 1 && preset <= 16) {
            
            n = (preset - 1) % 8 + 3;
            r = 5;
                   
            place_grid(dim, [r * 2 + (preset >= 8 ? holder_thickness / 2 : 0), r * 2 + holder_thickness / 2], hex = preset < 8)
                if (n == 9) 
                    rotate(45)
                        ngon(4, r);
                else if (n == 10)
                    circle(r);
                else
                    ngon(n, r);
                
        } else if (preset >= 17 && preset <= 32) {
            
            n = (preset - 17) % 8 + 3;
            r = 12;
            
            place_grid(dim, [r + holder_thickness, r], hex = preset < 8)
                profile(2) {
                    if (n == 9) 
                        rotate(45)
                            ngon(4, r);
                    else if (n == 10)
                        circle(r);
                    else
                        ngon(n, r);
                }
                
        } else if (preset == 33) {
            concentric_pattern(dim, 0.8);
        }
    }

    function radius_x(r) = r[0] == undef ? r : r[0];
    function radius_y(r) = r[1] == undef ? r : r[1];
    function ellipse_perimeter(r) = let(rx = radius_x(r), ry = radius_y(r)) 2 * PI * ((rx == ry) ? rx : sqrt((rx*rx + ry*ry) / 2));
    function arc_step_count(r, a) = $fn > 0 ? a / 360 * $fn : ceil(max(min(a / $fa, ellipse_perimeter(r) / $fs), 5));
    function arc_step(s, e, c) = (e - s) / c;
    function arc_pt(r, a, p) = [cos(a) * radius_x(r) + p[0], sin(a) * radius_y(r) + p[1]];
    function arc_loop_no_close(r, s, e, p, c) = [ for(i = [0 : c-1]) arc_pt(r, s + i * arc_step(s, e, c), p) ];
    function arc_loop(r, s, e, p, c, close = true) = close 
        ? concat(arc_loop_no_close(r,s,e,p,c), [arc_pt(r, e, p)])
        : arc_loop_no_close(r,s,e,p,c);
    function arc(r, s, e, p = [0,0], close = true) = arc_loop(r, s, e, p, arc_step_count(r, abs(e - s)), close);

    function ngon_poly(n, r, p = [0, 0]) = arc_loop_no_close(r, 0, 360, p, n);
    module ngon(n, r) 
        polygon(ngon_poly(n, r));

    module arc_shape(r, s, e, thickness) {
        inner = arc(r - thickness, s, e);
        outer = arc(r, e, s);
        polygon(concat(inner, outer));
    }

    mount_plate_dim = [device_dimensions[0], device_dimensions[1] * (1 - holder_cut_factor), holder_thickness];
    shelf_dim = [device_dimensions[2] + holder_thickness * 2, holder_thickness + shelf_additional_height_val];

    // tolerance to join parts
    union_tolerance = 0.1;

    module square_top_fillet(d, r = 0) {
        if (r == 0) {
            square([d[0], d[1]]);
        } else {
            polygon(concat([[0,0],[d[0],0]],
                arc(r, 0, 90, [d[0] - r, d[1] - r], true),
                arc(r, 90, 180, [r, d[1] - r], true)
            ));
        }
    }

    module charger(height) {
        if (charger_holes == "yes") {
        
            translate([charger_position_factors[0] * device_dimensions[0] + charger_dimensions[2] / 2 - charger_dimensions[0] / 2, 0, holder_thickness + charger_dimensions[2] / 2])
            rotate([-90,0,0])
            hull($fn=64) {
                cylinder(d = charger_dimensions[2], h = height);
                translate([charger_dimensions[0] - charger_dimensions[2], 0, 0]) cylinder(d = charger_dimensions[2], h = height);
            }
            
        }
    }

    module pattern_mode(mode) {
        if (mode == "i") {
            intersection() {
                children(0);
                children(1);
            }
        } else if (mode == "d") {
            difference() {
                children(0);
                children(1);
            }
        } else {
            children();
        }
    }

    module pattern_filled(part, dim, off=[0,0]) {
        linear_extrude(holder_thickness) {
            difference() {
                children();
                offset(-pattern_outlines[part])
                    children();
            }
            translate([pattern_outlines[part] + off[0], pattern_outlines[part] + off[1]]) 
                pattern_mode(pattern_modes[part]) {
                    translate([-pattern_outlines[part] - off[0], -pattern_outlines[part] - off[1]])
                        children();
                    pattern(part, [dim[0] - pattern_outlines[part] * 2, dim[1] - pattern_outlines[part] * 2]);
                }
        }
        
        pt = pattern_thickness[part];
        if (pt > 0) {
            linear_extrude(holder_thickness - pt)
                children();
        }
    }

    module holder_base() {
        pattern_filled(0, [mount_plate_dim[0], mount_plate_dim[1]], [0,shelf_dim[1]])
            translate([0, shelf_dim[1]])
                square_top_fillet(mount_plate_dim, holder_fillet, $fn = 64);        
    }

    module holder_shelf() {
        difference() {
            union() {
                translate([mount_plate_dim[0],0])
                rotate([0,-90,0])
                linear_extrude(mount_plate_dim[0], $fn = 64)
                    polygon(concat(
                        [
                            [0,0], 
                            [0,-union_tolerance],
                            [holder_thickness,-union_tolerance]
                        ],
                        shelf_additional_height_val == 0 || (shelf_shape != "arc" && shelf_shape != "darc") ?
                            [[holder_thickness,0], [shelf_dim[0], shelf_additional_height_val]] :
                        shelf_shape == "arc" ?
                            arc([shelf_dim[0] - holder_thickness, shelf_additional_height_val], 180, 90, [shelf_dim[0], 0]) :
                            concat(
                                arc([(shelf_dim[0] - holder_thickness) / 2, shelf_additional_height_val / 2], 180, 90, [(shelf_dim[0] + holder_thickness) / 2, 0], false),
                                arc([(shelf_dim[0] - holder_thickness) / 2, shelf_additional_height_val / 2], -90, 0, [(shelf_dim[0] + holder_thickness) / 2, shelf_additional_height_val], true)
                            ),
                        [
                            [shelf_dim[0], shelf_dim[1]], 
                            [holder_thickness, shelf_dim[1]], 
                            [holder_thickness, shelf_dim[1] + union_tolerance], 
                            [0, shelf_dim[1] + union_tolerance]
                        ]
                    ));
                    
                if (front_support_height > 0) {
                    translate([0, shelf_dim[1] - union_tolerance, device_dimensions[2] + holder_thickness])
                    linear_extrude(holder_thickness)
                        square_top_fillet([device_dimensions[0], front_support_height + union_tolerance], front_support_fillet_val);
                }
            }
            
            translate([0, 0, charger_position_factors[1] * (device_dimensions[2] - charger_dimensions[2])])
            charger(shelf_dim[1] + front_support_height + 1);
        }
    }

    module holder_foot() {
        dimensions = [mount_plate_dim[0], foot_length_val];
        pattern_filled(1, dimensions) 
            square_top_fillet(dimensions, holder_fillet);
    }
        
    module holder_arc() {
        translate([mount_plate_dim[0], 0, arc_radius_val])
            rotate([90,0,0])
                rotate([0, -90, 0])
                    linear_extrude(mount_plate_dim[0], $fn = 128)
                        arc_shape(arc_radius_val, -90, holder_angle, holder_thickness);
    }

    union() { 

        translate([0,0,arc_radius_val])
        rotate([90 - holder_angle, 0, 0])
        translate([0,0,arc_radius_val - holder_thickness])    
        holder_base();
        
        render()
        difference() {
            
            union() {
                translate([0,0,arc_radius_val])
                rotate([90 - holder_angle, 0, 0])
                translate([0,0,arc_radius_val - holder_thickness])    
                holder_shelf();
                holder_arc();
            }
            
            translate([0, -arc_radius_val - 1, 0])
                charger(arc_radius_val + holder_thickness + 1);
        }
        
        holder_foot();
    }

}

holder();