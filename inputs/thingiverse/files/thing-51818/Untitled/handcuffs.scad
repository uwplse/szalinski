// left wrist hole adjustment
left_wrist_hole=27; //[23:35]

// right wrist hole adjustment
right_wrist_hole=27; //[23:35]

translate ([0,-40,15])rotate ([0,90,0])union (){
rotate ([0,0,-90])union (){

// below is male latch-top
difference () {union () {translate ([4,-70,-20]) rotate ([0,0,90]) cube ([4,2,25]); translate ([2,-70,-20])rotate ([0,0,90])cube([4,4,8]); translate ([3,-70,-22])cube([4,4,10]); translate ([6,-70,-23])cube([3,4,11]);} translate ([-2,-84,-23])cube([4,2,4]); translate ([6,-73,-35])rotate ([0,-45,0]) cube ([10,15,25]);}

// below is male latch-outer
difference () {union () {translate ([-2,-84,-23])cube([4,6,4]); translate ([-2,-80,-20])rotate ([90,0,0])cube([4,8,4]); translate ([-2,-80,-20])cube ([4,2,25]); translate ([2,-80,-20])rotate ([0,0,90])cube([5,4,8]); } translate ([-7,-90,-31])rotate ([-39,0,0]) cube ([10,5,25]);}

difference () {difference (){union () {  
// below is latch support
scale ([0.3,1,1]) translate ([0,-70,52]) sphere(r=10); scale([0.3,1,1]) translate([0,-70,0])rotate([0,0,90]) cylinder(h=52,r1=10,r2=10);

//below is cross support
scale([0.3,1,1])translate ([0,0,52])rotate([90,90,0]) cylinder (h=70,r1=5,r2=10); 

//below is corner brace 1
translate([-2,-20,30])rotate ([0,90,0])cylinder (h=4,r1=23,r2=23);

//below is corner brace 2
translate([-2,-46,32])rotate ([0,90,0])cylinder (h=4,r1=24,r2=24);

//below is holed swing arm
scale([0.3,1,1])
cylinder(h=52,r1=15,r2=5);
translate([0,0,-3]) scale([0.3,1,1])sphere(r=15); scale([0.3,1,1])
translate([0,0,52]) sphere(r=5);}




//below bores hole in swing arm
rotate([0,90,0]) translate ([0,0,-20])cylinder(h=55,r1=6,r2=6);}

//below is adjustable inner cut
translate([-8,-35,25])rotate ([0,90,0]) scale([1,1.2,.8])cylinder(h=20, r1=left_wrist_hole,r2=27);}
}

//below begins mirrored cuff

translate ([0,35,20]) rotate ([-28.5,180,180])union (){

// below is male latch-top
difference () {union () {translate ([4,-70,-20]) rotate ([0,0,90]) cube ([4,2,25]); translate ([2,-70,-20])rotate ([0,0,90])cube([4,4,8]); translate ([3,-70,-22])cube([4,4,10]); translate ([6,-70,-23])cube([3,4,11]);} translate ([-2,-84,-23])cube([4,2,4]); translate ([6,-73,-35])rotate ([0,-45,0]) cube ([10,15,25]);}

// below is male latch-outer
difference () {union () {translate ([-2,-84,-23])cube([4,6,4]); translate ([-2,-80,-20])rotate ([90,0,0])cube([4,8,4]); translate ([-2,-80,-20])cube ([4,2,25]); translate ([2,-80,-20])rotate ([0,0,90])cube([5,4,8]); } translate ([-7,-90,-31])rotate ([-39,0,0]) cube ([10,5,25]);}

difference () {difference (){union () {  
// below is latch support
scale ([0.3,1,1]) translate ([0,-70,52]) sphere(r=10); scale([0.3,1,1]) translate([0,-70,0])rotate([0,0,90]) cylinder(h=52,r1=10,r2=10);

//below is cross support
scale([0.3,1,1])translate ([0,0,52])rotate([90,90,0]) cylinder (h=70,r1=5,r2=10); 

//below is corner brace 1
translate([-2,-20,30])rotate ([0,90,0])cylinder (h=4,r1=23,r2=23);

//below is corner brace 2
translate([-2,-46,32])rotate ([0,90,0])cylinder (h=4,r1=24,r2=24);

//below is holed swing arm
scale([0.3,1,1])
cylinder(h=52,r1=15,r2=5);
translate([0,0,-3]) scale([0.3,1,1])sphere(r=15); scale([0.3,1,1])
translate([0,0,52]) sphere(r=5);}




//below bores hole in swing arm
rotate([0,90,0]) translate ([0,0,-20])cylinder(h=55,r1=6,r2=6);}

//below is adjustable inner cut
translate([-8,-35,25])rotate ([0,90,0]) scale([1,1.2,.8])cylinder(h=20, r1=right_wrist_hole,r2=27);}
}

//female latch section #1
rotate ([0,-26.5,0])union () {translate ([0,10,-7]) rotate ([180,180,0]) union () {cube ([65,5,15]);
translate ([0,15,0])cube ([65,5,15]);
translate ([53,20,-14]) rotate ([90,0,0]) cube ([11,20,20]);
translate ([0,-9,7])rotate ([0,90,90])cylinder (h=30,r1=5.5,r2=5.5);}

//below is cutouts for #1 latches
difference (){scale([1,0.3,1]) translate([-70,0,0])rotate([0,180,90]) cylinder(h=21,r1=10,r2=10);
union (){translate ([-2,1,17])difference (){ 
translate ([-71,-4,-35])rotate ([0,0,0])union (){cube ([8, 1, 20]);cube ([8,6,6]);} translate ([-72,1,-44.5])rotate ([45,0,0])cube (10);}
translate ([-8,0,34])difference (){translate ([-2,1,-47]) 
translate ([-71,-4,-5])rotate ([0,0,0])union (){translate ([0,1,-10])cube ([3, 40, 45]); cube ([8,6,6]);} translate ([-72,-4,-53])rotate ([0,39,0])cube (10);}}}}

//female latch section #2
translate ([0,34.9,20]) rotate ([180,26,-90]) union () {translate ([0,10,-7]) rotate ([180,180,0]) union () {cube ([65,5,15]);
translate ([0,15,0])cube ([65,5,15]);
translate ([53,20,-14]) rotate ([90,0,0]) cube ([11,20,20]);
translate ([0,-5,7])rotate ([0,90,90])cylinder (h=30,r1=5.5,r2=5.5);}

//below is cutouts for #2 latches
difference (){scale([1,0.3,1]) translate([-70,0,0])rotate([0,180,90]) cylinder(h=21,r1=10,r2=10);
union (){translate ([-2,1,17])difference (){ 
translate ([-71,-4,-35])rotate ([0,0,0])union (){cube ([8, 1, 20]);cube ([8,6,6]);} translate ([-72,1,-44.5])rotate ([45,0,0])cube (10);}
translate ([-8,0,34])difference (){translate ([-2,1,-47]) 
translate ([-71,-4,-5])rotate ([0,0,0])union (){translate ([0,1,-10])cube ([3, 40, 45]); cube ([8,6,6]);} translate ([-72,-4,-53])rotate ([0,39,0])cube (10);}}}}
}

