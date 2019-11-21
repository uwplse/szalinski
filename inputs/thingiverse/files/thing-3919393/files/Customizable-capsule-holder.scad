$fn=108;
/*[recovery capsule]*/
//cover diameter (mm)
outer_diameter=53.0;
//maximum diameter of the rest body (mm)
inner_diameter=47.5;
//capsule height (mm)
height=38.0;
/*[holder]*/
//distance between capsule cover and outer wall
outer_gap=1;
//outer wall height
outer_wall_height=3;
//outer wall thickness
outer_wall_thickness=2;
//distance between body and inner wall
inner_gap=1;
// bottom thickness
bottom_thickness=3;
distance_bottom_capsule=3;
//diameter for the two lift holes 
lift_hole_diameter=22;

module holder0(outer_diameter,height,outer_gap,outer_wall_height,outer_wall_thickness,bottom_thickness,distance_bottom_capsule){
    tot_height=bottom_thickness+distance_bottom_capsule+height+outer_wall_height;
translate([0,0,tot_height/2])
cylinder(tot_height,(outer_diameter+2*outer_gap+2*outer_wall_thickness)/2,(outer_diameter+2*outer_gap+2*outer_wall_thickness)/2,center=true);
}

module holder1(inner_diameter,height,inner_gap,bottom_thickness,distance_bottom_capsule){
    tot_height1=height+distance_bottom_capsule;
    translate([0,0,tot_height1/2+bottom_thickness])
    cylinder(tot_height1,(inner_diameter+2*inner_gap)/2,(inner_diameter+2*inner_gap)/2,center=true);    
    }

module holder2(outer_diameter,height,outer_gap,outer_wall_height,bottom_thickness,distance_bottom_capsule){
    tot_height2=outer_wall_height;
    translate([0,0,tot_height2/2+bottom_thickness+distance_bottom_capsule+height])
    cylinder(tot_height2,(outer_diameter+2*outer_gap)/2,(outer_diameter+2*outer_gap)/2,center=true);    
    }


module lifthole(lift_hole_diameter,outer_diameter,height,outer_wall_height,bottom_thickness,distance_bottom_capsule){
    tot_height3=bottom_thickness+distance_bottom_capsule+height+outer_wall_height;
    translate([0,0,tot_height3])
    rotate([0,90,0])
    cylinder(2*outer_diameter,lift_hole_diameter/2,lift_hole_diameter/2,center=true);
    
    
    }


difference(){
holder0(outer_diameter,height,outer_gap,outer_wall_height,outer_wall_thickness,bottom_thickness,distance_bottom_capsule);
    
    holder1(inner_diameter,height,inner_gap,bottom_thickness,distance_bottom_capsule);
    
    holder2(outer_diameter,height,outer_gap,outer_wall_height,bottom_thickness,distance_bottom_capsule);
    
    lifthole(lift_hole_diameter,outer_diameter,height,outer_wall_height,bottom_thickness,distance_bottom_capsule);
}




