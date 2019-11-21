echo(version=version(2.0));
//comments: Version 2 adds anti-"elephant foot" scaling at bottom of dovetail sections
/* [Size] */
//Box unit size in mm. This defines the size of 1 'unit' for your box.
BoxUnits = 40;
//Box Width in units
BoxWidthUnits = 1;
BoxWidth = BoxWidthUnits * BoxUnits;
//Box Length in units
BoxLengthUnits = 4;
BoxLength = BoxLengthUnits * BoxUnits;
//Box Height in mm
BoxHeight = 40;
//Box Wall Thickness in mm
BoxWall = 1;
//Box Floor Thickness in mm
BoxFloor = 2;
//Fit Factor. Greater factor = looser fit
FitFactor = 0.15;  // [0:0.05:0.4]

/* [Walls] */
//North Wall open or closed
NorthWallOpen = 0; // [0:Closed, 1:Open]
//South Wall open or closed
SouthWallOpen = 0; // [0:Closed, 1:Open]

/* [Dovetail] */
//Dovetail inside length in mm
DTInsideLength = 4;
//Dovetail angle in degrees
DTAngle = 45;
//Dovetail width in mm
DTWidth = 2;

/* [Hidden] */
//This helps calculate the length of the 'long' side of the dovetail
DTx=tan(DTAngle)*DTWidth;
//This polygon defines the dovetail shape
DTShape = [[0,0],[DTInsideLength/2,0],[DTInsideLength/2+DTx,DTWidth],[-DTInsideLength/2-DTx,DTWidth],[-DTInsideLength/2,0]];

difference(){
    
union(){
    //main box
cube([BoxLength,BoxWidth,BoxHeight], center=false);

    //male dovetails
for (i=[1:BoxLengthUnits])
translate([(i-1)*BoxUnits+(BoxUnits/2),BoxWidth,0])
	//in 2 sections. first section is slightly scaled down to counter "elephant foot"
	union(){
		linear_extrude(height=1, center=false)
	        scale([1-(2*FitFactor),1-(2*FitFactor),1])
			union(){        
				//this adds a slight offset to the male dovetail for a looser fit
	            translate([-DTInsideLength/2,0,0])
	            square([DTInsideLength,DTWidth]);
	            //main dovetail shape
	            translate([0,DTWidth*FitFactor*2,0])
	            polygon(DTShape);
	        };
		translate([0,0,1])
		linear_extrude(height=BoxHeight-1, center=false)
        		union(){
	            //this adds a slight offset to the male dovetail for a looser fit
	            translate([-DTInsideLength/2,0,0])
	            square([DTInsideLength,DTWidth]);
	            //main dovetail shape
	            translate([0,DTWidth*FitFactor*2,0])
	            polygon(DTShape);
        		};
	}        

for (i=[1:BoxWidthUnits])
translate([0,(i-1)*BoxUnits+(BoxUnits/2),0])
    //in 2 sections. first section is slightly scaled down to counter "elephant foot"
	rotate([0,0,90])
	union(){
		linear_extrude(height=1, center=false)				//1mm high anti-elephant foot section
	        scale([1-(2*FitFactor),1-(2*FitFactor),1])
			union(){        
				//this adds a slight offset to the male dovetail for a looser fit
	            translate([-DTInsideLength/2,0,0])
	            square([DTInsideLength,DTWidth]);
	            //main dovetail shape
	            translate([0,DTWidth*FitFactor*2,0])
	            polygon(DTShape);
	        };
	    translate([0,0,1])
		linear_extrude(height=BoxHeight-1, center=false)
	        union(){
	            //male dovetail offset
	            translate([-DTInsideLength/2,0,0])
	            square([DTInsideLength,DTWidth]);
	            //main dovetail shape
	            translate([0,DTWidth*FitFactor*2,0])
	            polygon(DTShape);
	        };
	}
}
//female dovetails
for (i=[1:BoxLengthUnits])
	union(){
		translate([(i-1)*BoxUnits+(BoxUnits/2),0,0])
		    scale([1+FitFactor,1+FitFactor,1])
		    linear_extrude(height=BoxHeight, center=false)
		    polygon(DTShape);
	
		//added a second dovetail cutout at the bottom, scaled up to counter "elephant foot" when printed
		translate([(i-1)*BoxUnits+(BoxUnits/2),0,0])
		    scale([1+(3*FitFactor),1+(3*FitFactor),1])
		    linear_extrude(height=1, center=false)
		    polygon(DTShape);					
	}

for (i=[1:BoxWidthUnits])
	union(){
		translate([BoxLength,(i-1)*BoxUnits+(BoxUnits/2),0])
		    rotate([0,0,90])
		        scale([1+FitFactor,1+FitFactor,1])
		            linear_extrude(height=BoxHeight, center=false)
		                polygon(DTShape);
		//added a second dovetail cutout at the bottom, scaled up to counter "elephant foot" when printed
		translate([BoxLength,(i-1)*BoxUnits+(BoxUnits/2),0])
		    rotate([0,0,90])
		        scale([1+(3*FitFactor),1+(3*FitFactor),1])
		            linear_extrude(height=1, center=false)
		                polygon(DTShape);	
	}
//carves out main box
translate([BoxWall,DTWidth+BoxWall,BoxFloor], center=false)
    cube([BoxLength-(2*BoxWall)-DTWidth, (BoxWidth-(2*BoxWall)-DTWidth), BoxHeight]);

if (NorthWallOpen)
    translate([-DTWidth*(1+FitFactor+FitFactor),BoxWall+DTWidth,BoxFloor], center=false)
        cube([BoxWall+(DTWidth*(1+FitFactor+FitFactor)), (BoxWidth-(2*BoxWall)-DTWidth), BoxHeight]);    

if (SouthWallOpen)
    translate([BoxLength-(BoxWall)-DTWidth,BoxWall+DTWidth,BoxFloor], center=false)
        cube([BoxWall+DTWidth, (BoxWidth-(2*BoxWall)-DTWidth), BoxHeight]);


}

//
/*
difference(){
    linear_extrude(height=h)
        offset(r=5)
        offset(r=-5)
        polygon(Poly1);

    linear_extrude(height=h)
        offset(r=5)
        offset(r=-10)
        polygon(Poly1);

    translate([w2,0,0])
    rotate([0,-90,0])
    linear_extrude(height=BackWidth)
        polygon(Poly2);
    
    for (a =[0:NumSlots-1])
     translate([0, FrontOffset+Slot1+(a*SlotSpacing)+(0*SlotSizeStep), BottomOffset +((a)*tan(SlotBottomSlope)*SlotSpacing)])
        rotate([-SlotAngle,0,0])
            translate([-(BackWidth/2),-(Slot1+a*SlotSizeStep),0])
            cube([BackWidth,Slot1+(a*SlotSizeStep),SlotDepth], center=false); 
}
*/
