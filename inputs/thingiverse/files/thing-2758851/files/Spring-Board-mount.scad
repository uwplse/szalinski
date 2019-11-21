////////////////////////////////////////////////
//  Parametric circuit board mount  ////////////
////////////////////////////////////////////////
/// OpenSCAD File V1.0 by Ken_Applications /////
/////////  OpenSCAD version 2015.03-2 //////////
////////       16 - 12 - 2018              /////
////////////////////////////////////////////////


//Parameters/////
x_dimension=34.3;
y_dimension=61.3;
spring_height=2;
gap_under_board=2.5;
corner_support=0; // [1=support 0=no support]
board_thickness=2.5;

///// Tab parameters ////////
Tab_Width=11;
fixing_hole_size=4;
chamfer=1; // [1=chamfer  0= no chamfer]

///////////////////////////////////////////////
Tab_Height=spring_height;

//calculations//
y_thick=y_dimension/16;
x_straight=x_dimension-(4*y_thick);
hgt_with_gap=spring_height+gap_under_board+board_thickness*2;
gap_with_spring=gap_under_board+spring_height;
//////////////////////////////////////////////////////////////
//insert tabs
translate([0,-(y_dimension/2)-Tab_Width/2,0]) tab();
translate([0,+(y_dimension/2)+Tab_Width/2,0]) rotate([0,0,180]) tab();

spring_mount ();


module spring_mount (){
difference(){
union(){
linear_extrude(height=spring_height) 5bends();
if (corner_support==1)  {translate([-x_dimension/2,-y_dimension/2,0]) holes_grid(2,2,x_dimension,y_dimension,y_thick*4,gap_with_spring);}
  
if (corner_support==0)  {translate([-x_dimension/2,-y_dimension/2,0]) holes_grid(2,2,x_dimension,y_dimension,y_thick*4,gap_with_spring-gap_under_board);}
  
    
translate([-x_dimension/2,-y_dimension/2,0]) holes_grid(2,2,x_dimension,y_dimension,y_thick*2,hgt_with_gap);
}

//The board
#translate([0,0,(board_thickness/2)+gap_under_board+spring_height+0.15]) cube([x_dimension+0.3,y_dimension,board_thickness],true);
}
}


 

$fn=100;
$vpr = [60, 0, 345];//cnc view point
//$vpd=(360);


module holes_grid (holesX,holesY,X_Space,Y_Space,holeDiameter,thickness,){
      for (i=[0:holesX-1]) {
        for (j=[0:holesY-1]) {
	 	translate([X_Space*i,Y_Space*j,-.1]) cylinder(d=holeDiameter,h=thickness+0.2);
    }
  }
}


module c_shape(c_thick,straight_len){
difference(){ 
    union(){
    difference(){
        circle(c_thick*2);
       translate([c_thick*3,0,0]) square([c_thick*6,c_thick*6],true) ;
    }  
    translate([straight_len/2,0,0]) square([straight_len,c_thick*4],true);
    }

circle(c_thick);
    translate([(straight_len/2)+0.1,0,0]) square([straight_len+.2,c_thick*2],true);
}

}



module 5bends(){
translate([-(x_dimension/2)+2*y_thick,0,0]){
c_shape(y_thick,x_straight);
translate([x_straight,y_thick*3,0]) rotate([0,0,180]) c_shape(y_thick,x_straight);
translate([x_straight,-y_thick*3,0]) rotate([0,0,180]) c_shape(y_thick,x_straight);
translate([0,y_thick*6,0]) rotate([0,0,0]) c_shape(y_thick,x_straight);
translate([0,-y_thick*6,0]) rotate([0,0,0]) c_shape(y_thick,x_straight);
translate([y_thick+x_straight,(y_dimension/2)-y_thick/2,0]) square([y_thick*2,y_thick],true);   
translate([y_thick+x_straight,-(y_dimension/2)+y_thick/2,0]) square([y_thick*2,y_thick],true);   
}
}



module tab (){
  
difference(){
union(){
linear_extrude(height=Tab_Height) circle(Tab_Width/2,$fn=60);
translate([-Tab_Width/2,0,0]) cube([Tab_Width,Tab_Width/2,Tab_Height],false);
}
cylinder(h=Tab_Height*3, d1=fixing_hole_size, d2=fixing_hole_size, center=true,$fn=60);

if (chamfer==1)  {
translate([0,0,Tab_Height-(fixing_hole_size/2)+.1]) cylinder(h=fixing_hole_size/2, d1=fixing_hole_size, d2=fixing_hole_size+4, center=false,$fn=60);
}

}
}