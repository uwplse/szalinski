/*
Adjustable Motor Mount
    -by Harlo
    -27/04/2016

A universal, configurable motor mount
for attaching electric RC motors to
planes etc. at 90 degrees.
*/

//Wall thickness/Edge Diameter
wall_thickness = 3; //[1:0.25:10]
//Edge 'Smoothness' -- higher is smoother
wall_res = 32; //[20:2:60]
//Size of the brackets back plate dimensions (YZ)
cube_yz = 30; //[11:0.5:150]
//Size of the brackets length (X)
cube_x = 40; //[11:0.5:150]
//Propellor Shaft - Max Diameter (at back)
prop_shaft_dia = 7; //[0:0.5:20]
//Propellor Fixing Screws Diameter
prop_screw_dia = 3.55; //[2:0.25:10]
//Propellor Retainer Slide Length
prop_screw_slide_length = 4; //[0:0.5:10]
//Propellor Fixing Screw Seperation -- center to center
prop_screw_seperation = 19; //[5:0.5:30]
//Rotation of Fixing Screw Holes (degrees)
prop_mount_rotation = 45; //[0:None, 45:Easier_Printing]

//Retaining Screw Diameter
retain_screw_dia = 3.8; //[0:0.25:10]
//Retaining Screw Slide Length
retain_screw_slide = 8; //[0:0.5:10]
//Retaining Screw X Seperation
retain_screw_x_seperation = 18; //[0:0.5:120]
//Retaining Screw Y Seperation 
retain_screw_y_seperation = 16; //[0:0.5:120]
//Rotation of Retaining Screw Holes
retain_screws_rotation = 0; //[0:Slides_Forwards, 90:Slides_Sideways]


///Internal Variables
plate_offset = (cube_yz/2) - (wall_thickness/2); // internal calculation for placing seperate pieces
plate_offset_x = (cube_x/2) - (wall_thickness/2);


    final_unit();



module final_unit(){
difference(){
    solid_bracket();
    cut_side_circles();
    cut_prop_mount();
    rotate([0,0,retain_screws_rotation]){
    cut_screw_mount();
    }
}
}


module cut_screw_mount(){

    mount_screw_slide(retain_screw_x_seperation/2, retain_screw_y_seperation/2, retain_screw_slide);
    
    mount_screw_slide(retain_screw_x_seperation/2, -retain_screw_y_seperation/2, retain_screw_slide);
    
    mount_screw_slide(-retain_screw_x_seperation/2, retain_screw_y_seperation/2, retain_screw_slide);
    
    mount_screw_slide(-retain_screw_x_seperation/2, -retain_screw_y_seperation/2, retain_screw_slide);

}

module cut_prop_mount(){
rotate([prop_mount_rotation,0,0]){
screw_slide_hole(0);
screw_slide_hole(90);
screw_slide_hole(180);
screw_slide_hole(270);    
}
    rotate([0,90,0]){
        cylinder ( h = cube_yz + cube_x +2, d = prop_shaft_dia, center = true, $fn = prop_shaft_dia * 8);
    }
    
}

//added wall thickness variable in this module
module mount_screw_slide(x_pos, y_pos, slide_in_mm){
hull(){    
    translate([x_pos + slide_in_mm/2 - wall_thickness/2,y_pos,0]){
        cylinder(h = cube_yz + cube_x +2, d = retain_screw_dia, center = true, $fn = retain_screw_dia * 8);
    }
    
    translate([x_pos - slide_in_mm/2 - wall_thickness/2,y_pos,0]){
        cylinder(h = cube_yz + cube_x +2, d = retain_screw_dia, center = true, $fn = retain_screw_dia * 8);
    }
}
}


module screw_slide_hole(rotation){
    rotate([rotation,0,0]){
translate([0,0,prop_screw_seperation/2]){
    hull(){
    //positive z pos
    translate([0,0,prop_screw_slide_length/2]){
        rotate([0,90,0]){
            cylinder (h = cube_yz + cube_x +2, d = prop_screw_dia, center = true, $fn = prop_screw_dia * 8);
        }
    }
    //negative z pos
    translate([0,0,-prop_screw_slide_length/2]){
        rotate([0,90,0]){
            cylinder (h = cube_yz + cube_x +2, d = prop_screw_dia, center = true, $fn = prop_screw_dia * 8);
        }
    }
}
}
}
}

module solid_bracket(){
    union(){
    back_plate();
    side_plate();
    mirror([0,1,0]){
        side_plate();
    }
    bottom_plate();
}
}


module cut_side_circles(){
    
    circle_dia = (cube_yz-(wall_thickness*3))/2;
    
    translate([(cube_x/2) - (wall_thickness*1.5 + circle_dia/2),0,-((cube_yz)/4 - wall_thickness/2)]){
    rotate([90,0,0]){
        cylinder (h = cube_yz + 2, d = circle_dia, center = true, $fn = cube_yz * 8);
    }
}
}

//FROM HERE
module back_plate(){
        hull(){
            //Bottom left
            translate([plate_offset_x,-plate_offset,- plate_offset]){
                sphere(d = wall_thickness, center = true, $fn = wall_res);
            }
            //Bottom right
            translate([plate_offset_x,plate_offset,- plate_offset]){
                sphere(d = wall_thickness, center = true, $fn = wall_res);
            }
            //Top left
            translate([plate_offset_x,-plate_offset, plate_offset]){
                sphere(d = wall_thickness, center = true, $fn = wall_res);
            }
            //Top right
            translate([plate_offset_x,plate_offset, plate_offset]){
                sphere(d = wall_thickness, center = true, $fn = wall_res);
            }
            
        }
}

module bottom_plate(){
    hull(){
            //Bottom left
            translate([plate_offset_x,-plate_offset,- plate_offset]){
                sphere(d = wall_thickness, center = true, $fn = wall_res);
            }
            //Bottom right
            translate([plate_offset_x,plate_offset,- plate_offset]){
                sphere(d = wall_thickness, center = true, $fn = wall_res);
            }
            
            //Front left
            translate([-plate_offset_x,-plate_offset, -plate_offset]){
                sphere(d = wall_thickness, center = true, $fn = wall_res);
            }
            
            //Front right
            translate([-plate_offset_x, plate_offset, -plate_offset]){
                sphere(d = wall_thickness, center = true, $fn = wall_res);
            }
            
    }
    
}

module side_plate(){
    hull()
    {
            //Bottom left
            translate([plate_offset_x,-plate_offset,- plate_offset]){
                sphere(d = wall_thickness, center = true, $fn = wall_res);
            }
            
            //Top left
            translate([plate_offset_x,-plate_offset, plate_offset]){
                sphere(d = wall_thickness, center = true, $fn = wall_res);
            }
            
            //Front left
            translate([-plate_offset_x,-plate_offset, -plate_offset]){
                sphere(d = wall_thickness, center = true, $fn = wall_res);
            }
        
    }
}