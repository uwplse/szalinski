// variable description
shoulder1_diameter = 65.4;
shoulder1_length = 20;
transition_diameter_1 = 66.1;
transition_length = 120;
transition_diameter_2 = 41.6;
shoulder2_diameter = 40.1;
shoulder2_length = 30;
// 

$fn=150;
union(){
translate([0,0,shoulder1_length/2])cylinder(shoulder1_length,shoulder1_diameter/2,shoulder1_diameter/2,center=true);
translate([0,0,(transition_length/2 +shoulder1_length )])cylinder(transition_length,transition_diameter_1/2,transition_diameter_2/2,center=true);
translate([0,0,(shoulder1_length + transition_length + shoulder2_length/2)])cylinder(shoulder2_length,shoulder2_diameter/2,shoulder2_diameter/2,center=true);
}