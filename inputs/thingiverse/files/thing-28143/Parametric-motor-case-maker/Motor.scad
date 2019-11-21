// This is a parametric case maker for a motor

//Example1

// to make a custom case, replace the parameters with your own

//examplemotor1
dm = 24.5; // Diameter of motor
th = 2; // Thickness of case
hc = 13; // Height of motor
he =  dm/2; // Height to ends
de = 2; // Diameter of ends
dbe = 15.75; // Distance between ends
le = 2.5; // Length of ends
dte = le/2; // Distance to ends

//Example2

//to use, get rid of "/*" and "*/"

/*//examplemotor2
dm = 18; // Diameter of motor
th = 2; // Thickness of case
hc = 28; // Height of motor
he =  19; // Height to ends
de = 4; // Diameter of ends
dbe = 12.5; // Distance between ends
le = 5; // Length of ends
dte = 7; // Distance to ends*/



//program
if (le-dte >0)
{
difference() {
cylinder(r = (dm/2+th), h = (hc+th));
cylinder(r = (dm/2), h = hc);
translate([dm/2-he,dbe/2,hc-dte/2])
cylinder(r = (de/2)+th, h = le+2 * th, center = true);
translate([dm/2-he,-dbe/2,hc-dte/2])
cylinder(r = (de/2)+th, h = le+2 * th, center = true);
}
}
else
{
difference() {
cylinder(r = (dm/2+th), h = (hc+th));
cylinder(r = (dm/2), h = hc);
translate([dm/2-he,dbe/2,hc-dte/2])
cylinder(r = (de/2)+th, h = le, center = true);
translate([dm/2-he,-dbe/2,hc-dte/2])
cylinder(r = (de/2)+th, h = le, center = true);
}
}