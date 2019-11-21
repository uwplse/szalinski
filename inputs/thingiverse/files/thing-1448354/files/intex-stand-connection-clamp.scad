height=10;
breadth=3;
gap_width=40;
part1_length=50;
part2_length=25;
knob_diameter=6.7;
knob_roundness=0.333;
knob1_position=2;
knob1_length=10.7;
knob2_length=7;
knob_distance=13.2;
reinforcement_height=2;
reinforcement_start=15;
reinforcement_end=8;
separator_thickness=2;
separator_height=3;
separator_start=5;

$fn=100;

part2_start=sqrt(pow(part1_length,2)-pow((gap_width)/2,2));
alpha=acos(part2_start/part1_length);
knob1_posx=part2_start+part2_length-knob_diameter/2-knob1_position;
knob2_posx=knob1_posx-knob_diameter-knob_distance;
reinforcement_start_y=gap_width*reinforcement_start/(part2_start*2);
seperator_width=gap_width*separator_start/part2_start+breadth;

module smooth(p1,p2,p3,m) {
    difference() {
        translate(m) cylinder(h=height,d=breadth*2);
        translate([0,0,-0.01]) linear_extrude(height+0.02) polygon(points=[p1,p2,p3]);
    }
}

module knob(l) {
    cylinder(h=l-(knob_diameter*knob_roundness)/2,d=knob_diameter);
    translate([0,0,l-(knob_diameter*knob_roundness)/2]) scale([1,1,knob_roundness]) sphere(knob_diameter/2);
}

smooth([0,0],[part2_start,gap_width/2],[part2_start,-gap_width/2]);

rotate(alpha) cube([part1_length,breadth,height]);
rotate(-alpha) translate([0,-breadth,0]) cube([part1_length,breadth,height]);

module part2() {
    smooth([0,breadth/2],[part2_start,gap_width/2],[part2_start+part2_length,gap_width/2],[part2_start,gap_width/2,0]);
    translate([part2_start,gap_width/2,0]) cube([part2_length-breadth/2,breadth,height]);
    translate([part2_start+part2_length-breadth/2,gap_width/2+breadth/2]) cylinder(h=height,d=breadth);
    translate([knob1_posx,gap_width/2,+height/2]) rotate([-90,0,0]) knob(knob1_length+breadth);
    translate([knob2_posx,gap_width/2,+height/2]) rotate([-90,0,0]) knob(knob2_length+breadth);
    translate([0,0,(height-reinforcement_height)/2]) linear_extrude(reinforcement_height) polygon(points=[[reinforcement_start,reinforcement_start_y],[part2_start,gap_width/2],[part2_start+part2_length-reinforcement_end,gap_width/2]]);
}
part2();
mirror([0,1,0]) part2();

translate([separator_start,-seperator_width/2,(height-separator_height)/2]) cube([separator_thickness,seperator_width,separator_height]);