
//Defines the radius of the riser's base
radius=40;//[20:100]

//Defines the height of the riser
height=50;//[10:50]

r=radius/0.8;
h=height;

//Defines the resolution
$fn = 50;

difference(){
    
    cylinder(h,r*.8,r*.5);
    
    translate([0,0,h*1.1])
    sphere(r*.3); 
    
    translate([0,0,-r*0.1])
    cylinder(h*1.1,r*0.1,r*0.1);
    
    translate([0,0,-h*0.27])
    rotate([0,90,0])
    cylinder(r*2,h*.4,h*.4,true);
    
    //translate([0,0,-r1*0.27])
    //rotate([90,0,0])
    //cylinder(r1*2,r1*.4,r1*.4,true);
    
    for(i = [0 : 1 : 12]){
        translate([0,0,h])
        rotate([0,90,0])
        rotate([i*30,0,0])
        rotate([0,-5,0])
        cylinder(r,r*0.05,r*0.05);  
    }
    
}