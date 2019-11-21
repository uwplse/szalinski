// in mm.  ZTE Speed is 66, Moto E4 is 72
phone_width = 72; // [54:0.5:100]

// in mm.  ZTE Speed is 10.2, Moto E4 is 9.3
phone_thickness = 9.3; //[5:0.1:20]

// in mm.  Original ServoCity clip thickness is 3.2, suggest 5 for added strength
clip_thickness=5; //[3.2:0.1:7.0]

// two clips or single clip?
two_clips="true"; //[true,false]



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

}