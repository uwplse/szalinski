/* [Geral] */
Print = "True"; // [True,False]
// Printer XY Dimensional Error
printerErrorMargin = 0.5;
/* [Dimensions] */
// Box side size (Y)
boxSizeWidth  = 55;
boxSizeHeight = 20;
// Face of tthe box (where cover slides in) (X)
boxSizeDepth  = 35;
boxWallThickness = 1.5;
coverThickness = 2;
/* [Text] */
TextLateral1 = "Allen Screw";
TextLateral2 = "Metric 3x10";
// Zero to AUTO
LateralFontSize=7;
TextFront = "";
TextBack = "";

TextCover1 = " A M3x10";
TextCover2 = "";
TextHeight = 0.4;

/* [HIDDEN] */
$fn = 50;
diffMargin = 0.01;

if(Print == "True"){
    box();
    translate([-boxSizeDepth-1,0,0])
        cover();
}else{
    box();
    translate([printerErrorMargin/2,0,
               boxSizeHeight-coverThickness])
        cover();
}

module box(){
    bwt = boxWallThickness;
    difference(){
        minkowski(){
            translate([0.5,0.5]) cube([boxSizeDepth-1,boxSizeWidth-1,boxSizeHeight-1]);
            cylinder(d=1,h=1);
        }
                
        translate([bwt,bwt,bwt])
            cube([boxSizeDepth-bwt*2,
                  boxSizeWidth-bwt*2,
                  boxSizeHeight+bwt*2]);
        translate([bwt,
                   -2*diffMargin,
                   boxSizeHeight-coverThickness
                   +diffMargin]){
            cube([boxSizeDepth-bwt*2,bwt*2,
                  coverThickness]);
        }
        d=coverThickness*2/3;
        h=boxSizeWidth+2*diffMargin-boxWallThickness;
        translate([boxWallThickness,-2*diffMargin,
                   boxSizeHeight-coverThickness+d/2])
            coverCutCylinder(d,h);
        translate([boxSizeDepth-boxWallThickness,
                   -2*diffMargin,
                   boxSizeHeight-coverThickness+d/2])
            coverCutCylinder(d,h);
    }
    boxText();
}
module boxText(){
    // Frente e Fundo
    if(len(TextFront) > 0) translate([1,0,5]) CreateText(TextFront,boxSizeHeight/3,90,0,0);
    if(len(TextBack) > 0) 
        translate([boxSizeDepth,boxSizeWidth,6]) 
            CreateText(TextBack,boxSizeHeight/3,90,0,180);
    // Lateral
    yOffset = 1;
    lateralFont = LateralFontSize > 0? LateralFontSize:(boxSizeHeight/2)-2;
    if(len(TextLateral1) > 0 && len(TextLateral2) > 0) {
        translate([0,boxSizeWidth-yOffset,boxSizeHeight/2])
            CreateText(TextLateral1,lateralFont,90,0,-90);    
        translate([boxSizeDepth,yOffset,boxSizeHeight/2])
            CreateText(TextLateral1,lateralFont,90,0,90);
    }
    if(len(TextLateral1) > 0 && len(TextLateral2) == 0) {
        translate([0,boxSizeWidth-yOffset,boxSizeHeight/3])
            CreateText(TextLateral1,lateralFont,90,0,-90);    
        translate([boxSizeDepth,0,boxSizeHeight/3])
            CreateText(TextLateral1,lateralFont,90,0,90);
    }
    if(len(TextLateral2) > 0){
        translate([0,boxSizeWidth-yOffset,1])
            CreateText(TextLateral2,lateralFont,90,0,-90);
        translate([boxSizeDepth,yOffset,1])
            CreateText(TextLateral2,lateralFont,90,0,90);    
    }

}
module cover(){
    bwt = boxWallThickness;
    h=boxSizeWidth-bwt-printerErrorMargin;
    x=boxSizeDepth-bwt*2-printerErrorMargin;
    translate([bwt+0,0,0]){
        cube([x,
              h,
              coverThickness]);
        d=coverThickness*2/3;
        translate([0,-2*diffMargin,d/2])
            coverCutCylinder(d,h);
        translate([boxSizeDepth-bwt*2-printerErrorMargin,
                   -2*diffMargin,d/2])
            coverCutCylinder(d,h);
    }
    size = x/2;
    if(len(TextCover2) > 0){        
        translate([x-2,1,coverThickness])
            CreateText(TextCover2,(size/2),0,0,90);
        translate([x/2-2,1,coverThickness])
            CreateText(TextCover1,(size/2),0,0,90);
    }else{
         translate([2*x/3,1,coverThickness])
            CreateText(TextCover1,(size/2),0,0,90);
    }
}
/* Aux Functions */
module coverCutCylinder(d,h){
    rotate(a=[-90,0,0])
        cylinder(d=d,
                 h=h);
}
module CreateText(Text, Size, RotX, RoY, RotZ){
    color("blue")
    rotate(a=[RotX, RoY, RotZ])
        linear_extrude(height=TextHeight)
            text(Text,Size);
}
