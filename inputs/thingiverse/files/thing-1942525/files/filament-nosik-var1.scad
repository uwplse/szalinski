$fn=128;
hole_size=15.5;
glass_w=4.7;
pangle=40;
translate([-40,0,0])rotate([90,0,0])
difference(){
    rotate_extrude(angle=pangle,convexity=2)translate([40,0,0])circle(d=8);
    rotate_extrude(angle=pangle+1,convexity=2)translate([40,0,0])circle(d=4);
    rotate_extrude(angle=pangle+1,convexity=2)translate([45,0,0])square ([10,2],center=true);
}



   difference(){
        
       union(){
           translate([0,0,-glass_w-3-3])cylinder(d=hole_size+5,h=3);
           translate([0,0,-glass_w-3])cylinder(d=hole_size,h=glass_w);
           translate([0,0,-3])cylinder(d1=hole_size+1,d2=hole_size,h=3);
       }
       translate([0,-15-hole_size/2,0])cube([30,30,10],center=true);
       translate([0,+15+hole_size/2,0])cube([30,30,10],center=true);
       translate([0,0,-16])cylinder(d=4,h=22);
       translate([50,0,0])cube([100,2,100],center=true);
       /*difference(){
            translate([0,0,-10])cylinder(d=26,h=6); 
            translate([0,0,-4-6])cylinder(d=15,h=6);
       }*/
   }
   