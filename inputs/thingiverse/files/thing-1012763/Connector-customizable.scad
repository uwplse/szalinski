// Customizable Connectors
// Author Mathias Dietz
// http://gcodeprintr.dietzm.de


//Overall length
l=95;
//Width and high
wid=16;  // [10:50]

//Radius of screw holes
r1=3.5; // [1.5:0.5:6]

//Hole direction
hole=0;// [0:vertical,1:horizontal]

/* [Hidden] */
t=3.5; 
lochabstand=wid/5+r1;
$fn=60;
//Height
h=wid;

difference(){
    union(){
        translate([-t,0,0]) cube([wid+2*t,h+t,h]);
        cube([wid,l,h]);
    }
    cube([wid,h,h]);
    translate([-t-0.5,lochabstand,h/2]) rotate([0,90,0]) cylinder(r=r1,h=wid+2*t+1) ;
    if ( hole == 0){
           #translate([wid/2,l-lochabstand,0]) rotate([0,0,0]) cylinder(r=r1,h=h) ;
         //abgerundet
    difference(){
    translate([wid/2,l/2,-0.5]) cylinder(r=l,h=h+1) ;
    translate([wid/2,l/2,-0.5]) cylinder(r=l/2,h=h+1) ;
    translate([-t,-10,0]) cube([wid+2*t,l,h]) ;    
        }
    } else {
           #translate([0,l-lochabstand,h/2]) rotate([0,90,0]) cylinder(r=r1,h=h) ;
         //abgerundet
   translate([0,0,h]) rotate([0,90,0]) difference(){
    translate([wid/2,l/2,-0.5]) cylinder(r=l,h=h+1) ;
    translate([wid/2,l/2,-0.5]) cylinder(r=l/2,h=h+1) ;
    translate([-t,-10,0]) cube([wid+2*t,l,h]) ;    
        }
    }
    
   
}

module cap(){
kn=6;
difference(){
    union(){
  translate([0,-15,0]) cylinder(r=5.7,h=kn,$fn=30) ;
  translate([-5,-20,0]) cube([10,10,kn]) ;
          translate([0,-22,0]) rotate([0,0,45]) cube([10,10,kn]) ;
    }
        translate([0,-15,kn-3.2]) cylinder(r=4,h=3.2,$fn=6) ;
  translate([0,-15,0]) cylinder(r=2.2,h=kn,$fn=30) ;
}
}



