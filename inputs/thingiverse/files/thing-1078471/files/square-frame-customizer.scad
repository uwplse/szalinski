element_x = 2; // [1,2,3,4,5,6]
element_y = 2; // [1,2,3,4,5,6]
rows = 2; // [1,2,3,4,5,6]
columns = 2; // [1,2,3,4,5,6]
left_edge = "false"; // [false,true]
right_edge = "false"; // [false,true]
front_edge = "false"; // [false,true]
back_edge = "false"; // [false,true]

module frame_square(x,y,l,r,f,b) {
  difference() {
    union() {
      translate([-l,-f,0]) cube([25*x+r+l,25*y+f+b,7.5]);
    }
    translate([3.6-l,3.6-f,-0.1]) cube([25*x+r+l-7.2,25*y+f+b-7.2,10]);
    for(i = [0 : x-1]) {
      translate([12.5+i*25,-5-f,3.75]) rotate([270,0,0]) cylinder(31*y+f+b,.75,.75,$fn=50);
      translate([12.5+i*25,3.6-f,-.1]) rotate([0,0,0]) cylinder(3.85,.75,.75,$fn=50);
      translate([12.5+i*25,25*y-3.6+b,-.1]) rotate([0,0,0]) cylinder(3.85,.75,.75,$fn=50);
    }
    for(i = [0 : y-1]) {
      translate([-5-l,12.5+i*25,3.75]) rotate([0,90,0]) cylinder(31*x+r+l,.75,.75,$fn=50);
      translate([3.6-l,12.5+i*25,-.1]) rotate([0,0,0]) cylinder(3.85,.75,.75,$fn=50);
      translate([25*x-3.6+r,12.5+i*25,-.1]) rotate([0,0,0]) cylinder(3.85,.75,.75,$fn=50);
    }
  }
}

module frame(x, y, rows, cols, ledge="false", redge="false", fedge="false", bedge="false", border=9.2) {
    for(i = [0 : rows-1]) {
        for(j = [0 : cols-1]) {
            translate([25*x*i,25*y*j,0]) frame_square(
                x,y,
                i>0 ? .1:i==0 && ledge == "true" ? border:0,
                i == rows-1 && redge == "true" ? border:0,
                j>0 ? .1:j==0 && fedge == "true" ? border:0,
                j == cols-1 && bedge == "true" ? border:0);
        }
    }
}

frame(element_x,element_y,rows,columns, ledge=left_edge,redge=right_edge,fedge=front_edge,bedge=back_edge);