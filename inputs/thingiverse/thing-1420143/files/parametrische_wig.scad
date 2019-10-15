/// alle maten in milimeters 
/// Wouter 16-3-2016

hoogste = 7; //hoogste kant van de wig
lengte = 70; //lengte van de wig 
breedte = 10; //breedte van de wig
laagste = 0.8; //laagste kant van de wig
gaatje = 4;

difference (){
hull(){
cylinder(d=hoogste, h=breedte);
translate([lengte-(hoogste/2)-(laagste/2),0,0]) cylinder(d=laagste, h=breedte); 
}

translate ([0,0,-1]) cylinder (d=gaatje, h=breedte+2);
}