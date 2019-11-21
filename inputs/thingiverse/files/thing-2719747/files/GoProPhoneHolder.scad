// Phone holder with GoPro Mount
// (c) 2017 Michael Neuendorf <michael@neuendorf-online.de>

/* [General] */
// The phone width in mm
phone_width = 147;
// The phone thickness in mm
phone_thickness = 11;
// The phone height in mm
phone_height = 75;

// Select to generate sound ducts
sound_duct = 2; // [0:none, 1:left, 2:right, 3:both]
// Select to generate a hole for the power cord
power_connector = 1; // [0:no, 1:yes]

/* [Hidden] */
wall_thickness = 1.6;
holder_thickness = phone_thickness + 2 * wall_thickness;
holder_width = phone_width + 2 * wall_thickness;
front_side_border = 5;
front_bottom_border = 2;
back_height = 30;

function left_height() = (sound_duct == 1 || sound_duct == 3) ? phone_height : back_height;
function right_height() = (sound_duct == 2 || sound_duct == 3) ? phone_height : back_height;

// Artifact eliminating offset
a = 0.01;

module boder_cut(l, w = phone_thickness - 3 * wall_thickness, t = wall_thickness + 2 * a) {
    w2 = w / 2;
    linear_extrude(height = t)
    polygon(points = [
        [w2, 0]
        ,[w, w2]
        ,[w, l - w2]
        ,[w2, l]
        ,[0, l - w2]
        ,[0, w2]
    ]);
}

module phone_holder() {
    difference() {
        cube([holder_width, phone_thickness + 2 * wall_thickness, phone_height + wall_thickness]);
        translate([wall_thickness, wall_thickness, wall_thickness])
        cube([phone_width, phone_thickness, phone_height + a]);
        
        // Front cut
        translate([wall_thickness + front_side_border, -a, wall_thickness + front_bottom_border])
        cube([phone_width - 2 * front_side_border, wall_thickness + 2 * a, phone_height - front_bottom_border + a]);
        
        translate([-a, holder_thickness + a, wall_thickness])
        rotate([90, 0, 0])
        linear_extrude(height = holder_thickness + 2 * a)
        polygon(points = [
            [-a, left_height()]
            ,[front_side_border, left_height()]
            ,[front_side_border + 20, back_height]
            ,[holder_width - 20 - front_side_border, back_height]
            ,[holder_width - front_side_border, right_height()]
            ,[holder_width + 2 * a, right_height()]
            ,[holder_width + 2 * a, phone_height + a]
            ,[-a, phone_height + a]
        ]); 
        
        translate([-a, 2.5 * wall_thickness, 2 * wall_thickness])
        rotate([90, 0, 90])
        boder_cut(l = left_height() - 3 * wall_thickness);
        
        translate([holder_width - wall_thickness - a, 2.5 * wall_thickness, 2 * wall_thickness])
        rotate([90, 0, 90])
        boder_cut(l = right_height() - 3 * wall_thickness);
    }
}

module sound_duct(h) {
    difference() {
        cylinder(r = holder_thickness, h = h, $fn = 50);
        
        translate([0, 0, -a])
        cylinder(r = holder_thickness - wall_thickness, h = h + 2*a, $fn = 50);
        
        translate([0, 0, -a])
        linear_extrude(height = h + 2 * a)
        polygon(points = [
            [0, 0]
            ,[holder_thickness + a, 0]
            ,[holder_thickness + a, -holder_thickness - a]
            ,[-holder_thickness - a, -holder_thickness - a]
            ,[-holder_thickness - a, holder_thickness + a]
            ,[0, holder_thickness + a]
        ]);
    }
}

module gopro_mount(a) {
    difference() {
        union() {
            translate([15, 0, 0])
            cylinder(d = 15, h = 9, $fn=50);
            translate([0, -7.5, 0])
            cube([15, 15, 9]);
        }
        
        translate([15, 0, -a])
        cylinder(d = 5.2, h = 9 + 2 * a, $fn=25);
        translate([-a, -7.5 - a, 9 / 2 - 3.4 / 2])
        cube([23, 15 + 2 * a, 3.4]);
    }
}

difference() {
    union() {
        phone_holder();
        
        if (sound_duct == 1 || sound_duct == 3) {
            translate([0, 0, left_height() + wall_thickness])
            rotate([0, 180, 0])
            sound_duct(h = left_height() + wall_thickness);
        }
        
        if (sound_duct == 2 || sound_duct == 3) {
            translate([holder_width, 0, 0])
            sound_duct(h = right_height() + wall_thickness);
        }
        
        translate([holder_width / 2 - 9.5 / 2, holder_thickness, 7.5])
        rotate([90, 0, 90])
        gopro_mount(a);
    }
    
    if (power_connector == 1) {
        if (sound_duct == 1 || sound_duct == 3) {
            translate([-holder_thickness - a, (holder_thickness - 9) / 2, (phone_height - 18) / 2])
            rotate([90, 0, 0])
            rotate([0, 90, 0])
            boder_cut(l = 18, w = 9, t = holder_thickness + wall_thickness + 2*a);
        }

        if (sound_duct == 2 || sound_duct == 3) {
            translate([holder_width - wall_thickness - a, (holder_thickness - 9) / 2, (phone_height - 18) / 2])
            rotate([90, 0, 0])
            rotate([0, 90, 0])
            boder_cut(l = 18, w = 9, t = holder_thickness + wall_thickness + 2*a);
        }
    }
}