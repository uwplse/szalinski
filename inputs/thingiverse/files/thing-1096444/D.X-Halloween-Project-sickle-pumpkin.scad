
// BEGIN CUSTOMIZER

//select part(s) to render
parts_render = 5; //[1:sickle ,2:hands,3:body,4:preview, 5:all(for print)] 
//3 different eye style can CHOOSE!
eyestyle_render = 2; // [1: type1, 2:type2, 3:type3]
//selsect color to render
color_sickle_render = 5; //[1: Maroon, 2: Red, 3:Black, 4:MidnightBlue, 5:White]

//you can change the size of your project
project_size = 100;//[ 100: 300]


// Draft for preview, production for final
Quality_render = 28;    // [28:Draft,60:production]

$fn = Quality_render;


scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)
  {
    if (parts_render == 1) {
        if (color_sickle_render == 1) {
        color("Maroon")
        sickle() ;
    }
        
    
    if (color_sickle_render == 2) {
        color("Red")
        sickle() ;
    }
    if (color_sickle_render == 3) {
        color ("Black")
        sickle() ;
    }
    if (color_sickle_render == 4) {
        color ("MidnightBlue")
        sickle() ;
    }
    if (color_sickle_render == 5) {
        color ("White")
        sickle() ;
    }
}
    if (parts_render == 2) {
        translate([60,0,10])
        hands() ;
        
    }
      
    
    if (parts_render == 3) {
            body() ;
    
}
    
    if (parts_render == 4) {
       preview();
    }
    
    if (parts_render == 5) {
       all() ;
    }
    
    if (eyestyle_render == 1) {
        
        if (parts_render ==3) {
             
            !difference() {
                scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor) 
                body ();
          eyes_style_1 ();
                }
            
        
    }
        if (parts_render == 4) { 
            
            !difference() {
                scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)
                
                preview ();
          eyes_style_1 ();
                
        
            }
    
    }
    if (parts_render == 5) { 
            
            !difference() {
                scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)
                all ();
                
                
          eyes_style_1 ();
                
        
            }
    
    }
}


    
    if (eyestyle_render == 2) {
         
        if (parts_render ==3) {
            !difference() {
                scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)
                body ();
          eyes_style_2 ();
           
        }
        }
        if (parts_render == 4) { 
           !difference() {
               scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)
                preview ();
          eyes_style_2 ();
            
        }
    }
    if (parts_render == 5) { 
            
            !difference() {
                scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)
                all ();
                
                
          eyes_style_2 ();
                
        
            }
    
    }
        
    }
    
    if (eyestyle_render == 3) {
        
        if (parts_render ==3) {
        
             
            !difference() {
                scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)
                body ();
          eyes_style_3 ();
            }
        }
    }
        if (parts_render == 4) { 
            
            !difference() {
                scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)
                preview ();
          eyes_style_3 ();
            }
        }
        if (parts_render == 5) { 
            
            !difference() {
                scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)
                all ();
                
                
          eyes_style_3 ();
                
        
            }
    
    }
    }
    
    
    
  
    
    

    
  scale_factor = 156*1;  
    module sickle () {
    difference() {
scale([0.6,0.6,0.6]) {
//sickle
color("Red") {    

      rotate([90,180,90]) 
   
       union() {
    //stick
    translate([25,0,0])
    rotate([0,0,0]) {
    cylinder( r = 2, h = 140,center = true);
    }
    
    //mid part
    
    translate([25,0,70]){
        rotate([0,0,0]){
    hull() {
        translate([0,0,7.5])
          rotate([0,30,0])
            cylinder(r = 2, h = 5);
            cylinder(r = 2.3, h=5);
    }
        translate([0,0,7.5])
            rotate([0,30,0])
            cylinder(r1=2,r2=3.5,h=17);
    hull() {
     translate([6.5,0,20])
        rotate([0,30,0])
            cylinder(r1=3,r2=3,h=12);
    translate([14,0,29])
        rotate([0,10,0])
            cylinder(r1=3,r2=3,h=5);
    }
    translate([15,0,33])
        rotate([0,-20,0])
            cylinder(r1=3,r2=3,h=12);
    hull() {
     translate([11,0,43])
        rotate([0,-40,0])
            cylinder(r1=3,r2=3,h=5);
     translate([-8,0,55])
        rotate([0,50,0])
            cylinder(r1=3,r2=3,h=12);
    
    }
    
    }
   }
  translate([0,0,0]) {
    rotate([85,-95,0]) {  
   //cylinders
   union() {
      
        difference() {
        translate([140,-20,-1])
            rotate([0,5,-90]) 
            cylinder(r=20, h=7,center =true);
         translate([140,-20,0])
            
            rotate([0,5,-90]) cylinder(r=13,h=50,center = true);
        }
    }

   //knife
   difference() {
    scale([1.12,1,1]) {
    translate([41,136,10.5]){
   rotate([0,5,-90]) {
   union() {
       difference() {
       hull() {
       rotate([0,-2,0]){
           union() {
      
       difference() {
       translate([100,0,0])
       cylinder(r= 110, h = 2.5,center = true);
       
       translate([110,-20,-1])
           cylinder(r= 120, h = 5, center = true);
           translate([110,0,-10])
           cube([100,100,100]);
       }
   
   }
   }
 
       union() {
      
       difference() {
       translate([100,0,0])
       cylinder(r= 115, h = 2.5,center = true);
       
       translate([110,-20,-1])
           cylinder(r= 120, h = 5, center = true);
           translate([110,0,-10])
           cube([100,100,100]);
       }
   
     }
   
   }
   translate([105,-25,-5])
   cylinder(r=115, h = 50,center = true);
       }
      }
     }
    }
   }
  union() {
      
       
      translate([158,-15.5,34])
            
            rotate([13,-18,-90]) cylinder(r=13,h=10,center = true);
        }
    
            }
           }  
          }
         }
         
        }
    }
       
    
    translate([29,35,-1.8])
    cube([150,130,1.5],center = true);
        }
    
    
   }
   
   
   
   
   
   module hands() {
       color("DarkOrange") {
     scale([0.6,0.6,0.6]) {
      //hands
    rotate([12,0,0])
    union (){
    difference() {    
    union() {
    
        
        translate([-140,-10 ,-5])
        rotate([-12,-20,0]) {
        scale([1.5,8,1.5]) {
        sphere(r=6);
        }
    }
      translate([-55,-10 ,-5])
        rotate([-12,20,0]) {
        scale([1.5,8,1.5]) {
        sphere(r=6);
        }
    }
}
        
translate([-75,-35,-1])
    rotate([0,88,-5]) {
    cylinder( r = 2.5, h = 180,center = true);
}
}
}
}
}
    }
    
    
    
    
    
    module body () {   
scale([0.6,0.6,0.6]) {
    color("DarkOrange") {


translate([0,35,5]) {
   
  difference() {
    union() {  
        translate([0,0,30])
        cylinder(r=5, h=20);
    
        translate([-1,0,47])
            rotate([0,30,0])    
            cylinder(r=4.8, h=18);
    
            sphere(r = 38);
    
        translate([27,0,0])
            rotate([0,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
    
        translate([20,-20,0])
            rotate([15,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([0,-27,0])
            rotate([15,0,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([-27,0,0])
            rotate([0,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([-20,20,0])
            rotate([-15,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
  
        translate([0,27,0])
            rotate([-15,0,0])
                scale([1.5,1.5,2])
                sphere(r=20);

        translate([-20,-20,0])
            rotate([15,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);

        translate([20,20,0])
            rotate([-15,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
            }
            


        
        union() {
        scale([0.8,0.8,0.8]){      
        translate([0,0,30])
        cylinder(r=5, h=20);
    
        translate([-1,0,47])
            rotate([0,30,0])    
            cylinder(r=1, h=18);
    
            sphere(r = 38);
    
        translate([27,0,0])
            rotate([0,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
    
        translate([20,-20,0])
            rotate([15,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([0,-27,0])
            rotate([15,0,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([-27,0,0])
            rotate([0,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([-20,20,0])
            rotate([-15,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
  
        translate([0,27,0])
            rotate([-15,0,0])
                scale([1.5,1.5,2])
                sphere(r=20);

        translate([-20,-20,0])
            rotate([15,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);

        translate([20,20,0])
            rotate([-15,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
            }
            //hands
    union (){
    difference() {    
    union() {
    
        
        translate([-40,-37 ,-19])
        rotate([-12,-20,0]) {
        scale([1.5,8,1.5]) {
        sphere(r=6);
        }
    }
      translate([45,-45 ,-10])
        rotate([-32,20,-1]) {
        scale([1.5,8,1.5]) {
        sphere(r=6);
        }
    }
}
        
translate([15,-35,2])
    rotate([0,79,-5]) {
    cylinder( r = 2.5, h = 180,center = true);
}
}
}
}
    



// mouth
 
        

   
    union() {
        scale([0.7,2,0.7]) 
        rotate([90,0,0])
        translate([-0,10,16]) {
            difference() {
             
                
            }
            translate([-45,-15,5])
            rotate([0,0,0])
            scale([0.25,1.2,2])
            sphere(r=10);
            
            translate([-38,-20,5])
            rotate([0,0,0])
            scale([0.25,1.2,2])
            sphere(r=10);
            
            translate([-30,-28,5])
            rotate([0,0,0])
            scale([0.25,1.3,2])
            sphere(r=10);
            
            translate([-19,-32,5])
            rotate([0,0,0])
            scale([0.25,1.4,2])
            sphere(r=10);
            
            translate([-8,-35,5])
            rotate([0,0,0])
            scale([0.25,1.5,2])
            sphere(r=10);
            
            translate([15,-35,5])
            rotate([0,0,0])
            scale([0.25,1.5,2])
            sphere(r=10);
            
            translate([4,-36,5])
            rotate([0,0,0])
            scale([0.25,1.6,2])
            sphere(r=10);
            
            translate([28,-32,5])
            rotate([0,0,0])
            scale([0.25,1.4,2])
            sphere(r=10);
            
            translate([40,-24,5])
            rotate([0,0,0])
            scale([0.25,1.3,2])
            sphere(r=10);
            
            translate([48,-15,5])
            rotate([0,0,0])
            scale([0.25,1.2,2])
            sphere(r=10);
            
       }
      }
     }
    }
   }
  }
  
 }
 
 
 
 
 module preview () { 
     rotate([0,-10,0]){
    
        if (color_sickle_render == 1) {
        color("Maroon")
        sickle() ;
    }
        
    
    if (color_sickle_render == 2) {
        color("Red")
        sickle() ;
    }
    if (color_sickle_render == 3) {
        color ("Black")
        sickle() ;
    }
    if (color_sickle_render== 4) {
        color ("MidnightBlue")
        sickle() ;
    }
    if (color_sickle_render == 5) {
        color ("White")
        sickle() ;
    }
     }
  //hands
 color("Darkorange") { 
 translate([0,25,2])
       scale([0.6,0.6,0.6]) { 
 union (){
    difference() {    
    union() {
    
        
        translate([-40,-37 ,-19])
        rotate([-12,-20,0]) {
        scale([1.5,8,1.5]) {
        sphere(r=6);
        }
    }
      translate([45,-45 ,-10])
        rotate([-32,20,-1]) {
        scale([1.5,8,1.5]) {
        sphere(r=6);
        }
    }
}
        

}
}
}
}
 scale([0.6,0.6,0.6]) {
    color("DarkOrange") {


translate([0,35,5]) {
   
  difference() {
    union() {  
        translate([0,0,30])
        cylinder(r=5, h=20);
    
        translate([-1,0,47])
            rotate([0,30,0])    
            cylinder(r=4.8, h=18);
    
            sphere(r = 38);
    
        translate([27,0,0])
            rotate([0,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
    
        translate([20,-20,0])
            rotate([15,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([0,-27,0])
            rotate([15,0,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([-27,0,0])
            rotate([0,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([-20,20,0])
            rotate([-15,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
  
        translate([0,27,0])
            rotate([-15,0,0])
                scale([1.5,1.5,2])
                sphere(r=20);

        translate([-20,-20,0])
            rotate([15,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);

        translate([20,20,0])
            rotate([-15,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
            }
            


        
        union() {
        scale([0.8,0.8,0.8]){      
        translate([0,0,30])
        cylinder(r=5, h=20);
    
        translate([-1,0,47])
            rotate([0,30,0])    
            cylinder(r=1, h=18);
    
            sphere(r = 38);
    
        translate([27,0,0])
            rotate([0,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
    
        translate([20,-20,0])
            rotate([15,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([0,-27,0])
            rotate([15,0,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([-27,0,0])
            rotate([0,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
   
        translate([-20,20,0])
            rotate([-15,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
  
        translate([0,27,0])
            rotate([-15,0,0])
                scale([1.5,1.5,2])
                sphere(r=20);

        translate([-20,-20,0])
            rotate([15,-15,0])
                scale([1.5,1.5,2])
                sphere(r=20);

        translate([20,20,0])
            rotate([-15,15,0])
                scale([1.5,1.5,2])
                sphere(r=20);
            }
            //hands
    union (){
    difference() {    
    union() {
    
        
        translate([-40,-37 ,-19])
        rotate([-12,-20,0]) {
        scale([1.5,8,1.5]) {
        sphere(r=6);
        }
    }
      translate([45,-45 ,-10])
        rotate([-32,20,-1]) {
        scale([1.5,8,1.5]) {
        sphere(r=6);
        }
    }
}
        

translate([15,-35,2])
    rotate([0,79,-5]) {
    cylinder( r = 2.5, h = 180,center = true);
}
}
}
}
    
    
// mouth
 
        

   
    union() {
        scale([0.7,2,0.7]) 
        rotate([90,0,0])
        translate([-0,10,16]) {
            difference() {
             
                
            }
            translate([-45,-15,5])
            rotate([0,0,0])
            scale([0.25,1.2,2])
            sphere(r=10);
            
            translate([-38,-20,5])
            rotate([0,0,0])
            scale([0.25,1.2,2])
            sphere(r=10);
            
            translate([-30,-28,5])
            rotate([0,0,0])
            scale([0.25,1.3,2])
            sphere(r=10);
            
            translate([-19,-32,5])
            rotate([0,0,0])
            scale([0.25,1.4,2])
            sphere(r=10);
            
            translate([-8,-35,5])
            rotate([0,0,0])
            scale([0.25,1.5,2])
            sphere(r=10);
            
            translate([15,-35,5])
            rotate([0,0,0])
            scale([0.25,1.5,2])
            sphere(r=10);
            
            translate([4,-36,5])
            rotate([0,0,0])
            scale([0.25,1.6,2])
            sphere(r=10);
            
            translate([28,-32,5])
            rotate([0,0,0])
            scale([0.25,1.4,2])
            sphere(r=10);
            
            translate([40,-24,5])
            rotate([0,0,0])
            scale([0.25,1.3,2])
            sphere(r=10);
            
            translate([48,-15,5])
            rotate([0,0,0])
            scale([0.25,1.2,2])
            sphere(r=10);
            
       }
      }
     }
    }
   }
  }
 }
 
 
module eyes_style_1 () {
    scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor) {
    color("Darkorange") {
   scale ([0.6,0.6,0.6]) {
    translate([0,35,5]) {
    union() {
    translate([-28,-55,20]) {
    scale([1,5,1])
        difference() {
    
        hull() {
        sphere(r = 8);
        
        translate([20,0,-6])
            cube([1,8,1],center = true);
        
        
    
    }
    translate([0,0,32])
        rotate([0,30,0])
        cube([100,50,50],center= true);
    
}
}
}

    union() {
        rotate([0,0,180])
        translate([-28,55,20]) {
        
            scale([1,5,1])
            difference() {
    
            hull() {
            sphere(r = 8);
            
            translate([20,0,-6])
                cube([1,8,1],center = true);
        
        
    
        }
        translate([0,0,32])
            rotate([0,30,0])
            cube([100,50,50],center= true);
    
        }
    }

}

} 
 }
}
}
}

 module eyes_style_2 () {
     scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor) {
     color("Darkorange") {
     scale ([0.6,0.6,0.6]){
     translate([0,35,5]) {
     union() {
    translate([-28,-55,20]) {
    scale([1,5,1])
        difference() {
    
        hull() {
        translate([2,0,0])
            sphere(r = 8);
        
        translate([7,0,-6])
            sphere(r= 12);
        
        
    
    }
    translate([0,0,32])
        rotate([0,30,0])
        cube([100,50,50],center= true);
    
}
}
}

    union() {
        rotate([0,0,180])
        translate([-28,55,20]) {
        
            scale([1,5,1])
            difference() {
    
            hull() {
            translate([2,0,0])
            sphere(r = 8);
            
            translate([7,0,-6])
                sphere(r=12);
        
        
    
        }
        translate([0,0,32])
            rotate([0,30,0])
            cube([100,50,50],center= true);
    
        }
    }

}
        }
    }
    }
}
}
 
 
 
 
   module eyes_style_3 () {
       scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor) {
       color("Darkorange") {
       scale ([0.6,0.6,0.6]){
       translate([0,35,5]) {
       union() {
    translate([-28,-55,20]) {
    scale([1,5,1])
        difference() {
    
        hull() {
        translate([11,0,0])
            sphere(r = 8);
        
        translate([6,0,-5])
            sphere(r= 10.5);
        
        
    
    }
    
    
}
}
}

    union() {
        rotate([0,0,180])
        translate([-28,55,20]) {
        
            scale([1,5,1])
            difference() {
    
            hull() {
            translate([11,0,0])
            sphere(r = 8);
            translate([6,0,-5])
                sphere(r=10.5);
        
        
    
        }
        
    
        }
    }

}
  }
  }
       }
   }
   }
    module nose () {
    color ("Darkorange") {
    union() {
    union() {
    translate([-4,-55,7]) {
    scale([0.25,10,0.25])
        difference() {
    
        hull() {
        translate([11,0,0])
            sphere(r = 8);
        
        translate([6,0,-5])
            sphere(r= 10.5);
        
        
    
    }
    
    
}
}
}

    union() {
        rotate([0,0,180])
        translate([-4,55,7]) {
        
            scale([0.25,5,0.25])
            difference() {
    
            hull() {
            translate([11,0,0])
            sphere(r = 8);
            translate([6,0,-5])
                sphere(r=10.5);
        
        
    
        }
        
    
        }
    }

}
}
}
}        
module all() {
    difference() {
  union () {
        body();
        translate([-10,0,-11])
        hands();
        translate([-20,-20,-19]){
  if (color_sickle_render == 1) {
        color("Maroon")
        sickle() ;
    }
        
    
    if (color_sickle_render == 2) {
        color("Red")
        sickle() ;
    }
    if (parts_render == 2) {
        translate([60,0,10])
        hands() ;
        
    }
      if (color_sickle_render == 3) {
        color ("Black")
        sickle() ;
    }
    if (color_sickle_render== 4) {
        color ("MidnightBlue")
        sickle() ;
    }
    if (color_sickle_render == 5) {
        color ("White")
        sickle() ;
    }      
}
}

    translate([0,0,-20.5])
 cube([500,500,1],center = true);
}
}