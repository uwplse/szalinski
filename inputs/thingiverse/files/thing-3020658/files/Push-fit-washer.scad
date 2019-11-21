////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
/// OpenSCAD File version 2015.03-2       ////// 
///           26 - 07 - 2018              //////
///         by Ken_Applications           //////
///                V1.0                   //////
////////////////////////////////////////////////



//...The diameter you want to grip  [Default 10]
Inner_dia=10;// [5:0.5:26]

//...The larger the width the stronger the clip [Default 8]
//...Must be bigger than 5
width=8; // [5,6,7,8,9,10,11,12,13,14,15,16]


//...The smaller the grip_angle the stronger the push fit [Default 45]
grip_angle=45;// [30:1:60]

//...Washer thickness
washer_thickness=1.2;










outter_dia=Inner_dia+width;
//#circle(Inner_dia/2-.05);
mid_point=((outter_dia-Inner_dia)/2);
rrad=(mid_point/2)-0.001;
$fn=200;


module the_washer(){
difference(){
circle(outter_dia/2);//radius
circle(Inner_dia/2);
}
}

module tri_1 (){
hull(){
circle(0.05);
rotate([0,0,-grip_angle]) translate([0,-outter_dia*20,0]) circle(.3);
rotate([0,0,grip_angle]) translate([0,-outter_dia*20,0]) circle(.3);
}
}


module tri_2 (){
hull(){
circle(Inner_dia/10);
rotate([0,0,-30]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
rotate([0,0,-45]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
rotate([0,0,-60]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
}
}

module tri_3 (){
hull(){
circle(Inner_dia/10);
rotate([0,0,30]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
rotate([0,0,45]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
rotate([0,0,60]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
}
}
module circlip(){
round2d(OR=rrad,IR=0){
difference(){
the_washer();
tri_1 ();
//tri_2 ();  
//tri_3 ();     
}
}
}

module e_circlip(){
round2d(OR=0.5,IR=Inner_dia/10){
difference(){
circlip();
    tri_2 ();
    tri_3 ();
}
}
}


module round2d(OR,IR){
    offset(OR)offset(-IR-OR)offset(IR)children();
}




linear_extrude(height=washer_thickness){
e_circlip();
}