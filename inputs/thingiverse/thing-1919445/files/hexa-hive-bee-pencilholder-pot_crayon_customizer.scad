//radius of hex
radius = 20 ;

//shell thickness
shell_thickness =0.84 ;

//height of central hex
central_hex_height = 90 ;

//height of North East hex
NE_hex_height = 60 ;

//height of North hex
N_hex_height = 35 ;

//height of North West hex
NW_hex_height = 75 ;

//height of South West hex
SW_hex_height = 80 ;

//height of South hex
S_hex_height = 80 ;

//height of South East hex
SE_hex_height = 80 ;



module pot_hexa(h,r,shell) {
	difference (){
        cylinder(h,r,r,$fn=6);  
        translate([0,0,shell])
        cylinder(h,r-shell,r-shell,$fn=6);
}
};



module marguerite(h,r,shell,face1,face2,face3,face4,face5,face6) {

//centre    
    pot_hexa(h,r+shell_thickness/2,shell) ;

if (face1>0) {
    translate([3/2*r,r*sqrt(3)/2,0])
    pot_hexa(face1,r+shell_thickness/2,shell) ;
}

if (face2>0) {
    translate([00,sqrt(3)*r,0])
    pot_hexa(face2,r+shell_thickness/2,shell) ;
}
if (face3>0) {
    translate([-3/2*r,r*sqrt(3)/2,0])
    pot_hexa(face3,r+shell_thickness/2,shell) ;
}

if (face4>0) {
    translate([00,-sqrt(3)*r,0])
    pot_hexa(face4,r+shell_thickness/2,shell) ;
}
if (face5>0) {
    translate([-3/2*r,-r*sqrt(3)/2,0])
    pot_hexa(face5,r+shell_thickness/2,shell) ;
}

if (face6>0) {
    translate([3/2*r,-r*sqrt(3)/2,0])
    pot_hexa(face6,r+shell_thickness/2,shell) ;
}
    }

marguerite(central_hex_height,radius,shell_thickness,NE_hex_height,N_hex_height,NW_hex_height,SW_hex_height,S_hex_height,SE_hex_height) ;
