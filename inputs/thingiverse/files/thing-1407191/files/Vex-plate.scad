width=5;            //width in number of squares
length=10;           //length in number of squares
thickness=1;  //0.046 is the original if printed in plastic this should be thicker.


unit_width=0.5*2.54*10;  //the width of each unit, the vex unit is 0.5in
union(){
    for(j=[0:width-1]){
        union(){translate([0,unit_width*j,0]){
            for(i=[0:length-1]){
                translate([unit_width*i,0,0]) vex_unit();
                }
            }
        }
    }
}

module vex_unit(){
translate([unit_width/2,unit_width/2,thickness/2])difference(){
intersection(){
cube(size=[unit_width,unit_width,thickness],center=true);
rotate(45)cube(size=unit_width*6/5,center=true);
}
cube(size=[unit_width/3,unit_width/3,1.1*thickness],center=true);
}
}