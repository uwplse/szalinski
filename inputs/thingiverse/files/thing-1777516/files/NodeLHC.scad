/* General */
PrinterErrorXY = 0.4;

Mode = "Print"; //[View, Print]

PrintLid = "True"; // [True, False]
PrintBox = "True"; // [True, False]

CutButtonsInLid = "True"; // [True, False]
CutHotAirSinkInLid = "True"; // [True, False]
// View from USB port (8 Pins)
CutLeftPinsInBox = "True"; // [True, False]
// View from USB port (12 Pins)
CutRightPinsInBox = "True"; // [True, False]

/* Custom Cut in Box */
CustomCutBox = "False"; // [True, False]
CustomBoxCutSizeX = 10;
CustomBoxCutSizeY = 10;
CustomBoxCutOffsetX = 10;
CustomBoxCutOffsetY = 10;

/* Custom Cut in Lid */
CustomCutLid = "False"; // [True, False]
CustomLidCutSizeX = 30;
CustomLidCutSizeY = 2;
CustomLidCutOffsetX = 13;
CustomLidCutOffsetY = 2;

/* [HIDDEN] */
thickness = 1;
$fn = 50;
/* Lid */
lidHeight = 3;
/* Box */
// da placa, não da caixa
height = 9.5; // Total, Pode variar com o capacitor
width = 26;
lenght = 45;
ldoFtdiClearance = 0.5;

/* Exemple ESP */
pcbThickness = 2;
// props Sizes
pushButtonSize = 6;
pushButtonHeight = 4;
// Usb
usbOffsetX=1;
usbSizeX =9.2;
usbSizeY = 7.7;
usbHeight = 3.7;
// caps
capacitorDiameter = 4;
capacitorHeight = 5.4;
// esp
espSizeX = 24;
espSizeY = 16;
espChipX = 15;
espChipY = 12;
espChipHeight = 2.5;
// ldo
ldoHeight = 1.6;
ldoSizeX = 3.7;
ldoSizeY = 6.6;
//ftdi
ftdiHeight = 1.6;
ftdiSizeX = 10.3;
ftdiSizeY = 5.3;
// AUX
boxNodeVDist = max(ldoHeight,ftdiHeight)+ldoFtdiClearance;

if(Mode == "View"){
    difference(){
        union(){
            translate([thickness+PrinterErrorXY/2,
                       thickness+PrinterErrorXY/2,
                       thickness]) 
                nodeLhc();
            if(PrintLid == "True") translate([0,0,15]) boxLid();
            if(PrintBox == "True") boxBase();
        }
        //translate([-1,26,-10]) cube([100,100,100]);
    }
}else{
    if(PrintLid == "True")
        translate([0,-5,lidHeight]) rotate(a=[180,0]) boxLid();
    if(PrintBox == "True") boxBase();
}

