// Copyright 2019 Michael K Johnson
// Use allowed under Attribution 4.0 International (CC BY 4.0) license terms
// https://creativecommons.org/licenses/by/4.0/legalcode
// Model of Mikey's Square, Knife, and Threading Tools
// https://www.hobby-machinist.com/threads/models-for-grinding-hss-lathe-tools.62111/
// Scale 200-500% for printing, reducing length, to see closely
// All parameters are in inches, because that's common use
// https://me-mechanicalengineering.com/single-point-cutting-tool/ has definitions

// Stock is assumed to be square in cross section
stock_width = 0.5;
// Typical stock is 3-6 inches long; can reduce to print enlarged models to concentrate on shape of tip
stock_len = 3;
// To model the curve from the wheel; 6" and 8" are common
wheel_diameter = 8;
// Wheel or platen thickness; matters only if using this for visualizations
wheel_thickness = 1;
// Radius of the edge of the wheel/platen; shows at back edge of top cut
wheel_edge_radius = .0625;
// Common radii are .0156 (1/64") .03125 (1/32") .0625 (1/16") (Nose radius currently ignored)
nose_radius = .03125;
knife_nose_radius = 0.156;
// Side Cutting Edge Angle (SCEA)
side_cutting_edge_angle = 15;
// End Cutting Edge Angle (ECEA) is derived from the included angle of the tip, and is normally less than 90
tip_included_angle = 80;
knife_tip_included_angle = 65;
threading_tip_included_angle = 60;
// Back Rake (BR) 
back_rake_angle = 15;
// Back Rake depth ratio (depth of back rake relative to stock width; reduce for high BR)
back_rake_depth_ratio = 1;
// Knife Back Rake (BR) (knife tool)
knife_back_rake_angle = 10;
// Side Rake (SR)
side_rake_angle = 15;
// Side Relief
side_relief_angle = 15;
// End Relief ("Clearance")
end_relief_angle = 15;
// How far back the top of the tool the side cut extends, relative to the width of the stock; typically between 1 and 2
side_edge_aspect_ratio = 1.5;
threading_side_edge_aspect_ratio = 0.5;
// use_platen: true for belt grinder platen, false for wheel grinder
use_platen = true;

/* [Hidden] */

// true to use simple shapes for fast rendering while developing; false for more accurate shapes for final renders
fast_render = false;

function mm(inches) = inches * 25.4;

stock_w = mm(stock_width);
stock_l = mm(stock_len);
wheel_r = mm(wheel_diameter) / 2;
wheel_t = mm(wheel_thickness);
wheel_e_r = mm(wheel_edge_radius);
nose_r = mm(nose_radius);
knife_nose_r = mm(knife_nose_radius);

// Logical pre-rounded tip located at -pivot_offset
function pivot_offset(scea=side_cutting_edge_angle, sear=side_edge_aspect_ratio) = -mm(sear * stock_width) * sin(scea);

