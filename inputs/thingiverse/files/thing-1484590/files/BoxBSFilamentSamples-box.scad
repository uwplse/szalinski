offset=10;

inner_dim_x=100;
inner_dim_y=27;
inner_dim_z=26;
wall_thickness=2.2;

shoulder_thickness=1;
shoulder_height=5;
cover_height_without_shoulder=25;
cover_height=shoulder_height+cover_height_without_shoulder;
spacing=0.2;
spacing_vertical=1;



Assembly();

module Assembly(){
    translate([0,-inner_dim_y-offset,0]) Box();
    translate([0,inner_dim_y+offset,0]) Box_Cover();
}
module Box(){
    translate([0,0,(inner_dim_z+wall_thickness)/2])
    difference(){
    difference(){
            cube ([inner_dim_x+(2*wall_thickness),inner_dim_y+(2*wall_thickness),inner_dim_z+wall_thickness], center= true);
            
        Inner_Cube();
        }
    Outer_Shoulder();
    }
}
    
module Inner_Cube(){
    translate ([0,0,wall_thickness/2]) cube ([inner_dim_x,inner_dim_y,inner_dim_z], center= true);
    }
    
module Outer_Shoulder(){
    translate ([0,0,(((inner_dim_z+wall_thickness)/2)-shoulder_height/2)])
    difference(){
        cube ([inner_dim_x+(2*wall_thickness),inner_dim_y+(2*wall_thickness),shoulder_height], center= true);
        cube ([inner_dim_x+wall_thickness,inner_dim_y+wall_thickness,shoulder_height], center= true);
        }
}
    
module Box_Cover(){
    translate([0,-((inner_dim_y+wall_thickness)/2)-10,(cover_height+wall_thickness+spacing_vertical)/2]){
        difference(){
            difference(){
                difference(){
                    cube ([inner_dim_x+(2*wall_thickness)+2*spacing,inner_dim_y+(2*wall_thickness)+2*spacing,cover_height+wall_thickness+spacing_vertical], center= true);
                    translate ([0,0,wall_thickness/2+(cover_height-shoulder_height)/2]) cube ([inner_dim_x+wall_thickness+spacing,inner_dim_y+wall_thickness+spacing,shoulder_height+spacing_vertical], center= true);
                    translate ([0,0,wall_thickness/2]) cube ([inner_dim_x+spacing,inner_dim_y+spacing,cover_height+spacing_vertical], center= true);
                }
                color("red") translate([(inner_dim_x)/2+wall_thickness,0,(cover_height+spacing_vertical)/2+1]) cube([1,14,1.8],center=true);
            }
            color("red") translate([-((inner_dim_x)/2+wall_thickness),0,(cover_height+spacing_vertical)/2+1]) cube([1,14,1.8],center=true);
        }
    }
}

