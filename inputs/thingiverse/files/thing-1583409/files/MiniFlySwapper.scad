/*[Dimensions]*/

// How long should the main stick be in mm?
stick_length = 140; // [100:10:150]

// How thick should the swapper be in mm?
swapper_thickness = 2; // [1.5:0.5:3]

/*[Text Options]*/
// What text should be on the main stick?
sometext = "JoPri's Mini Fly Swapper";

// Distance to place text
textlocation = 15; // [10:5:30]

/*[Additional Options]*/
// Need to hang the swapper?
swaphanger = "Yes"; // [Yes,No]

// does the fly need a luckyhole?
luckyhole = "No"; // [Yes,No]


difference () {
    union () {
        translate ([15,-stick_length,0]) cube ([10,stick_length+2,swapper_thickness]);
        hull () {
            translate ([5,0,0]) cylinder (h=swapper_thickness,d=20);
            translate ([35,0,0]) cylinder (h=swapper_thickness,d=20);
            translate ([0,40,0]) cylinder (h=swapper_thickness,d=20);
            translate ([40,40,0]) cylinder (h=swapper_thickness,d=20);
        }
    }
    
    if (swaphanger == "Yes") {
        translate ([20,0-stick_length+7.50,0]) cylinder (d=5,h=swapper_thickness);
    }
    if (luckyhole == "Yes") {
        translate ([12,35,0]) cylinder (d=10,h=swapper_thickness);
    }
    translate ([0,-5,0]) cube ([40,1,swapper_thickness]);
    
    translate ([-2.50,-2.5,0]) cube ([45,1,swapper_thickness]);
    translate ([-2.50,-0,0]) cube ([45,1,swapper_thickness]);
    translate ([-2.50,2.5,0]) cube ([45,1,swapper_thickness]);
    translate ([-2.50,5,0]) cube ([45,1,swapper_thickness]);
    translate ([-2.50,7.5,0]) cube ([45,1,swapper_thickness]);
    translate ([-2.50,10,0]) cube ([45,1,swapper_thickness]);
    translate ([-2.50,12.5,0]) cube ([45,1,swapper_thickness]);
    translate ([-2.50,15,0]) cube ([45,1,swapper_thickness]);
    translate ([-2.50,17.5,0]) cube ([45,1,swapper_thickness]);
    translate ([-2.50,20,0]) cube ([45,1,swapper_thickness]);
    translate ([-5,22.5,0]) cube ([50,1,swapper_thickness]);
    translate ([-5,25,0]) cube ([50,1,swapper_thickness]);
    translate ([-5,27.5,0]) cube ([50,1,swapper_thickness]);
    translate ([-5,30,0]) cube ([50,1,swapper_thickness]);
    translate ([-5,32.5,0]) cube ([50,1,swapper_thickness]);
    translate ([-5,35,0]) cube ([50,1,swapper_thickness]);
    translate ([-5,37.5,0]) cube ([50,1,swapper_thickness]);
    translate ([-5,40,0]) cube ([50,1,swapper_thickness]);
    translate ([-5,42.5,0]) cube ([50,1,swapper_thickness]);
    translate ([-2.50,45,0]) cube ([45,1,swapper_thickness]);
}

translate ([-3,-5,0]) rotate ([0,0,5]) cube ([3,50,swapper_thickness]);
translate ([7,-6,0]) rotate ([0,0,5]) cube ([2,55,swapper_thickness]);
translate ([18.50,-6,0]) rotate ([0,0,0]) cube ([2,55,swapper_thickness]);
translate ([30,-6,0]) rotate ([0,0,-5]) cube ([2,55,swapper_thickness]);
translate ([40,-5,0]) rotate ([0,0,-5]) cube ([3,50,swapper_thickness]);

if (luckyhole == "Yes") {
    difference () {
        translate ([12,35,0]) cylinder (d=12.50,h=swapper_thickness);
        translate ([12,35,0]) cylinder (d=10,h=swapper_thickness);
    }
}


color ("red")
union () {
    translate ([22.5,-stick_length+textlocation,swapper_thickness])
    rotate([0,0,90])
    linear_extrude(height = 1.5, center = true, convexity = 10, twist = 0)
    text(sometext, font = "Broadway:style=Regular", size = 5);   
}

