
Diameter_1=14.5;
Diameter_2=10.5;
Diameter_top_hole=5;
Height_1=50.5;
Height_2=44;

a=a;
$fn=72;

difference()
    {
    translate([0,0,0])
        hull()
            {
            translate([0,0,Height_1/2-Diameter_1/5-1])
               rotate_extrude()
                translate([Diameter_1/2-Diameter_1/5,0,0])
                 rotate([0,0,0])
                  circle(d=Diameter_1/5,center=true);

               translate([0,0,-Height_1/2+Diameter_1/5])
                 rotate([0,0,0])
               rotate_extrude()
                translate([Diameter_1/2-Diameter_1/5,0,0])
                 rotate([0,0,0])
                  circle(d=Diameter_1/5,center=true);

                }    
         translate([0,0,-Height_1/2-1])
         cylinder(d=Diameter_2,h=Height_2+1,center=false);
         translate([0,0,0])
         cylinder(d=Diameter_top_hole,h=Height_1*2,center=false);
}
