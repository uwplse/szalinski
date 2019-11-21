metalX=12;
metalY=4.2;
metalZ=4;

plasticC=2;

bearingR=22.1/2;
bearingH=7;
precission=100;

difference(){
hull(){
translate([0,0,0]) cube([metalX+2*plasticC,bearingH+plasticC,metalZ], center=true);
translate([0,0,-bearingR-9.9])  rotate([90,0,0]) 
cylinder(r=bearingR+plasticC, h=bearingH+plasticC, center=true, $fn = precission); 
}
translate([0,0+0.5,-bearingR-9.9])  rotate([90,0,0]) 
translate([0,0,plasticC]) cylinder(r =bearingR, h=bearingH+plasticC, center=true, $fn = precission); 
translate([0,0,5]) cube([metalX,metalY,metalZ+40], center=true);
}
