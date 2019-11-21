$fn=30;
d=9.75;
w=3.8;
p=1.5*d;
   
font = "Liberation Sans";

JN();


// Nicer, but not generally installed:
// font = "Bank Gothic";

module G(){ offset(-0.15) text("Julia", size=10, halign="center", valign="center", font = font);}

module N(){ offset(-0.15) text("Nielsen", size=9, halign="center", valign="center", font = font);}

module JN(){    
    difference(){
        wing();
        translate([0,0,-p*3/2]) nutbase();
        translate([p/2,0,0]) rotate([0,90,0]) linear_extrude(height = 2.5, convexity = 3, center=true)G();
        translate([-p/2,0,0]) rotate([0,-90,0]) linear_extrude(height = 2.5, convexity = 3, center=true)N();
        translate([0,0,p]) color("red") cube([w,22,15], center=true);
translate([0,0,23]) color("blue") cube([22,22,5], center=true);

        
    }
}
module wing(){
 
    scale([1,1,3])  {
       intersection()
         { 
        cube([p,p,p], center=true);
        sphere(.75*p);
      }
      translate([0,p-0.5,0])      rotate([90,0,0])
    cylinder(h=1.5*d,r1=2,r2=p/2+0.05,center=true);
      
    translate([0,-p+0.5,0])      rotate([-90,0,0])
    cylinder(h=1.5*d,r1=2.0,r2=p/2+0.05,center=true);
  }
}

module nutbase(){
   cube([w,d,4.5*d],center=true);
   rotate([0,0,90]) 
    cube([w,d,4.5*d],center=true);
    rotate([0,0,45])color("red")
    cube([w,d,4.5*d],center=true);
     rotate([0,0,135]) 
    cube([w,d,4.5*d],center=true);
}