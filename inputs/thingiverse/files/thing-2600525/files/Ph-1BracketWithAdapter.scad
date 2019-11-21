/* [Global] */
// preview[view:north west, tilt:top]
/* [Bracket Arm] */
angle = 0; // [-90:90]
bracketLength = 20;
bracket = 1; //[0:Hide,1:Show]
bracketOffset = 0;
part = "Adapter"; // [Bracket:Modify Bracket,Adapter:Modify Adapter]

/* [Model Angle] */
//Rotate the model so it lays flay on the build surface
modelAngle = 0; // [360]
/* [USB End] */

//USB Port Sizes
usbCWidth = 7;
usbCLength = 12;
usbCHeight = 23;

/* [USB Cable] */

//USB Cable Sizes
usbCCableDiamiter = 4; // [2.0:8]
usbCCableShroudDiamiter = 10; // [2.0:11]

/* [Hidden] */
print_part();

module print_part() {
	if (part == "Bracket") {
		myBracket();
	} else if (part == "Adapter") {
		myAdapter();
	}
}


module myAdapter(){
    //Insert Body
    color("cyan",alpha=1)
    difference(){
        cube([71,8,33],center=true);
        cylinder(h=200, d1=usbCCableDiamiter+0.2 ,d2=usbCCableShroudDiamiter+0.2,center=true);
            
        //phone Insert
        translate([0,0,15])
            cube([72,8.2,6], center=true);

        //USB Insertion Port
        translate([-25,0,0])
            cube([18,7,34],center=true);
        
        //USB cable Insertion Port
        translate([-10,0,0])
            cube([20,usbCCableDiamiter+0.2,34], center = true);
        
        color("red")
        translate([0,0,13])
        cube([usbCLength,usbCWidth,usbCHeight*2],center=true);
    }
}

module myBracket() {
    //Mount for PH-1
    rotate([modelAngle,0,0]){
    cube([28,2.6,24.8], center=true);

    if (bracket){
        color("red"){
            if (angle >= 42)
                translate([-10.1,2,9.4])
                    rotate([angle,0,0])
                        cube([19.8, bracketLength,3], center=false);
            else if (angle <= 0) 
                translate([-10.1,-1,9.4])
                    rotate([angle,0,0])
                        cube([19.8, bracketLength,3], center=false);
            else
                translate([-10.1,1,9.4])
                    rotate([angle,0,0])
                        cube([19.8, bracketLength,3], center=false);
        }
    }

    //Holding nub
        color("blue"){
            translate([0,-1.5,-8])
            rotate([0,90,0])
            cylinder(h=1.9,r1=1,r2=1,center=true);
        }
    }
}
