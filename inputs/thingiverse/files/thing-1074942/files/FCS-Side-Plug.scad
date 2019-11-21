////////////////////////////////////////
///////// VARIABLES
////////////////////////////////////////


cylinder_diameter = 28; //[20:0.2:40]
cylinder_depth_outer = 22; //[15:0.2:40]

cylinder_diameter_cut = 24; //[10:0.2:40]
cylinder_depth_cut = 3.5; //[0:0.2:15]

inner_cube_length = 16; //[14:0.2:24]
inner_cube_width = 6.5; //[5.5:0.1:8]
inner_cube_depth = 23;  //[18:0.2:30]

poly_variable = 4*1;

locating_width = 3; //[1.5:0.5:5]
locating_length = 38;   //[0:1:50]

grub_diameter = 3.5;    //[2:0.2:5]
grub_height = 22;   //[0:0.5:40]

fin_cant = 5; //[-15:0.5:15]

////////////////////////////////////////
///////// RENDER
////////////////////////////////////////

//Final
union(){
complete_housing();
grub_flush();
}

////////////////////////////////////////
///////// FUNCTIONS
////////////////////////////////////////
module bigger_flush_cut(){
    translate([9.5, 0,9.5]){
    scale([1.1, 1.1, 1]){
    grub_hole_cut();
    }
}
}
module grub_flush(){
    difference(){
    difference(){
    translate([(cylinder_diameter/2)*0.9, 0, (cylinder_depth_outer/2)-(cylinder_depth_cut/2)]){
    cylinder(h = cylinder_depth_cut, d = grub_diameter*2, center = true, $fn = 30);
}

inner_recess();
}
//HERE
bigger_flush_cut();

}
} 
module grub_hole_cut(){
    translate([8.5, 0, 7]){
    rotate( a = 45, v = [0,1,0]){
    cylinder(h = grub_height, d = grub_diameter, center = true, $fn = 30);
    }
}

}

module locating_pins(){
    $fn = 34;
    translate([0,(locating_length/2)-(locating_width/2),(cylinder_depth_outer/2-(locating_width))]){
    sphere(r =locating_width*.5);
    }

}

module locating_arms(){
    difference(){
    translate([0,0,(cylinder_depth_outer/2-(3.5/2))]){
    cube([locating_width,locating_length,3.5],center=true);
    }
   
    inner_recess();
}

locating_pins();
mirror([0,1,0]){
    locating_pins();
}

}
module all_cuts(){ 
    side_cuts();
    mirror([1,0,0]){
        side_cuts();}
}

module side_cuts(){
    side_cut();
    mirror([0,1,0]){side_cut();}
}


module side_extras(){
    translate([cylinder_diameter/2,0,(-cylinder_depth_outer/2)-5]){
cylinder(h=cylinder_depth_outer*0.75, r1=2, r2=2, center=false);    
    }
    
    translate([cylinder_diameter/2,0,0]){
        resize([9,12,5]){
sphere(d=10);    
    }    
}
}

module side_cut(){

linear_extrude(height=cylinder_depth_outer*0.65, scale=[2.4,0.7], slices=45, twist=0, center = true)
 polygon(points=[[inner_cube_length/2,inner_cube_length/2], [poly_variable,cylinder_diameter/2],[cylinder_diameter/2,poly_variable]]);
    
    //side_extras();
}

module complete_housing(){
difference(){
difference(){
union(){
difference(){
difference(){    
    difference(){

        outer_housing();
        inner_recess();
        }
    plug_space();
    }    
    all_cuts();
    
}

locating_arms();
}

grub_hole_cut();

}
//HERE


bigger_flush_cut();
}
}

module plug_space(){
    rotate(-fin_cant, [0,1,0]){
cube([inner_cube_width, inner_cube_depth, inner_cube_length], center = true);
// inner_cube_width
}
}


module outer_housing(){
$fn = 100;
cylinder (h = cylinder_depth_outer, d = cylinder_diameter, center = true);
    
}

module inner_recess(){
$fn = 100;    
translate([0,0,(cylinder_depth_outer/2)-(cylinder_depth_cut/2)]){
    color("red") 
    cylinder (h = cylinder_depth_cut, d = cylinder_diameter_cut, center = true);    
}    
}