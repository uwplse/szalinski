//Overall width (left-right) distance (in mm)
total_width = 258; //[40:400]
// Overall height (top-bottom) distance (in mm)
total_height = 174; // [50:300]
// Thickness of the sheet 
thickness = 2; // [0.5:5]
// Number of columns
number_columns = 6; // [1:15]
// Number of rows
number_rows = 6; // [1:15]
// Left margin (distance from left side of sheet to the first button, in mm)
left_margin = 25; // [0:50]
// Right margin (distance from right side of sheet to the first button, in mm)
right_margin = 25; // [0:50]
// Top margin (distance from top of sheet to the first button, in mm)
top_margin = 36; // [0:50]
// Bottom margin (distance from bottom of sheet to the last button, in mm)
bottom_margin = 36; // [0:50]
// Distance between the right edge of one button and the left edge of the next (in mm)
horizontal_gap = 5; // [2:30]
// Distance between the bottom edge of one button and the top edge of the next (in mm)
vertical_gap = 5; // [2:30]

module makebuttons(number_columns,number_rows,left_margin,top_margin,button_width,button_height,horizontal_gap,vertical_gap) {

for ( i = [0 : number_columns-1] )
{
	for (j = [0 : number_rows-1])
    translate([left_margin + i * (button_width + horizontal_gap), top_margin + j * (button_height + vertical_gap), 0])
	linear_extrude(height=thickness)
   square([button_width,button_height]);
}

}

button_height = (total_height - top_margin - bottom_margin - (number_rows-1)*vertical_gap ) / number_rows;

button_width = (total_width - left_margin - right_margin - (number_columns-1)*horizontal_gap ) / number_columns;

difference() {
linear_extrude(height = thickness)
square([total_width,total_height]);

makebuttons(number_columns,number_rows,left_margin,top_margin,button_width,button_height,horizontal_gap,vertical_gap);
}