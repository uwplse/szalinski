$fn=150;

difference()
{
    cube([35.2,18,3.15],center= true);          //Main body
cube([23.4,12.5,4],center= true);               //Servo cut out
   translate([14.5,0,-2]) cylinder(h=5, r=1.2);   // Screw hole + direction
translate([-14.5,0,-2]) cylinder(h=5, r=1.2);     // Screw hole - direction 
 translate([-20,6.24,-2])cube([40,15,4]);       //Cut off bar  + direction
} 