module boxBase(){
    difference(){
        cube([lenght+PrinterErrorXY+thickness*2,width+PrinterErrorXY+thickness*2,height]);
        translate([thickness,thickness,thickness])
            cube([lenght+PrinterErrorXY,width+PrinterErrorXY,height]);
        // corte da USB
        translate([-thickness/2,
                   width/2-usbSizeY/2+PrinterErrorXY/2+0.5,
                   thickness+boxNodeVDist+pcbThickness])
            cube([thickness*2,usbSizeY+1,usbHeight+5]);
        if(CutRightPinsInBox == "True")
            translate([12,2,-pcbThickness]) 
                cube([31,2,pcbThickness*3]);
        if(CutLeftPinsInBox == "True")    
            translate([23,width-2,-pcbThickness]) 
                cube([20,2,pcbThickness*3]);
        
        if(CustomCutBox == "True"){
            translate([CustomBoxCutOffsetX,CustomBoxCutOffsetY,-thickness])
                cube([CustomBoxCutSizeX,CustomBoxCutSizeY,thickness*3]);
        }
    }
    // suportes
    tamanhoSuporte = 3;
    translate([thickness,thickness]) 
        cornerSupport(tamanhoSuporte);
    translate([thickness,width-thickness+tamanhoSuporte])
        rotate(a=[0,0,270])cornerSupport(tamanhoSuporte);
    translate([lenght-thickness+tamanhoSuporte,thickness])
        rotate(a=[0,0,90])cornerSupport(tamanhoSuporte);
    translate([lenght-thickness+tamanhoSuporte,
               width-thickness+tamanhoSuporte])
        rotate(a=[0,0,180])cornerSupport(tamanhoSuporte);
}
module boxLid(){
    difference(){
        color("gray") union(){
            cube([lenght+PrinterErrorXY+thickness*2,
                  width+PrinterErrorXY+thickness*2,lidHeight]);
            translate([thickness,thickness,-1])
                cube([lenght+PrinterErrorXY,
                    width+PrinterErrorXY,lidHeight+1]);
        }
        translate([thickness*2,thickness*2,-thickness-1])
            cube([lenght+PrinterErrorXY-thickness*2,
                  width+PrinterErrorXY-thickness*2,lidHeight+1]);
        translate([-thickness/2,
                   width/2-usbSizeY/2+PrinterErrorXY/2+0.5,
                   -usbHeight-5])
            cube([thickness*5,usbSizeY+1,usbHeight+5]);
        if(CutButtonsInLid == "True"){
            translate([3+thickness+PrinterErrorXY/2,
                       1+thickness+PrinterErrorXY/2,1])
                cube([pushButtonSize,pushButtonSize,thickness*3]);
            translate([3+thickness+PrinterErrorXY/2,
                       width-pushButtonSize+PrinterErrorXY/2,
                       1])
                cube([pushButtonSize,pushButtonSize,thickness*3]);
        }
        if(CustomCutLid == "True"){
            translate([CustomLidCutOffsetX,CustomLidCutOffsetY,thickness])
                cube([CustomLidCutSizeX,CustomLidCutSizeY,thickness*3]);
        }
        if(CutHotAirSinkInLid == "True"){
           translate([30,15,thickness]){
              cylinder(d=2.5,h=thickness*3);
              for(i=[1:11]){
                s = 1.5+(i/5);
                rotate(a=[0,0,i*36]) translate([3+i/2,0])
                   //cube([s,s,thickness*3]);
                   cylinder(d=s,h=thickness*3);
              }
          }
        }
    }
}

/* Aux */
module cornerSupport(tamanhoSuporte){
    cube([tamanhoSuporte/2,tamanhoSuporte,boxNodeVDist+thickness]);
        cube([tamanhoSuporte,tamanhoSuporte/2,boxNodeVDist+thickness]);
        translate([tamanhoSuporte/2,tamanhoSuporte/2]) 
            cylinder(d=tamanhoSuporte,boxNodeVDist+thickness);
}
module nodeLhc(){
    // pcb
    translate([0,0,boxNodeVDist]){
        color("lightgreen"){ 
            difference(){
                cube([lenght,width,pcbThickness]);
                translate([11,1,-pcbThickness]) 
                    cube([31,2,pcbThickness*3]);
                translate([22,width-3,-pcbThickness]) 
                    cube([20,2,pcbThickness*3]);
            }
        }
        translate([0,0,pcbThickness]) {
            // pushButton
            translate([3,1]) pushButton();
            translate([3,width-pushButtonSize-1]) pushButton();
            // USB port
            color("lightgray"){
                translate([-usbOffsetX,width/2-usbSizeY/2])
                    cube([usbSizeX,usbSizeY,usbHeight]);
                // caps
                translate([17,width-7.25]) 
                    cylinder(d=capacitorDiameter,capacitorHeight);
                translate([17,8.62]) 
                    cylinder(d=capacitorDiameter,capacitorHeight);
            }
            // esp
            translate([lenght-espSizeX,width/2-espSizeY/2]){
                color("darkgreen")
                    cube([espSizeX,espSizeY,1]);
                translate([1,espSizeY/2-espChipY/2,1])
                    color("gold") cube([espChipX,espChipY,espChipHeight]);
            }
        }
        // ldo
        translate([4.3,width-ldoSizeY-1.6,-ldoHeight])
            color("gray") cube([ldoSizeX,ldoSizeY,ldoHeight]);    
        // ftdi
        translate([17,width/2-ftdiSizeY/2,-ftdiHeight])
            color("gray") cube([ftdiSizeX,ftdiSizeY,ftdiHeight]);
    }
}
module pushButton(){
    color("lightgray") cube([pushButtonSize,pushButtonSize,pushButtonHeight-1]);
    color("gray")
        translate([pushButtonSize/2,pushButtonSize/2]) 
            cylinder(d=pushButtonSize/2,h=pushButtonHeight);
    
}