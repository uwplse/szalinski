$fn=64;
shoe_diameter=57.5; // how wide is the hole in the shoe we want to adapt to.
hose_diameter=32; //default 32, how wide is the connector of our vacuum hose
hose_connector_length=32; //default 32, how long is the connector of our vacuum hose
diameter=hose_diameter;

module aussen()
{
cylinder(d=shoe_diameter, h=35, center=false);
minkowski(){translate ([0,0,18.5]) cylinder(d=54, h=0.01, center=false);
translate ([0,0,40,18.5]) sphere(d=9);};
translate ([0,0,35]) cylinder(d=(hose_diameter+13), h=hose_connector_length, center=false);
};
if (hose_diameter>50) {
   diameter=50;
    echo (diameter);
} 
 echo ($diameter); 
difference() {
    aussen();
    translate ([0,0,35.5]) cylinder(d=hose_diameter, h=hose_connector_length, center=false);
    if (hose_diameter>50) {
   diameter=50; //don't exceed the maximum bore for the shoe 
   cylinder(d=diameter, h=80, center=false);
    }
    else
       cylinder(d=diameter, h=80, center=false);
    
    cylinder(d=50, h=32, center=false);
};
