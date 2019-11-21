$fn=100;
h_mini=0.4;
h_big=0.8;

feld=5;


translate([-90,-90,0])aussenfeld();
translate([-90,90,0])aussenfeld();


translate([90,-90,0])aussenfeld();
translate([90,90,0])aussenfeld();

translate([-50,-50,0])aussenfeld();
translate([-50,50,0])aussenfeld();


translate([50,-50,0])aussenfeld();
translate([50,50,0])aussenfeld();

difference(){
    cylinder(d=40,h=h_mini);
    cylinder(d=39,h=h_mini);
}



retrace();


module aussenfeld(){
    cube([feld,feld,h_mini]);
    translate([feld,0,0])cube([feld,feld,h_big]);
}




module retrace(){
    cube([10,5,h_big],center=true);
    translate([-1.5,0,0])  cylinder(d1=3,d2=1,h=10);
    translate([1.5,0,0]) cylinder(d1=3,d2=1,h=10);
    
    
    
}