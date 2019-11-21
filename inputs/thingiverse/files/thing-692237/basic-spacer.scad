   spacer_height = 12; //Heights of less than 10 are not recommended
   
   difference(){
   translate([-9,-5,0]) cube([18,10,spacer_height]);
   
   translate([6,0,-1]) cylinder(r=3.6/2,h=spacer_height+2,$fn=40);
   
   translate([-6,0,-1]) cylinder(r=3.6/2,h=spacer_height+2,$fn=40);
   
   translate([-2.75,-7,spacer_height - 6]) cube([5.5,14,7]);
   
   translate([0,6,spacer_height - 6]) rotate([90,0,0]) cylinder(r=5.5/2,h=12,$fn=50);
       
  
   }
 