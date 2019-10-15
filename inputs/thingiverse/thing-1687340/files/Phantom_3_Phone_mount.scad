Phone_Width=73;
Phone_Length=153;
Phone_Height=8.5;
Side_Holes=8;
Front_Hole=6;

difference(){
    union(){
        translate([0,0,0])
        cube([149,75,4],center=true);
        translate([0,0,0])
        cube([Phone_Width+4,Phone_Length+4,Phone_Height+4],center=true);
    }
    union(){
      translate([60,25,0])  
      cube(Side_Holes, center=true);
      translate([-60,25,0])
      cube(Side_Holes, center=true);  
      translate([60,-25,0])
      cube(Side_Holes, center=true);  
      translate([-60,-25,0])
      cube(Side_Holes, center=true);  
        
      translate([143/2,0,0])  
      cube([6,2,100], center=true); 
      translate([-143/2,0,0])  
      cube([6,2,100], center=true); 
      
      translate([0,-2,0])
      cube([Phone_Width,Phone_Length,Phone_Height], center=true); 
        translate([0,-72,0])
      cylinder(Phone_Height+4,Front_Hole/2,Front_Hole/2, center=true); 
        
        }
}
