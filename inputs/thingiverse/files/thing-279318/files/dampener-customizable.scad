//Dampeners for printer
//By Jkk79

// preview[view:north, tilt:bottom]

//
mountType=2;  //[1:square, 2:round]

//Has to be quite large to absorb vibrations. 100mm works well.
dampenerLength=100;//[60:150]

//30mm works well.
dampenerHeight=30; //[15:50]

//19mm for prusa i3 (with two extra dampeners under the frame), 46mm for k8200 (with 4 dampeners)
dampenerWidth=46; //[10:60]

//(Thickness). 2.6mm seems flexible enough, and 3 too stiff already.
dampenerStrength=2.6;//[1.6:0.1:4.0]

//~10mm is good for prusa i3, 12mm for k8200, at least...
mountHeight=12;//[0:0.5:20]

//22.4 for prusa i3 legs, 6mm for prusa i3's aluminium frame, 40mm for k8200's round legs.
mountLength=40;//[0:0.2:60]

//For possible bolt-type fastening. 
holeSize=6;//[0:0.5:20]


module squareMount(){
linear_extrude(dampenerWidth)polygon(points=[[0,mountHeight],[0,0],[mountLength,0],[mountLength,mountHeight],[mountLength+3,mountHeight],[mountLength+3,-dampenerHeight/2],[-3,-dampenerHeight/2],[-3,mountHeight]]);
}

module roundMount(){
	rotate([90,0,0])translate([mountLength/2,dampenerWidth/2,-mountHeight+1]){
		difference(){
			difference(){
				cylinder(mountHeight+2,(mountLength/2)+3,(mountLength/2)+3,$fn=128);
				translate([0,0,-1])cylinder(mountHeight+0.5,(mountLength/2),(mountLength/2),$fn=128);
			}
			translate([0-dampenerLength/2,dampenerWidth/2,-dampenerHeight+mountHeight])cube([100,mountLength/2,dampenerHeight+mountHeight]);
			translate([0-dampenerLength/2,-(mountLength/2)-dampenerWidth/2,-dampenerHeight+mountHeight])cube([100,mountLength/2,dampenerHeight+mountHeight]);
		}
	}

}


module dampener(){
	
	difference(){
        union(){
            if(mountType==1){
                
                squareMount();

            }else{
                
                roundMount();
            }
              translate([(mountLength)/2,((0-dampenerHeight/2)+10)-11,0])  resize([dampenerLength,dampenerHeight])cylinder(dampenerWidth,10,10,$fn=128);
            }
      translate([(mountLength)/2,((0-dampenerHeight/2)+10)-11,-1])resize([(dampenerLength-dampenerStrength*2),dampenerHeight-dampenerStrength*2])cylinder(dampenerWidth+2,1,1,$fn=128);
      rotate([90,0,0])translate([mountLength/2,dampenerWidth/2,-4])cylinder(10,holeSize/2,holeSize/2,$fn=128);
	}
}

dampener();