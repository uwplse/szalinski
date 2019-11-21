$fn = 150;
difference(){
cylinder (76.2,d1=74.6, d2=80.0);
    //translate ([9,19,25]) cylinder (80, d=28);  // Mod part 1
    //translate ([-9,19,25]) cylinder (80, d=28); // Mod part 2
    translate ([0,9,50]) cube([57, 27.5, 80], center=true); // Mod part 3
    //translate ([24,-3,15]) cylinder (80, d=22); //18650 No.1
    translate ([-12,-20,5]) cylinder (80, d=23); //Liquid
    translate ([12,-20,5]) cylinder (80, d=22); //Liquid
    translate ([12,-20,45]) cube([6, 25, 80], center=true); // Mod part 3
}