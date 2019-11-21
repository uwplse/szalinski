/* [Fine Tuning] */
//wiggle room (pcb)
w=0.5;
//Nozzle size (for single walls)
n=0.4;
//wiggle room (pegs)
wp=0.25;

/* [USB Size] */
//USB Tip X
utx=10.65;
usbTipX=utx+w;
//USB Body X
ubx=14.11;
usbBodyX=ubx+w;

usbTipY=11.2;
//USB Body Y
uby=22.2;
usbBodyY=uby+w;

usbTipZ=1.17;
usbBodyZ=1.42;

/* [Other] */
//Part to create
part = "Both Seperate"; // [Top,Bottom,Both Seperate,Both Together]
lockSymbol=true;
topHeight=2;

/* [Hidden] */
finalTipZ=2.3;
finalTipX=usbTipX+n*2;//12.05;
finalBodyX=usbBodyX+n*6;//16.5;
finalY=usbTipY+usbBodyY+n*3;
finalTipYPlugDepth=10;
$fn=128;

if (part=="Top") {
    caseTop();
} else if (part=="Bottom") {
    caseBottom();
} else if (part=="Both Together") {
    //#usb();
    caseBottom();
    caseTop();
} else if (part=="Both Seperate") {
    caseBottom();
    translate([finalBodyX+5,0,-finalTipZ])caseTop();
}

module usb(extraZ=0,extraY=0){
    union()translate([0,0,finalTipZ-usbBodyZ]){
        translate([-usbTipX/2,-extraY,usbBodyZ-usbTipZ])
        color("green")cube([usbTipX,usbTipY+0.1+extraY,usbTipZ+extraZ]);
        translate([-usbBodyX/2,usbTipY,0])color("darkgreen")cube([usbBodyX,usbBodyY,usbBodyZ+extraZ]);
    }
}

module caseBottom(wp=0){
    difference(){
        color("orange")
        union(){
            translate([-finalTipX/2,0,0])cube([finalTipX,finalY,finalTipZ]);
            translate([-finalBodyX/2,finalTipYPlugDepth,0])cube([finalBodyX,finalY-finalTipYPlugDepth,finalTipZ]);
        }
        usb();
        usb(extraZ=1,extraY=1);
    }
    pegWidth=4+wp*2;
    echo (pegWidth=pegWidth);
    for(i=[-1,1]){
        translate([-pegWidth/2+usbBodyX/4*i,finalY-((finalY-usbBodyY-usbTipY)/2)-(n*3)/2-wp,finalTipZ])
        cube([pegWidth,n*3+wp,topHeight]);
    }
    for(i=[-1,1]){
        translate([-(n*3+wp)/2+(usbBodyX/2+(n*3-wp)/2)*i,-pegWidth/2+usbTipY+usbBodyY/2,finalTipZ])
        cube([n*3+wp,pegWidth,topHeight]);
    }
}

module caseTop(){
    difference(){
            union(){
            translate([-finalBodyX/2,finalTipYPlugDepth,finalTipZ])cube([finalBodyX,finalY-finalTipYPlugDepth,topHeight]);
        }
        translate([-(finalBodyX+1)/2,finalTipYPlugDepth,finalTipZ+0.1])rotate([11,0,0])cube([finalBodyX+1,usbBodyY/2,topHeight]);
        caseBottom(wp=wp);
    }
    //Lock symbol
    if (lockSymbol) {
        lockSize=8;
        lockHeight=0.3;
        cornerRad=1;
        color("orange")translate([-lockSize/2,usbTipY+usbBodyY-(usbBodyY/2),finalTipZ+topHeight]){
            hull(){
                translate([0,lockSize/3*2-cornerRad,0])cube([lockSize,cornerRad,lockHeight]);
                translate([cornerRad,cornerRad,0])cylinder(r=cornerRad,h=lockHeight);
                translate([lockSize-cornerRad,cornerRad,0])cylinder(r=cornerRad,h=lockHeight);
            }
            translate([lockSize/2,lockSize/3*2,0]) {
                difference(){
                    cylinder(r=lockSize/2-cornerRad/2,h=lockHeight);
                    cylinder(r=lockSize/2-cornerRad/2-1,h=lockHeight+0.1);
                }
            }
        }
    }
}














