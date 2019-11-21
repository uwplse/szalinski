
slot_length=50;
slot_width=6;
pivot_diameter=12;
wall_thickness=4;
linkage_height=3;


module outter_profile (){
round2d(OR=0,IR=pivot_diameter+slot_width+wall_thickness){
translate([-(pivot_diameter+(wall_thickness*2))/2-slot_width/2,0,0]) circle((pivot_diameter+(wall_thickness*2))/2);
hull(){
translate([0,0,0]) circle((slot_width+(wall_thickness*2))/2);
translate([slot_length,0,0]) circle((slot_width+(wall_thickness*2))/2);
}
}
}

$fn=150;
   
module inner_profile (){    
translate([-(pivot_diameter+(wall_thickness*2))/2-slot_width/2,0,0]) circle(pivot_diameter/2);
hull(){
translate([0,0,0]) circle(slot_width/2);
translate([slot_length,0,0]) circle(slot_width/2);
}
}


module round2d(OR=3,IR=1){
    offset(OR)offset(-IR-OR)offset(IR)children();
}

module all(){
difference(){
 outter_profile ();   
  inner_profile ();  
}
}

linear_extrude(height=linkage_height) all();


