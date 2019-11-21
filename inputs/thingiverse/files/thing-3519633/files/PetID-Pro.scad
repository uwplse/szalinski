Type="Single"; //[Single,Double]
Size="Standard";//[Standard,Small]
YourText=["Name","+43 000 000 000 00"];
FontNames=["Pacifico","Helvetica"];
FontHeight=[7,4];
FontOffset=[0,0];
DoubleAngle=0;
Length=58;
Brim="yes"; //[yes,no]
BaseHeight=2;
TextHeight=1;
//--------------------
if(Type=="Single") {
    if(Size=="Small") {
        scale([0.85,0.85,0.85]){
            Simple();
        }
    }
    else {
         Simple();
    }
}
else {
    if(Size=="Small") {
        scale([0.85,0.85,0.85]){
            Double();
        }
    }
    else {
        Double();
    }
}
//--------------------
module Double() {
    color("darkorange")
    linear_extrude(height=BaseHeight/2) {
        Bone_Shape(Length,0,"yes");
    }
    translate([0,0,BaseHeight/2]){
        if(Brim=="yes"){
            color("black")
            linear_extrude(height=TextHeight) {
                difference(){
                    Bone_Shape(Length,0);
                    offset(delta=-1,chamfer=true)
                    Bone_Shape(Length,0);
                }
            }
        }
        color("black")
        for(i=[0:0]){
            Bone_Text(Length,0-FontHeight[i]/2-12-FontOffset[i],TextHeight,YourText[i],FontNames[i],FontHeight[i]);
        }
    }
    translate([35,0,0]) {
        color("darkorange")
        linear_extrude(height=BaseHeight/2) {
            Bone_Shape(Length,0,"yes");
        }
        translate([0,0,BaseHeight/2]){
            if(Brim=="yes"){
                color("black")
                linear_extrude(height=TextHeight) {
                    difference(){
                        Bone_Shape(Length,0);
                        offset(delta=-1,chamfer=true)
                        Bone_Shape(Length,0);
                    }
                }
            }
            color("black")
            for(i=[1:1]){
                Bone_Text(Length,0-FontHeight[i]/2-12-FontOffset[i],TextHeight,YourText[i],FontNames[i],FontHeight[i],DoubleAngle);
            }
        }
    }
}
//--------------------
module Simple() {
    color("darkorange")
    linear_extrude(height=BaseHeight) {
        Bone_Shape(Length,0,"yes");
    }
    translate([0,0,BaseHeight]){
        if(Brim=="yes"){
            color("black")
            linear_extrude(height=TextHeight) {
                difference(){
                    Bone_Shape(Length,0);
                    offset(delta=-1,chamfer=true)
                    Bone_Shape(Length,0);
                }
            }
        }
        color("black")
        for(i=[0:1]){
            Bone_Text(Length,0-FontHeight[i]/2-8.5*(i+1)-FontOffset[i],TextHeight,YourText[i],FontNames[i],FontHeight[i]);
        }
    }
}
//--------------------
module Bone_Shape(length,height,ring="no") {
// left
    translate([8,8,0])
    circle(r=16/2,$fn=100);
    translate([20,8,0])
    circle(r=16/2,$fn=100);
// middle        
    translate([6,8,0])
    square([17,length-16]);
// right
    translate([8,length-8,0])
    circle(r=16/2,$fn=100);
    translate([20,length-8,0])
    circle(r=16/2,$fn=100);
// ring
    if(ring=="yes"){
        difference(){
            translate([4.5,length/2,0])
            circle(r=8/2,$fn=100);
            translate([4.5,length/2,-1])
            circle(r=4/2,$fn=100);
        }
    }
}
//--------------------
module Bone_Text(length,offset,height,txt,fname,fsize,angle=0){
    rotate(90)
    translate([length/2,offset,0])
    rotate(angle)
    linear_extrude(height=height)
    text(txt,font=fname,size=fsize,halign="center",valign="center");
}
//--------------------