//translate([0,25,0])
//rotate_extrude()
//translate([15,0,0])
//circle(5);
   
   diameter=60;
   
    translate([0,0,0.5*diameter])
    rotate([90,0,0])
    rotate_extrude()
    translate([8,0,0])
    circle(2);
    
    rotate([20,0,0])
    rotate([0,45,0])
    difference(){
        sphere(d=diameter, $fn=50);
        
        translate([0,0,-1*diameter,])   
        linear_extrude(height = 2*diameter)
        polygon([[0,0],[17,100],[-17,100]]);
        
        translate([-1*diameter,0,0])
        rotate([0,90,0])
        linear_extrude(height = 2*diameter)
        polygon([[0,0],[17x,100],[-17,100]]);
    }
