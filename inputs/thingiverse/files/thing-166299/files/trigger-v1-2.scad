/* Version 1.2 */
//Trigger height from the bottom of should button:
triggerZ=0; // [0:10]
//Distance from face of shoulder button to trigger:
triggerY=30; // [5:50]
//Width of trigger:
triggerWidth=18; // [10:30]
//Horizontal distance from system in tenths of mm:
triggerXoffset=20; // [15:80]
offset=triggerXoffset/10;
//Do you want the snap fit option?
snapFit=1; // [1:Yes, 0:No]
//Round peg is recommended.
pegShape=1; // [0:Square, 1:Round]
//Left or Right Button?
side=1; // [0:Left, 1:Right]

/*[Advanced]*/
//Peg width in hundredths of mm (350 is 3.50mm)
pSize=350;//[222:400]
pegSize=pSize/100;
//Peg Depth in hundredths of mm (400 is 4.00mm)
pDepth=400;//[300:500]
pegDepth=pDepth/100;
//Peg Gap width in hundredths of mm (100 is 1mm)
pGap=125;//[10:150]
pegGap=pGap/100;
//Peg Lip size in hundredths of mm (50 is 0.50mm)
pLip=50;//[10:100]
pegLip=pLip/100;

/* [Hidden] */
pWidth=22;//width of shoulder button face
pThickness=4;//thickness of part
pHeight=8;//height of shoulder button face
height=10;//magic number :-)

if (side==1){
	snap();extension();}
else{
	mirror([-1,0,0]){snap();extension();}
}

module snap(){if (snapFit == 1){
	translate([-10,-1,0])cube([10,2,pHeight]);//snap base

if (pegShape == 0){
	translate([-8, -1-pegDepth, 3])
	difference(){
		union(){
			cube([pegSize, pegDepth, pegSize]);
			translate([-pegLip, 0, 0])cube([pegSize +2*pegLip,1,pegSize]);
			}

		translate([pegSize/2 - pegGap/2, -1, -1])cube([pegGap, pegDepth+1, pegSize+2]);
		}
	}
if (pegShape == 1){
	translate([-8, -1-pegDepth, 3])
	difference(){
		union(){
			translate([pegSize/2,pegDepth,2])
			rotate([90,0,0])
			cylinder(h=pegDepth-1, r=pegSize/2, center=false, $fn=40);

			translate([pegSize/2,1,2])
			scale([1,1,.8])
			rotate([90,0,0])
			cylinder(h=1, r1=pegSize/2+pegLip, r2=pegSize/2, center=false, $fn=40);
			}
		
		translate([pegSize/2 -pegGap/2, -1, -1])cube([pegGap, pegDepth+1, pegSize+2]);
				}
			}
		}
	}

module extension(){
	difference(){
		union(){
			cube([pWidth,pThickness,pHeight]);	
			
			hull(){
				translate([pWidth,0,0])cube([pThickness, pThickness, pHeight]);
				translate([pWidth+offset, -triggerY, triggerZ])cube([pThickness, pThickness, pHeight]);
				}

			translate([pWidth+offset,-triggerY,triggerZ])
			cube([triggerWidth,pThickness,pHeight]);
			}
		
		translate([pWidth+offset+pThickness, -triggerY, triggerZ-1])
		difference(){
			cube([triggerWidth, height, height]);
			
			translate([-1,0,height/2])
			rotate([0,90,0])
			cylinder(h = triggerWidth+2, r=height/2, center = false, $fn=40);
		}
	}
}
// preview[view:south, tilt:top]