$fn=120;
difference(){
union(){
difference(){
hull (){cube( [20,25,3]) ;
 
        translate([-10,12.5,0]) cylinder(3,10,10);    
       };
            translate([-10,12.5,-0.1]) cylinder(3.2,4,4);
            };
    translate([10,12.5,0]) cylinder (7,7,7);
                 
              
                
          };
        translate([10,12.5,-0.1]) cylinder (7.2,4,4);
      };
   difference(){  translate([20,-4.5,0]) cube([10,34,5]);
      translate([23,-1.5,-0.5]) cube([4,28,6]);
   };