r1 = 8.5; //the radius of the opening
r2 = 9.8; //the radius of the groove
v1 = 7.0; //the length of the opening
v2 = 3.5; //the height of the groove
v3 = 1.5; //height of lid
r3 = 10.5; //the radius of the lid
wall = 2; //Wall thickness
$fn=100; //extermination

module zapadka()
{
   polygon(points=[[r1-(wall*1.5),0],[r1-(wall*0.8),v1],[r2,v2+((v1-v2)/2)],[r1,v2],[r1,0]]);
}

module vycko_oble()
{
   cylinder(r=r3, h=v3);
   translate([0,0,0]) resize([2*r3,2*r3,2*v3]) sphere(r=r3);
   translate([0,0,v3]) rotate_extrude() zapadka();  
}

module vycko_ploche()
{
   cylinder(r=r3, h=v3);
   translate([0,0,0]) resize([2*r3,2*r3,2*v3]) sphere(r=r3);
   translate([0,0,v3]) rotate_extrude() zapadka();  
}



module forma_stena()
{
    difference()
    {
        union()
        {
            intersection()
            {
                translate([0,0,-15]) cube([13,13,(v1+v3+15)]);
//                translate([0,0,-15]) cylinder(r=15,h=(v1+v3+16),$fn=6);
            }
        }
        union()
        {
//            translate([17,0,-11]) rotate([0,0,45]) cube([25,25,42]);
            for(i=[0:90:180])
            {
                translate([0,0,(v3/2)]) rotate([0,0,i]) cube([50,1,v3],center=true);
            }
         
            translate([0,0,0]) cylinder(r=r1-(wall*0.8),h=v1+v3+0.1);
            translate([0,0,0]) vycko_oble();
        }
    }
}

module forma_stred()
{
    difference()
    {
        translate([0,0,v1+v3-3]) cube([31,31,10],center=true); 
        translate([0,0,v1+v3-4.51]) cube([26.6,26.6,7],center=true);
    }
    translate([0,0,v3+0.5]) cylinder(r1=r1-(wall*1.5),r2=r1-(wall*0.8),h=v1);
}
module forma_ram()
{
    difference()
    {
        translate([0,0,5]) cube([31,31,10],center=true); 
        translate([0,0,6]) cube([26.6,26.6,8.1],center=true);
    }
}

       translate([0,0,25])forma_stred();
       forma_stena();
        translate([0,0,-15])forma_ram();