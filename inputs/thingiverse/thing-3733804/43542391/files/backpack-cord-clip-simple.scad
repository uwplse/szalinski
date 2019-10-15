// Backpack Cord Clip
// This clip will hold together your backpack cords in the center of your chest
// so the cords will not slip from your soulder.

// (mm)
Total_Length=80; // [10:200]
// (mm)
Cord_Diameter=9; // [1:20]

Inner_Length=(Total_Length/2)-Cord_Diameter*2+Cord_Diameter/4;
Round_Edge=0+0;
// uncomment next line to have rounded edges, but it will render quite slow
//Round_Edge=Cord_Diameter/2.1;

// set low resolution for faster preview and high resolution for rendering
$fn = $preview ? 12 : 36;

module semi_clip()
{
    union()
    {
        difference() {
            // outer figure
            union()
            {
                translate([-Inner_Length/2,0,0])
                    cylinder(h=Cord_Diameter/2*1.5-Round_Edge,d=Cord_Diameter*2-Round_Edge,center=true);
                translate([Inner_Length/2,0,0])
                    cylinder(h=Cord_Diameter/2*1.5-Round_Edge,d=Cord_Diameter*2-Round_Edge,center=true);
                cube([Inner_Length,Cord_Diameter*2,Cord_Diameter/2*1.5],center=true);
            }
            // inner cutout
            union()
            {
                translate([-Inner_Length/2,0,0])
                    cylinder(h=Cord_Diameter+1,d=Cord_Diameter+Round_Edge,center=true);
                translate([Inner_Length/2,0,0])
                    cylinder(h=Cord_Diameter+1,d=Cord_Diameter+Round_Edge,center=true);
                cube([Inner_Length,Cord_Diameter,Cord_Diameter/2*1.5+1],center=true);
            }
            translate([Total_Length/4-Cord_Diameter/4,-Cord_Diameter,0])
                cube([Cord_Diameter*2,Cord_Diameter*2,Cord_Diameter+1],center=true);
        }
        translate([Total_Length/4-Cord_Diameter/4-Cord_Diameter,-Cord_Diameter/2,0])
            cylinder(h=Cord_Diameter/2*1.5-Round_Edge,d=Cord_Diameter-Round_Edge,center=true);
        translate([Total_Length/4-Cord_Diameter/8,0,0])
            cylinder(h=Cord_Diameter/2-Round_Edge,d=Cord_Diameter/2-Round_Edge,center=true);
    }
}

// round the edges of the figure
//minkowski()
{
    union()
    {
        translate([-(Total_Length/4-Cord_Diameter/8),0,0])
            semi_clip();
        
        translate([(Total_Length/4-Cord_Diameter/8),0,0])
            rotate([180,180,0])
                semi_clip();
    }

//    sphere(Round_Edge/2);
}