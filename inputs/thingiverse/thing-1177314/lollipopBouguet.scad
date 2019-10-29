/* [Base] */

SPHERE_RADIUS = 20;
PERCENT_BASE = 0.2;

/* [Sticks] */

STICK_RADIUS = 1.9;
TOTAL_STICKS = 150;
STICK_HEIGHT = 8;

/* [Hidden] */
CUBE_SIZE = 2*SPHERE_RADIUS;

 offset = (PERCENT_BASE-1)*(CUBE_SIZE);
 difference()
 {
    fullSphere();    
    translate([0,0,offset])
     cube(CUBE_SIZE, center=true);    
 }





module fullSphere()
{
  difference()
    {
     sphere(r= SPHERE_RADIUS, center=true, $fn=50); 
     sticks();
    }
}

module stick()
{
    translate([0,0,1+SPHERE_RADIUS-STICK_HEIGHT/2])
      cylinder(r=STICK_RADIUS, h=STICK_HEIGHT, center=true, $fn=20);    
}

module sticks()
{
    phi = (sqrt(5)+1)/2 - 1;
    ga = phi * 2 * PI;
    union()
    {
       for (i = [1:TOTAL_STICKS])
       {
          rotate([degrees(ga*i),0, 0])
           rotate([0,asin(-1 + 2*i/TOTAL_STICKS),0])
            stick();           
       }        
    }    
}
function degrees(x) = ((180*x)/PI);
    

