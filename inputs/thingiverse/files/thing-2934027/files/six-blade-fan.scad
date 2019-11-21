// Diameter of the fan
blade_length=60; // [20:100]
// Width of a blade
blade_width=7; //[5:10]
// Diameter of the axe
axe_diameter=2;  // [2:10]
// Diameter of the center hub
hub_diameter=18; // [10:30]
// Angle of the blades 
angle=45; // [30:60]

// compensate material shrink
shrink=1.1+0;
height=blade_width*2.5*cos(angle);
   

propeller();
//blade(); 
 
 module propeller(){
 
  difference(){
    union(){
      cylinder(d=hub_diameter,h=height,$fn=100);
      for(i=[0:60:360])
        rotate([0,0,i])
            blade();
    }
    cylinder(d=axe_diameter*shrink,h= 8,$fn=40);
  }
    
 }
 
 module blade(){
   translate([0,0,height/2])
   rotate([90,angle,0])
    linear_extrude(height=blade_length/2-2)
      scale([0.2,2.5])
        circle(d=blade_width,$fn=50);
   }