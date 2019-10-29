/*[Blade generator for sandpaper handler]*/

// Length of the blade:
BladeLength = 10;
// Radius for cylindrical blade (minimum 8):
BladeRadius = 16;
// Height for Ortho blade (minimum 10):
BladeHeight = 40;
// Hollow:
Hollow = 1; // [0:Fill, 1:Hollow]

// End type:
EndType=5; // [1:Round, 2:Chamfer, 3:Flat, 4:Cylindrical, 5:Ortho]

module MakeBlade()
{
    if (EndType==1)
        rotate([90,0,0])
        union()
        {
        cube([10,50,BladeLength]);
        translate([5,0,BladeLength])
            rotate([-90,0,0])
                cylinder(h=50,r=5,$fn=50);
        }
        
    if (EndType==2)
        rotate([0,90,180])
        difference()
        {
        cube([10,50,BladeLength]);
        translate([-10,-5,BladeLength-6])
            rotate([0,45,0])
                cube([10,60,20]);
        }

    if (EndType==3)
        cube([50,BladeLength,10]);

    if (EndType==4)
        rotate([0,90,0])
        difference()
        {
            union()
            {
            translate([0,0,-5])
                cube([50,12,10]);
            translate([0,BladeRadius+9,0])
                rotate([0,90,0])
                cylinder(h=50,r=BladeRadius,$fn=50);
                
            }
        if(Hollow>0)
        translate([-5,BladeRadius+9,0])
            rotate([0,90,0])
            cylinder(h=60,r=BladeRadius-4,$fn=50);
            
        }

    if (EndType==5)
        rotate([0,90,0])
        difference()
        {
            union()
            {
            translate([0,0,-5])
                cube([50,10,10]);
            translate([0,9.8,-BladeHeight/2])
                cube([50,BladeLength,BladeHeight]);
            }
        if(Hollow>0)
            translate([-5,9.8+(BladeLength-(BladeLength-5))/2,-(BladeHeight-5)/2])
                cube([60,BladeLength-5,BladeHeight-5]);
        }
}

// Main
MakeBlade();
