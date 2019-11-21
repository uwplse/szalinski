//include<shortcuts.scad>; // translation and rotation shortcuts.


//////DESCRIPTION
//Snapshot: 28/07/16
//A fun little posable robot that prints as one piece. 
//Comes off the print bed with moving limbs straight away.
//Add a little support underneath the legs and antenna for best print quality.

//Inspired by Robot Keychain Accessory http://www.thingiverse.com/thing:384213
//by jcubed111


//////SETTINGS
//Adjust these parameters to make the joints fit.
//These settings work with a stock Lulzbot Taz 5 printed in ABS with 20 to 25% infill

lFit=0.4;       // lego foot fit tolerance. Adjust to make foot fit on lego studs
legHole=5.5; //shrink this if legs too loose
legWidth=6.1;
shoulderBoneWidth=3.8; //shrink if arms stick too much
shoulderBoneDia=5.7; //shrink if arms stick too much
chestLogo=0; //0 for dial, 1 for BHiveLabs logo
//chestLogo=1;


$fn=50;
///////////ASSEMBLY/////////////////
body();
tx(-15) rightArm();
tx(15) leftArm();
tx(-5) rightLeg();
tx(+5) leftLeg();

module rightLeg(){
  e=2.5;
  jh=10-1/2;
  jt=10;//leg thickness
  bt=10;//body thickness
  //joint
  ty(-6) tz(bt/2) difference(){
    cube([legWidth,jh,jt],center=true);
    ry(90) cylinder(d=legHole,h=legWidth+2,center=true);
    ty(-jh/2) tz(jt/2) rx(45) cube([legWidth+2,e,e],center=true);
    ty(-jh/2) tz(-jt/2) rx(45) cube([legWidth+2,e,e],center=true);
    ty(jh/2) tz(-jt/2) rx(45) cube([legWidth+2,e,e],center=true);
    ty(jh/2) tz(jt/2) rx(45) cube([legWidth+2,e,e],center=true);
  }
  //leg
  ll=12;//leg length
  os=sqrt(2*(e/2)*(e/2));//offset of rotated chamfer cube
  ty(-6-jh/2-ll/2) tz(bt/2) cube([legWidth,ll,jt-2*os],center=true);
  //foot
  fh=5; //foot height
  fw=legWidth+2*os; //foot width
  fl=12; //foot length
  tx(-fw/2) ty(-6-jh/2-ll-fh) difference(){
    cube([fw,fh,fl]);
    //lego footprint. Need to be 8mm apart so move in by 1mm
    tx(fw/2+1-8) tx(-7.8/2) ty(-9.6-0.01) tz(ll) rx(-90) brick2x2();
   //tx(fw/2+1-16) tx(-7.8/2) ty(-9.6-0.01) tz(ll) rx(-90) brick2x2(); //lego footprint
    //chamfers
    tx(fw/2) ty(fh) tz(fl) rx(45) cube([fw+2,e,e],center=true);
    ty(fh) tz(fl/2) rz(45) cube([e,e,fl+2],center=true);
    tx(fw) ty(fh) tz(fl/2) rz(45) cube([e,e,fl+2],center=true);
    tx(0) ty(fh/2) tz(fl) ry(45) cube([e,fh+2,e],center=true);
    tx(fw) ty(fh/2) tz(fl) ry(45) cube([e,fh+2,e],center=true);
    tx(0) ty(fh-e/2) tz(fl) ry(45) rz(-45)  cube([e,fh+2,e],center=true);
    tx(fw) ty(fh-e/2) tz(fl) ry(-45) rz(45)  cube([e,fh+2,e],center=true);
  }
}

