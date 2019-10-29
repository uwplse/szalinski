height=50;
breadth=1.5;
breadth_big=3;
height_big=2;
diameter=51.5;
knob_diameter=10;
knob_roundness=0.2;
knob_length=4.4;
gap_width=2;
gap_height=20;
slope_height=1;
slope_factor=0.25;

$fn=50;
$fn_detail=100;

module knob(l) {
    cylinder(h=l-(knob_diameter*knob_roundness)/2,d=knob_diameter,$fn=$fn_detail);
    translate([0,0,l-(knob_diameter*knob_roundness)/2]) scale([1,1,knob_roundness]) sphere(knob_diameter/2,$fn=$fn_detail);
}

module gap() {
    translate([knob_diameter/2,0,-0.01]) cube([gap_width, diameter/2+breadth,gap_height-gap_width/2+0.01]);
    translate([knob_diameter/2+gap_width/2,0,gap_height-gap_width/2]) rotate([-90,0,0]) cylinder(h=diameter/2+breadth,d=gap_width,$fn=$fn_detail);
    translate([knob_diameter/2+gap_width*1.5,0,gap_width/2]) difference() {
        translate([-gap_width/2-0.01,-gap_width/2,-gap_width/2-0.01]) cube([gap_width/2+0.01, diameter/2,gap_width/2+0.01]);
        rotate([-90,0,0]) cylinder(h=diameter/2,d=gap_width,$fn=$fn_detail);
    }
}

 difference() {
    union() {
        difference() {
            translate([0,(diameter)/2+breadth,0]) {
                translate([0,0,slope_height]) cylinder(h=height-slope_height,d=diameter+breadth*2);
                translate([0,0,height-height_big]) cylinder(h=height_big,d=diameter+breadth_big*2);
                hull() {
                    translate([0,0,slope_height]) cylinder(h=0.01,d=diameter+breadth*2);
                    cylinder(h=0.01,d=diameter+breadth*2*slope_factor);
                }
            }
            gap();
            mirror([1,0,0]) gap();
            translate([-knob_diameter/2-0.01,0,-0.01]) cube([knob_diameter+0.02,diameter/2,knob_diameter/2+0.01]);
        }
        translate([0,diameter/2,knob_diameter/2]) rotate([90,0,0]) knob(knob_length+diameter/2);
    }
    translate([0,(diameter)/2+breadth,-0.01]) cylinder(h=height+0.02,d=diameter);
}
