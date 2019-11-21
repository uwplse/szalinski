part="all"; // [all:Preview All 6 Types,any3:3-to-1 "Any" Port,hay:2-to-1 "Hay" Port,sheep:2-to-1 "Sheep" Port,ore:2-to-1 "Ore" Port,wood:2-to-1 "Wood" Port,brick:2-to-1 "Brick" Port]

/* [Hidden] */
font="Helvetica";

if(part=="all") {
  translate([0,25]) port_any();
  translate([0,0]) port_hay();
  translate([30,0]) port_sheep();
  translate([30,25]) port_ore();
  translate([30,-25]) port_wood();
  translate([0,-25]) port_brick();
} else if(part=="any3") port_any();
else if(part=="hay") port_hay();
else if(part=="sheep") port_sheep();
else if(part=="ore") port_ore();
else if(part=="wood") port_wood();
else if(part=="brick") port_brick();

module base()
{
  rotate([0,0,30])
  {
    cylinder(d=29,h=4,$fn=3);
    *translate([0,0,2])
      cylinder(d1=29,d2=32,h=2,$fn=3);
  }
  translate([0,0,4]) union(){
    for(r=[30,150]) rotate([0,0,r]) translate([14.5,0]) rotate([0,0,150]) rotate_extrude(angle=60,$fn=40) square([5,0.4]);
  }
}
module port_sheep()
{
  base();
  translate([0,0,4]) {
    translate([-4,2,1]) rotate([0,0,rands(0,359,1)[0]]) sheep();
    translate([5,2,1]) rotate([0,0,rands(0,359,1)[0]]) sheep();
    translate([0,-5]) linear_extrude(1) text2("2");
  }
}
module port_ore()
{
  base();
  translate([0,0,4]) {
    translate([-4,2]) rotate([0,0,rands(-10,10,1)[0]]) ore();
    translate([5,2]) rotate([0,0,rands(-10,10,1)[0]]) ore();
    translate([0,-5]) linear_extrude(1) text2("2");
  }
}
module sheep() {
  /*
  scale([1,1.2,.8])
  for(layer=[1:3])
    rotate([90*layer,0])
      for(x=layer==3?[-.7:.1:.7]:[-.8:.1:.8])
        translate([0,0,x]) rotate_extrude($fn=30) translate([layer/4+.5*pow(1-abs(x),.3),0]) circle(d=.2,$fn=12);
  /*/
  scale([1,1,0.8]) {
    for(x=[-.75,.75])
      translate([x,0]) rotate([0,90,0]) sphere(d=4,$fn=20);
    translate([0,0]) rotate([0,90]) translate([0,0,-.75]) cylinder(d=3.95,h=1.5,$fn=20);
  }
  translate([2,0,1.5]) {
    sphere(d=2,$fn=30);
    translate([.1,-.8,.2]) sphere(d=1,$fn=10);
    translate([.1,.8,.2]) sphere(d=1,$fn=10);
    rotate([0,90]) translate([-.1,0,.6]) cylinder(d1=1.5,d2=0.5,h=0.7,$fn=30);
  }
  //*/
}
module ore() {
  //rp=rands(-1,1,9);
  which=floor(rands(5,6,1)[0]);
  union(){
    *translate([-3,-2]) linear_extrude(2) {
      polygon([
        [0+rp[0],2],
        [1,1+rp[1]],
        [3+rp[2],0],
        [5,1+rp[3]],
        [5.8+rp[4],1.2],
        [5,3+rp[5]],
        [3+rp[6],3],
        [3,4+rp[7]],
        [1+rp[8],3]]);
    }
    for(x=[0:40])
    {
      off=rands(-2,2,3);
      rot=rands(0,89,3);
      sz=rands(0.5,1.5,1)[0];
      //echo(str("translate([",off[0],",",off[1],",",off[2],"]) rotate([",rot[0],",",rot[1],",",rot[2],"]) sphere(",sz,",$fn=10);"));
      translate(off) rotate(rot) sphere(sz,$fn=10);
    }
    for(x=[0:40])
    {
      off=rands(-2,2,3);
      rot=rands(0,89,3);
      sz=rands(1,2.5,3);
      //echo(str("translate([",off[0],",",off[1],",",off[2],"]) rotate([",rot[0],",",rot[1],",",rot[2],"]) translate([",sz[0]*-.5,",",sz[1]*-.5,",",sz[2]*-.5,"]) cube([",sz[0],",",sz[1],",",sz[2],"],center=true);"));
      translate(off) rotate(rot) cube(sz,center=true);
    }
    for(x=[0:20])
    {
      off=rands(-1,1,3);
      rot=rands(0,89,3);
      sz=rands(0.4,1,3);
      //echo(str("translate([",off[0],",",off[1],",",off[2],"]) rotate([",rot[0],",",rot[1],",",rot[2],"]) translate([",sz[0]*-.5,",",sz[1]*-.5,",",sz[2]*-.5,"]) cube([",sz[0],",",sz[1],",",sz[2],"],center=true);"));
      translate(off) rotate(rot) cube(sz,center=true);
    }
  }
}
module port_brick()
{
  base();
  translate([0,0,4]) union(){
  translate([-4,2]) rotate([0,0,rands(-10,10,1)[0]]) brickpile();
  translate([4,2]) rotate([0,0,rands(-10,10,1)[0]]) brickpile();
  translate([0,-5]) linear_extrude(1) text2("2");
  }
}
module text2(txt,size=6,font=font,halign="center",valign="center")
{
  minkowski(){
    text(txt,size=size,font=font,halign=halign,valign=valign);
    circle(d=1,$fn=20);
  }
}
module port_wood()
{
  base();
  translate([0,0,4]) union(){
  translate([-4,0.5]) rotate([0,0,rands(-10,10,1)[0]]) woodpile();
  translate([5,0.5]) rotate([0,0,rands(-10,10,1)[0]]) woodpile();
  translate([0,-5]) linear_extrude(1) text2("2");
  }
}
module brickpile()
{
  translate([-3,3]) {
    brick();
    translate([3,0]) brick();
    translate([0,0,2]) rotate([0,0,-90]) mirror([0,1,0]) {
      brick();
      translate([3,0]) brick();
    }
  }
}
module brick()
{
  bcut=0.5;
  bcut4=4*bcut;
  ymax=-1*(6-bcut);
  //scale(1.2)
  difference(){
  rotate([90,0]) linear_extrude(6) scale([0.2,0.25]) polygon([[bcut4,0],[15-bcut4,0],[15,bcut4],[15,8-bcut4],[15-bcut4,8],[bcut4,8],[0,8-bcut4],[0,bcut4]]);
    translate([0,0,2-bcut]) rotate([45,0]) cube([10,2,2]);
    translate([0,ymax,2]) mirror([0,1]) rotate([-45,0]) cube([10,2,2]);
    translate([0,-1*bcut]) rotate([-45,0]) cube([10,2,2]);
    translate([0,ymax]) mirror([0,1,0]) rotate([-45,0]) cube([10,2,2]);
    translate([0,-1*bcut,0]) rotate([0,0,45]) cube([2,2,10]);
    translate([0,ymax]) mirror([0,1]) rotate([0,0,45]) cube([2,2,10]);
    translate([3-bcut,.01]) rotate([0,0,-45]) cube([2,2,10]);
    translate([3-bcut,-6.01]) rotate([0,0,-45]) cube([2,2,10]);
  }
}
module woodpile()
{
  translate([0,0,.6]) rotate([0,90]) {
    translate([0,0,-4]) {
      for(y=[0:2:4])
        translate([0,y]) log();
      translate([-1.5,1]) log();
      translate([-1.5,3]) log();
      translate([-3,2]) log();
    }
  }
}
module log()
{
  cylinder(d=2,h=7,$fn=20);
}
module port_hay()
{
  base();
  translate([0,0,4]) union(){
    translate([-4,2]) bale();
    translate([4,2]) bale();
    translate([0,-5]) linear_extrude(1) text2("2");
  }
}
module bale() {
  for(r=[0:40:359]) rotate([0,0,r]) {
      translate([2,0]) rotate([0,-5]) cylinder(d=2,h=3,$fn=20);
      translate([1.5,0]) rotate([0,5]) translate([0,0,3]) cylinder(d=2,h=3,$fn=16);
    }
  translate([0,0,2.5]) cylinder(d=6,h=1,$fn=30);
    cylinder(d=4,h=5.6,$fn=20);
}
module port_any()
{
  base();
    union(){
  translate([0,0,4]) {
  //translate([-2,-2,0]) linear_extrude(1.6) text("?",font=str(font,";style=bold"),size=12,valign="center",halign="center");
  translate([-5.5,2]) scale(0.8) rotate([0,0,30]) brickpile();
  translate([0.5,3]) scale(0.8) rotate([0,0,0]) woodpile();
  translate([-2,-1]) scale(0.8) ore();
  translate([3,-2,0.5]) scale(0.8) rotate([0,0,-50]) sheep();
    translate([5,2]) scale(0.8) bale();
  translate([0,-7,0]) linear_extrude(1) text2("3");
  }
} }