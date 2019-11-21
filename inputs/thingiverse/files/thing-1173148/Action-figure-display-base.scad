//Customizer Variables

// Specify the shape of the base
base_shape = 90;//[90:round,3:triangle,4:square,5:pentagon,6:hexagon,7:heptagon,8:octagon,10:decagon,12:dodecagon]

// Most display stands appear to be around 2 to 3.175 mm in height
base_height = 2;
base_diameter = 50.8;

// This section displays the peg measurement options

peg_height = 4;
peg_diameter = 3;

// This section displays the peg position.  Note the z offset is not customizable.  The peg_height should account for a z position of 0 and add the hight of the base to the size of the peg.  
// Default is a 6mm peg + base height

// If both X & Y offset are 0 peg will be centered
peg_x_offset = 0;
peg_y_offset = 15.875;

/* [Hidden] */
// Add a tolerance level of 0.001 mm to prevent zero sized prints
// This is small enough that it should not be noticeable to any printers

tolerance = 0.001;

// Create the base

if(base_shape == 3)
{   
    //Triangle base
    
    rotate([0,0,90]) cylinder(h=base_height+tolerance, d=base_diameter+tolerance, $fa=1, $fn=base_shape);
}

else 
{
    //All other shapes
    
    cylinder(h=base_height+tolerance, d=base_diameter+tolerance, $fa=1, $fn=base_shape);
}


//create the peg

translate([peg_x_offset, peg_y_offset, 0])
   cylinder(h=peg_height+tolerance+base_height, d=peg_diameter+tolerance, $fa=1, $fs=0.5);

