// in mm.  ZTE Speed is 66, Moto E4 is 72
phone_width = 72; // [54:0.5:100]

// in mm.  ZTE Speed is 10.2, Moto E4 is 9.3
phone_thickness = 9.3; //[5:0.1:20]

// in mm.  
clip_thickness=110; //[50:1:200]

// extended actobotics hole pattern?
actHoles="false"; //[true,false]

// extended goBILDA hole pattern?
gbHoles="false"; //[true,false]

// extended tetrix hole pattern?
tetHoles="false"; //[true,false]

// gap in top right?
gaptr="true"; //[true,false]

// gap in top left?
gaptl="false"; //[true,false]

// gap in bottom right?
gapbr="false"; //[true,false]

// gap in bottom left?
gapbl="false"; //[true,false]



/* [Hidden] */
ht=3.2;
cWid=3.7; // mm. width of clips

// preview[view:south, tilt:top]

i2m = 25.4; // inches to mm

// base with slots
bLen=53.3;
bWid=9.6;

/* [Hidden] */
i2m=25.4; // inches to mm
rHole=2.35; //mm
base_length=bLen; //[1.5:0.25:4.5]

rotate(180)
wholeClip();


//if (two_clips=="true") {
//translate([0,-3,0])
//mirror([0,1,0])
//wholeClip();
//}

module wholeClip() {
    
difference() {  // remove side gaps
    
union() { // base plus clips
    
difference() { // base w/ holes
    
    cube([bLen, bWid, clip_thickness]);
    
    translate([(bLen-1.5*25.4)/2, bWid-4.3, -1])
    cube([1.5*25.4, 4.3+0.01, clip_thickness+2]);
    
 //   if (clip_thickness>3.2) {
 //   translate([bLen/2-(22)/2, 0,ht])
 //   cube([22, bWid+2, clip_thickness]);
 //  }
    

    translate([bLen/2,20,clip_thickness/2])
    rotate(v=[1,0,0], a=90) {
        
       
    gobildaTetrixHoles();
if (gbHoles=="true") { 
    translate([0,24,0])
    gobildaHoles();
    
    translate([0,-24,0])
    gobildaHoles();
    
    translate([0,36,0])
    gobildaHoles();
    
    translate([0,-36,0])
    gobildaHoles();
}

if (tetHoles=="true") { 
    translate([0,32,0])
    tetrixHoles();
    
    translate([0,-32,0])
    tetrixHoles();
}

if (actHoles=="true") {    
    translate([0,1.5*25.4,0])
    actoboticsHoles();
    
    translate([0,-1.5*25.4,0])
    actoboticsHoles();
}

    
   
    actoboticsHoles();
if (actHoles=="true") {
}

}
 /*   translate([bLen/2-(13.3+0.3)/2, 2.3, -2])
    cube([13.3+0.3, ht+0.3, 10]);
    
    translate([bLen/2-1.5/2*i2m, 2.3, -2])
    cube([5,ht+0.3, 10]);
    
    translate([bLen/2+1.5/2*i2m -5, 2.3, -2])
    cube([5,ht+0.3, 10]);*/
}

clip();

translate([bLen,0,0])
mirror([1,0,0])
clip();
}

if (gaptl=="true") {
    translate([bLen,bWid+0.0001,clip_thickness*.5])
    cube([2*bLen, phone_thickness, clip_thickness*0.40]);
}

if (gaptr=="true") {
    translate([-bLen,bWid+0.0001,clip_thickness*.5])
    cube([2*bLen, phone_thickness, clip_thickness*0.40]);
}

if (gapbl=="true") {
    translate([bLen,bWid+0.0001,clip_thickness*.1])
    cube([2*bLen, phone_thickness, clip_thickness*0.400001]);
}

if (gapbr=="true") {
    translate([-bLen,bWid+0.0001,clip_thickness*.1])
    cube([2*bLen, phone_thickness, clip_thickness*0.400001]);
}

}

module clip() {
linear_extrude(height=clip_thickness)
polygon([
[0,0],
[bLen/2 - phone_width/2-cWid, bWid*0.7],
[bLen/2 - phone_width/2-cWid, bWid+phone_thickness+1],
[bLen/2 - phone_width/2-6-cWid, bWid+phone_thickness+5],
[bLen/2 - phone_width/2-5-cWid, bWid+phone_thickness+7],
[bLen/2 - phone_width/2 +2.5, bWid+phone_thickness+1.5],
[bLen/2 - phone_width/2 , bWid+phone_thickness-0.5],
[bLen/2 - phone_width/2 , bWid-0.5],
[(bLen/2 - phone_width/2)/4 , bWid*0.6],
[1,bWid*0.8]]);
}

module gobildaTetrixHoles() {
        // gobilda+tetrix holes
    hull() {
    
    translate([0 - 8, 0, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
            translate([0 - 12, 0, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
    }
    
    hull() {
    translate([0 + 8, 0, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
        
    translate([0 + 12, 0, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
    }
    
    hull() {
    translate([0 , 0 -8, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
        
    translate([0 , 0 -12, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
    }
    
    hull() {
    translate([0, 0 +8, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
        
    translate([0, 0 +12, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
    }
}

module gobildaHoles() {

    translate([0 - 12, 0, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);

        
    translate([0 + 12, 0, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);

        
    translate([0 , 0 -12, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);

        
    translate([0, 0 +12, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
}

module tetrixHoles() {

    translate([0 - 8, 0, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);

        
    translate([0 + 8, 0, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);

        
    translate([0 , 0 -8, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);

        
    translate([0, 0 +8, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
}

module actoboticsHoles() {
        // actobotics inner holes
    translate([0, 0, -2])
    rotate(45)
    translate([0.77/2*i2m, 0, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
    
    translate([0, 0, -2])
    rotate(135)
    translate([0.77/2*i2m, 0, -2])
            rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
    
    translate([0, 0, -2])
    rotate(-45)
    translate([0.77/2*i2m, 0, -2])
        rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
    
    translate([0, 0, -2])
    rotate(-135)
    translate([0.77/2*i2m, 0, -2])
        rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
    
    // actobotics outer holes
    translate([0, 0, -2])
    rotate(45)
    translate([0.75*i2m, 0, -2])
        rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
    
    translate([0, 0, -2])
    rotate(135)
    translate([0.75*i2m, 0, -2])
        rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
    
    translate([0, 0, -2])
    rotate(-45)
    translate([0.75*i2m, 0, -2])
        rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
    
    translate([0, 0, -2])
    rotate(-135)
    translate([0.75*i2m, 0, -2])
    rotate(180/8)
    cylinder(h=100, r=rHole, $fn=8);
}
}