module leftLeg(){
  mirror([1,0,0]) rightLeg();
}
module rightArm(){
  at=10;
  e=2.5;//edge length to chamfer
  os=sqrt(2*(e/2)*(e/2));//offset of rotated chamfer cube
  ty(5) difference(){ //shoulder
    tz(at/2) cube([at-3,at,at],center=true);
    tz(at/2){//remove hole for shoulder joint  
      tx(-2.25) ry(90) cylinder(d=7,h=4.5);
      tx(-2) ry(90) cylinder(d=5,h=7);
    }
    //chamfer shoulder
    tx(-(at-3)/2) tz(0) ry(45) cube([e,at+2,e],center=true);
    tx(-(at-3)/2) tz(at) ry(45) cube([e,at+2,e],center=true);
    //tx((at-3)/2) tz(at) ry(45) cube([e,at+2,e],center=true);
    //tx((at-3)/2) tz(0) ry(45) cube([e,at+2,e],center=true);
    tz(at) ty(at/2) rx(45) cube([(at-3)+2,e,e],center=true);
    tz(at) ty(-at/2) rx(45) cube([(at-3)+2,e,e],center=true);
    tz(0) ty(at/2) rx(45) cube([(at-3)+2,e,e],center=true);
    tz(0) ty(-at/2) rx(45) cube([(at-3)+2,e,e],center=true);
    tx(-(at-3)/2) ty(-at/2) tz(at/2) rz(45) cube([e,e,at+2],center=true);
    tx(-(at-3)/2) ty(at/2) tz(at/2) rz(45) cube([e,e,at+2],center=true);
    tx(-(at-3)/2) ty(-at/2) tz(at-os+0.5) rz(45) ry(45) cube([e,e,at+2],center=true);
    tx(-(at-3)/2) ty(at/2) tz(at-os+0.5) rz(-45) ry(45) cube([e,e,at+2],center=true);
  }
  aw=at-3-os;//arm width
  ah=at-2*os;//arm height
  al=10-1; //arm length  
  tx(os/2) ty(5) tz(at+al/2) difference(){//armbone
    cube([aw,ah,al],center=true);
    //chamfers
    ee=1.1;
    tx(-aw/2) ty(-ah/2) rz(45) cube([ee,ee,al+2],center=true);
    tx(-aw/2) ty(ah/2) rz(45) cube([ee,ee,al+2],center=true);
  }
  //hand
  //make octagonal 
  hl=10;
  hw=10-3;
  hh=10;
  cw=hl*hl/(hl*cos(360/16));
  tx(0.6) ty(5) tz(at+al+hl/2-1.2) difference(){ //z distance is a bodge at moment. check maths****************************
    ry(90) rz(360/8/2) cylinder(d=cw,h=hw,$fn=8,center=true);
    tx(-hw/2) tz(-hh/2) ry(45) cube([e,hl+2,e],center=true);//chamfer
    tx(hw/2) tz(-hh/2) ry(45) cube([e,hl+2,e],center=true);//chamfer
    ry(90) rz(360/8/2) cylinder(d=6,h=hw+2,$fn=8,center=true);
    //tz(3) cube([hw+2,7*(cos(360/16)),5],center=true);
    tz(3) cube([hw+2,5,5],center=true);
  }
}

module leftArm(){
  mirror([1,0,0]) rightArm();
}

