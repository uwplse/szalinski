
hole_diameter=4; //[3:40]
// the largest size handle.
handle_diameter=15; //[5:100]
// spacing between the handles.
spacing=2; //[0:20]
number_of_tools_in_a_row=6; // [1:20]
number_of_rows=1;// [1:10]
thickness=2; //[2:10]

wall_fixing_plate_height = 15; //[15:150]
// this will add a center support  if there is a hold located there it will add 2 supports .
center_support="yes"; // [yes,no]
screw_diameter = 3; //[1:10]
number_of_screws=4; // [0:10]

//Tool Guide
tool_guide="yes"; // [yes,no]
tool_guide_height=10; //[2:150] 

$fn=40; // [10:100] 
cubesize_length=(handle_diameter+spacing) *number_of_tools_in_a_row +spacing;
cubesize_width=(handle_diameter+spacing) *number_of_rows +spacing;
rows=cubesize_width/(number_of_rows);
cols =cubesize_length/(number_of_tools_in_a_row);
screws=cubesize_length / number_of_screws;
echo(screws);
clearbox_width = sqrt(pow(cubesize_width,2)+pow(wall_fixing_plate_height,2));
clearbox_angle =atan((wall_fixing_plate_height-thickness)/(cubesize_width-5));
support_1 = round((number_of_tools_in_a_row/2)-0.1);
support_2 = round((number_of_tools_in_a_row/2)+0.1);
echo(support_1);

// building object
difference() {
union() {
translate([0,5,0])cube([cubesize_length,cubesize_width-4.9,thickness]);
translate([0,cubesize_width+thickness-.2,0])rotate([90,0,0])cube([cubesize_length,wall_fixing_plate_height,thickness]);
translate([thickness,5,0])rotate([0,270,0])cube([wall_fixing_plate_height,cubesize_width-5,thickness]);
translate([cubesize_length,5,0])rotate([0,270,0])cube([wall_fixing_plate_height,cubesize_width-5,thickness]);
if (center_support == "yes") {
 if (support_1 == support_2 ) {
translate([(cubesize_length/2)+(thickness/2),5,0])rotate([0,270,0])cube([wall_fixing_plate_height,cubesize_width-5,thickness]);

} else 
{
translate([(cols*support_1)+(thickness/2),5,0])rotate([0,270,0])cube([wall_fixing_plate_height,cubesize_width-5,thickness]);
translate([(cols*support_2)+(thickness/2),5,0])rotate([0,270,0])cube([wall_fixing_plate_height,cubesize_width-5,thickness]);
}




}

hull(){
translate([5,5,0])cylinder(h=thickness,r=5);
translate([cubesize_length-5,5,0])cylinder(h=thickness,r=5);
}
}
translate([-cols/2,-rows/2,0]){
for (y=[1:number_of_rows]){
for (x = [1:number_of_tools_in_a_row]){
translate([cols*x,rows*y,-1])cylinder(h=thickness+tool_guide_height+2,r=hole_diameter/2);



}
}
}
// screw holes
if (number_of_screws > 0) {
translate([-screws/2,0,0]){
for (x = [1:number_of_screws]){
rotate([90,90,0])translate([-wall_fixing_plate_height/2,screws*x,-cubesize_width-thickness-1])cylinder(h=thickness+2,r=screw_diameter/2);
}
}
}

// clearing box
translate([-1,5,thickness])rotate([clearbox_angle,0,0])cube([cubesize_length+2,clearbox_width,clearbox_width]);
}

if (tool_guide == "yes") {
translate([-cols/2,-rows/2,0]){
for (y=[1:number_of_rows]){
for (x = [1:number_of_tools_in_a_row]){
difference() {
translate([cols*x,rows*y,0])cylinder(h=thickness+tool_guide_height,r=hole_diameter/2+(thickness/2));
translate([cols*x,rows*y,-1])cylinder(h=thickness+tool_guide_height+2,r=hole_diameter/2);
}
}


}
}
}
