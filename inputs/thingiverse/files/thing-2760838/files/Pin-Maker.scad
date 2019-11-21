//Diameter of pin bottom
baseDiam = 12; 
//Diameter of pin inner cylinder 
innerDiam = 8; 

//Thickness of pin bottom
baseHeight = 2; 
//Length of inner cylinder
innerHeight = 6.4; 

//Diameter of hook
hookDiam = innerDiam + 2; 

//Height of hook 
hookHeight = 2; 

//Width of inner slot
innerWidth = 2; 

//Angle of chamfer
chamferAngle = 45; 

//Overall width of pin
pinWidth = 3; 

//Make double sided?
doubleSided = "no"; //[no,yes] 

module pinSection(diam, height, trans){
    translate([0,0,trans])
        linear_extrude(height = height, center = false, convexity = 10, twist = 0)
        circle(d=diam);
}

module hookSection(diam, height, trans, angle){
    topDiam = diam/2 - (height/tan(angle));
    pinSection(diam, 0.5, trans);
    translate([0,0,trans+0.5])
    cylinder(height, diam/2, topDiam, center = false);
}

module slotCut(trans, height, width){
    translate([0,0,trans])
    linear_extrude(height = height+1, center = false, convexity = 10, twist = 0)
    square([width,baseDiam], center = true);
}

module sideCut(thickness, height, width){
    translate([0,thickness,0])
    linear_extrude(height = height, center = false, convexity = 10, twist = 0)
    square([width,width], center = false);
}

module pin($fn = 100){
    pinSection(baseDiam, baseHeight);

    difference(){
        pinSection(innerDiam, innerHeight, baseHeight);
        slotCut(baseHeight, innerHeight, innerWidth);
    }

    difference(){
        hookSection(hookDiam, hookHeight, innerHeight+baseHeight, chamferAngle);        
        slotCut(innerHeight+baseHeight, hookHeight, innerWidth);
    }
    
    
}

module generatePin(){
    difference(){
        pin();
        sideCut(pinWidth,innerHeight + baseHeight+hookHeight+1,baseDiam);
        mirror([1,0,0]) sideCut(pinWidth,innerHeight + baseHeight+hookHeight+1,baseDiam);
        mirror([0,1,0]) sideCut(pinWidth,innerHeight + baseHeight+hookHeight+1,baseDiam);
        mirror([0,1,0]) mirror([1,0,0]) sideCut(pinWidth,innerHeight + baseHeight+hookHeight+1,baseDiam);
    }
}


if(doubleSided == "yes"){
    generatePin();
    mirror([0,0,-1]) generatePin();
}
else{
    generatePin();
}
