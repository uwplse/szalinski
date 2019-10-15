//Height of the drum
height=60;
//diameter of the spool
diameter=51.5;


difference(){
cylinder(h = height, r1 = diameter/2, r2 = diameter/2,center=false); 
cylinder(h = height, r1=diameter/2-4, r2=diameter/2-4, center=false);
}

difference(){
cylinder(h = height, r1 = 16/2, r2 = 16/2,center=false); 
cylinder(h = height, r1 = 11/2, r2 = 11/2,center=false);     
}

translate([6,-2,0])
cube([(diameter/2-8.5),4,60],center=false);
rotate([0,0,180]){
    translate([6,-2,0])
    cube([diameter/2-8.5,4,60],center=false);}
rotate([0,0,90]){
    translate([6,-2,0])
    cube([diameter/2-8.5,4,60],center=false);}
rotate([0,0,-90]){
    translate([6,-2,0])
    cube([diameter/2-8.5,4,60],center=false);}
