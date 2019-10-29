// Arnsteio, 2018

// Makes a whiskerbiscuit suitable for slingbows

$fn=50;
vres=0.15; // vertical resolution of printer
hres=0.4;  // horizontal rsolution of printer
wall_thickness=hres*1.1;
error=0.001;

module solid_whiskerbiscuit(dia,width,fletching_cuts, shaft_dia)
/*
Builds the whiskerbiscuit
Arguments:
    Diameter of slingbow cutout
    Thickness of slingbow
    Number of cutouts for arrow fletchings
    Diameter of arrow (usually not useful but IMO the model is prettier with it in)
*/
{
step=360/fletching_cuts;// sets number of cutouts

difference ()
    {
        cylinder(h=width, d=dia, center=true);
            for (degrees = [0:step:360]) {
                rotate([0,0,degrees]) cube([dia-wall_thickness*2, 0.5, width], center=true);
            }//for
        translate([0, 0, width/2+vres*2]) resize([0,0,width*2]) sphere(d=dia-wall_thickness*2); // make middle of biscuit flexible. This gives last bit as 0,15mm*2, which is usually 2 thicknesses of plastic
        cylinder(h=width, d=shaft_dia, center=true);
    } //Diff
}

module whiskerbiscuit(dia,width,shaft_supports, shaft_dia)
/*
Builds the whiskerbiscuit
Arguments:
    Diameter of slingbow cutout
    Thickness of slingbow
    Number of brushes that give arrow supports
    Diameter of arrow
*/
    {
    step=360/shaft_supports; // To place shaft supports evenly 

// bottom-side fastening ring
    translate([0, 0, -width/2+hres]) difference () 
        {
            //
            cylinder(h=hres*2, d=dia+4, center=true);
            cylinder(h=hres*2, d=dia, center=true);
        }
        
// top-side fastening ring
 translate([0, 0, width/2-hres]) difference () 
        {
            //
            cylinder(h=hres*2, d=dia+hres*2, center=true);
            cylinder(h=hres*2, d=dia, center=true);
        }

// Wall
    difference ()
        {
            cylinder(h=width, d=dia, center=true);
            cylinder(h=width, d=dia-wall_thickness*2, center=true);
        }
// Brushes
    difference ()
        {
            for (degrees = [0:step:360]) { // whisker biscuit "brushes"
                    rotate([0,0,degrees]) cube([dia-wall_thickness*2, hres*1.05, width], center=true);
                    }//for
                    hull()
                    {
                        translate([0, 0, -width/4+vres*2]) resize([0,0,width/2]) sphere(d=dia-wall_thickness*2); // This gives middle bit twice the printing thickness of vres, for flexibility
                        translate([0, 0, width/2])cylinder(h=width/2, d=dia-wall_thickness*2);
                    } // hull
            cylinder(h=width, d=shaft_dia*1.05, center=true); // Cutout for shaft
        } // Brushes diff
} //Module

module flimsy_whiskerbiscuit(dia,width,shaft_supports, shaft_dia)
/*
Builds the whiskerbiscuit
Arguments:
    Diameter of slingbow cutout
    Thickness of slingbow
    Number of brushes that give arrow supports
    Diameter of arrow
*/
    {
    step=360/shaft_supports; // To place shaft supports evenly 

// BOTTOM-SIDE FASTENING RING
    translate([0, 0, -width/2+hres]) difference ()
        {
            //
            cylinder(h=hres*2, d=dia+4, center=true);
            cylinder(h=hres*2+error, d=dia-wall_thickness*2, center=true);
        }

// TOP-SIDE FASTENING RING
// Need to be above wall.
 translate([0, 0, width/2+hres*3]) difference ()
        {
            union()
            {
            cylinder(h=hres*2, d=dia+hres*2, center=true);
            translate([0,0,hres]) cylinder(h=hres*2, d=dia+hres*4, center=true);
            }
            cylinder(h=hres*4+error, d=dia-wall_thickness*2, center=true);
        }


// WALL
// Bottom-side fastening ring needs to be below wall. Ergo:
    translate([0,0,hres*2])
    difference ()
       {
        {
            // wall
            cylinder(h=width, d=dia, center=true);
            cylinder(h=width, d=dia-wall_thickness*2, center=true);
        }
       }
        
// BRUSHES
    difference () 
        {
            for (degrees = [0:step:360]) { // whisker biscuit "brushes"
                    rotate([0,0,degrees]) cube([dia-wall_thickness*2, hres*3, width], center=true);
                    }//for
            translate([0, 0, vres*3])  cylinder(h=width, d=dia-wall_thickness*2, center=true); // makes flimsy "brushes", for flexibility
            cylinder(h=width, d=shaft_dia*1.05, center=true); // Cutout for shaft
        } // Brushes diff
} //Module

//flimsy_whiskerbiscuit(62.5, 25, 50, 8);

flimsy_whiskerbiscuit(62.5, 25, 30, 8);

// 40 brushes is too much
