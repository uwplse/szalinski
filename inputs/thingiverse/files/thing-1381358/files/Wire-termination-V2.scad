// CHANGABLE PARAMETERS
// Cube dimensions (height is fixed = 6.5mm)

/*[Input Data]*/
// Number of pins in one row
number_of_pins = 12;           // [1:1:40]
// Number of rows (1 or 2)
rows = 2;                       // [1,2]

// whichever suits you (for Arduino Micro is 15.24)
row_distance = 15.24;
// square length and width (depends on printer accuracy) 
pin_hole_dim = 1.20; 		    // [1:0.05:1.50] 


// OPTIONALLY CHANGABLE PARAMETERS
// offset between pins (usually 2.54mm)
pin_offset = 2.54;   

// pin distance from edge of adapter
x_offset_from_edge = 2;
// pin distance from edge of adapter
y_offset_from_edge = 1.8;  		
// wire hole offset from bottom edge
z_offset_from_edge = 0.5;  // [0.5:0.1:1.0] 

/* [Hidden] */
// FIXED OR COMPUTED PARAMETERS
length = (2 * x_offset_from_edge) + ((number_of_pins - 1) * pin_offset) + pin_hole_dim;
width = (2 * y_offset_from_edge) + pin_hole_dim + (rows - 1) * row_distance;

// Draw object
draw(number_of_pins, rows, row_distance, pin_hole_dim, pin_offset, x_offset_from_edge, y_offset_from_edge, z_offset_from_edge, length, width); 

// Definition of the module
module draw (npin, nrow, rowdist, pindim, pinoff, xoff, yoff, zoff, nlength, nwidth){
    render(convexity = 2) 
    difference(){
        cube([nlength, nwidth, 6.5]);
            
        // cut holes for pins
        for(i = [0:pinoff:(npin - 1) * pinoff]){
            for(j = [0:rowdist:(nrow - 1) * rowdist]){
                translate([xoff + i, yoff + j, 0]) 
                cube([pindim, pindim, 6.5]);
                //color("cyan");
            }
        }
        
        // cut holes for wires
        for(i = [0:pinoff:(npin - 1) * pinoff]){
            for(j = [0:rowdist:(nrow - 1) * rowdist]){
                translate([xoff + i, j, z_offset_from_edge])   // if connection with wire is loose, insreace distance from 0.5 to (not more than) 1mm
                cube([pindim, 2 * yoff + pindim, pindim]);
                //color("red");
            }
        }
    }
};