// in mm.  ZTE Speed is 66, Moto E4 is 72
phone_width = 72; // [54:0.5:100]

// in mm.  ZTE Speed is 10.2, Moto E4 is 9.3
phone_thickness = 9.3; //[5:0.1:20]

// in mm.  Original ServoCity clip thickness is 3.2, suggest 5 for added strength
clip_thickness=5; //[3.2:0.1:7.0]

// two clips or single clip?
two_clips="false"; //[true,false]

// hi res? may not work in customizer. :(
hi_res="false";

// preview[view:south, tilt:top]

/* [Hidden] */
ht=3.2;
cWid=3.7; // mm. width of clips

i2m = 25.4; // inches to mm

// base with slots
bLen=53.3;
bWid=9.6;

wholeClip();


if (two_clips=="true") {
translate([0,-3,0])
mirror([0,1,0])
wholeClip();
}

module wholeClip() {

difference() {
    
    cube([bLen, bWid, clip_thickness]);
    
    if (clip_thickness>3.2) {
    translate([bLen/2-(22)/2, 0,ht])
    cube([22, bWid+2, clip_thickness]);
    }
    
    translate([bLen/2-(13.3+0.3)/2, 2.3, -2])
    cube([13.3+0.3, ht+0.3, 10]);
    
    translate([bLen/2-1.5/2*i2m, 2.3, -2])
    cube([5,ht+0.3, 10]);
    
    translate([bLen/2+1.5/2*i2m -5, 2.3, -2])
    cube([5,ht+0.3, 10]);
}

clip();

translate([bLen,0,0])
mirror([1,0,0])
clip();
}

module clip() {
    
degr=10;
    
difference() {
union() {
// original clip    
linear_extrude(height=clip_thickness)
polygon([
[0,0],
[bLen/2 - phone_width/2-cWid, bWid*0.9],
[bLen/2 - phone_width/2-cWid, bWid+phone_thickness+1],
[bLen/2 - phone_width/2-6-cWid, bWid+phone_thickness+5],
[bLen/2 - phone_width/2-5-cWid, bWid+phone_thickness+7],
[bLen/2 - phone_width/2 +2.5, bWid+phone_thickness+1.5],
[bLen/2 - phone_width/2 , bWid+phone_thickness-0.5],
[bLen/2 - phone_width/2 , bWid],
     
[(bLen/2 - phone_width/2)/2 , bWid*0.8],
    
[0,bWid*0.8],
[1,bWid*0.8]]);

    
// 1/4 circle base
translate([0,bWid*0.9,0])
scale([bLen/2 - phone_width/2-cWid, bWid*0.9, 1])
rotate(180) quarterCylinder(60);
}

translate([(bLen/2 - phone_width/2)/2,bWid*0.8,-1])
cube([-(bLen/2 - phone_width/2)/2,bWid*(1-0.8), 1000]);

translate([(bLen/2 - phone_width/2)/2,bWid,0])
scale([(bLen/2 - phone_width/2)/2, bWid*0.4, 1])
rotate(180) quarterCylinder(32);

translate([(bLen/2 - phone_width/2)/2,bWid*0.6+bWid*0.2/(1-cos(degr)),0])
scale([(bLen/2 - phone_width/2)/4/(sin(degr)), bWid*0.2/(1-cos(degr)), 1])
rotate(-270) quarterCylinder(120);


}

intersection() {
if (hi_res=="true") {
translate([0.0*(bLen/2 -phone_width/2)/4,bWid-bWid*0.2/(1-cos(degr)),0])
scale([(bLen/2 - phone_width/2)/4/(sin(degr)), bWid*0.2/(1-cos(degr)), 1]) 
rotate(270)
quarterCylinder(120);
} else {
translate([0.0*(bLen/2 -phone_width/2)/4,bWid-bWid*0.2/(1-cos(degr)),0])
scale([(bLen/2 - phone_width/2)/4/(sin(degr)), bWid*0.2/(1-cos(degr)), 1]) 
rotate(270)
scale([1,1.075,1])
quarterCylinder(120);
}
    
translate([(bLen/2 - phone_width/2)/3,bWid*0.5,0])
cube(100);
    
}

module quarterCylinder(ne) {
rotate(180)
difference() {
  //  rotate(180/(ne*0.5))
if (hi_res=="true") {
cylinder(h=clip_thickness, r=1, $fn=ne*2);
} else {
cylinder(h=clip_thickness, r=1, $fn=ne*0.5);
}
translate([50, 0, -1]) 
    scale([-1,1,1])
cube(100);
translate([0, -50, -1]) scale([-1,1,1])
cube(100);
}
}

}