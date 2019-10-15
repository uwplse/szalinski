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