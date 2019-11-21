    translate([2,0,0])
        cube(size=[20,5,12]);
      
    translate([2,0,0])
            cube(size=[20,0,12]);
      
    translate([5,0,5])
        rotate([90,0,0])
            cylinder(1);
            
    translate([7,0,3])
        rotate([90,0,0])
            cylinder(1);

    translate([7,0,7])
        rotate([90,0,0])
            cylinder(1);
            
    translate([6,2.5,12])
        cylinder(r=2,r2=2, h=.5);
     
    rotate([90,0,0])
        translate([16,6,0])
            cylinder(4,5,5);
            
    rotate([90,0,0])
        translate([16,6,3])
            cylinder(3,4,4);
        
    translate([10,0,14])
        rotate([0,90,0])
          linear_extrude(height=4, slices=10)
          
  polygon(points=[ [0,0], [6,0], [5,2], [1,2]]);
  
    translate([7,5,5])
        rotate([270,0,0])
            cylinder(r=4,r2=4,h=.5);
        
    translate([9,6,6])
        rotate([90,0,0])
              cylinder(1);
              
      translate([7,6,3])
        rotate([90,0,0])
              cylinder(1);
              
      translate([5,6,6])
        rotate([90,0,0])
              cylinder(1);
              
     translate([11,1,2])
        cube(size=[10,5,9]);
       