
//settings
Height_under = 20;
Height_over = 10;
Wall_thickness = 2;
Board_length = 84;
Board_width = 55;
Board_thickness = 10;
Add_hole = true;



//calculations

Outside_box_length = Board_length + (2*(5+Wall_thickness));
Outside_box_width = Board_width + (2*(5+Wall_thickness));
Outside_box_height = Height_under + Height_over + Board_thickness + 5;
Inside_box_length =  Outside_box_length - (2*Wall_thickness);
Inside_box_width =  Outside_box_width - (2*Wall_thickness);
Inside_box_height =  Outside_box_height;

Support_height = Board_thickness + 5;
Supports_z = Height_under;




module hole(){
    //side 1
    translate([Outside_box_length/3,-1,10]){
        cube([Outside_box_length/3,5,5]);
    }
}



module hollow_box(){
    
    difference(){
        cube([Outside_box_length,Outside_box_width,Outside_box_height]);
        translate([Wall_thickness,Wall_thickness,Wall_thickness]){
            cube([Inside_box_length,Inside_box_width,Inside_box_height]);
        }
    }
}

module corner(support_x,support_y,cutout_x,cutout_y,pole_x,pole_y) {
    translate([support_x,support_y,Supports_z]){
        union(){
            difference(){
                cube([15,15,Support_height]);
                translate([cutout_x,cutout_y,5]){
                    cube([10,10,Board_thickness + 1]);
                }
            }
            translate([pole_x,pole_y,(0 - Height_under)]){
                cube([5,5,Outside_box_height - Wall_thickness]);
            }
        }
    }
}

module corners(){
     //corner 1
    length_offset =  Board_length - 10 + (Wall_thickness + 5);
    width_offset = Board_width - 10 + (Wall_thickness + 5);
    
    corner(Wall_thickness, Wall_thickness,5,5,0,0);
    corner(Wall_thickness, width_offset,5,0,0,10);
    corner(length_offset, width_offset,0,0,10,10);
    corner(length_offset, Wall_thickness,0,5,10,0);

}



difference(){
    union(){
        hollow_box();
        corners();
    }
    if (Add_hole == true){
        hole();
    }
}