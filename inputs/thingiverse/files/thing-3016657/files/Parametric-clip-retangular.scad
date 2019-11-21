

length_1=52.2;
length_2=10.2;
Thickness=6;
height=12;
hole_dia=4;


module round2d(OR=3,IR=1){
    offset(OR)offset(-IR-OR)offset(IR)children();
}

$fn=100;
module clip(){
linear_extrude(height=height){
    fillet=Thickness/2.85;
round2d(OR=fillet,IR=fillet){
translate([-length_1/2-Thickness,0,0]) square([length_1+Thickness+Thickness,Thickness],false);
translate([length_1/2,-length_2,0]) square([Thickness,length_2],false);    
translate([-length_1/2-Thickness,-length_2,0]) square([Thickness,length_2],false);  
translate([-length_1/2-Thickness,-length_2-Thickness,0]) square([Thickness*1.5,Thickness],false);  
translate([+length_1/2-Thickness/2,-length_2-Thickness,0]) square([Thickness*1.5,Thickness],false);  
}
}
}




difference(){
clip();
rotate([90,0,0]) translate([length_1/4,height/2,-Thickness*2-Thickness/2]) cylinder(  Thickness*4, d1=hole_dia,  d2=hole_dia  );
    rotate([90,0,0]) translate([-length_1/4,height/2,-Thickness*2-Thickness/2]) cylinder(  Thickness*4, d1=hole_dia,  d2=hole_dia  );
    
rotate([90,0,0]) translate([length_1/4,height/2,-hole_dia/2.39]) cylinder(  hole_dia/2.38, d1=hole_dia,  d2=hole_dia*2  );


rotate([90,0,0]) translate([-length_1/4,height/2,-hole_dia/2.39]) cylinder(  hole_dia/2.38, d1=hole_dia,  d2=hole_dia*2  );



    
    
    
}