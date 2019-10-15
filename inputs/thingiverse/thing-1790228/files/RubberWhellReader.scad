WheelExternalDiameter = 16;
WheelInternalDiameter = 6;
WheelHeight = 12;

ScrewDiameter = 3;
NutExternalSize = 6;

EncoderTeeth = 10;

Mode = "Print"; // [Print, View]

/* [HIDDEN] */

$fn=50;
if(Mode == "View"){
    translate([0,0,5]) 
        rubberWheel(WheelExternalDiameter,WheelInternalDiameter,WheelHeight);
    wheelHolder(0);
    translate([0,0,10+WheelHeight]) 
        rotate(a=[180,0]) wheelHolder(EncoderTeeth);
}else{
    translate([-WheelExternalDiameter,0,0]) 
        wheelHolder(0);
    translate([WheelExternalDiameter,0,0]) 
        wheelHolder(EncoderTeeth);
}
module wheelHolder(EncoderTeeth=0){    
    h = 2;
    encSize = 7;
    s = EncoderTeeth<1 ? WheelExternalDiameter:WheelExternalDiameter+encSize;
    difference(){
        union(){
            cylinder(d=s,h=h);
            cylinder(d=WheelInternalDiameter,h=h+WheelHeight/3);
        }
        translate([0,0,-1]) 
            cylinder(d=ScrewDiameter,h=WheelHeight);
        translate([0,0,-.1])
            cylinder(d=NutExternalSize,h=1,$fn=6);            
        if(EncoderTeeth>0){
            for(t=[1:EncoderTeeth]){
                w = (PI*s)/(EncoderTeeth*4);
                rotate(a=[0,0,t*360/EncoderTeeth])                
                    translate([s/2-encSize+1,-w/2,-.1]) 
                        cube([encSize,w,h*2]);
            }
        }
    }
}

module rubberWheel(ExD,InD,h){
    difference(){
        cylinder(d=ExD,h=h);
        translate([0,0,-1]) cylinder(d=InD,h=h+2);
    }
}