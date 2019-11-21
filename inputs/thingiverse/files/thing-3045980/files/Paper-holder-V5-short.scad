////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
/// OpenSCAD File version 2015.03-2       ////// 
///           8 - 10 - 2018              //////
///         by Ken_Applications           //////
///                V5.0                   //////
////////////////////////////////////////////////
// v1  original first design
// v2  added optional lip
// v3  made shorter (stubby paper holder)
// v4  made clip lean backwards when free standing on desk but will need stand
// v5  paper entry guide and base

paper_gap=0.5;//[0.2:0.1:0.5]
thickness=20;
grip_end_L1=12;
grip_end_L2=17;
grip_radius=13;


module taper_ring (){
difference(){
 rotate([0,90,0])
 translate([-thickness/2,-grip_radius+sagitta/2,-grip_end_L1/2])
 cylinder(  6, r1=grip_radius-paper_gap,  r2=grip_radius-paper_gap+.1  );

rotate([0,90,0])
 translate([-thickness/2,-grip_radius+sagitta/2,-grip_end_L1/2])
 translate([0,0,-0.1])cylinder(  6.2, r1=grip_radius-6,  r2=grip_radius+paper_gap );
}
}

//taper_ring ();
 

module taper_ring2 (){
difference(){
 rotate([0,90,0])
 translate([-thickness/2,-grip_radius+sagitta/2,-grip_end_L1/2-0.1])
 cylinder(  4.0, r1=grip_radius+paper_gap+2,  r2=grip_radius+paper_gap-1.0  );

rotate([0,90,0])
 translate([-thickness/2,-grip_radius+sagitta/2,-grip_end_L1/2-.2])
 translate([0,0,0])cylinder(  4.4, r1=grip_radius-.1,  r2=grip_radius-.1 );
}
}



module round2d(OR=3,IR=1){
    offset(OR)offset(-IR-OR)offset(IR)children();
}


//////calculate sagitta (cord height)
sagitta=grip_radius-sqrt(grip_radius*grip_radius-(thickness/2)*(thickness/2));
echo (sagitta);

$fn=200;


module spring (){
translate([40,5.1,0]){
difference(){
        dia=11;
    thk=1.3;
 circle(r=dia);
 circle(r=dia-thk*2);
 rotate([0,0,24])   translate([-dia,0,0]) square([dia,dia],false);
}
}
}


module main_shape(){
intersection() {

translate([24,0,0]) circle(3.5);//center pivot
}
translate([0,5,0]) rotate([0,0,12]) square([50,3],false);//back straight
translate([0,-8,0]) rotate([0,0,-12]) square([42,3],false);//front straight
round2d(3,0) square([grip_end_L1,grip_end_L2],true);//grip end shape
translate([50,-2.5,0]) circle( 4  );
translate([45,16.5,0]) circle( 4  );
}


module main_shape_3(){
round2d(0,4.2) main_shape();
    spring ();
}

module main_shape_2(){
linear_extrude(height=thickness)
round2d(1,2){
main_shape_3();
}
}

module ring(){
difference(){
circle(grip_radius);
circle(grip_radius-paper_gap);
}
}


    
 module ring2(){   
rotate([0,90,0])
translate([-thickness/2,-grip_radius+sagitta/2,-grip_end_L1/2-.1])
linear_extrude(height=grip_end_L1+.2) ring();

 }
 
module main_minus_ring(){ 
difference(){
 main_shape_2();
  ring2();
    taper_ring ();
    taper_ring2 ();
   }
}




main_minus_ring();