//Salt hole radius in mm [default 1.5]
salt_r=1.5;//[0.5:0.1:3]
//Pepper holes radius in mm default [0.7]
pepper_r=0.7;//[0.2:0.1:1.2]
//Width and depth of tip base in mm [def 14]
x=14;//[13.5:0.1:14.5]
//Height of tip base in mm [def 3]
z=3;//[1:0.1:7]
//Height of clasps in mm [def 4]
h=4;//[0:0.1:8]




//salt
difference() { 
    union() {
        translate([0,0,z/2])
        cube([x,x,z], center = true);
         translate([0,0,z/2])
        rotate(45) cube([x,x,z], center = true);
            };
          translate([0,0,z/2])  
    cylinder(h=2*z,r=salt_r, center = true, $fn=20);
        }
        
// clasps
     clasps();   
        


//pepper        
translate([25,0,0]) {
        difference() { 
    union() {
        translate([0,0,z/2])
        cube([x,x,z], center = true);
        translate([0,0,z/2])
        rotate(45) cube([x,x,z], center = true);
            };
    union(){
        translate([0,0,z/2]){
          cylinder(h=2*z,r=pepper_r, center = true, $fn=20);  
           translate([-3.5,0,0]) {     
    cylinder(h=2*z,r=pepper_r, center = true, $fn=20);
           }
        translate([3.5,0,0]) {
    cylinder(h=2*z,r=pepper_r, center = true, $fn=20);
        }
                 translate([0,5,0]) {     
    cylinder(h=2*z,r=pepper_r, center = true, $fn=20);
           }
        translate([0,-5,0]) {
    cylinder(h=2*z,r=pepper_r, center = true, $fn=20);
        } 
        translate([3.5,-3.5,0]) {
    cylinder(h=2*z,r=pepper_r, center = true, $fn=20);
        }
          translate([-3.5,-3.5,0]) {
    cylinder(h=2*z,r=pepper_r, center = true, $fn=20);
        }  
           translate([3.5,3.5,0]) {
    cylinder(h=2*z,r=pepper_r, center = true, $fn=20);
        } 
            translate([-3.5,3.5,0]) {
    cylinder(h=2*z,r=pepper_r, center = true, $fn=20);
        }  
    }     
    }
        }
        // clasps
clasps();
    }
    
    module clasps(){
                rotate(45) {

translate([-5,2,(h/2)+z]) {     
cube([2,2,h], center = true);  
   translate([4,1,h/2]) {
    rotate(180){
   prism(2, 5, 2);  }
} 
} 


translate([-5,-2,(h/2)+z]) {     
cube([2,2,h], center = true);  
   translate([4,1,h/2]) {
    rotate(180){
   prism(2, 5, 2);  }
} 


}

 
translate([5,2,(h/2)+z]) {     
cube([2,2,h], center = true);  
   translate([-4,-1,h/2]) {
   prism(2, 5, 2);  }
} 

translate([5,-2,(h/2)+z]) {     
cube([2,2,h], center = true);  
   translate([-4,-1,h/2]) {
   prism(2, 5, 2);  }
} 

translate([0,-3,h+z]) {     
cube([12,0.2,0.2], center = true);   
} 
translate([0,-1,h+z]) {     
cube([12,0.2,0.2], center = true); 
} 
   translate([0,3,h+z]) {     
cube([12,0.2,0.2], center = true);   
} 
translate([0,1,h+z]) {     
cube([12,0.2,0.2], center = true); 
}


// bridges 

}
}



    
       module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [0,l,0], [w,l,0], [w,0,0], [w,0,h], [w,l,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
       }
   



