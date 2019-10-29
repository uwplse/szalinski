/*----------------------------------------------------------------------------*/
/*-------                         INFORMATION                         --------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/

// ventilation grid
// Remix of https://www.thingiverse.com/thing:3115753
// Modified and extended by Kakiemon @ Thingiverse
// Rolf Jethon
// HOW TO USE THIS FILE :

// -- Solution 1 :
// Open this file with OpenScad software (free and open-source)
// http://www.openscad.org/downloads.html
// Choose your parameters in the SETTINGS chapter (see below)
// Press F5 to compile and see the resulting hook
// Check your hook's global size in the console window (below viewing area)
// If OK, press F6 to render
// Go to : File => Export => Export as STL : choose filename and location
// Save the STL file of your customized hook
// Send this STL file to your 3D printer

// -- Solution 2 :
// This file had been optimized for Thingiverse Customizer
// You will need to have a Thingiverse Account, then :
// Go to object's page on Thingiverse
// Click on the button "Open in Customizer"
// Choose your settings in parameters tabs
// Save the STL file of your customized hook
// Send this STL file to your 3D printer



/*----------------------------------------------------------------------------*/
/*-------                           SETTINGS                          --------*/
/*----------------------------------------------------------------------------*/

/* [Sizes] */
// Note: overall length and width = length + diameter
length=100;//[1000] 
width=40;//[1000] 
brim_width=10;//[100]
brim_radius=brim_width*2;
// tube_wall * 2 must be smaller than diameter, range 0-1000
tube_wall=2;
tube_radius=tube_wall*2;
// diameter range 0-1000
diameter=8;
// brim_height must be smaller or equal to height, range 0 -1000
brim_height=1;
height=10;//[1000]
/* [Grid] */
//grid_x must be larger than gridthickness, range 0 to 1000
grid_x=6;
//grid_y must be larger than gridthickness, range 0 to 1000
grid_y=6;
//grid_height must be smaller or equal to height, range 0 to 1000
grid_height=5;
//grid_thickness must be smaller than grid_x and grid_y range 0 to 1000
grid_thickness=1;
$fn=50;


/*------------------------------------------------------------------------------

NOTES about how to use :

To get round ventilation grids, set length and width to 0 and set the desired
diameter.
To omit either the x or y grid or both make the grid_x or grid_y value larger than width
or height + diameter.
To make the grid as high as the height, use for both the same value.
Console will display warning messages if some values are illogic.

------------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*-------                             CODE                            --------*/
/*----------------------------------------------------------------------------*/

/*____________________________________________________________________________*/
if (tube_radius>=diameter)
    echo (" WARNING : tube_radius must be smaller than diameter ");
if (brim_height>height)
    echo (" WARNING : brim_height must be smaller or equal to height ");
if (grid_x<=grid_thickness)
    echo (" WARNING : grid_x must be larger than grid_thickness ");
if (grid_y<=grid_thickness)
    echo (" WARNING : grid_y must be larger than grid_thickness ");
echo ("overall length= ",length + diameter," and overall width= ",width + diameter);
translate([-length/2,0,0])
difference(){
    union(){
        hull(){   
            cylinder(d=diameter+brim_radius,h=brim_height);
            translate([length,0,0])
            cylinder(d=diameter+brim_radius,h=brim_height);
            translate([0,width,0])
            cylinder(d=diameter+brim_radius,h=brim_height);
            translate([length,width,0])
            cylinder(d=diameter+brim_radius,h=brim_height);
        }

        hull(){   
            cylinder(d=diameter,h=height);
            translate([length,0,0])
            cylinder(d=diameter,h=height);
            translate([0,width,0])
            cylinder(d=diameter,h=height);
            translate([length,width,0])
            cylinder(d=diameter,h=height);
             }
         }
translate([0,0,-1])
hull(){   
cylinder(d=diameter-tube_radius,h=height+2);
translate([length,0,0])
cylinder(d=diameter-tube_radius,h=height+2);
translate([0,width,0])   
cylinder(d=diameter-tube_radius,h=height+2);  
translate([length,width,0])
cylinder(d=diameter-tube_radius,h=height+2);    
}

}

intersection(){
    translate([-length/2,0,0])
    hull(){   
            cylinder(d=diameter,h=height);
            translate([length,0,0])
            cylinder(d=diameter,h=height);
            translate([0,width,0])  
            cylinder(d=diameter,h=height);
            translate([length,width,0])
            cylinder(d=diameter,h=height);
             }
union(){
for (a =[0:grid_x:length+diameter])
{
    translate([a-length/2-diameter/2,-diameter/2,0])
    cube([grid_thickness,diameter+width,grid_height]);
}

for (a =[0:grid_y:width+diameter-1])
{
    translate([-length/2-diameter/2,a-diameter/2,0])
    cube([length+diameter,grid_thickness,grid_height]);
}
}
}