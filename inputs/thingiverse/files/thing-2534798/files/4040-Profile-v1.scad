//Specify the height
Height = 25 ; // [1:1:500]
//Specify the inner diameter
InnerDiameter = 6 ; // [5:1:6]

4040_Profile ();
module 4040_Profile() {
    color ("silver")
    difference () {
        translate ([0,0,0]) cube ([40,40,Height]);
        translate ([10,10,-1]) cylinder(d=InnerDiameter,h=+Height+2);
        translate ([10,30,-1]) cylinder(d=InnerDiameter,h=+Height+2);
        translate ([20,20,-1]) cylinder(d=InnerDiameter,h=+Height+2);
        translate ([30,10,-1]) cylinder(d=InnerDiameter,h=+Height+2);
        translate ([30,30,-1]) cylinder(d=InnerDiameter,h=+Height+2);

        translate ([0,0,0]) 4040_ProfileCutOut (Height=Height);             //bottom left
        translate ([20,0,0]) 4040_ProfileCutOut (Height=Height);            //bottom right

        translate ([0,0,0]) mirror ([1,0,0]) rotate ([0,0,90]) 4040_ProfileCutOut (Height=Height); //leftside bottom
        translate ([0,20,0]) mirror ([1,0,0]) rotate ([0,0,90]) 4040_ProfileCutOut (Height=Height); //leftside top
        
        *translate ([0,20,0]) mirror ([0,1,0]) 4040_ProfileCutOut (Height=Height);
        
        translate ([40,20,0]) rotate ([0,0,-90]) mirror ([0,1,0]) 4040_ProfileCutOut (Height=Height); //rightside bottom
        translate ([40,40,0]) rotate ([0,0,-90]) mirror ([0,1,0]) 4040_ProfileCutOut (Height=Height); //rightside top 

        *translate ([0,20,0]) 4040_ProfileCutOut (Height=Height);
        translate ([0,40,0]) mirror ([0,1,0]) 4040_ProfileCutOut (Height=Height); //Top Left
        translate ([20,40,0]) mirror ([0,1,0]) 4040_ProfileCutOut (Height=Height); //Top right
        *translate ([20,40,0]) rotate ([0,0,-90]) mirror ([0,1,0]) 4040_ProfileCutOut (Height=Height);
    }
}
*translate ([0,0,0]) 4040_ProfileCutOut (Height=50,InnerDiameter=5);
module 4040_ProfileCutOut () {    
    color ("silver")
    union () {
        translate ([10-3.25,-0.5,-1]) cube ([6.5,6,Height+2]);
        hull () {
            translate ([10-6.25,1.35,-1]) cube ([12.5,1,Height+2]);
            translate ([10-3,5,-1]) cube ([6,1,Height+2]);
        }
    }
}