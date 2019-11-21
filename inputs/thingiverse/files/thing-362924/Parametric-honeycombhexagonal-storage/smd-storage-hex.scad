// Measured vertex to vertex
slot_radius =  8;
slot_depth  =  3;
number_of_columns  =  4.5;
number_of_rows =  7;
wall_thickness =  2;
bottom_thickness =  2;
first_line_type = 0; // [1:Short, 0:Long]
use_tabs = 1; // [0:No, 1:Yes]

S30 = sin(30);
C30 = cos(30);

nNumShort = floor(number_of_columns);
nNumLong  = ceil(number_of_columns);
nNumOdd   = first_line_type ? nNumLong : nNumShort;
nNumEven  = first_line_type ? nNumShort : nNumLong;

vFullWidth = (nNumShort==nNumLong ? nNumLong+0.5 : nNumLong)*2*slot_radius*C30+wall_thickness;

iFirstLong = first_line_type ? 1 : 0;
iLastLong  = (number_of_rows+first_line_type)%2 ? number_of_rows-1 : number_of_rows-2;

iFirstLongEnd = nNumOdd == nNumEven ? 1-first_line_type : iFirstLong;
iLastLongEnd  = nNumOdd == nNumEven ? number_of_rows-2+first_line_type : iLastLong;

echo("iFirstLongEnd", iFirstLongEnd);
echo("iLastLongEnd", iLastLongEnd);
module holder(r, h) {
	for (i=[0:5]) rotate(a = [0,0,60*i]) translate([-slot_radius*C30,-slot_radius/2,0]) {
		cylinder(r = wall_thickness/2, h=bottom_thickness + slot_depth, $fa=15, $fs = 0.1);
		translate([-wall_thickness/2,0,0]) {
			cube(size = [wall_thickness, slot_radius, bottom_thickness + slot_depth], center = false);
			cube(size = [slot_radius, slot_radius, bottom_thickness], center = false);
		}
	}
}

//rotate([0,0,$t*360]) 
translate([-number_of_columns*slot_radius*C30,-number_of_rows*slot_radius*(1+S30)/2,0])
union() {
	for (iH = [0:number_of_rows-1]) {
		translate([slot_radius*C30*((iH+first_line_type)%2),iH*slot_radius*(1+S30),0])
			for (iW = [0:(iH%2 ? nNumOdd : nNumEven)-1]) {
				translate([iW*slot_radius*2*C30,0,0])
					holder(slot_radius, slot_depth);
			}
	}
	if (use_tabs) {
		translate([-slot_radius*C30-wall_thickness/2,iFirstLong*2*slot_radius*C30*C30,0]) {
				cube(size=[
					slot_radius*C30+wall_thickness/2,
					(iLastLong-iFirstLong)*2*slot_radius*C30*C30,
					bottom_thickness], center=false);
		}
		translate([vFullWidth - 2*slot_radius*C30-2*wall_thickness/2,iFirstLongEnd*2*slot_radius*C30*C30,0]) {
				cube(size=[
					slot_radius*C30+wall_thickness/2,
					(iLastLongEnd-iFirstLongEnd)*2*slot_radius*C30*C30,
					bottom_thickness], center=false);
		}
	}
}
