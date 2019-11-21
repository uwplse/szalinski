$fn=128;
//Printer settings
n=0.4;//Nozzle width

//Base
bT=0.4*2;//Base thickness
gT=n*4;//Grid line Thickness

//Box Size
sH=22+bT;//Side Height
sLenX=18;//Side Length X
sLenY=17.5;//Side Length Y
sThick=n*2;//Side Thickness

fsLenX=13;//Finger slot Length X
fsLenY=13;//Finger slot Length Y

//Extras
tlR=5; //Tray Lift Radius (Height)
cr=4; //Corner radius
fr=sH/2; //Fillet radius


/*
   Cell Walls
   ----------
   Cells Walls are defined by a Horizontal and a Vertical two dimensional array.
   Remember that you need an outside edge, so three cells in a row will require four walls.

   Cell Walls: 0=Gap, 1=Wall, 2=Finger slot, 3=Tray Lift,
   Fillets:+ .1=bottom/right fillet, .2=top/left fillet, .3=both fillets

   e.g. "3.2" is a Tray lift wall with a top or left fillet, depending if it's vertical or horizontal.
*/

//Test example
testH=[ //Cells Horizontal
    [1,2,1],
    [1.1,3.3,1],
    [1.2,0,1]
];
testV=[ //Cells Vertical
    [2,1.1,1.2,1],
    [1.1,0,3.2,1]
];

//Xia: Legends of a drift system

//Layout A (Xia Blasters)
cellsH_XiaA = [ //Cells Horizontal
    [1,1,1,1,1,1,1],
    [0,0,0,2,1,1,0],
    [0,0,1,1,0,2,0],
    [1,1,1,1,1,1,1]
];

cellsV_XiaA = [ //Cells Vertical
    [1,0,1,1,2,0,0,1],
    [1,0,1,0,1,2,1,1],
    [1,0,1,0,0,1,1,1]
];

//Layout B (Xia Engines)
cellsH_XiaB = [ //Cells Horizontal
    [1,1,1,1,1,1,1],
    [0,0,1,1,0,2,0],
    [0,0,1,0,1,0,0],
    [1,1,1,1,1,1,1]
];

cellsV_XiaB = [ //Cells Vertical
    [1,0,2,1,0,2,1,1],
    [1,0,2,0,1,1,0,1],
    [1,0,2,1,0,1,0,1]
];

//ModularGridRC(testH,testV,grid=false);

ModularGridRC(cellsH_XiaA,cellsV_XiaA);
translate([0,65,0])ModularGridRC(cellsH_XiaB,cellsV_XiaB);

module gridBase(cellsH,cellsV){
    //Base plate
    xLen = sLenX*len(cellsH[0])+sThick*(len(cellsH[0])+1);
    yLen = sLenY*(len(cellsH)-1)+sThick*(len(cellsH));   
 
    stLen = sLenX+sThick;
    
    rotZ=atan(sLenX/sLenY);

    intersection(){
        translate([0,-yLen,0])cube([xLen,yLen,bT]);
        for (rH=[0:len(cellsH)-2]) { //Row
            for (cH=[0:len(cellsH[rH])]) { //Column
                yHTrans = -((rH*sLenY)+(sThick*(rH+1)));
                xHTrans = cH*sLenX+(sThick*(cH+1));
                translate([xHTrans-sThick/2,yHTrans+sThick/2,0])rotate([0,0,rotZ])translate([-gT/2,-stLen*2+gT,0])cube([gT,stLen*2,bT]);
                translate([xHTrans-sThick/2,yHTrans+sThick/2,0])rotate([0,0,-rotZ])translate([-gT/2,-stLen*2+gT,0])cube([gT,stLen*2,bT]);
            }
        }
    }
    //Edge
    eT=max(gT,sThick);
    translate([0,-eT,0])cube([xLen,eT,bT]);
    translate([0,-yLen,0])cube([xLen,eT,bT]);
    translate([0,-yLen,0])cube([eT,yLen,bT]);
    translate([xLen-eT,-yLen,0])cube([eT,yLen,bT]);

}

module ModularGridRC(cellsH,cellsV,grid=true){
    //Modular Grid with Rounded Corners
    xLen = sLenX*len(cellsH[0])+sThick*(len(cellsH[0])+1);
    yLen = sLenY*(len(cellsH)-1)+sThick*(len(cellsH));
    difference(){
        ModularGrid(cellsH,cellsV,grid=grid);
        translate([xLen/2-cr,yLen/2-cr,0])roundedCorner(cutout=true);
        translate([-xLen/2+cr,yLen/2-cr,0])rotate([0,0,90])roundedCorner(cutout=true);
        translate([-xLen/2+cr,-yLen/2+cr,0])rotate([0,0,180])roundedCorner(cutout=true);
        translate([xLen/2-cr,-yLen/2+cr,0])rotate([0,0,270])roundedCorner(cutout=true);
    }
    translate([xLen/2-cr,yLen/2-cr,0])roundedCorner();
    translate([-xLen/2+cr,yLen/2-cr,0])rotate([0,0,90])roundedCorner();
    translate([-xLen/2+cr,-yLen/2+cr,0])rotate([0,0,180])roundedCorner();
    translate([xLen/2-cr,-yLen/2+cr,0])rotate([0,0,270])roundedCorner();
}

