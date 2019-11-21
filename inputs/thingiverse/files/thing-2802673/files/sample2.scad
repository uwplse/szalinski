//on the first line
text_1 = "Manufacturer";

//on the second Line
text_2 = "TYPE colour";

//of the text
size = 8; //[2:30]

//length
x = 80; //[20:200]

//width
y = 30; //[10:100]

//height
z = 3; //[1:10]

//width
border = 5; //[1:20]

//diameter - 0 for disable
hole = 3; //[0:20]

//center distance from edge
hole_x = 3; //[0:40]

//center distance from edge
hole_y = 3; //[0:40]

//first row
translate([x/2,y*2/3,z/2])
linear_extrude(height=z/2)
text(text=text_1,halign="center",valign="center",size=size,font="Helvetica:style=Bold");

//second row
translate([x/2,y/3,z/2])
linear_extrude(height=z/2)
text(text=text_2,halign="center",valign="center",size=size,font="Helvetica");

//plate
difference() {
cube([x,y,z]);
    union(){
        //inner plate
        translate([border,border,z/2])
        cube([x-border*2,y-border*2,3]);
        //hole
        translate([(hole_x),(y-hole_y),0])
        cylinder(z, d=hole, $fn=100);
    }
}