module body(){
  bt=10; //body thickness 8 mm
  bw=22;//body width
  bh=20;//body height
  ht=10; //head thickness 8 mm
  hw=16;//headwidth
  hh=14;//head height
  nt=6.3;
  nw=hw-7;
  nh=2;
  tz(bt/2){  
    difference(){ // main chamfered body
      cube([bw,bh,bt],center=true);
      e=2.5;//edge length to chamfer
      //vertical chamfers
      tx(-bw/2) tz(bt/2) ry(45) cube([e,bh+2,e],center=true);
      tx(-bw/2) tz(-bt/2) ry(45) cube([e,bh+2,e],center=true);
      tx(bw/2) tz(-bt/2) ry(45) cube([e,bh+2,e],center=true);
      tx(bw/2) tz(bt/2) ry(45) cube([e,bh+2,e],center=true);
      //horizontal chamfers
      ty(-bh/2) tz(bt/2) rx(45) cube([bw+2,e,e],center=true);
      ty(-bh/2) tz(-bt/2) rx(45) cube([bw+2,e,e],center=true);
      ty(bh/2) tz(-bt/2) rx(45) cube([bw+2,e,e],center=true);
      ty(bh/2) tz(bt/2) rx(45) cube([bw+2,e,e],center=true);
      //other chamfers
      tx(-bw/2) ty(bh/2) rz(45) cube([e,e,bt+2],center=true);
      tx(-bw/2) ty(-bh/2) rz(45) cube([e,e,bt+2],center=true);
      tx(bw/2) ty(-bh/2) rz(45) cube([e,e,bt+2],center=true);
      tx(bw/2) ty(bh/2) rz(45) cube([e,e,bt+2],center=true);
      //dial
//      if(chestLogo==1){
//        tx(-bw/2+5.5) ty(-1.7) tz(bt/2-0.5) rz(90) linear_extrude(1) text("BHive",font = "Nimbus sans:style=Bold",2.5);
//        tx(-bw/2+9) ty(-1.7) tz(bt/2-0.5) rz(90) linear_extrude(1) text("Labs",font = "Nimbus sans:style=Bold",2.5);
//      }
//      else{
      if(chestLogo==0){
        ty(-3) tz(bt/2-1) difference(){
          cylinder(d=18,h=2);
          tz(-1) cylinder(d=10,h=4);
          ty(-20) tz(-1) rz(33) cube([10,30,4]);
          ty(-20) tz(-1) rz(-33) tx(-10) cube([10,30,4]);
          rz(10) tz(-0.5) cube([1.5,16,3],center=true);
        }
      }
      //holes for legs
      legWidth=7;//leg hole width
      lh=8;//leg hole height
      tx(-5) ty(-bh/2+(lh+1)/2-1) cube([legWidth,lh+1,bt+2],center=true);
      tx(5) ty(-bh/2+(lh+1)/2-1) cube([legWidth,lh+1,bt+2],center=true);
      os=sqrt(2*(e/2)*(e/2));//offset of rotated chamfer cube
      tx(-5) ty(-bh/2+lh) tz(bt/2-os) rx(45) cube([legWidth,e,e],center=true);
      tx(-5) ty(-bh/2+lh) tz(-bt/2+os) rx(45) cube([legWidth,e,e],center=true);
      tx(-5-legWidth/2) ty(-bh/2+lh-1) tz(-bt/2+os) cube([legWidth,1+os,bt-2*os]);
      tx(5) ty(-bh/2+lh) tz(bt/2-os) rx(45) cube([legWidth,e,e],center=true);
      tx(5) ty(-bh/2+lh) tz(-bt/2+os) rx(45) cube([legWidth,e,e],center=true);
      tx(5-legWidth/2) ty(-bh/2+lh-1) tz(-bt/2+os) cube([legWidth,1+os,bt-2*os]);
      
    }
    if(chestLogo==1){
      ty(3) tz(bt/2-0.25) BHiveLabsLogo(hexSize=5,t=1.5,h=1);
//      tx(-bw/2+2) ty(5) tz(bt/2-0.25) color("black") linear_extrude(1) text("BHive",2);
//      tx(-bw/2+3.2) ty(2.5) tz(bt/2-0.25) color("black") linear_extrude(1) text("Labs",2);
      
    }
    else{
      ty(-3) tz(bt/2) difference(){
        difference(){ //dial's bevel
            cylinder(d=18+2,h=0.5);
            tz(-1) cylinder(d=10-2,h=4);
            ty(-20) tz(-1) rz(33+2) cube([10,30,4]);
            ty(-20) tz(-1) rz(-33-2) tx(-10) cube([10,30,4]);
            //rz(10) tz(-0.5) cube([1.5,16,2],center=true);
          }
          difference(){ //dial's bevel
            tz(-1) cylinder(d=18,h=2+2);
            tz(-1) cylinder(d=10,h=2+2);
            ty(-20) tz(-1) rz(33) cube([10,30,4]);
            ty(-20) tz(-1) rz(-33) tx(-10) cube([10,30,4]);
            //#rz(10) tz(-0.5) cube([1.5,16,2],center=true);
          }
        }
      }
    //leg attachment cylinder
    ty(-6) ry(90) cylinder(d=4,h=bw-2,center=true);
    //head
    ty(bh/2+hh/2+nh) difference(){ // main chamfered body
      cube([hw,hh,ht],center=true);
      e=2.5;//edge length to chamfer
      //vertical chamfers
      tx(-hw/2) tz(ht/2) ry(45) cube([e,hh+2,e],center=true);
      tx(-hw/2) tz(-ht/2) ry(45) cube([e,hh+2,e],center=true);
      tx(hw/2) tz(-ht/2) ry(45) cube([e,hh+2,e],center=true);
      tx(hw/2) tz(ht/2) ry(45) cube([e,hh+2,e],center=true);
      //horizontal chamfers
      ty(-hh/2) tz(ht/2) rx(45) cube([hw+2,e,e],center=true);
      ty(-hh/2) tz(-ht/2) rx(45) cube([hw+2,e,e],center=true);
      ty(hh/2) tz(-ht/2) rx(45) cube([hw+2,e,e],center=true);
      ty(hh/2) tz(ht/2) rx(45) cube([hw+2,e,e],center=true);
      //other chamfers
      tx(-hw/2) ty(hh/2) rz(45) cube([e,e,ht+2],center=true);
      tx(-hw/2) ty(-hh/2) rz(45) cube([e,e,ht+2],center=true);
      tx(hw/2) ty(-hh/2) rz(45) cube([e,e,ht+2],center=true);
      tx(hw/2) ty(hh/2) rz(45) cube([e,e,ht+2],center=true);
      //eyes
      tx(-2.5) ty(1.5) tz(ht/2) rz(45) cube([3,3,3],center=true);
      tx(2.5) ty(1.5) tz(ht/2) rz() cube([3,3,3],center=true);
      //mouth
      for(x=[-4:2:4]) tx(x) ty(-3) tz(ht/2) rz() cube([1,3,3],center=true);
    }
    //ears
    ty(bh/2+hh/2+nh+1) tx(-hw/2+0.5) sphere(d=4,$fn=8);
    ty(bh/2+hh/2+nh+1) tx(hw/2-0.5) sphere(d=4,$fn=8);
    //antenna
    ty(bh/2+hh/2+nh+hh/2){
//      tz(-0.25) #rx(-105) cylinder(d1=2,d2=1,h=4.3);
      tz(-0.9) rx(-95) cylinder(d1=2,d2=1,h=4.3);
      rx(-90) cylinder(d1=2,d2=1,h=4);
      ty(4) ry(90) sphere(d=4,$fn=8);
    }
    //neck
    ty(bh/2+nh/2) difference(){ // main chamfered body
      cube([nw,nh,nt],center=true);
      e=2.5;//edge length to chamfer
      //vertical chamfers
      tx(-nw/2) tz(nt/2) ry(45) cube([e,nh+2,e],center=true);
      tx(-nw/2) tz(-nt/2) ry(45) cube([e,nh+2,e],center=true);
      tx(nw/2) tz(-nt/2) ry(45) cube([e,nh+2,e],center=true);
      tx(nw/2) tz(nt/2) ry(45) cube([e,nh+2,e],center=true);
    }
    //shoulder bones
    ty(5) ry(90) cylinder(d=4.5,h=bw+10,center=true);
    tx(-(bw+8)/2) ty(5) ry(90) cylinder(d=shoulderBoneDia,h=shoulderBoneWidth,center=true); //V1: d=6,h=4
    tx((bw+8)/2) ty(5) ry(90) cylinder(d=shoulderBoneDia,h=shoulderBoneWidth,center=true);//V1: d=6,h=4
  }
}

