//Specify the height
Height = 25 ; // [1:1:500]
//Specify the inner diameter
InnerDiameter = 6 ; // [5:1:8]

3030_Profile ();
module 3030_Profile() {
    color ("silver")
    difference () {
        translate ([0,0,0]) cube ([30,30,Height]);
        translate ([15,15,-1]) cylinder(d=InnerDiameter,h=+Height+2);

        3030_ProfileCutOut (Height=Height);
        mirror ([1,0,0]) rotate ([0,0,90]) 3030_ProfileCutOut (Height=Height);
        translate ([0,30,0]) mirror ([0,1,0]) 3030_ProfileCutOut (Height=Height);
        translate ([30,30,0]) rotate ([0,0,-90]) mirror ([0,1,0]) 3030_ProfileCutOut (Height=Height);

    }
}
module 3030_ProfileCutOut () {    
    color ("silver")
    union () {
        translate ([15-3.25,-0.5,-1]) cube ([6.5,6,Height+2]);
        hull () {
            translate ([15-6.25,1.35,-1]) cube ([12.5,1,Height+2]);
            translate ([15-3,5,-1]) cube ([6,1,Height+2]);
        }
    }
}