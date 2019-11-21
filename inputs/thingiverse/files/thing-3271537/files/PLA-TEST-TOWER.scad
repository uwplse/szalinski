
difference(){
   mycube(); 
   translate([0,5,6]){rotate([-15,0,0]){cube([4,12,2]); }}
   translate([0,5,12]){rotate([-15,0,0]){cube([4,12,2]); }}
   translate([0,5,18]){rotate([-15,0,0]){cube([4,12,2]); }}
   translate([0,5,24]){rotate([-15,0,0]){cube([4,12,2]); }} 
   translate([0,5,30]){rotate([-15,0,0]){cube([4,12,2]); }} 
   translate([0,5,36]){rotate([-15,0,0]){cube([4,12,2]); }} 
   translate([0,5,41]){rotate([-15,0,0]){cube([4,12,2]); }} 
   translate([6,2,3]){rotate([90,0,0])linear_extrude(2){{text("210",4);}}}    
   translate([6,2,8]){rotate([90,0,0])linear_extrude(2){{text("205",4);}}}  
   translate([6,2,13]){rotate([90,0,0])linear_extrude(2){{text("200",4);}}}  
   translate([6,2,18]){rotate([90,0,0])linear_extrude(2){{text("195",4);}}}  
   translate([6,2,23]){rotate([90,0,0])linear_extrude(2){{text("190",4);}}}  
   translate([6,2,28]){rotate([90,0,0])linear_extrude(2){{text("185",4);}}}  
   translate([6,2,33]){rotate([90,0,0])linear_extrude(2){{text("180",4);}}}  
   translate([6,2,38]){rotate([90,0,0])linear_extrude(2){{text("174",4);}}}  
    }

module mycube(){
translate([-5,-5,0]){cube([37,30,2]);}
translate([2,2,0]){cylinder(43,2,2,$fn=128);}
translate([2,0,0]){cube([20,4,43]);}
translate([0,2,0]){cube([2,20,43]);}
translate([24,0,0]){cube([1,20,43]);}
translate([24,4,0]){cube([4,2,43]);}
translate([22,0,41]){cube([2,4,2]);}
translate([10,10,0]){cylinder(45,2,2,$fn=128);}

translate([15,15,0]){
linear_extrude(43,100,convexity=100,twist=3600,slices=700){
circle(2,3,3,$fn=64);
translate([-1,-1,0]){square(3,6);}    
}
}
}