module smooth_wheel(r=wheel_r, t=wheel_t) {
    x = t/2 - wheel_e_r;
    y = r - mm(0.5);
    translate([0, r, 0])
    rotate([0, 90, 0])
    rotate_extrude($fa=1)
    rotate([0, 0, 90])
    translate([0, -(r-wheel_e_r), 0])
    hull() {
        translate([x, 0, 0]) circle(r=wheel_e_r, $fn=45);
        translate([-x, 0, 0]) circle(r=wheel_e_r, $fn=45);
        translate([x, y, 0]) circle(r=wheel_e_r, $fn=45);
        translate([-x, y, 0]) circle(r=wheel_e_r, $fn=45);
    }
}
module wheel(r=wheel_r, t=wheel_t) {
    z = -stock_w/2; // honed angles at edges will be as set
    // simple cylinder
    if (fast_render) {
        translate([-t/2, r, z]) rotate([90, 0, 90])
        cylinder(r=r, h=t, $fa=1);
    } else {
        smooth_wheel(r, t);
    }
}
module platen(h=wheel_r, t=wheel_t) {
    hull() {
        // front of platen
        translate([t/2, wheel_e_r, -h/2])
            cylinder(r=wheel_e_r, h=h, $fn=45);
        translate([-t/2, wheel_e_r, -h/2])
            cylinder(r=wheel_e_r, h=h, $fn=45);
        // extend it back to represent what will be cut out
        translate([t/2, t, -h/2])
            cylinder(r=wheel_e_r, h=h, $fn=45);
        translate([-t/2, t, -h/2])
            cylinder(r=wheel_e_r, h=h, $fn=45);
    }
}
module surface(t=wheel_t) {
    if (use_platen) {
        platen(t=t);
    } else {
        wheel(t=t);
    }
}
module stock(w=stock_w, l=stock_l, scea=side_cutting_edge_angle, sear=side_edge_aspect_ratio) {
    // origin is pivot point for cuts, oriented to be like using a wheel
    translate([pivot_offset(scea=scea, sear=sear), -l, -w])
        cube([w, l, w]);
}
module side_cut(br=back_rake_angle, era=end_relief_angle, sra=side_relief_angle, scea=side_cutting_edge_angle, sear=side_edge_aspect_ratio) {
    z = 90-scea;
    t = (scea*sra*era*br == 0) ? wheel_t : ((-pivot_offset(scea=scea, sear=sear))+(tan(sra)*stock_w)+(tan(era)*stock_w)+(tan(br)*stock_w)/sin(scea) + wheel_e_r*4) * 2;
    echo(t);
    rotate([0, -sra, 0])
    rotate([0, 0, z])
    difference() {
        rotate([0, 0, -z])
        rotate([0, sra, 0])
            stock(scea=scea, sear=sear);
        surface(t=t);
    }
}
module end_cut(tia=tip_included_angle, br=back_rake_angle, era=end_relief_angle, sra=side_relief_angle, scea=side_cutting_edge_angle, sear=side_edge_aspect_ratio) {
    z = (90-tia)+scea;
    rotate([0, 0, -z])
    rotate([-era, 0, 0])
    difference() {
        rotate([era, 0, 0])
        rotate([0, 0, z])
            side_cut(br=br, era=era, sra=sra, scea=scea, sear=sear);
        translate([wheel_t/2-wheel_e_r, 0, 0]) surface();
    }
}
module nose_radius(nr=nose_r, tia=tip_included_angle, br=back_rake_angle, era=end_relief_angle, sre=side_relief_angle, scea=side_cutting_edge_angle, sear=side_edge_aspect_ratio) {
    // There is no chamfer function to follow the
    // the sharp edge with a clean curve
    // Should find a way to sufficiently approximate
    end_cut(tia=tia, br=br, era=era, sre=sra, scea=scea, sear=sear);
}
module top_cut(br=back_rake_angle, nr=nose_r, tia=tip_included_angle, era=end_relief_angle, sra=side_relief_angle, scea=side_cutting_edge_angle, sear=side_edge_aspect_ratio) {
    z = 90 + br;
    rotate([0, -90, 0])
    rotate([0, 0, -z])
    difference() {
        rotate([0, 0, z])
        rotate([0, 90, 0])
            nose_radius(nr=nr, tia=tia, br=br, era=era, sra=sra, scea=scea, sear=sear);
        surface(t=stock_w*2*back_rake_depth_ratio);
    }
}
module square_tool(br=back_rake_angle, nr=nose_r, tia=tip_included_angle, era=end_relief_angle, sra=side_relief_angle, scea=side_cutting_edge_angle, sear=side_edge_aspect_ratio) {
    top_cut(br=br, nr=nr, tia=tia, br=br, era=era, sra=sra, scea=scea, sear=sear);
}
module knife_tool(br=knife_back_rake_angle, nr=knife_nose_r, tia=knife_tip_included_angle, era=end_relief_angle, sra=side_relief_angle, scea=0, sear=0) {
    top_cut(br=br, nr=nr, tia=tia, br=br, era=era, sra=sra, scea=scea, sear=sear);
}
module threading_tool(br=0, nr=0, tia=threading_tip_included_angle, era=end_relief_angle, sra=side_relief_angle, scea=threading_tip_included_angle/2, sear=threading_side_edge_aspect_ratio) {
    // no top cut or nose radius
    end_cut(tia=tia, br=br, era=era, sra=sra, scea=scea, sear=sear);
}
square_tool();
//knife_tool();
//threading_tool();
translate([-2*stock_w, 0, 0]) knife_tool();
translate([2*stock_w, 0, 0]) threading_tool();
