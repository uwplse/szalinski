/*
*****************************************************

By Jordi Caparrós
jordicaparros@gmail.com
2016

v1.3:     calculate row & col positions with a col. vector
v1.4:     Separate limits for rows and columns & variable height text
v1.5:     Thingiverse Customizer version

*****************************************************
*/

// Customizer helper code
include <utils/build_plate.scad>;

// preview[view:south, tilt:top]


//CUSTOMIZER VARIABLES

/* [Plate Size] */

// Number where rows start counting
first_row_number = 2; // [1:20]

// Number where rows end counting
last_row_number = 9; // [1:20]

// Number where Columns start counting
first_column_number = 2; // [1:20]
// Number where Columns end counting
last_column_number = 9;  // [1:20]

// Plate thickness ( 0 = no plate ! )
plate_thickness = 2;  // [0:0.5:10]

/* [Numbers Settings] */

// Number's Font size
font_size=6; // [5:20]

// Number's default thickness (3D height)
numbers_thickness = 1;  // [0.5:0.5:10]

// Set >0 to get Variable Height Numbers (Proportional to value)
variable_numbers_thicknessbers = 0; // [0:0.5:5]

/* [General Layout] */

// White space (margins) from plate border to numbers
intend = 3; // [1:10]


//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//CUSTOMIZER VARIABLES END

/* [Hidden] */
cells_sep_x = 2*1 ;     // X_inter-cell-space
cells_sep_y = 5*1;        // Y_inter-cell-space


$fn=15;
build_plate_selector = 3;
plate_op = "X";
line_size=3;


total_num_row = last_row_number - first_row_number + 1; 
total_num_col = last_column_number - first_column_number + 1; 
num_z_adjust = plate_thickness - 0.2;

// Modules

module write_num(num) {
    
    snum = str(num);
    linear_extrude(height = numbers_thickness + ( num / 10 ) * variable_numbers_thicknessbers , center = false) 
        text(snum, font = "Comic Sans:style=Bold Italic", size=font_size);
        
}   // moudule write_num

module write_text(texto) {
    
    linear_extrude(height = numbers_thickness , center = false) 
        text(texto, font = "Comic Sans:style=Bold Italic", size=font_size);
        
}   // moudule write_text



// Helper functions to Calculate x,y number positions

function  x_pos(columna) = ( columna <= first_column_number -1 ) ?

        // First Column

            intend   :

        // Non First Columns

            ( columna == first_column_number ) ?   // Second col ?

                       cells_sep_x + len ( str (last_row_number))*font_size 
                        +  x_pos(columna - 1)

                    :  // Column 3 to end
                        len ( str ((columna-1)*
                        last_row_number))*font_size +  x_pos(columna - 1);


function  y_pos(fila) = ( intend + (total_num_row - (fila - first_row_number  + 1 )) * ( font_size + cells_sep_y ));



// MAIN PLATE SIZE CALCULATION
plate_size_x = x_pos(last_column_number + 1)  - cells_sep_x; 
plate_size_y = intend+(total_num_row+1)*(font_size+cells_sep_y); 


build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);


union() {
    cube([plate_size_x,plate_size_y,plate_thickness],center=false);
    
    // HEADER: Operation symbol operator + First Row numbers

    translate([x_pos(first_column_number-1),y_pos(first_row_number-1),num_z_adjust])    
                write_text(plate_op);

    for (head =[first_column_number:last_column_number]) 
        translate([x_pos(head),y_pos(first_row_number-1),num_z_adjust])
            write_num(head);


    // TABLE BODY (second row to last_row_number row)

    for (row =[first_row_number:last_row_number]) {
        
        translate([x_pos(first_column_number-1),y_pos(row),num_z_adjust])
                write_num(row);
        
        for (col = [first_column_number:last_column_number]) {
            
            translate([x_pos(col),y_pos(row),num_z_adjust])
                write_num(row*col);
        }
    }

    // COLUMN SEPARATOR
    
    translate( [x_pos(first_column_number)- cells_sep_x ,intend,num_z_adjust+0.5] ) 
        rotate ([270,0,0]) 
            linear_extrude(height = (y_pos(first_row_number-1)+cells_sep_y )) resize([line_size-1,line_size/3]) circle(d=3);

}
