//By http://www.thingiverse.com/Paintballmagic



motor_size = 7.0;
motor_hole_modifier_percentage = 1.0;
wall_thickness = 1.0;  
base_height = 2.0;  
support_hole = 7.0;  
tower_height = 10.0;  
tower_support_diameter = 12.0;
groove_size = 8.65;
tower_grove_height = 0.0;  
screw_holes_diameter = 2.5;  
screw_base_diameter = 4.0;
screw_base_height = 2.0;  
screw_support_base_width = 6.0; 
screw_holes_radius = 7.62;  
screw_holes_connector_radius =7.0;
notch = 1; // [0,1]
notch_depth=5;
pillars = 4;
pillar_height = 2.0;
pillar_width = 2.0;
pillar_length = 2.0; 
pillar_inset = 0.5;
pillar_z_offset = 0.0;

// No need to modify below this line. Anything adjustable is listed in the aboveglobal veriables.

module example001()
{

for ( i = [0 : pillars-1] )
{

  rotate(a= i* 360/pillars, v=[0,0,1]) 
translate([0,motor_size/2+pillar_length/2-pillar_inset,pillar_height/2+pillar_z_offset ])
cube(size = [pillar_length,pillar_width,pillar_height], center = true);
}


motor_size = motor_size +(motor_hole_modifier_percentage*.1);
if (notch == 0){
difference() {
cylinder(h = tower_height, r=motor_size/2+ wall_thickness );     
cylinder (h = tower_height*4, r=motor_size/2, center = true, $fn=100);

}
}
if (notch == 1){

difference() {
translate([0,0,base_height + tower_grove_height ])
cylinder(h = tower_height -(base_height + tower_grove_height), r=motor_size/2+ wall_thickness  );     
cylinder (h = tower_height*4, r=motor_size/2, center = true, $fn=100);
translate([0,0,tower_height-notch_depth + (tower_height/2)])
cube(size = [1,20,tower_height], center = true);

}

}




difference() {
cylinder(h = base_height, r=tower_support_diameter/2);   
cylinder (h = tower_height, r=support_hole/2, center = true, $fn=100);
} 

if(tower_grove_height > 0 )
{
difference() {
translate([0,0,base_height + tower_grove_height ])
cylinder(h = base_height, r=tower_support_diameter/2);   
cylinder (h = tower_height, r=motor_size/2, center = true, $fn=100);
} 
}

difference() {
translate([-screw_holes_radius,0,0]) 
cylinder(h = base_height, r=screw_base_diameter/2);
translate([-screw_holes_radius,0,0]) cylinder(h = tower_height, r=screw_holes_diameter/2, center = true, $fn=100);

}

difference() {
translate([screw_holes_radius,0,0]) 
cylinder(h = base_height, r=screw_base_diameter/2);
translate([screw_holes_radius,0,0]) cylinder(h = tower_height, r=screw_holes_diameter/2, center = true, $fn=100);

}

difference() {
translate([screw_holes_connector_radius,0,0]) 
cylinder(h = screw_base_height, r=screw_support_base_width/2);
translate([screw_holes_radius,0,0]) cylinder(h = tower_height, r=screw_holes_diameter/2, center = true, $fn=100);

}

difference() {
translate([-screw_holes_connector_radius,0,0]) 
cylinder(h = screw_base_height, r=screw_support_base_width/2);
translate([-screw_holes_radius,0,0]) cylinder(h = tower_height, r=screw_holes_diameter/2, center = true, $fn=100);

}


difference() {
translate([0,0,base_height ])
cylinder(h = tower_grove_height, r=groove_size/2);
   
cylinder (h = tower_height+1, r=motor_size/2, center = true, $fn=100);
} 

}

example001();

string = motor_size +(motor_hole_modifier_percentage*.1);
echo ("<p> Actual part inner diameter" ,string , "<br><br> Motor diameter", motor_size , "</p>");
