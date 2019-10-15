module fins()
{
    $fn=60;
    difference()
    {
        union()
        {
            for(z_rotation=[0:72:288])
            {
                rotate([0,0,z_rotation]) difference()
                {
                    translate([16,16,0]) cylinder(h=2, r=20,center=true);
                    translate([24,4,0]) cylinder(h=2, r=20,center=true);
                }
            }
        }      
        difference()
        {
            cylinder(h=12, r=46,center=true);
            cylinder(h=12, r=39,center=true);    
        }   
    }
}

module tyre()
{
    $fn=60;
    difference()
    {   
        difference()
        {
            cylinder(h=12, r=39,center=true);
            cylinder(h=12, r=34,center=true);    
         }     
         difference()
         {
            cylinder(h=12, r=7,center=true);
            cube([3,3,12],center=true);    
          }             
    }
}

module shaftHole()
{
    $fn=60;
    difference()
    { 
        cylinder(h=12, r=6,center=true);
        cube([3,3,12],center=true);  
        translate([0,0,4]) cylinder(h=4,r=4.5,center=true);
     }
     translate([0,0,2.5]) difference()
     {
         cylinder(h=1,r=4.5,center=true);
         cylinder(h=1,r=1,center=true);
     }
}

module ridges()
{
    for(i=[0:360])
    {
        translate([39*sin(i),39*cos(i),0]) rotate([0,0,45+i]) cube([1,1,12],center=true);
    }
}
module wheel()
{
    //Width of the tire : 12 mm.
    //Diameter of the tire : 78 mm.
    //Diameter of the Shaft Hole : 3x3 mm  
    tyre();
    ridges();
    fins(); 
    shaftHole();
}
wheel();

