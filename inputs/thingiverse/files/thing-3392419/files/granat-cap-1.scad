r1 = 8.5; //the radius of the opening
r2 = 9.5; //the radius of the groove
v1 = 7.5; //the length of the opening
v2 = 4; //the height of the groove
v3 = 1; //height of lid
r3 = 10.5; //the radius of the lid
wall = 1; //Wall thickness
$fn=100; //extermination

module zapadka()
{
   polygon(points=[[r1-wall,0],[r1-wall,v1],[r2,v2+((v1-v2)/2)],[r1,v2],[r1,0]]);
}

module vycko()
{
   cylinder(r=r3, h=v3);
   difference()
   {
      union()
      {
         translate([0,0,v3]) rotate_extrude() zapadka();  
      }
      union()
      {
         for(i=[0:60:360])
         {
            rotate([0,0,i]) cube([4,r2*3,v1*3],center=true);
         }
      }
   }
}

vycko();