part="all"; // [all:Preview borders,expansion:Preview 5-6 player expansion,long:Long Border,short:Short Border (for expansion)"]
// Long Border Port Hole Setup
long_port=1; // [1:Single Port Hole in middle,2:2 Port Holes on sides]
// Short Border Port Hole
short_port=0; // [0:No Port hole,1:Port Hole to Left,2:Port Hole to Right]

/* [Hidden] */
diffix=1;
dx=67.85;
dy=78.8;
td=289;
bpw=dx;
hp=long_port;

if(part=="long")
  border_long_manual(hp=long_port);
else if(part=="short")
  border_short(port=short_port);
else {
  off=(part=="all"?0:79);

//*/
 if(part=="expansion")
color("green") translate([-39.5,45.5]) border_short(port=0);
rotate([0,0,0]) border_long_manual(2);
translate([196.5,0]) rotate([0,0,60]) translate([39,0]) border_long_manual(1);
translate([196.5,0]) rotate([0,0,60]) translate([39,0])
translate([196.5,0]) rotate([0,0,60]) translate([39,0])
  translate([off,0]) {
    border_long_manual(2);
    if(part=="expansion")
   color("green") translate([-79,0]) translate([39.5,45.5]) border_short(port=0);
  }

translate([196.5,0]) rotate([0,0,60]) translate([39,0])
translate([196.5,0]) rotate([0,0,60]) translate([39,0]) translate([off,0]) 
translate([196.5,0]) rotate([0,0,60]) translate([39,0])
 translate([off,0]) {
   border_long_manual(2);
  if(part=="expansion")
    color("green") translate([-79,0]) translate([39.5,45.5]) border_short(port=2);
 }
translate([196.5,0]) rotate([0,0,60]) translate([39,0])
translate([196.5,0]) rotate([0,0,60]) translate([39,0])
 translate([off,0]) 
translate([196.5,0]) rotate([0,0,60]) translate([39,0])
 translate([off,0]) 
translate([196.5,0]) rotate([0,0,60]) translate([39,0])
 border_long_manual();
translate([196.5,0]) rotate([0,0,60]) translate([39,0])
translate([196.5,0]) rotate([0,0,60]) translate([39,0])
 translate([off,0]) 
translate([196.5,0]) rotate([0,0,60]) translate([39,0])
translate([196.5,0]) rotate([0,0,60]) translate([39,0])translate([off,0]) 
translate([196.5,0]) rotate([0,0,60]) translate([39,0])  {
    border_long_manual(2);
  if(part=="expansion")
    color("green") translate([-79,0]) translate([39.5,45.5]) border_short(port=1);
  }
//*/
}
module main()
{
intersection()
{
  //color("blue") rotate([0,0,0]) translate([td*-.5,0,-diffix*2]) cylinder(d=td,h=6,$fn=3);
  //translate([-250,00]) cube([100,200,6]);
  //translate([dx*-1,-300]) cube([dx*2,150,6]);
  *#borders(1);
for(r=[0:5])
  rotate([0,0,r*60]) border_long(port=r%2==0?1:2);
}
rotate([0,0,-15]) border_short();

}
module border_short(port=0) {
  difference(){
  union(){
    border_single(h=4,port=port);
    for(m=[0:1]) mirror([m,0])
    rotate([0,0,-30]) {
      translate([45.5,0,1]) {
        rotate([0,0,-60]) translate([15,-2.5,1.5]) {
          intersection(){
            sphere(d=8,$fn=30);
            cylinder(d=8,h=3,$fn=30);
            translate([-4,-4]) cube([8,6.5,3]);
          }
        }
      }
    }
    
  }
  translate([-41,-47,1]) rotate([35,0]) cube([82,10,10]);
  translate([0,0,1]) cylinder(d=16,h=10,$fn=40);
  for(m=[0:1]) mirror([m,0])
  rotate([0,0,-30]) {
    translate([0,-5,2]) cube([45,5.1,10]);
    translate([45.5,0,1]) {
      cylinder(d=16,h=10,$fn=40);
      rotate([0,0,-60]) translate([15,-2.5,1.5]) {
        sphere(d=5,$fn=30);
        rotate([-90,0]) cylinder(d=3,h=10,$fn=20);
      }
    }
  }
}
}
module border_long_manual(hp=hp) {
  union() {
  nx=196.2+cos(60)*39;
  ny=0+sin(60)*39;
  x1=0;
  y1=21.5;
  x2=45.5*cos(30);
  y2=21.5+45.5*sin(30);
  x3=x2+45.5*cos(30);
  y3=y1;
  difference(){
    union(){
      linear_extrude(4) polygon([
      [45.5*cos(30)*4,y3],
      [45.5*cos(30)*3,y2],
      [45.5*cos(30)*2,y3],
      [45.5*cos(30)*1,y2],
      [0,21.5],[0,0],[196.2,0],[nx,ny],[nx-cos(30)*21.5,ny+sin(30)*21.5]]);
      intersection(){
        translate([2.5,7.65,2.5]) sphere(r=4.5,$fn=50);
        cube([10,15,6.5]);
      }
      translate([196.2,0]) rotate([0,0,60]) translate([39,0]) mirror([1,0])
      intersection(){
        translate([2.5,7.65,2.5]) sphere(r=4.5,$fn=50);
        cube([10,15,6.5]);
      }
    }
    translate([-1,-2,0]) rotate([40,0]) cube([200,6,5]);
    translate([196.2,0,0]) rotate([0,0,60]) {
      translate([0,-2]) rotate([40,0]) cube([50,6,5]);
      translate([39-2.5,7.65,2.8]) {
        sphere(d=5,$fn=50);
        rotate([0,90,0]) cylinder(d=3,h=10,$fn=20);
      }
    }
    translate([2.5,7.65,2.8])
    {
      sphere(d=5,$fn=50);
      rotate([0,-90,0]) cylinder(d=3,h=10,$fn=20);
    }
    for(x=[0,dy,dy*2])
    {
      translate([x,63,1.8]) rotate([0,0,30]) cylinder(r=46.5,h=5,$fn=6);
      translate([x,21.5,1]) cylinder(r=8,h=10,$fn=50);
      translate([x+cos(30)*45.5,21.5+sin(30)*45.5,1]) cylinder(r=8,h=10,$fn=40);
    }
    if(hp==1)
      translate([45.5*cos(30)*2,21.5,-diffix]) {
        rotate([0,0,0]) translate([26,0]) rotate([0,0,60]) cylinder(d=30,h=10,$fn=3);
      }
    else {    
      translate([45.5*cos(30)*2,21.5,-diffix]) {
        rotate([0,0,180]) translate([26,0]) rotate([0,0,60]) cylinder(d=30,h=10,$fn=3);
      }
      translate([45.5*cos(30)*4,21.5,-diffix]) {
        rotate([0,0,0]) translate([26,0]) rotate([0,0,60]) cylinder(d=30,h=10,$fn=3);
      }

    }
  }
}
module border_long_old() {
  translate([78.8,188.3+15.23]) rotate([0,0,30]) difference() {
  union(){
    border_long(h=4,port=2);
    translate([0,dy*-2,2.5]) rotate([0,0,300]) translate([59.5,-2.5,0.2]) {
      intersection(){
        sphere(d=8,$fn=30);
        cylinder(d=8,h=3,$fn=30);
        translate([-4,-4]) cube([8,6.5,3]);
      }
    }
   translate([dx*-3,dy*-2.5,2.5]) rotate([0,0,60]) translate([76.5,-1.5,0]) {
      intersection(){
        sphere(d=8,$fn=30);
        cylinder(d=8,h=3,$fn=30);
        translate([-4,-4]) cube([8,6.5,3]);
      }
    }
  }
  translate([0,-237,1]) {
    rotate([0,0,-30]) translate([-250,0]) rotate([35,0]) cube([250,10,10]);
    rotate([0,0,30]) rotate([35,0]) cube([100,10,10]);
  }
  translate([0,dy*-2,2.5]) rotate([0,0,300]) translate([59.5,-2.5,0.2]) {
      sphere(d=5,$fn=30);
      rotate([-90,0]) cylinder(d=3,h=10,$fn=20);
    }
   translate([dx*-3,dy*-2.5,2.5]) rotate([0,0,60]) translate([76.5,-1.5,0]) {
      sphere(d=5,$fn=30);
      rotate([-90,0]) cylinder(d=2.5,h=10,$fn=20);
    }
  for(off=[[0,dy*-2,1],[dx*-1,dy*-1.5,1],[dx*-2,dy*-1,1]])
  translate(off) {
    for(r=[0:60:359]) rotate([0,0,r]) translate([45.5,0]) cylinder(d=16,h=10,$fn=30);
    translate([0,0,1])
    cylinder(r=49.5,h=10,$fn=6);
  }
}
}
}
module border_long(h=5.1,port=1)
{
  intersection(){
    rotate([0,0,30]) cylinder(d=470,h=h,$fn=6);
    union(){
      rotate([0,0,-30]) translate([dy*-.5,dx*-3+44.25]) { 
        border_single(h=h,port=port==1?2:0);
        translate([dy,0]) border_single(h=h,port=port==1?0:1);
      }
      border_corner(h=h,port=port==1?1:0);
    }
  }
}
module border_corner(h=2,port=1) {
  difference() {
    intersection(){
      rotate([0,0,30]) cylinder(d=500,h=h,$fn=6);
      translate([0,-236.4]) cylinder(r=45.5,h=h,$fn=6);  
    }
    if(port>0)
    translate([0,-210,-diffix]) rotate([0,0,30]) cylinder(d=30,h=h+diffix*2,$fn=3);
  }
}
module border_single(h=2,port=2) {
  ry=-22.75;
  difference(){
  rotate([0,0,180])
  translate([-39.4,0]) difference(){
  cube([dy,45,h]);
  translate([0,ry,-diffix]) rotate([0,0,30]) cylinder(r=45.5,h=h+diffix*2,$fn=6);
  translate([dy,ry,-diffix]) rotate([0,0,30]) cylinder(r=45.5,h=h+diffix*2,$fn=6);
  }
  if(port>0)
    translate([0,-32,-diffix]) {
      //linear_extrude(h+diffix*2) text(port==1?"L":(port==2?"R":"?"),size=24,valign="bottom",halign="center");
      translate([port==1?-13:13,9]) rotate([0,0,port==1?60:0]) cylinder(d=30,h=h+diffix*2,$fn=3);
    }
}
}
module border_longmid() {
  
}
module borders(h=1) {
difference() {
  rotate([0,0,30]) cylinder(d=500,h=h,$fn=6);
  translate([-135.7,-157.6,-diffix])
  for(x=[0:4])
    for(y=[(x==0||x==4?2:(x==2?0:1)):4])
      translate([67.85*x,(x==2?0:(x%2==0?-1*dy:-.5*dy))+dy*y])
        cylinder(r=45.5,h=h+diffix*2,$fn=6);
  
}
}
module borders6(h=1) {
difference() {
  linear_extrude(h) {
  translate([dx,0]) rotate([0,0,30]) circle(d=500,$fn=6);
  translate([-dx,0]) rotate([0,0,30]) circle(d=500,$fn=6);
  translate([0,dy/2]) rotate([0,0,30]) circle(d=500,$fn=6);
  translate([0,dy*-.5]) rotate([0,0,30]) circle(d=500,$fn=6);
}
translate([-203.55,-78.8,-diffix])
for(x=[0:6])
  for(y=[0:5])
    if(((x==0||x==6)&&y<3)||((x==1||x==5)&&y<4)||((x==2||x==4)&&y<5)||x==3)
    translate([67.85*x,dy*y-(x==3?dy*1.5:(x<3?(x%3)*dy/2:(6-x)%3*dy/2))])
      cylinder(r=45.5,h=h+diffix*2,$fn=6);
}
}