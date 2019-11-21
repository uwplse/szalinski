//Specify the height
Height = 50 ; // [50:5:100]
//Height for screws
Screwholes = 12.5 ; // [10:0.5:15]

2020_ProfileCombiner ();

module 2020_ProfileCombiner() {
    difference () {
        translate ([0,0,0]) cube ([24,24,Height]);
        translate ([1.80,1.80,-1]) cube ([20.40,20.40,Height+2]);

        translate ([-3,12,Screwholes]) rotate ([0,90,0]) cylinder (d=4.5,h=30);
        translate ([-3,12,Height-Screwholes]) rotate ([0,90,0]) cylinder (d=4.5,h=30);
        translate ([12,-3,Screwholes]) rotate ([-90,0,0]) cylinder (d=4.5,h=30);
        translate ([12,-3,Height-Screwholes]) rotate ([-90,0,0]) cylinder (d=4.5,h=30);

    }
    difference() {
        union () {
            translate ([9,0,0]) cube ([6,2.25,Height]);
            translate ([9,24-2.25,0]) cube ([6,2.25,Height]);
            translate ([0,9,0]) cube ([2.25,6,Height]);
            translate ([24-2.25,9,0]) cube ([2.25,6,Height]);
        }
        translate ([-3,12,Screwholes]) rotate ([0,90,0]) cylinder (d=4.5,h=30);
        translate ([-3,12,Height-Screwholes]) rotate ([0,90,0]) cylinder (d=4.5,h=30);
        translate ([12,-3,Screwholes]) rotate ([-90,0,0]) cylinder (d=4.5,h=30);
        translate ([12,-3,Height-Screwholes]) rotate ([-90,0,0]) cylinder (d=4.5,h=30);
    }
}