//lego brick hole cut outs
module brick2x2(){// with clearance of 0.35mm
  cube([15.8,15.8,9.6]);
  translate([15.8/2,15.8/2,9.6]){
    tx(4) ty(4) cylinder(d=4.8+lFit,h=1.7+0.5);
    tx(-4) ty(4) cylinder(d=4.8+lFit,h=1.7+0.5);
    tx(4) ty(-4) cylinder(d=4.8+lFit,h=1.7+0.5);
    tx(-4) ty(-4) cylinder(d=4.8+lFit,h=1.7+0.5);
  }
}  

module BHiveLabsLogo(hexSize=50,t=3,h=2){
  d=hexSize;
  //d=50;
  //r=d/2;
  //t=3;
  //h=2;
  boxX=3/2*d+d/2*sin(30);
  boxY=2*d*cos(30);
  //echo(boxX,boxY);
  tx(-boxX/2) ty(-boxY/2){
    intersection(){
      tx(d/2) ty(d/2*cos(30)) union(){
        for(i=[0:60:300]) trtheta(r=d*cos(30),theta=i) hexagon(d=d,t=t,h=h,c="black");
        for(i=[0:60:330]) trtheta(r=2*d*cos(30),theta=i) hexagon(d=d,t=t,h=h,c="black");
        for(i=[30:60:360]) trtheta(r=d/2+2*d*sin(30),theta=i) hexagon(d=d,t=t,h=h,c="black");  
      }
      tx(boxX/2) ty(boxY/2) box(boxX=boxX,boxY=boxY,t=t,h=h,solid=true);
    }
    tx(boxX/2) ty(boxY/2) box(boxX=boxX,boxY=boxY,t=t,h=h,solid=false);
    tx(d/2) ty(d/2*cos(30)) hexagon(d=d-t+0.05,t=t,h=h-0.25,solid=true,c="yellow");
  }
}

module hexagon(d,t,h,solid=false,c="black"){
  color(c) difference(){
    cylinder(d=d+t/2,h=h,$fn=6);
    if(solid==false) tz(-1) cylinder(d=d-t/2,h=h+2,$fn=6);
  }
}

module box(boxX,boxY,t,h,solid=false,c="black"){
  color(c) difference(){
    translate([-boxX/2-t/4,-boxY/2-t/4,0]) cube([boxX+t/2,boxY+t/2,h]);
    if(solid==false) translate([-boxX/2+t/4,-boxY/2+t/4,-1]) cube([boxX-t/2,boxY-t/2,h+2]);
  }
}

// helper modules to speed up code writing
module tx(x){translate([x,0,0]) children();}
module ty(y){translate([0,y,0]) children();}
module tz(z){translate([0,0,z]) children();}
module trtheta(r,theta){ //translate in [x,y] by entering [r,θ]
  tx(r*sin(theta)) ty(r*cos(theta)) children();
}
module rx(x){rotate([x,0,0]) children();}
module ry(y){rotate([0,y,0]) children();}
module rz(z){rotate([0,0,z]) children();}