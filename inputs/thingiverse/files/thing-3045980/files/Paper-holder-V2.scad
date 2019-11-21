////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
/// OpenSCAD File version 2015.03-2       ////// 
///           31 - 08 - 2018              //////
///         by Ken_Applications           //////
///                V2.0                   //////
////////////////////////////////////////////////




Alter_spring_gap=4;//[0:1:7]
paper_gap=0.2;//[0.2:0.1:0.5]
thickness=20;
grip_end_L1=20;
grip_end_L2=17;
grip_radius=13;

//guide lip helps paper locate
add_lip=1;// [0,1]


module round2d(OR=3,IR=1){
    offset(OR)offset(-IR-OR)offset(IR)children();
}


//////caculate sagitta (cord height)
sagitta=grip_radius-sqrt(grip_radius*grip_radius-(thickness/2)*(thickness/2));
echo (sagitta);

$fn=200;

//$vpd=(350);//1:1 scale for my screen





module main_shape(){
intersection() {
round2d(0.8,16){
translate([0,5,0]) rotate([0,0,12]) square([100,3],false);
translate([0,-8,0]) rotate([0,0,-12]) square([100,3],false);
}
translate([53.6,0,0]) circle(19);//spring radius .. need to calculate
}
translate([0,5,0]) rotate([0,0,12]) square([85,3],false);//back straight
translate([0,-8,0]) rotate([0,0,-12]) square([69,3],false);//front straight
round2d(3,0) square([grip_end_L1,grip_end_L2],true);//grip end shape
}

module main_shape_3(){
round2d(0,4) main_shape();
}

module main_shape_2(){
linear_extrude(height=thickness)
round2d(1,0){
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


module stand(){   
round2d(1.5,12){
translate([84,24,0]) rotate([0,0,-0-75]) square([33,3],false);//bottom straight
translate([56,-4.5-Alter_spring_gap,0]) rotate([0,0,-6]) square([46,3.5],false);
translate([62,-5-Alter_spring_gap,0])   circle(3.1);//narrow gap with circle
translate([87,24,0])   circle(5.5);//back foot
    
translate([74,23,0])   circle(1.1);//back blend    
translate([97.7,-10,0])   circle(5.6); //front foot 
      
}
}

module all(){
difference(){
    
linear_extrude(height=thickness) stand();
//stand();

translate([97.7,-10,-1])   linear_extrude(height=thickness+2) circle(3.5); //front foot 
  
translate([87,24,-1])  linear_extrude(height=thickness+2) circle(3.5);//back foot
}
}

module all_plus_ring(){
all();
main_minus_ring();
}
 

//projection(cut = true) all_plus_ring();

module all_plus_ring_penholder(){
difference(){
 all_plus_ring();
//below pen holder / counter balance weight
translate([86,20,thickness/2]) rotate([90,0,-15]) cylinder( 50,d1=5,d2=15);
   
}
}

//projection(cut = true) all_plus_ring();
//all_plus_ring_penholder();
all_plus_ring();

if (add_lip==1)  {
translate([-3,0,0])
intersection(){
all_plus_ring();
ring3();
}
}



