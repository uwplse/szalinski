//henry Piller 2017
// variable description
// Ausschnitt
breite = 5; // [5:0.5:30]
//Rundung
durchmesser = 24; // [5:0.2:50]
loch = 0 ; // [0:nein,1:ja]
/*[hidden]*/
radius= durchmesser/2;
$fn = 80;
 rotate([270,0,0])
  translate([0,-2,0])  
difference(){
union(){
difference(){
union(){
 cylinder(h=1,r1=radius,r2=radius,center=false);
  translate([0,0,breite+1])  
 cylinder(h=1,r1=radius,r2=radius,center=false);
}
translate([-radius,0,0])
 cube([durchmesser+1,durchmesser+1,durchmesser+1/2],center=false);
}
translate([-radius,0,0])
 cube([durchmesser,2,breite+2],center=false);
}
if (loch==1){
 translate([0,-radius/2,0])
cylinder(h=2,r1=radius/3,r2=radius/3,center=false);
}
}
//end