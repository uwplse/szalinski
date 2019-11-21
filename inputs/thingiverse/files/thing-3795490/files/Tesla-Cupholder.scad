$fn = 150;
difference(){
cylinder (76.2,d1=69.6, d2=76.0);
    translate ([10,19,25]) cylinder (80, d=27);
    translate ([-10,19,25]) cylinder (80, d=27);
    translate ([24,-3,15]) cylinder (80, d=19);   //18650 No.1
    translate ([-24,-3,15]) cylinder (80, d=19);   //18650 No.2
    translate ([-0,-18,5]) cylinder (80, d=32);  //Liquid
}