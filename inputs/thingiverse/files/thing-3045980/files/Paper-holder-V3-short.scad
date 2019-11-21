////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
/// OpenSCAD File version 2015.03-2       ////// 
///           29 - 09 - 2018              //////
///         by Ken_Applications           //////
///                V3.0                   //////
////////////////////////////////////////////////
// v1  original first design
// v2  added optional lip
// v3  made shorter (stubby paper holder)

paper_gap=0.2;//[0.2:0.1:0.5]
thickness=20;
grip_end_L1=20;
grip_end_L2=17;
grip_radius=13;

//guide lip helps paper locate
add_lip=0;// [0,1]


module round2d(OR=3,IR=1){
    offset(OR)offset(-IR-OR)offset(IR)children();
}


//////calculate sagitta (cord height)
sagitta=grip_radius-sqrt(grip_radius*grip_radius-(thickness/2)*(thickness/2));
echo (sagitta);

$fn=200;

//$vpd=(350);//1:1 scale for my screen

module spring (){
translate([45,5.1,0]){
difference(){
        dia=12;
    thk=1.3;
 circle(r=dia);
 circle(r=dia-thk*2);
 rotate([0,0,24])   translate([-dia,0,0]) square([dia,dia],false);
}
}
}





module main_shape(){
intersection() {

translate([24,0,0]) circle(3.9);//spring radius .. need to calculate
}
translate([0,5,0]) rotate([0,0,12]) square([60,3],false);//back straight
translate([0,-8,0]) rotate([0,0,-12]) square([60,3],false);//front straight


round2d(,0) square([grip_end_L1,grip_end_L2],true);//grip end shape


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
//main_shape_2();

module ring(){
difference(){
circle(grip_radius);
circle(grip_radius-paper_gap);
}
}

//ring2();


module ring3(){
    rotate([0,90,0])
    translate([-thickness/2,-grip_radius+sagitta/2,-grip_end_L1/2-.1])
linear_extrude(height=5)

difference(){
 circle(grip_radius+2);
circle(grip_radius);
}
}


//ring3();
    
 module ring2(){   
rotate([0,90,0])
translate([-thickness/2,-grip_radius+sagitta/2,-grip_end_L1/2-.1])
linear_extrude(height=grip_end_L1+.2) ring();

 }
 
module main_minus_ring(){ 
difference(){
 main_shape_2();
  ring2();
   }
}


module all_plus_ring(){

main_minus_ring();
}
 


all_plus_ring();

if (add_lip==1)  {
translate([-3,0,0])
intersection(){
all_plus_ring();
ring3();
}
}



