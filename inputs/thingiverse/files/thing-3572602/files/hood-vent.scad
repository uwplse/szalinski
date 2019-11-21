/* [Global] */

part = "all"; // [all:All parts, insert:Insert for conduit holder, cap:Cover for hole, no_cap:Hood vent mount and insert,mount:Hood vent mount, radius:radius guage]

tolerance = 0.2;

/* [Wall] */

wall_radius = 40;
wall_height = 100;
wall_width = 110;
wall_diff = 3;
wall_thickness = 3;

/* [Connector] */

inner_wall_id = 51.5;
inner_wall_od = 54.5;
inner_wall_height = 30;

outer_wall_id = 62.5;
outer_wall_od = 65.5;
outer_wall_height = 25;

/* [Hidden] */

bwallh = wall_height + wall_diff;
bwallw = wall_width + (2*wall_diff);
hwallw = wall_width / 2;
hwallh = wall_height / 2;

module wall(height, width, thickness, radius) {
    a = height - radius;
    b = width - 2* radius;
    union(){
        cube([width, a, thickness], false);
        translate([radius,a, 0]) cube([width - 2* radius, radius, thickness], false);
        translate([radius, a, 0]) cylinder(r=radius, h = thickness);
        translate([width - radius, a, 0]) cylinder(r=radius, h = thickness);
    }
}

module tube(outer, inner, height) {
    difference() {
        cylinder(d=outer, h = height);
        translate([0,0,-0.5]) cylinder(d=inner, h=height+1);
    }
}

module guage() {
    intersection() {
        cube(wall_radius+5, false);
        union() {
            translate([0,0,wall_thickness*2]) cylinder(r=wall_radius-5,h = wall_thickness);
            translate([0,0,wall_thickness]) cylinder(r=wall_radius,h = wall_thickness);
            cylinder(r=wall_radius + 5,h = wall_thickness);
        }
        
    }
}

module insert() {
    inner = 7.8;
    difference() {
        union() {
            translate([hwallw,inner/2,7.5]) cube([13.3, inner, 13.8], true);
            translate([hwallw,4.9,7.5]) cube([11.8, 9.8, 15],true);
        }
        translate([hwallw,10,-0.5]) cylinder(d=11.6, h = 16);
        translate([hwallw,10,0.75]) cylinder(d=13.5, h = 13.5);
    }
}

module mount() {
    difference(){
        union(){
            translate([0,0,6]) wall(bwallh, bwallw, 3, wall_radius);
            translate([3,0,3]) wall(100, wall_width, 3, wall_radius);
            wall(bwallh, bwallw, 3, wall_radius);
            translate([hwallw, hwallh, 9]) tube(outer_wall_od, outer_wall_id, outer_wall_height);
            translate([hwallw, hwallh, 9]) tube(inner_wall_od, inner_wall_id, inner_wall_height);
            translate([hwallw, 10, 0]) cylinder(d=16, h=15);
            translate([hwallw, 5, 7.5]) cube([16,10,15], true);
        }
        translate([hwallw,hwallh,-.5]) cylinder(d=inner_wall_id, h=inner_wall_height+1);
        translate([hwallw,10,0.75]) cylinder(d=13.5, h = 13.5);
        translate([hwallw,-1,.5]) cube([13.5, 8.9, 14],true);
        translate([hwallw,-1,-0.5]) cube([12, 11, 16],true);
        translate([hwallw,10,-0.5]) cylinder(d=11.5, h = 16);
        translate([hwallw,4.5,7.5]) cube([12, 11, 16],true);
    }
}

module cap() {
    translate([hwallw,hwallh,3 * wall_thickness + tolerance]) tube(outer_wall_id - tolerance, inner_wall_od + tolerance, inner_wall_height);
    translate([hwallw,hwallh,39.2]) cylinder(d=outer_wall_id - tolerance, h=wall_thickness);
}

if (part == "insert") {
    insert();
} else if (part == "all") {
    insert();
    mount();
    cap();
} else if (part == "no_cap") {
    insert();
    mount();
} else if (part == "cap") {
    cap();
} else if (part == "radius") {
    guage();
} else {
    mount();
}