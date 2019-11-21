pin_height = 4;
cylinder_radius = 30;


base_radius = cylinder_radius + 10;

maze_radius = cylinder_radius - pin_height;
trap_radius = cylinder_radius - 2*pin_height;


bottom_height = 20;
cylinder_height = 100;


cylinder_thikness = 3;


reset_curve_elements = 32;


side_lenght =  (2*3.1415*cylinder_radius)/ reset_curve_elements;


module cell(position_x,position_y,depth){
    rotate([0,0,position_x * (360/reset_curve_elements) - reset_curve_elements/2]) 
    translate([cylinder_radius - depth,0, bottom_height+10 + position_y * side_lenght]) 
    cube([pin_height*2 + position_x*pin_height*2/reset_curve_elements, side_lenght, side_lenght*1.01], center=true);
}

//rotating part

translate([90,0,0]){
    color ("orange")
    union(){
    difference()
    { 
        union(){
           cylinder(r = base_radius, h = bottom_height,$fn=6); 
        }
        union(){
            cylinder(r = cylinder_radius, h = bottom_height,$fn=32);    
            translate([cylinder_radius,0,bottom_height/2])
    cube([pin_height*10, side_lenght, side_lenght*1.01], center=true);
            translate([base_radius,0,bottom_height/2])
    cube([10, side_lenght*10, side_lenght*10], center=true); 
        }
    }
}
    

translate([20,0,0]){
    difference(){
        union(){
    
    translate([cylinder_radius+pin_height*1.5+12.5,0,bottom_height/2])
    cube([4, 70, 20], center=true);
    
    mirror([0,1,0])
    translate([cylinder_radius+pin_height*1.5-2.5,22.5,bottom_height/2])
    cube([30, 25, 20], center=true);
    translate([cylinder_radius+pin_height*1.5-2.5,22.5,bottom_height/2])
    cube([30, 25, 20], center=true);
    
    /*
    translate([0,10,10])
    rotate([90,0,0])
    difference(){
    translate([cylinder_radius+pin_height*1.5,0,bottom_height/2])
    translate([1,-7.5,0])
    linear_extrude(height = 2, center = true, convexity = 10)
    resize([8,15])
    import (file = "spring.dxf");
        translate([cylinder_radius+pin_height*1.5,0,bottom_height/2])
    translate([2.6,-6,0])
    linear_extrude(height = 2, center = true, convexity = 10)
    resize([5,12])
    import (file = "spring.dxf");
    }*/
    }

    cylinder(r = base_radius, h = bottom_height,$fn=6);
}

//pin intself
    translate([cylinder_radius,0,bottom_height/2])
    cube([pin_height*2, side_lenght*0.9, side_lenght*0.9], center=true);
    //pin connection
    translate([cylinder_radius+pin_height*1.5,0,bottom_height/2])
    cube([pin_height, side_lenght*0.6, side_lenght*0.6], center=true);
    
    //spring
    difference(){
    translate([cylinder_radius+pin_height*1.5,0,bottom_height/2])
    translate([1,-7.5,0])
    linear_extrude(height = 2, center = true, convexity = 10)
    resize([8,15])
    import (file = "spring.dxf");
        translate([cylinder_radius+pin_height*1.5,0,bottom_height/2])
    translate([2.6,-6,0])
    linear_extrude(height = 2, center = true, convexity = 10)
    resize([5,12])
    import (file = "spring.dxf");
    }
    
    translate([cylinder_radius+pin_height*1.5+10,0,bottom_height/2])
    cube([pin_height, side_lenght*0.6, side_lenght*0.6], center=true);
}
    
}






//central piece
difference(){
    union(){
        cylinder(r = cylinder_radius, h = bottom_height + cylinder_height,$fn=32);
        
        
        //cylinder base
        cylinder(r = base_radius, h = bottom_height,$fn=6);
             
    }
    
    union(){
        translate([0,0,cylinder_thikness]) cylinder(r = trap_radius-cylinder_thikness, h = bottom_height + cylinder_height - cylinder_thikness);
        
        //reset section
        for(i=[0:reset_curve_elements]){
        rotate([0,0,i * (360/reset_curve_elements) - reset_curve_elements/2]) 
            translate([cylinder_radius,0, bottom_height+10])            cube([pin_height*2 + i*pin_height*2/reset_curve_elements, side_lenght, side_lenght], center=true);
        }
        
        //rotate([0,0,(360/reset_curve_elements)]) translate([cylinder_radius,0, bottom_height+10]) cube([pin_height*2, pin_height, pin_height*4], center=true);
        cell(1,1,0);
        cell(1,2,0);
        cell(1,3,0);
        cell(1,4,0);
        cell(1,5,0);
        cell(2,5,0);
        cell(0,5,0);
        cell(-1,5,3);
        cell(-1,4,3);
        cell(-1,3,3);
        cell(-1,2,3);
        cell(-1,1,3);
        
        cell(2,5,0);
        cell(2,6,0);
        cell(2,7,0);
        cell(2,8,0);
        cell(2,9,0);
        cell(2,10,0);
        cell(2,11,0);
        cell(2,12,0);
        cell(2,13,0);
        cell(2,14,0);
        cell(2,15,0);
    }

}
