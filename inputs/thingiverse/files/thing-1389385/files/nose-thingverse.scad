//Outside diameter tube in mm
OD = 39; //[200]
//Inside diameter tube in mm
ID=35; //[200]
//Shoulder length in mm
SHOULDER = 30; //[200]

//Ratio of nose >3 it's ok.
RATIO = 3; //[5]

/* [Hidden] */
h=RATIO*OD/2*3;
//Leave these as is
$fa=0.01;
//Course render = 2, Fine render = 0.3
$fs=1;

//Build nose cone
translate([0,0,SHOULDER]){
	difference(){
		resize([0,0,h]) sphere (d = OD);
		resize([0,0,h-4]) sphere (d = ID-2);
		translate([0,0,-h/2]) cylinder(d = OD, h = h/2);
	}
}

//Add Shock Cord Attachment
rotate ([90,0,0]){
	translate ([0,2,-ID/2+.25]){
		cylinder (r=2, h=ID-.5);
	}
}

//Add SHOULDER
difference(){
	cylinder(d=ID, h=SHOULDER);
    translate([0,0,-1]){
        cylinder(d=ID-3, h=ID+2);
    }
}


