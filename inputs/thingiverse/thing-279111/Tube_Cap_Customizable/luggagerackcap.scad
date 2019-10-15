// cap diameter in mm (not radius!)
cap_diameter=14.75; 
// wall thickenss in mm
wall_thickness=0.825; 
// Total height in mm
outer_height=16; 
// Height of interior cut out in mm
inner_height=12; 


$fn=100+0;
difference() {
cylinder(r=cap_diameter/2,h=outer_height,center=true);
translate([0,0,(outer_height-inner_height)/2+.1])
cylinder(r=cap_diameter/2-wall_thickness,h=inner_height+.05,center=true);
}

