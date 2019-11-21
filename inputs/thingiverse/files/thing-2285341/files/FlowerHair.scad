$fn=40;

Diam=160;

module Torus(r1=3,r2=50)
{
    rotate_extrude()
    {
        translate([r2,0])circle(r=r1);
    }
}
module Flower()
{
    
    color("red")cylinder(r=3.2,h=3);
    color("purple")
    for(i=[0:4])
    {
       rotate([0,0,i*360/5])translate([4,0,0])scale([2,1,1])cylinder(r=2,h=2);
    }
}

module FlowerRing()
{
     nrOfFlowers = floor(Diam*0.17);
     for(i=[0:nrOfFlowers-1])
     {
         //
         // Draw the flowers, and rotate each flower a bit for a better effect...  (i*3). . .
         //
         rotate([0,0,360*i/(nrOfFlowers)])translate([0,Diam/2,0]) rotate([270,i*3,0])Flower();
     }
}

FlowerRing();
color("green")Torus(r1=2,r2=(Diam/2)-1);


