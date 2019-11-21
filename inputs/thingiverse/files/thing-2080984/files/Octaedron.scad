//Octaedron Generator by David_LG 03/02/2017
// this isn't a precise model, but it seems ok for 3D printing purposes

Diameter=100; // Diameter of the circumbscribed circle
Total_Height=200; // Total Heigth
Number_of_octaedrons=3; // Total number of octaedrons to pile up

Height=Total_Height/Number_of_octaedrons;

for(i=[0:Number_of_octaedrons-1]){
    rotate([0,0,60*i])translate([0,0,Height*i])hull(){
        cylinder(r=Diameter/2,h=.0001, $fn=3); 
        rotate([0,0,60])translate([0,0,Height])cylinder(r=Diameter/2,h=.0001, $fn=3); 
    }
}