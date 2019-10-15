// the width of the headband, how for out the hook will extend past the clip
headband_width = 40;
// Distance between the outer edges of the two large wires that make up the lip
lipWidth=34.25;
// Diameter of the large wires that make up the lip
wireWidth=6.5;
// Add a notch in the clip so it has flex and doesn't break while putting it on
doFlexNotch=true;
//the width of the clip accross
width=30;
//not used yet
//wireSpacing=16.9;
//smallWireWidth=3.5;

module clip(_lip_width, _wire_radius, _do_flex_notch, _width, _wire_spacing, _small_wire_width) {
    difference() {
        cube([_wire_radius*4, _lip_width+(2*_wire_radius), _width]);
        translate([_wire_radius, _wire_radius*2, 0]) cube([_wire_radius*3, _lip_width-(2*_wire_radius), _width]);
        translate([_wire_radius*2, _wire_radius*2, 0]) cylinder(r=_wire_radius, h=_width, $fn=100);
        translate([_wire_radius*2,_lip_width, 0]) cylinder(r=_wire_radius, h=_width, $fn=100);
        if(_do_flex_notch) {
                translate([_wire_radius*2, _wire_radius*.9, 0]) cylinder(r=_wire_radius*0.3, h=_width, $fn = 100);
        }
        //comming soon
        if(_wire_spacing < _wire_radius) {
        }
    }
}
clip(lipWidth, wireWidth/2, doFlexNotch, width, wireSpacing, smallWireWidth);
//include <clip.scad>;
module headphonehook(_head_band_width, _width) {
    _lip_edge=3;
    difference() {
        union() {
            translate([-1*_head_band_width,0,_width/2]) rotate([0,90,0]) cylinder(r=_width/2, h=_head_band_width);
            translate([-1*_head_band_width,0,_width/2]) rotate([0,90,0]) cylinder(r=_width/2+_lip_edge, h=_lip_edge);
        }
        translate([-1*_head_band_width, -1*_width/2-_lip_edge, -1*_lip_edge]) cube([_head_band_width,_width/2 + _lip_edge, _width + _lip_edge*2]);
        translate([-_head_band_width, 0, -_lip_edge]) cube([_lip_edge+0.00001, _lip_edge*10, _lip_edge]);
        translate([-_head_band_width, 0, _width]) cube([_lip_edge+0.00001, _lip_edge*10, _lip_edge]);
    }
}
headphonehook(headband_width, width);