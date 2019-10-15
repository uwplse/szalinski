height=10;
breadth=3;
breadth_small=1.2;
length=66;
gap_width=50;
roundness=0.5;
knob_diameter=8.8;
knob_roundness=0.333;
knob_length=7.7;

$fn=100;

straight_length=length*(1-roundness);

module knob(l) {
    cylinder(h=l-(knob_diameter*knob_roundness)/2,d=knob_diameter);
    translate([0,0,l-(knob_diameter*knob_roundness)/2]) scale([1,1,knob_roundness]) sphere(knob_diameter/2);
}

module roundPart() {
    difference() {
        translate([-straight_length/2,gap_width/2+breadth,0]) scale([(length-straight_length)/(gap_width+breadth*2),1,1]) cylinder(h=height,d=gap_width+breadth*2);
        translate([-straight_length/2,gap_width/2+breadth,-0.01]) scale([(length-straight_length-breadth_small*2)/gap_width,1,1]) cylinder(h=height+0.02,d=gap_width);
        translate([-straight_length/2,breadth,-0.01]) cube([length,gap_width,height+0.02]);
    }
}

translate([0,0,height/2]) rotate([90,0,0]) knob(knob_length);
translate([-straight_length/2,0,0]) cube([straight_length,breadth,height]);
translate([-straight_length/2,gap_width+breadth,0]) cube([straight_length,breadth,height]);
roundPart();
mirror([1,0,0]) roundPart();