module roundedCorner(cutout=false){
    if (cutout==true){
        difference(){
            translate([0,0,-1])cube([cr+1,cr+1,sH+2]);
            translate([0,0,-2])cylinder(r=cr,h=sH+4);
        }
        
    } else {
        intersection(){
            cube([cr,cr,sH]);
            difference(){
                cylinder(r=cr,h=sH);
                translate([0,0,-1]){
                    cylinder(r=(cr-sThick),h=sH+2);
                }
            }
        }
        //Base trim
        eT=max(gT,sThick);
        intersection(){
            cube([cr,cr,sH]);
            difference(){
                cylinder(r=cr,h=bT);
                translate([0,0,-1]){
                    cylinder(r=(cr-eT),h=bT+2);
                }
            }
        }
    }
}

module ModularGrid(cellsH,cellsV,grid=true){
    xLen = sLenX*len(cellsH[0])+sThick*(len(cellsH[0])+1);
    yLen = sLenY*(len(cellsH)-1)+sThick*(len(cellsH));
    echo ("xLen",xLen,"yLen",yLen);
    translate([-xLen/2,yLen/2,0]){
        //Base plate
        if (grid){
            gridBase(cellsH,cellsV);
        } else {            
            translate([0,-yLen,0])cube([xLen,yLen,bT]);
        }
        
        wLenX = sLenX + sThick*2;
        wLenY = sLenY + sThick*2;
        //Horizontal lines
        for (rH=[0:len(cellsH)-1]) { //Row
            for (cH=[0:len(cellsH[rH])-1]) { //Column
                xHTrans = cH*sLenX+(sThick*(cH+1));
                yHTrans = -((rH*sLenY)+(sThick*(rH+1)));
                wallType=floor(cellsH[rH][cH]);
                filletType=round((cellsH[rH][cH]-wallType)*10);
                if (wallType==1 || wallType==3){
                    translate([xHTrans-sThick,yHTrans,0])cube([wLenX,sThick,sH]);
                }
                if (wallType==2){
                    difference(){
                        translate([xHTrans-sThick,yHTrans,0])cube([wLenX,sThick,sH]);
                        translate([xHTrans+(sLenX-fsLenX)/2,yHTrans-1,-1])cube([fsLenX,sThick+2,sH+2]);
                    }
                }
                if (wallType==3){
                    translate([xHTrans+(0.5*sLenX),yHTrans,sH])rotate([-90,0,0])cylinder(h=sThick,r=tlR);
                }
                if (filletType==1 || filletType==3){ //Bottom
                    translate([xHTrans-sThick,yHTrans-fr,bT]){
                        difference(){
                            translate([0,0,-bT])cube([wLenX,fr,fr+bT]);
                            translate([-1,0,fr])rotate([0,90,0])cylinder(r=fr,h=wLenX+2);
                        }
                        
                    }
                }
                if (filletType==2 || filletType==3){ //Top
                    translate([xHTrans-sThick,yHTrans+sThick,bT]){
                        difference(){
                            translate([0,0,-bT])cube([wLenX,fr,fr+bT]);
                            translate([-1,fr,fr])rotate([0,90,0])cylinder(r=fr,h=wLenX+2);
                        }
                        
                    }
                }
            }
        }

        //Vertical lines
        for (rV=[0:len(cellsV)-1]) { //Row
            for (cV=[0:len(cellsV[rV])-1]) { //Column
                xVTrans = cV*sLenX+ (sThick*(cV));
                yVTrans = -((rV+1)*sLenY + (sThick*(rV+1)));
                wallType=floor(cellsV[rV][cV]);
                filletType=round((cellsV[rV][cV]-wallType)*10);
                if (wallType==1 || wallType==3){
                    translate([xVTrans,yVTrans-sThick,0])cube([sThick,wLenY,sH]);
                }
                if (wallType==2){
                    difference(){
                        translate([xVTrans,yVTrans-sThick,0])cube([sThick,wLenY,sH]);
                        translate([xVTrans-1,(((rV+1)*sLenY)-(sLenY-fsLenY)/2+sThick)*-1,-1])cube([sThick+2,fsLenY,sH+2]);
                    }
                }
                if (wallType==3){
                    translate([xVTrans,yVTrans+(0.5*sLenY),sH])rotate([0,90,0])cylinder(h=sThick,r=tlR);
                }
                if (filletType==1 || filletType==3){ //Right
                    translate([xVTrans+sThick,yVTrans-sThick,bT]){
                        difference(){
                            translate([0,0,-bT])cube([fr,wLenY,fr+bT]);
                            translate([fr,-1,fr])rotate([-90,0,0])cylinder(r=fr,h=wLenY+2);
                        }
                        
                    }
                }
                if (filletType==2 || filletType==3){ //Left
                    translate([xVTrans-fr,yVTrans-sThick,bT]){
                        difference(){
                            translate([0,0,-bT])cube([fr,wLenY,fr+bT]);
                            translate([0,-1,fr])rotate([-90,0,0])cylinder(r=fr,h=wLenY+2);
                        }
                    }
                }
            }
        }
    }
}