// Diameter of the large wires that make up the lip
wireWidth=6.5;
// Add a notch in the clip so it has flex and doesn't break while putting it on
doFlexNotch=true;
// Distance between the outer edges of the two large wires that make up the lip
lipWidth=34.5;
// how wide the hinge and clip will be
width = 30;
// how much space to leave between hinge pieces
spaceTolerance=0.6;
// how big to make the pin of the hinge
pinDiameter=10;
// how thick the walls of the barrel will be
barrelThickness=3;
// Diameter of the holes in the hinge
hingeHoleDiameter=6;

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


module hinge(_space_tolerance,_pin_diameter, _barrel_thickness,_lip_width,_hinge_hole_diameter) {
    _barrelRadius = _pin_diameter/2+_barrel_thickness;
    _hingeY = _lip_width-_barrelRadius;
    _hingeX = -1*(_pin_diameter/2+_barrel_thickness + _space_tolerance);
    // clip part
    //bottom
    translate([_hingeX,_hingeY-_barrelRadius, 0])
        cube([_pin_diameter/2+_barrel_thickness+_space_tolerance,_pin_diameter+2*_barrel_thickness, width/3]);
    translate([_hingeX,_hingeY, 0])
        cylinder(r=_pin_diameter/2+_barrel_thickness, h=width/3, $fn=50);
    //top
    translate([_hingeX,_hingeY-_barrelRadius, 2*width/3])
        cube([_pin_diameter/2+_barrel_thickness+_space_tolerance,_pin_diameter+2*_barrel_thickness, width/3]);
    translate([_hingeX,_hingeY,  2*width/3])
        cylinder(r=_pin_diameter/2+_barrel_thickness, h=width/3, $fn=50);
    //shaft
    translate([_hingeX,_hingeY, 0])
        cylinder(r=_pin_diameter/2-_space_tolerance, h=width, $fn=50);
    //moving part
    difference() {
        union() {
            translate([_hingeX,_hingeY, width/3+_space_tolerance])
                cylinder(r=_pin_diameter/2+_barrel_thickness, h=width/3-2*_space_tolerance, $fn=50);
            translate([2*_hingeX+_barrel_thickness,0, width/3+_space_tolerance])
                cube([_pin_diameter,_lip_width-((_pin_diameter)/2+_barrel_thickness), width/3-2*_space_tolerance]);
            translate([2*_hingeX+_barrel_thickness,0, 0])
                cube([_pin_diameter,_lip_width-2*((_pin_diameter)/2+_barrel_thickness+_space_tolerance), width]);
        }
        translate([_hingeX,_hingeY, width/3])
            cylinder(r=_pin_diameter/2, h=width/3, $fn=50);
        translate([_hingeX*2+_barrel_thickness,_hingeY/3, width/3-_hinge_hole_diameter/2])
            rotate([0,90,0])
                cylinder(r=_hinge_hole_diameter/2,h=_pin_diameter,$fn=50);
        translate([_hingeX*2+_barrel_thickness,_hingeY/3, 2*width/3+_hinge_hole_diameter/2])
            rotate([0,90,0])
                cylinder(r=_hinge_hole_diameter/2,h=_pin_diameter,$fn=50);
    }
    
}
hinge(spaceTolerance,pinDiameter, barrelThickness, lipWidth, hingeHoleDiameter);