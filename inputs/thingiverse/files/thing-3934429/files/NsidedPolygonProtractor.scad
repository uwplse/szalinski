//Single Piece of Geometry Aid

//Length in mm (min: 100 max:200)
length = 120;

//Thickness in mm (min: 1 max:5)
thickness = 3;

nums = "180       90   45    ";

$fn=100;

module solid(){
    hull(){
    cylinder(thickness,length/15,length/15);
        
    translate([0,length*14/15-length*.2,0])
        cylinder(thickness,length/15,length/15);
    }
    cylinder(thickness*3,length/35,length/35);
}

module body(){
    difference(){
        solid();
        translate([0,length*14/15-length*.2,0])
        cylinder(thickness,length/35+.25,length/35+.25);
        
        translate([-length/7,length/6,0])
        cube([length/7,length/2,thickness]);
        
        //dial overlap
        difference(){
            translate([0,0,thickness/2])rotate([0,0,-70])
            rotate_extrude(angle=-200, convexity = 10)
            square([length*.2,thickness/1.5]); 
            
            cylinder(thickness,length/15,length/15);
            }
            
            }
  }

body();

module prot(){
    rotate([0,0,-70])rotate_extrude(angle=-200, convexity = 10)
    square([length*.2,thickness/1.5]);
    
    for (i = [1:len(nums)]){
        rotate([0,0,200-i*(200/len(nums))])
        translate([0,length*.155,0])
        linear_extrude(thickness)scale([.5,.5,.5])
        text(nums[i-1], halign = "center");
    }
    
for (i = [1:18]){
    rotate([0,0,(i)*10])translate([0,length*.05,0])
    cube([length*.005,length*.1,thickness]);
}
}
prot();
