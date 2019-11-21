//Written by Remi Vansnickt
//Feel free to tip me : https://www.thingiverse.com/Remivans/about
//Thingiverse : https://www.thingiverse.com/thing:3149090
//Licensed under the Creative Commons - Attribution - Non-Commercial - Share Alike license.

/* [PVC TUBE] */
//( mm ) Outer diameter of pvc pipe
pvcOuterDiameter=40;//[8:0.5:200]

//( mm ) Inner diameter of pvc pipe
pvcInnerDiameter=34;//[4:0.5:190]

//( mm ) Clearance beetween part and outer pvc pipe
pvcpartClearance=0.4;//[0.1:0.05:1]

//Wall's number determine Thickness PrinterNozzleWidth*WallLayerCount 0.4*3=1.2mm
PvcWallLayerCount=6;  //[1:1:10]

//(mm) Thickness of bottom floor
floorWidth=1;//[1:01:10]

//( mm ) length mount on pvc tube
pvcLength=10;//[5:1:100]

/* [printerSetting] */
//( mm ) Width of the Nozzle
PrinterNozzleWidth=0.4; //[0.1:0.05:1]


pvcT=PvcWallLayerCount*PrinterNozzleWidth+0.01;

module tube(){
difference(){
     translate([0,0,0])
        cylinder(r=pvcOuterDiameter/2+pvcpartClearance+pvcT,h=pvcLength,$fn=4*pvcOuterDiameter);

 translate([0,0,-floorWidth])
        cylinder(r=pvcOuterDiameter/2+pvcpartClearance,h=pvcLength,$fn=4*pvcOuterDiameter);
    }

cylinder($fn = 100, $fa = 12, $fs = 100, h = pvcLength-floorWidth, r1 = pvcInnerDiameter/2-pvcpartClearance, r2 = pvcInnerDiameter/2+pvcpartClearance, center = false);
}rotate(180,[1,0,0])tube();

