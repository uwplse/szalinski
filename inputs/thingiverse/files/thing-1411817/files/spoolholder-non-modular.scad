//the outer diameter of the spool
spoolDiameter=250;
// the thickness of the spool
spoolWidth=45;
// Diameter of the center hole in the spool
centerDiameter=50;
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
module spoolHolder(_spool_diameter, _spool_width, _center_diameter) {
    _lipWidth=3;
    translate([-1*(_spool_diameter)/2, 0,0])
        cube([(_spool_diameter)/2, _center_diameter/2, width]);
    difference(){
        union() {
            translate([-1*(_spool_diameter)/2, 0,])
                cylinder(r=_center_diameter/2, h=_spool_width+width, $fn=100);
            translate([-1*(_spool_diameter)/2, 0,width+_spool_width])
                cylinder(r1=_center_diameter/2, r2=_center_diameter/2+_lipWidth, h=_lipWidth, $fn=100);
        }
        translate([-1*(_spool_diameter+_center_diameter)/2-_lipWidth, -_center_diameter/2-_lipWidth,])
            cube([_center_diameter+_lipWidth*2, _center_diameter/2+_lipWidth, _spool_width+_lipWidth+width]);
        translate([-1*(_spool_diameter+_center_diameter)/2-_lipWidth,0,0])
            cube([_lipWidth, 4*_lipWidth, _spool_width+_lipWidth+width]);
        translate([-1*(_spool_diameter-_center_diameter)/2,0,width])
            cube([_lipWidth, 4*_lipWidth, _spool_width+_lipWidth]);
    }
}
spoolHolder(spoolDiameter, spoolWidth, centerDiameter);