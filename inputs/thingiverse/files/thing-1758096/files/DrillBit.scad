/* [General] */
PrinterXYErrorMargin = 0.4;

PrintMode = "True"; // [True;False]
PrintBigBox = "True"; // [True;False]
PrintBitBox = "True"; // [True;False]

/* [Dimensions] */
BoxWidth = 35;
BoxHeight = 10;
BoxLength = 75;
WallThickness = 1.5;

/* [Drill Bit] */
NumberOfBits = 4;
FirstSize = 1;
IncrementInMillimeters = 1;

/* [HIDDEN] */
$fn = 25;
fit = 0.5;
lockDiameter = BoxHeight/4;

//DrillBits();

if(PrintMode == "True"){
    if(PrintBigBox=="True") BigBox();
    translate([WallThickness+fit,-BoxWidth,0]) 
        if(PrintBitBox=="True") SmallBox();
}
else{
    BigBox();
    translate([WallThickness+fit,WallThickness+fit,WallThickness+fit]) 
        SmallBox();
}

module BigBox(){    
    difference(){
        cube([BoxLength,BoxWidth,BoxHeight]);
        translate([WallThickness,WallThickness,WallThickness]) 
            cube([BoxLength-2*WallThickness,BoxWidth-2*WallThickness,BoxHeight]);
        
        cutHeight = BoxHeight/2+lockDiameter/2;
        translate([WallThickness+BoxHeight/2,WallThickness/2+0.5,cutHeight]) 
            rotate(a=[-90]) LockCut();
        translate([WallThickness+BoxHeight/2,BoxWidth-WallThickness/2-0.5,cutHeight]) 
            rotate(a=[-90]) LockCut();
    }    

    translate([WallThickness+BoxHeight*2,WallThickness,BoxHeight/2+fit])
        sphere(d=lockDiameter*0.75);
    translate([WallThickness+BoxHeight*2,BoxWidth-WallThickness,BoxHeight/2+fit])
        sphere(d=lockDiameter*0.75);
    
    translate([WallThickness+BoxHeight/2,lockDiameter,BoxHeight/2+fit])
        rotate(a=[90,0]) cylinder(d2=lockDiameter,d1=lockDiameter*0.8,h=lockDiameter);
    translate([WallThickness+BoxHeight/2,BoxWidth,BoxHeight/2+fit])
        rotate(a=[90,0]) cylinder(d1=lockDiameter,d2=lockDiameter*0.8,h=lockDiameter);
}
module SmallBox(){
    bH = BoxHeight-WallThickness-fit*2;
    bW = BoxWidth-2*WallThickness-2*fit;
    
    difference(){
        union(){
            translate([BoxHeight/2,0])
               cube([BoxHeight*2,bW, bH]);
            translate([BoxHeight/2,0,bH/2])
                rotate(a=[-90])cylinder(d=bH,h=bW);
        }
        translate([bH/2,BoxWidth-WallThickness,bH/2]) 
            rotate(a=[0,-90,180]) DrillBits();
        translate([BoxHeight/2,-0.1,bH/2]){
            rotate(a=[-90]){
                cylinder(d=lockDiameter,h=lockDiameter);
                translate([0,0,bW-lockDiameter+0.2]) 
                    cylinder(d=lockDiameter,h=lockDiameter);
            }
        }
        translate([BoxHeight*2,0,bH/2]){
            sphere(d=lockDiameter+0.1);
            translate([0,bW])sphere(d=lockDiameter+0.1);
        }
    }
    
}
/* Aux */
module DrillBits(){
    bW = BoxWidth-4*WallThickness-2*fit;
    distIncrement = bW / NumberOfBits;
    for(i = [1:NumberOfBits]){        
        translate([0,i*distIncrement,0]){
            size =FirstSize+(i-1)*IncrementInMillimeters;
            cylinder(d=size+PrinterXYErrorMargin,h=BoxLength);
            translate([BoxHeight/3,-BoxHeight/4]) 
                rotate(a=[90,0,90]) linear_extrude(height=5) text(str(size),BoxHeight/2);
        }        
    }
}
module LockCut(){
    difference(){
        LockCutPattern(2*lockDiameter,WallThickness*2,BoxHeight);
        LockCutPattern(1.4*lockDiameter,WallThickness*2+1,BoxHeight+1);
    }
    
}
module LockCutPattern(d,h,w){
    hull(){
        cylinder(d=d,h=h,center=true);
        translate([0,w]) cube([d,w,h],center=true);
    }
}

