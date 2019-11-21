
// How long should the body be?
body_length = 70; // [1:200]

// How big around should the body be?
body_radius=27; // [1:100]

// How thick should the entire Cord Guard be?
thickness=2;   // [1:10]

// How long should the cones between the body and the tip be?
end_length=20;  // [1:80]

//How long should the ends protrude?
tip_length=10;  // [1:40]

// How big around should the end parts be? 
tip_radius=9;   // [1:40]


difference (){
union () {
   difference(){
     cylinder (h=body_length, r=body_radius);
     cylinder (h=body_length+10, r=body_radius-thickness);
       
   }
   
   rotate ([0,0,0]) translate ([0,0,body_length])
   difference () {
     union (){
       cylinder (h=end_length, r1=body_radius, r2=tip_radius);
       translate ([0,0,end_length]) cylinder (h=tip_length, r=tip_radius);
       translate ([0,0,end_length+tip_length-thickness])cylinder (h=thickness, r=tip_radius+thickness);
     }
     union () {
       translate ([0,0,-2]) cylinder (h=end_length, r1=body_radius, r2=tip_radius);
       cylinder (h=end_length+tip_length, r=tip_radius-thickness);
     }
   }
   
   rotate ([180,0,0]) translate ([0,0,0])
   difference () {
     union (){
       cylinder (h=end_length, r1=body_radius, r2=tip_radius);
       translate ([0,0,end_length]) cylinder (h=tip_length, r=tip_radius);
       translate ([0,0,end_length+tip_length-thickness])cylinder (h=thickness, r=tip_radius+thickness);
     }
     union () {
       translate ([0,0,-2]) cylinder (h=end_length, r1=body_radius, r2=9);
       cylinder (h=end_length+tip_length, r=tip_radius-thickness);
     }
   }
   
   }
rotate ([0,-90,0]) translate ([-end_length-tip_length-1, -body_radius,0 ])
cube ([end_length*2+tip_length*2+ body_length+2, 
   body_radius*2, body_radius]);
   
   }
   
   rotate ([0,-90,0]) 
   translate ([0, body_radius-thickness*2,-thickness*2])
   cube ([body_length, thickness, thickness*3]);