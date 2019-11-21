// preview[view:south west, tilt:diagonal]
/* [General] */

part="hclamp"; // [clamp_tray:Clamp Tray,rod_tray:Rod Dray,dual_tray:Dual Tray,hclamp:Flat(H) Clamp,vclamp:V-Clamp,tvclamp:Tall V-Clamp,vclamp_rod:V-Clamp Rod,presser:Presser,grip:Grip,preview:Preview All]
// Bolt Diameter
boltd=6.35; // [3:M3,4:M4,5:M5,6:M6,7:M7,8:M8,3.175:1/8",4.7625:3/16",6.35:1/4",7.9375:5/16",9.525:3/8",11.1125:7/16",12.7:1/2"]

/* [Flat Clamp] */

// Flat Clamp Width (X)
hcw=80; // [40:120]
// Flat Clamp Height (Y)
hch=20; // [10:40]
// Flat Clamp Depth (Z)
hcd=6; // [4:0.1:20]
// Flat Clamp Extra Notch
hnotch=1; // [1:Yes,2:No]

/* [V-Clamp] */

// V-Clamp Width (X)
vcw=76; // [40:120]
// V-Clamp Height (Y)
vch=20; // [10:40]
// V-Clamp Depth
vcd=16; // [10:0.1:40]
// V-Clamp Rod diameter
vcrd=12; // [10:20]

/* [Others] */

// Clamp Tray Count
ctray_count=12; // [1:20]

// Grip Big Diameter
gripd=40; // [20:60]

if(part=="clamp_tray")
    clamp_tray();
