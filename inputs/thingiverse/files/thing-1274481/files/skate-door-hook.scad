roll_diameter = 75;
roll_width = 50;
door_width = 13.7;
strength = 5;
inner_strength = 2;
inner_height = 12;

$fn=100;

difference(){
    cube([roll_diameter +2*strength , roll_diameter + 2*strength, roll_width]);
    
    translate([roll_diameter/2+strength, roll_diameter/2, -2*strength]) cylinder(r=roll_diameter/2, h=100);
    
    translate([-0.1,-0.1,-2*strength]) cube([roll_diameter/2+0.1, roll_diameter -2*strength+0.3, 100]);
    
    translate([-0.1,-0.1,-2*strength]) cube([roll_diameter+strength+0.1,roll_diameter/2+0.1,100]);
    
    translate([-0.1,roll_diameter-2*strength+0.1,-0.1]) cube([roll_diameter/4+0.1,5*strength+0.1,roll_width*2]);
}
translate([roll_diameter+2*strength,0,0]) cube([door_width + inner_strength, strength, roll_width]);

translate([roll_diameter+2*strength+door_width,strength,0]) 
cube([inner_strength, inner_height+strength, roll_width]);