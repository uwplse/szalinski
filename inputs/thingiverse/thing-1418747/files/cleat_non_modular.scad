// Distance between the outer edges of the two large wires that make up the lip
lipWidth=34.25;
// Diameter of the large wires that make up the lip
wireWidth=6.5;
// Add a notch in the clip so it has flex and doesn't break while putting it on
doFlexNotch=true;
//not used yet
//wireSpacing=16.9;
//smallWireWidth=3.5;
// how wide to make the hook/cleat
width=20;
// how long the actual cleat will be
cleatLength=60;
// how far to have the cleat extend from the clip
cleatDepth=15;
// how thick the cleat "arms" should be
cleatThickness=10;
// wether or not to do the cord clip
doCordClip=true;
// how big the cord clip should be only used if doCordClip=True;
cordDiameter=5;

module clip(_lip_width, _wire_radius, _do_flex_notch, _width, _wire_spacing, _small_wire_width) {
    difference() {
        cube([_wire_radius*4, _lip_width+(2*_wire_radius), _width]);
        translate([_wire_radius, _wire_radius*2, 0]) cube([_wire_radius*3, _lip_width-(2*_wire_radius), _width]);
        translate([_wire_radius*2, _wire_radius*2, 0]) cylinder(r=_wire_radius, h=_width, $fn=50);
        translate([_wire_radius*2,_lip_width, 0]) cylinder(r=_wire_radius, h=_width, $fn=50);
        if(_do_flex_notch) {
                translate([_wire_radius*2, _wire_radius*.9, 0]) cylinder(r=_wire_radius*0.3, h=_width, $fn = 50);
        }
        //comming soon
        if(_wire_spacing < _wire_radius) {
        }
    }
}
clip(lipWidth, wireWidth/2, doFlexNotch, width, wireSpacing, smallWireWidth);

module cleat(_cleat_length, _cleat_depth, _cleat_thickness, _do_cord_clip, _cord_diameter) {
    translate([-1*(_cleat_thickness+_cleat_depth), -(_cleat_length/2)+width/2,0]) 
        cube([_cleat_thickness, _cleat_length, width]);
    translate([-1*(_cleat_depth), width/2,width/2]) rotate([0,90,0]) 
        cylinder(r=width/2, h= _cleat_depth, $fn=50);
    if (_do_cord_clip) {
        difference() {
            translate([-1*(_cleat_thickness+_cleat_depth+_cord_diameter*.8),width/2-0.65*_cord_diameter,0]) 
                cube([_cord_diameter*.8, _cord_diameter*1.3, width]);
            translate([-1*(_cleat_thickness+_cleat_depth+_cord_diameter*.6),width/2,0])
                cylinder(r=_cord_diameter/2,h=width, $fn=50);
        }
    }
}
cleat(cleatLength, cleatDepth, cleatThickness, doCordClip, cordDiameter);