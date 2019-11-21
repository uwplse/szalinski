/********* BEST VIEWED IN 80 COLUMNS ** BEST VIEWED IN 80 COLUMNS **************
*
* Milwaukee Low Profile Packout Bit Holder
* Benjamen Johnson <workshop.electronsmith.com>
* 20190517
* Version 1
* openSCAD Version: 2015.03-2 
*******************************************************************************/
bit_depth = 9;
num_slots= 10;
min_edge = 1;

spring_slot_depth = 6;
spring_slot_width = 1;

width = 89;
thickness = 9;

pivot_length = 2;
pivot_dia = 5;

// bit fudge factor
fudge = 1.04;

//inches to mm conversion
in_to_mm = 25.4;

//bit size
bit_dia_points =.288*in_to_mm*fudge;
//bit_dia_flats = .25*in_to_mm*fudge;

height = bit_depth + thickness/2;
width2= width - 2 * min_edge;
step = width2 /(num_slots);
start = -width2/2+step/2;
end = width2/2;

rotate([-90,0,0])
difference(){
    translate([0,height/2-thickness/2,0])difference(){
        union(){
            //Create main body
            translate([0,thickness/4,0])cube([width,height-thickness/2,thickness],center=true);
            
            //create rounded bottom
            translate([0,-height/2+thickness/2,0])rotate([0,90,0])cylinder(d=thickness, h=width,$fn=40,center=true);   
          
            //Create pivot shaft
            translate([0,-height/2+thickness/2,0])rotate([0,90,0])cylinder(d=pivot_dia, h=width+2*pivot_length,$fn=40,center=true);   
        }
         
        // drill holes
        for (x=[start:step:end]){
            translate([x,thickness/4,0])rotate([90,30,0])cylinder(d=bit_dia_points, h=bit_depth, center=true,$fn=6);
        }
    
        // create spring slot
        translate([0,(height - spring_slot_depth)/2,0])cube([width,spring_slot_depth,spring_slot_width],center=true);
    }

    // Chamfer ends
    chamfer = 2;
    chamfer_leg = chamfer*1.414;
    
    for(y=[-90:5:90]){
       rotate([y,0,0])translate([0,-thickness/2,0])rotate([90,0,0])translate([width/2,0,0])rotate([0,45,0])cube([chamfer_leg,height*2,chamfer_leg],center=true); 
        
        rotate([y,0,0])translate([0,-thickness/2,0])rotate([90,0,0])translate([-width/2,0,0])rotate([0,45,0])cube([chamfer_leg,height*2,chamfer_leg],center=true);
    }
}
