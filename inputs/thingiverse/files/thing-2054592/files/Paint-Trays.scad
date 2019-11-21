thick  = 2;
height = 10;

radiusDown = 20.0 /2;
radiusUp   = 30.0 / 2; 

jetDown = 5.0 /2;
jetUp = 8.0 /2;

$fn = 100;

module tray()
{
    difference()
    {
        difference()
        { 
         union()
         {   
          cylinder(h= height, r=radiusUp + (thick/2), center=true);
          translate([0, radiusUp, 0]) cylinder(h= height, r1= jetDown, r2 = jetUp, center=true);   
         }     
         translate([0,0, thick]) #cylinder(h=height, r1=radiusDown, r2=radiusUp, center=true);
         
         // Jet
         rotate([-10, 0, 0])
         translate([0, radiusUp - thick, height - thick]) 
          #cylinder(h= height, r= jetUp - thick, center=true);
        }
    }
}

tray();