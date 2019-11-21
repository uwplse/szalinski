$fn = 100;
shell = 1;              // Thickness of outer wall

base_dia = 17;          // Diameter of base circles (Thickness of your finger)
base_spacing = 3;       // Base circle spacing (How much wider your finger is)

joint_dia = 15;         // Diameter of joint circles
joint_spacing = 4;      // Joint circle spacing
knuckle_length = 20;    // Length of second knuckle / support portion
angle = 15;

tip_dia = 15;           // Diameter of fingertip circles
tip_spacing = 3.5;      // Tip circle spacing
tip_length = 26;        // Length of first knuckle / supported portion

x_width = 8;            // Width of structural bars along front and back sides of finger
y_width = 6;            // Width of structural bars along sides of finger


difference(){
    tip(joint_dia, joint_spacing, tip_dia, tip_spacing, tip_length, knuckle_length, angle);
    tipmask(joint_dia, joint_spacing, tip_dia, tip_spacing, tip_length, knuckle_length, angle, x_width); 
} 
difference(){
    base(base_dia, base_spacing, joint_dia, joint_spacing, knuckle_length);
    basemask(x_width, y_width);
}

module tipmask(joint_dia, joint_spacing, tip_dia, tip_spacing, tip_length, knuckle_length, angle, x_width){
difference(){
    translate([-joint_dia, -joint_dia, knuckle_length+4])
        cube([joint_dia*2, joint_dia*2, tip_length/2]);
    
    translate([-x_width/2, -15, knuckle_length+4])
    cube([x_width, 30, knuckle_length-2]);   
    
    rotate(v = [1, 0, 0], a = -angle){
        translate([-15, -8.5, knuckle_length])
        cube([30, x_width-1, tip_length-2]);
    }
}
} //tipmask

module basemask(x_width, y_width){
difference(){
    translate([(-base_dia/2)-base_spacing, -base_dia, 4])
    cube([base_dia+base_spacing+3*shell, base_dia*2, knuckle_length-4]);
        
    translate([-x_width/2, -15, 2])
    cube([x_width, 30, knuckle_length-2]);   
    
    translate([-15, -4, 4])
    cube([30, x_width, knuckle_length-2]);   
    }
}

module base(base_dia, base_spacing, joint_dia, joint_spacing, knuckle_length){
    difference(){
        hull(){
            translate([base_spacing/2, 0, 0])
            cylinder(d = base_dia+2*shell, h = 1);
            translate([-base_spacing/2, 0, 0])
            cylinder(d = base_dia+2*shell, h = 1);

            translate([joint_spacing/2, 0, knuckle_length])
            cylinder(d = joint_dia+2*shell, h = 1);
            translate([-joint_spacing/2, 0, knuckle_length])
            cylinder(d = joint_dia+2*shell, h = 1);
        }
        hull(){
            translate([base_spacing/2, 0, 0])
            cylinder(d = base_dia, h = 1);
            translate([-base_spacing/2, 0, 0])
            cylinder(d = base_dia, h = 1);

            translate([joint_spacing/2, 0, knuckle_length])
            cylinder(d = joint_dia, h = 1);
            translate([-joint_spacing/2, 0, knuckle_length])
            cylinder(d = joint_dia, h = 1);
            }    
       }
}

module tip(joint_dia, joint_spacing, tip_dia, tip_spacing, tip_length, knuckle_length, angle){
    difference(){
        //outer shell
        hull(){
            translate([joint_spacing/2, 0, knuckle_length])
            cylinder(d = joint_dia+2*shell, h = 1);
            translate([-joint_spacing/2, 0, knuckle_length])
            cylinder(d = joint_dia+2*shell, h = 1);
            
            translate([tip_spacing/2,sin(angle)*(tip_length-tip_dia/2),cos(angle)*(tip_length-tip_dia/2)+knuckle_length]){
                sphere(d = tip_dia+(2*shell));}
                
             translate([-tip_spacing/2,sin(angle)*(tip_length-tip_dia/2),cos(angle)*(tip_length-tip_dia/2)+knuckle_length]){
                sphere(d = tip_dia+(2*shell));}   
            
        }
        
        //inner shell
        hull(){
            translate([joint_spacing/2, 0, knuckle_length])
            cylinder(d = joint_dia, h = 1);
            translate([-joint_spacing/2, 0, knuckle_length])
            cylinder(d = joint_dia, h = 1);
            
            
            translate([tip_spacing/2,sin(angle)*(tip_length-tip_dia/2),cos(angle)*(tip_length-tip_dia/2)+knuckle_length])
            sphere(d = tip_dia);
                
             translate([-tip_spacing/2,sin(angle)*(tip_length-tip_dia/2),cos(angle)*(tip_length-tip_dia/2)+knuckle_length])
             sphere(d = tip_dia);
        }
   }        //inner hull
        
} //tip