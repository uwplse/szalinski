use <threads.scad>
$fn=200;
Hoehe = 150;
Durchmesser = 40;

difference()
     {
         translate([0,0,-2]) cylinder(h=2, d=36);
         translate([0,0,-2]) cylinder(h=2, d=25.8);
     }
     
 difference()
     {
         translate([0,0,Hoehe]) cylinder(h=2, d=36);
         translate([0,0,Hoehe]) cylinder(h=2, d=30);
     }    


//cylinder(h=2, d=36);

difference()
     { 
         cylinder(h=Hoehe, d=Durchmesser);
         
         cylinder(h=105, d=25.8);
         translate([0,0,113]) cylinder(h=37, d=30);
         translate([0, 0, 105]) metric_thread(22.5, 1, 8);  
         translate([0,0,100]) rotate_extrude() translate([19.5,0,0]) circle(d=4); 
         translate([0,0,120]) rotate_extrude() translate([19.5,0,0]) circle(d=4); 
         translate([0,0,10]) rotate_extrude() translate([19.5,0,0]) circle(d=4); 
     }
     
translate([0,0,0]) rotate_extrude() translate([18,0,0]) circle(d=4);
translate([0,0,Hoehe]) rotate_extrude() translate([18,0,0]) circle(d=4);