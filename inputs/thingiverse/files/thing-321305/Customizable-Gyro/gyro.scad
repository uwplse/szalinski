//Radius of outer ring
Radius = 20;
//thickness of each ring
Thickness = 3;
//height of each ring
Height = 10;
//spacing between rings
Spacing = 0.5;
// Number of Rings 
N_Rings = 4;

module ring(radius,thickness,height) {
  difference() {
     sphere(radius,center=true);
     sphere(radius-thickness,center=true);
     translate([0,0,-Large/2-height/2]) cube(Large,center=true);    
     translate([0,0,Large/2+height/2]) cube(Large,center=true);
  }

}

module rings(radius,thickness,height,spacing,n) {
 translate([0,0,height/2])
   for (i=[0:n-1]) 
      rotate([-i*$t*180,i*$t*180,0]) 
         ring(radius - (i-1)* (thickness+spacing),thickness,height);
}

Large=Radius * 4;
$fn=100;
$t=0.0;
rings (Radius,Thickness,Height,Spacing,N_Rings);