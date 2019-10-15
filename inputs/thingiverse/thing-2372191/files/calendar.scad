$fn = 50;

columns = 2;
rows = 7;

CHANGE_NO_VALUES_BELOW_THIS_POINT="CHANGE NO VALUES BELOW THIS POINT";

hole_width = 6;
hole_length = 18;
thickness = 10;

x_offset = 7;
y_offset = 6.833;

module base(){
    cube([(hole_length+x_offset)*columns+x_offset,(hole_width+y_offset)*rows+y_offset,thickness]);
}
module hole(){
    cube([hole_length,hole_width,thickness+2]);
    
    rotate(a=90, v=[0,1,0]) translate([-3.5,.5,0]) cylinder(r=3.162/2, h=hole_length);
    
    rotate(a=90, v=[0,1,0]) translate([-3.5,hole_width-.5,0]) cylinder(r=3.162/2, h=hole_length);
}
module holematrix(){
    for(col = [0:columns-1]){
        for(row = [0:rows-1]){
            translate([x_offset+(col*(hole_length+x_offset)),y_offset+(row*(hole_width+y_offset)),-1]){
                hole();
            }
        }
    }
}
difference(){
    base();
    holematrix();
}