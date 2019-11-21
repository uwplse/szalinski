BoardThickness = 15;
// Ratio between the board thickness and the corner
ThicknessSizeRatio = 2;
CornerThickness = 1.25;
PrinterXYErrorMargin = 0.4;
// "0" to 180º
CornerNumber = 4;

DecorationPattern = "Grid"; // [None, Lines, Grid]
DecorationThickness = 0.3;
DecorationSpacing = 1.68;
DecorationOffsetX = 0.75;
DecorationOffsetY = 0.85;
DecorationRotation = 0;
DecorationSize = 0.2;

BackText = "RE";
BackTextSize = 9;
BackTextOffsetX = -1;
BackTextOffsetY = 0;

/* [HIDDEN] */
decSize = DecorationSize>0.5?0.5:DecorationSize;
/* Do Stuff */

if(DecorationPattern == "Hex"){
    difference(){
        CuboCorner(CornerNumber);
        translate([0,DecorationSize])
            decoration();        
    }
}else{
    CuboCorner(CornerNumber);
    if(DecorationPattern == "Lines" || DecorationPattern == "Grid"){
        translate([0,-decSize,0]) intersection(){
            CuboCorner(CornerNumber);
            decoration();
        }
    }
}
module CuboCorner(ExitsNumber){
    bt = BoardThickness+PrinterXYErrorMargin;
    
    translate([-bt/2-CornerThickness,0,-bt/2-CornerThickness]) 
        cube([bt+CornerThickness,bt,bt+CornerThickness*2]);
    if(len(BackText)>0) textStuff();
        
    qtd = (ExitsNumber == 0 ? 3 : (ExitsNumber > 4 ? 4 : ExitsNumber));
    angle = 90;
    for(e=[0:qtd-1]){
        if(!(e == 1 && ExitsNumber == 0)){
            rotate(a=[0,angle*e,0]) translate([bt/2,0,-bt/2-CornerThickness])
            difference(){
                cube([bt*ThicknessSizeRatio,bt,bt+CornerThickness*2]);
                translate([CornerThickness,CornerThickness,CornerThickness])
                    cube([bt*ThicknessSizeRatio,bt,bt]);
            }
        }        
    }
}
module textStuff(){
    translate([(len(BackText)*BackTextSize/2)-1-BackTextOffsetX,
               BoardThickness-0.2,
               BackTextOffsetY-BackTextSize/2]){
        rotate(a=[90,0,180]) linear_extrude(height=1)
            text(BackText,size=BackTextSize);
    }
}
module decoration(){    
    size = (floor(BoardThickness*(ThicknessSizeRatio+3)));
    translate([DecorationOffsetX,0,DecorationOffsetY]) rotate(a=[0,DecorationRotation]){
        if(DecorationPattern == "Lines" || DecorationPattern == "Grid"){        
            decorationLines(size);
        }
        if(DecorationPattern == "Grid"){        
            rotate(a=[0,90]) decorationLines(size);
        }        
        if(DecorationPattern == "Hex"){            
            step = DecorationSpacing;
            size = (floor(BoardThickness*(ThicknessSizeRatio+3)));
            interactions = size/step;
            rotate(a=[90,0]){                    
                for(y=[-interactions/2:interactions/2+1]){
                    for(x=[-1-interactions/2:interactions/2+1]){                            
                        add = (floor(y)%2==0) ? 0 : step/2;
                        yPos = y*(step-0.3);
                        xPos = x*step+add;
                        if((xPos < BoardThickness && xPos > -BoardThickness) || 
                           (yPos < BoardThickness && yPos > -BoardThickness)){
                            translate([yPos,xPos]) // trocado pois rotaciona
                                cylinder(d=DecorationSpacing*1.1-DecorationThickness,h=0.5,$fn=6);
                        }                            
                    }
                }
            }
        }        
    }
}
module decorationLines(size){
    step = (DecorationThickness+DecorationSpacing);
    for(i=[-1:size/step+1]){
        translate([0,0,i*step-size/2])
            cube([size*1.2,1,DecorationThickness],center=true);
    }
}



