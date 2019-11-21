

length_1=17;
length_2=3.6;
Thickness=0.9;
height=35;
hole_dia=4;
standoff=3;

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
    
 translate([-(length_1*0.8/2),0,0]) square([length_1*0.8,standoff]);   
    
}
}
}




difference(){
clip();

    rotate([90,0,0]) translate([0,height/4,-Thickness*37-Thickness/2]) cylinder(  Thickness*38, d1=hole_dia,  d2=hole_dia  );
rotate([90,0,0]) translate([0,height/4,-hole_dia/2.39]) cylinder(  hole_dia/2.38, d1=hole_dia,  d2=hole_dia*2  );


    rotate([90,0,0]) translate([0,height/2+height/4,-Thickness*37-Thickness/2]) cylinder(  Thickness*38, d1=hole_dia,  d2=hole_dia  );
rotate([90,0,0]) translate([0,height/2+height/4,-hole_dia/2.39]) cylinder(  hole_dia/2.38, d1=hole_dia,  d2=hole_dia*2  );
  
    
}