else if(part=="dual_tray")
{
  clamp_tray();
  translate([ctray_count*9,0])
    m4_tray(left=0);
} else if(part=="rod_tray") {
  m4_tray();
} else if(part=="vclamp_rod") {
  vclamp_rod();
} else if(part=="hclamp")
{
  translate([0,0,hcd]) mirror([0,0,1]) hclamp();
} else if(part=="vclamp")
{
  translate([0,0,vch]) rotate([-90,0])
  vclamp();
} else if(part=="tvclamp") {
   rotate([90,0]) tvclamp();
} else if(part=="presser") {
  mirror([0,0,1]) presser();
} else if(part=="grip")
{
  grip(gripd);
} else if(part=="preview")
{
  color("lightblue") clamp_tray();
  color("lightgreen") translate([ctray_count*9,0]) m4_tray(left=0);
  color("yellow") for(x=[0:(ctray_count-1)/2-2]) {
    translate([8.5+x*9,2.5,hcw+2]) rotate([0,-90,0]) mirror([1,0]) hclamp();
  }
  color("red") for(x=[0:2]) {
    translate([((ctray_count-1)/2-2)*9+20+x*18,2.5,2.5]) rotate([0,-78]) vclamp();
  }
  for(x=[0:1:4],y=[0:1]) {
    if(x%2!=y%2)
    translate([ctray_count*9+6+x*10,6+y*12])
    {
      color("silver") cylinder(d=4,h=50,$fn=20);
      translate([0,0,25+x*5+y*10-(x==4?5:0)])
      {
        color("gray") mirror([0,0,1]) rotate([0,0,30]) grip();
        if(x>2)
          color("pink") translate([(vcrd-1)*-.5,vch*-.5,-15]) mirror([0,0,1]) vclamp_rod();
      }
    }
  }
}
module clamp_tray() {
  difference() {
    box([2+ctray_count*9,25,20],bottom=0,r=2);
    for(x=[0:ctray_count-1]) {
      translate([2+x*9,2,2]) cube([7,21,20]);
    }
  }
}  
module m4_tray(left=1) {
  difference(){
    union(){
      translate([0,0]) box([52,25,18],left=left,bottom=0,r=2);
      *translate([115,0,4]) {
        for(x=[0:6],y=[0:1]){
          translate([x*10,6+y*12]) cylinder(d=7,h=16,$fn=20);
        }
      }
    }
    translate([6,0,4]) {
      for(x=[0:4],y=[0:1]){
        translate([x*10,6+y*12]) cylinder(d=boltd+.5,h=20,$fn=20);
      }
    }
  }
}
module presser() {
  difference(){
    union() {
      sphere(d=13+boltd,$fn=50);
    }
    translate([0,0,boltd>5?-2:0])
      cylinder(d=boltd+.2,h=20,$fn=20);
    translate([0,0,boltd>5?1:3])
      cylinder(d=boltd*2+.2,h=30,$fn=6);
    translate([-10,-10,5])
      cube(20);
  }
}
module tvclamp() {
  tvh=48;
  difference(){
    union() {
      box([vcw-20,vcd,4],front=0);
      translate([vcw-24,0]) box([4,vcd,tvh],front=0);
      translate([vcw-24,0,tvh-5]) box([24,vcd,5],front=0);
      translate([vcw-24,0,tvh-24]) intersection() {
        rotate([0,-45]) box([40,2,40],r=1,front=0);
          box([24,2,24],r=1,front=0);
      }
      translate([vcw-60,0,0]) intersection() {
        rotate([0,45]) box([60,2,60],r=1,front=0);
          box([40,2,40],r=1,front=0);
      }
    }
    *translate([vcw-20,-.01,tvh-4])
      rotate([0,90,0]) cube([80,vcd+.02,30]);
    *translate([-.01,-.01,4]) cube([50,vcd+.02,80]);
    translate([vcw-vcd/2,vcd/2,0]) {
      cylinder(d=4,h=tvh+.02,$fn=20);
      translate([0,0,tvh-5]) rotate([0,0,30]) cylinder(d=8.2,h=3,$fn=6);
    }
    for(x=[vcd/2:16:44]) {
      translate([x,vcd/2,-.01]) cylinder(d=4,h=5,$fn=20);
    }
  }
  %translate([vcw-vcd/2,vcd/2,tvh-15]) presser();
}
module box(size,r=1,top=1,bottom=1,left=1,right=1,front=1,back=1)
{
  w=size[0];
  d=size[1];
  h=size[2];
  intersection(){
    cube([w,d,h]);
    minkowski(){
      translate([left?r:0,front?r:0,bottom?r:0]) cube([w-(left?r:0)-(right?r:0),d-(front?r:0)-(back?r:0),h-(top?r:0)-(bottom?r:0)]);
      sphere(r,$fn=30);
    }
  }
}
module rounded_rect(w,h,r) {
  translate([r,r]) circle(d=r*2,$fn=30);
  translate([r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,r]) circle(d=r*2,$fn=30);
  translate([r,0]) square([w-r*2,h]);
  translate([0,r]) square([r,h-r*2]);
  translate([w-r,r]) square([r,h-r*2]);
}
module rounded_cube(dims,rsides=2,rvert=0)
{
  w=dims[0];
  h=dims[1];
  d=dims[2];
  if(rvert==0)
  {
    linear_extrude(d) rounded_rect(w,h,rsides);
  } else {
    translate([rsides,rsides,rvert]) scale([1,1,rvert/rsides]) minkowski() {
      cube([w-rsides*2,h-rsides*2,(d-rvert*2)/(rvert/rsides)]);
      sphere(rsides,$fn=30);
    }
  }
}
module hclamp() {
  difference(){
    rounded_cube([hcw,hch,hcd],8);
    translate([3+boltd,-.01]) mirror([1,0]) rotate([0,60]) cube([10,hch+.02,20]);
    if(hnotch)
      translate([-.01,-.01,hcd-1]) mirror([0,0,1]) cube([3,hch,hcd]);
    translate([0,3,-.01]) mirror([0,1,0]) rotate([0,0,10]) cube(20);
    translate([0,hch-3,-.01]) rotate([0,0,10]) cube(20);
    translate([5+boltd,hch/2-boltd/2-.2,-.01]) rounded_cube([hcw-13-boltd*2,boltd+.4,8.02],boltd/2);
    translate([hcw-8,hch/2,-.01]) cylinder(d=boltd+.4,h=8.02,$fn=20);
  }
}
module vclamp() {
  difference(){
    translate([0,vch]) rotate([90,0]) rounded_cube([vcw,vcd,vch],rsides=2,rvert=0);
    
    translate([0,-.01,1]) rotate([0,-18,0]) cube([vcw,vch+.02,vcd]);
    translate([vcw*2/3,0,0]) {
      translate([vcrd/2-.5,-.01,vcd]) rotate([0,35]) cube([vcw,vch+.02,vcd]);
      translate([0,-.01,vcd]) rotate([-90,0]) cylinder(d=vcrd,h=vch+.02,$fn=30);
      translate([0,-.01,vcd-vcrd/2-4]) mirror([0,0,1]) rotate([0,-15,0]) cube([vcw,vch+.02,vcd]);
      translate([0,-.01,vcd-vcrd/2-4]) mirror([0,0,1]) mirror([1,0]) rotate([0,-7,0]) cube([vcw,vch+.02,vcd]);
      for(r=[-35:5:50])
        translate([0,vch/2,vcd-.01]) rotate([0,r]) translate([0,0,vcd*-2]) cylinder(d=boltd+.5,h=vch+vcd,$fn=20);
    }
  }
}
module vclamp_rod() {
  difference(){
    intersection(){
      cube([vcrd-1,vch,(vcrd-1)/2]);
      translate([(vcrd-1)/2,0]) rotate([-90,0]) cylinder(d=vcrd-1,h=vch,$fn=30);
    }
    translate([(vcrd-1)/2,vch/2,-.01]) cylinder(d=boltd+.5,h=vch,$fn=20);
  }
}
module grip(od=gripd,md=boltd)
{
  nuth=(boltd==4?3:(boltd>8?6:4));  
  difference(){
    union(){
      cylinder(d=od,h=nuth+1,$fn=6);
      translate([0,0,nuth+1]) cylinder(d1=18,d2=12,h=3,$fn=30);
      translate([0,0,nuth+3]) cylinder(d=12,h=nuth*2,$fn=30);
      for(d=[0:60:330])
        rotate([0,0,d]) translate([od/2,0]) cylinder(d=od/5,h=nuth+1,$fn=30);
    }
    translate([0,0,-.01]) cylinder(d=md*2+.2,h=nuth+.2,$fn=6);
    translate([0,0,-.01]) cylinder(d=md+.5,h=40.02,$fn=20);
    for(d=[30:60:330])
      rotate([0,0,d]) translate([od/2,0,-.01]) cylinder(d=od/3,h=nuth+1.02,$fn=30);
  }
}
