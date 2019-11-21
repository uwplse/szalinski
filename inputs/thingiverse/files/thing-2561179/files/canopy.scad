// screw offset from front of canopy to first screw
screw_offset = 35;

// thickness of canopy walls
canopy_t = 3;

// thickness of strap inset
strap_t = 1;

// width of strap cut
strap_w = 20;

// screw x separation
screw_x = 91;

// screw y separation
screw_y = 95;

// screw drill hole diameter
screw_d = 3.5;


module outset(r) {
    minkowski() {
        circle(r=r);
        children();
    }
}

module inverse() {
	difference() {
		square(1e5,center=true);
		children();
	}
}

module fillet(r=1) {
	inset(r=r) render() outset(r=r) children();
}

module rounding(r=1) {
	outset(r=r) inset(r=r) children();
}

module inset(r) {
    inverse() outset(r) inverse() children();
}

module half_body_shape() {
    polygon([[0, 0], [0, 45], [60, 95], [150, 60], [150, 0]]);
}

module body_shape() {
    half_body_shape();
    mirror([0, 1, 0]) half_body_shape();
}

module body_perimeter(t) {
    difference() {
        body_shape();
        inset(t) body_shape();
    }
}

module canopy(t, t_strap) {
    render() difference() {
        union() {
            linear_extrude(t) body_shape();
            difference() {
                linear_extrude(80) body_perimeter(t);
                translate([50, -500, 40]) cube([100, 1000, 100], center=false);
            }
        }
    }
}

module strap_cuts() {
    render() translate([0, 0, -50]) intersection() {
        linear_extrude(100) difference() {
            outset(canopy_t) body_shape();
            inset(strap_t) body_shape();
        };
        translate([105, -500, 0]) cube([strap_w, 1000, 100]);
    }
}

module drill_holes() {
    translate([screw_offset, 0, 0]) linear_extrude(100) {
        translate([0, screw_y/2]) circle(d=screw_d);
        translate([0, -screw_y/2]) circle(d=screw_d);
        translate([screw_x, screw_y/2]) circle(d=screw_d);
        translate([screw_x, -screw_y/2]) circle(d=screw_d);
    }
}

module accessory_port_back() {
    translate([80, -50, canopy_t + 1]) cube([100, 100, 60], center=false);
}

module accessory_port_front() {
    translate([-40, 0, 0]) cube([100, 70, 20], center=true);
}

render() difference() {
    canopy(canopy_t, strap_t);
    accessory_port_back();
    translate([0, 0, 70]) accessory_port_front();
    //translate([0, 0, 20]) accessory_port_front();
    drill_holes();
    strap_cuts();
}

