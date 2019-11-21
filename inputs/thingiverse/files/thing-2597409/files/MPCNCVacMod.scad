// Part to Print
part="sb"; // [all:Preview All,rc:Gantry-Rod Connector,srt:Smooth Rod Top,hc:Hose Clamp,cc:Clamp Clamp,loner:Loner Clamp,sb:Shoe Base Top,skirt:Shoe Base Skirt,ws:Wire Support from Smooth Rod Top]
clamp_type=2; // [0:None,1:Friction,2:3mm Set Screw (w/ Hex Nut),3:3mm Set Screw (w/ Square Nut)]
skirt_height=10;
// Tool Y-Offset
dyo=-80; // -73
// Tool Diameter
dd=60; // 48
// Tool hole inner diameter
cuthole_id=36;
// X-offset for left rod. Adjust these values if your tube diameter is not 23.5mm.
anchorx1=-66;
// X-offset for right rod
anchorx2=66;
// Y-offset for left rod
anchory1=0;
// Y-offset for right rod
anchory2=0;
// Smooth Rod Height
srh=13*25.4;
// Clamp Clamp Height
cch=6;
// Clamp Clamp Radius
ccr=22;
// Clamp Clamp Thickness
cct=2;
// Vacuum Hose Inner-Diameter
vac_hose_id=30;
// Vacuum Hose Diameter (only affects Smooth Rod Top)
vac_hose_dia=44;

/* [Hidden] */
anchorx=[anchorx1,anchorx2];
anchory=[anchory1,anchory2];
//novac=1;
//include<VacAttach.scad>;

if(part=="srt")
  rotate([180,0]) smooth_rod_top();
else if(part=="ws")
  rotate([-90,0]) wire_support();
else if(part=="hc")
  hose_clamp();
else if(part=="rc")
  rotate([0,0,90]) rotate([0,90,0]) rod_clamp();
else if(part=="cc")
  clamp_clamp();
else if(part=="loner")
  loner_clamp();
else if(part=="sb")
  shoe_base(vac=2);
else if(part=="skirtvac")
  mirror([0,0,1]) skirt_vac();
else if(part=="skirt2d")
  rotate([180,0]) shoe_base(1,ex=0,bot=0,h=2,skirtlen=skirt_height);
else if(part=="skirt")
  rotate([180,0]) shoe_base(1,h=2,skirtlen=skirt_height);
else if(part=="skirt2")
  shoe_base(2,h=2,skirtlen=2,vac=0);
else if(part=="skirt3")
  shoe_base(2,h=2,skirtlen=2,vac=3);
else if(part=="rc")
  rotate([0,90]) rod_clamp(rods=[1]);
else if(part=="all")
{
  translate([82,-20,80]) rotate([0,0,-45]) rotate([0,-90]) 
  union() {
    //color("blue") translate([-118.8,-114.5,4]) import("MPCNC/files/C-XY.stl");
    %translate([0,0,-50]) cylinder(d=25,h=200,$fn=30);
    translate([44.8,-3.3,-3]) mirror([1,0]) rod_clamp(rods=[1]);
    translate([-72.4,-3.3,-3]) mirror([1,0]) rod_clamp(rods=[1]);
  }
  translate([-82,-20,55]) rotate([0,0,45]) rotate([0,90]) {
    //color("green") translate([-118.8,-114.5,4]) import("MPCNC/files/C-XY.stl");
    %translate([0,0,-50]) cylinder(d=25,h=200,$fn=30);
    translate([44.8,-3.3,-3]) rod_clamp(rods=[1]);
    translate([-72.4,-3.3,-3]) rod_clamp(rods=[1]);
  }
      %translate([0,dyo]) cylinder(d=dd,h=11*25.4,$fn=80);
  %for(m=[0,1]) mirror([m,0]) translate([35,-10,-20]) cylinder(d=25,h=200,$fn=30);
    for(xi=[0,1])
    {
      x=anchorx[xi];
        translate([x,-48,-20]) {
      %cylinder(d=8,h=srh,$fn=24);
      //rotate([0,0,45]) translate([0,0,80]) mirror([0,1]) rod_clamp2();
    }
  }
  //color("gray") translate([-105,-51.9,18]) mirror([0,0,1]) import("MPCNC/files/C-XYZ.stl");
  //color("gray") translate([-105,-51.9,119]) import("MPCNC/files/C-XYZ.stl");
  *translate([0,dyo,-15]) shoe_base(2,h=2,skirtlen=2,vac=3);
  translate([0,dyo,-20]) shoe_base(vac=2);
  translate([0,dyo,-25]) shoe_base(1,skirtlen=skirt_height);
  translate([0,dyo,-25-skirt_height+3]) mirror([0,0,1]) shoe_base(2,h=2,skirtlen=2,vac=0);
  translate([anchorx[1],-48,140]) hose_clamp(ar=-90);
  translate([0,0,srh-20]) smooth_rod_top();
  translate([14.5,-46,srh-36]) wire_support();
}

module skirt_vac(){
  fd1=42;
  fd2=fd1+8;
  botd=(1+3/8)*25.4;
  echo(str("Bottom D: ",botd));
  base_male();
  translate([0,0,20]) ring2(od1=31.5,od2=35,t=2.5,h=10);
  translate([0,0,30]) difference() {
      cylinder(d1=35,d2=36,h=30,$fn=60);
      translate([0,0,-.01]) cylinder(d1=30,d2=32.5,h=30.02,$fn=60);
    }
  translate([0,0,60]) {
    difference() {
      union(){
      cylinder(d=54,h=2,$fn=80);
        rotate_extrude($fn=60) translate([18,-4])
          difference() {
            square([4,4]);
            translate([4,0]) circle(r=4,$fn=30);
          }
      }
      translate([0,0,-.01]) {
        cylinder(d=32,h=3.02,$fn=60);
      for(r=[90:90:270])
        rotate([0,0,r]) translate([23,0,-10]) {
          cylinder(d=3,h=13.02,$fn=20);
          cylinder(d=8,h=10,$fn=30);
        }
    }
  }
  }
  *difference() {
    translate([-20,-20,60])
      cube([40,40,3]);
    cylinder(d=32.5,h=80,$fn=60);
    *translate([0,0,59.99]) {
      translate([0,0,2.01]) cylinder(d1=32.5,d2=34,h=1.01,$fn=60);
      translate([-16,-16]) cylinder(d=4,h=4,$fn=12);
      rotate([0,0,90]) translate([-16,-16]) cylinder(d=4,h=4,$fn=12);
      rotate([0,0,180]) translate([-16,-16]) cylinder(d=4,h=4,$fn=12);
      rotate([0,0,270]) translate([-16,-16]) cylinder(d=4,h=4,$fn=12);
    }
  }

}
module wire_support(ext=30,extr=20) {
  
  difference() {
    cube([40,4,20]);
    translate([20,-.01,4]) rotate([-90,0]) cylinder(d=3,h=10,$fn=20);
    translate([8.5,-.01,12]) rotate([-90,0]) cylinder(d=3,h=10,$fn=20);
    translate([31.5,-.01,12]) rotate([-90,0]) cylinder(d=3,h=10,$fn=20);
  }
  translate([30,4,20]) {
    rotate([90,0]) rotate([0,-90]) linear_extrude(20) polygon([[0,0],[0,ext],[4,ext],[13,0]]);
  }
  translate([20,0,ext+20+extr-3]) rotate([-90,0]) rotate([0,0,180]) difference() {cylinder(r=extr,h=4,$fn=50);
    translate([0,0,-.01]) cylinder(r=extr-2.5,h=4.02,$fn=50);
    translate([-extr+5,0,-.01]) cube([extr*2-10,50,4.02]);
  }
}
module smooth_rod_top() {
  translate([anchorx[0],-48,-6]) {
    hose_clamp(grip=0,ar=50,h=10,slot=2,ext=20,grip_angle=180,grip_angle_start=-80,grip_radius=10,armt=4);
  }
  translate([anchorx[1],-48,-6]) {
    hose_clamp(grip=0,ar=-80,h=10,slot=2,ext=20,grip_angle=180,grip_angle_start=-30,grip_radius=vac_hose_dia/2,armt=6);
    difference() {
      rotate([0,0,-80]) translate([50,0]) {
        rotate([0,0,30]) translate([-64,0,6]) cube([36,4,4]);
      }
      translate([-anchorx[1],-1,0]) cube([100,8,50]);
    }
    *translate([0,-54,10]) rotate([0,0,195]) {
      clamp_clamp();
    }
  }
  translate([anchorx[0],-55,2]) cube([anchorx[1]-anchorx[0],9,2]);
  *translate([0,0,2]) linear_extrude(2) difference() {
      hull() {
        for(x=anchorx)
          translate([x,-48]) circle(d=10,$fn=20);
      }
  }
  for(xi=[0:1]) translate([anchorx[xi],-48,0]) cylinder(d=14,h=4,$fn=40);
  difference() {
    translate([anchorx[0]+5,-50,-16]) cube([anchorx[1]-anchorx[0]-10,4,18]);
    *translate([0,0,-16]) linear_extrude(18) hull() for(x=anchorx) translate([x+(x>0?-7:7),-48]) circle(d=4,$fn=10);
    a=anchorx[0]+20;
    c=anchorx[1]-20;
    b=(c-a)/4;
    for(x=[a:b:c],z=[-4,-12])
      if(z>-10||x<c)
      translate([x+(z<-10?b/2:0),-40,z]) rotate([90,0]) cylinder(d=3,h=20,$fn=20);
  }
  for(xi=[0:1])
  {
    x=anchorx[xi];
    translate([x,-48,4]) rotate([0,0,xi==0?0:180]) mirror([0,0,1]) rod_boot(h=20,od=14,floor=4);
    *translate([x,-48,-16]) difference() {
      cylinder(d=14,h=16,$fn=40);
      translate([0,0,-.01]) cylinder(d=8.2,h=12,$fn=24);
      translate([0,-10,6]) rotate([-90,0]) cylinder(d=3,h=20,$fn=20);
    }
  }
}

module clamp_clamp(h=cch,grip_thick=cct,grip_radius=ccr)
{
  difference() {
        union() {
          translate([0,0,-h+10]) rotate_extrude(angle=180,$fn=50) translate([grip_radius,0]) square([grip_thick,h]);
          for(x=[-grip_radius-4,grip_radius+4])
          translate([x,0,-h+10]) cylinder(d=8,h=h,$fn=30);
        }
        for(x=[-grip_radius-4,grip_radius+4])
        {
          translate([x,0,-10.01]) cylinder(d=3,h=h+20.02,$fn=20);
          if(h>14) {
            translate([x,0,-10.5]) cylinder(d=9.02,h=11,$fn=30);
            translate([x,0]) rotate([0,0,x>0?45:-45]) intersection() {
              cylinder(d=9,h=15,$fn=30);
              translate([-5,5]) rotate([0,0,-90]) rotate([0,45,0]) cube(20);
            }
          }
        }
      }
}
module loner_clamp()
{
  rod_boot(floor=0,h=12,holes=1);
}
module hose_clamp(grip=clamp_type,armt=4,ar=-100,h=18,slot=1,ext=40,grip_angle=90,grip_angle_start=0,grip_radius=20)
{
  difference() {
    union() {
      if(grip>1)
        rotate([0,0,160]) rod_boot(floor=1,h=h);
      linear_extrude(h,convexity=2) difference() {
        union() {
          if(grip==1)
            circle(d=12,$fn=30);
          hull() {
            circle(d=armt,$fn=10);
            rotate([0,0,ar]) 
              translate([ext,0]) circle(d=armt,$fn=10);
          }
          if(grip==1)
            rotate([0,0,0]) translate([0,1,0]) square([15,5]);
        }
        circle(d=8.2,$fn=24);
        if(grip)
        rotate([0,0,0]) translate([0,3,0]) square([20,1]);
      }
      rotate([0,0,ar]) 
        translate([ext+4+grip_radius,0])
          rotate([0,0,135+grip_angle_start]) {
            rotate_extrude(angle=grip_angle,$fn=50)
              translate([grip_radius,0]) square([4,h]);
            if(slot==2)
            {
              for(r=[0,grip_angle])
                rotate([0,0,r]) translate([grip_radius+4,0]) cylinder(d=8,h=h,$fn=30);
              
            }
          }
    }
    for(z=[5,13]) translate([10,8,z]) rotate([90,0]) cylinder(d=3,h=10,$fn=20);
    if(slot==1)
      for(r=[20,-20]) rotate([0,0,ar+90]) translate([0,-14,5]) rotate([0,0,r+180]) translate([-1,14]) cube([2,50,8]);
    else if(slot==2)
    {
        rotate([0,0,ar]) 
        translate([ext+4+grip_radius,0,-.01])
          rotate([0,0,135+grip_angle_start]) {
            for(r=[0,grip_angle])
                rotate([0,0,r]) translate([grip_radius+4,0]) cylinder(d=3,h=h+.02,$fn=20);
          }
    }

  }

}
module rod_boot(floor=1,od=16,h=15,holes="auto")
{
  nutoff=-10;
  difference() {
    union(){
      cylinder(d=od,h=h,$fn=40);
      *translate([nutoff-2,0,11]) rotate([0,-90]) cylinder(d1=6,d2=4,h=1,$fn=30);
      if(clamp_type>1)
        translate([nutoff-2,-5,0]) cube([9,10,h]);
      else if(clamp_type==1)
        translate([-17,-3,0]) cube([17,6,h]);
    }
    if(clamp_type==3) {
      translate([nutoff,0,h-5]) rotate([0,90]) rotate([0,0,45]) cylinder(d=8,h=3,$fn=4);
      translate([nutoff,-2.875,h-5]) cube([3,5.7,10]);
    } else if(clamp_type==2) {
      translate([nutoff,0,h-5]) rotate([0,90]) rotate([0,0,45]) cylinder(d=7.2,h=3,$fn=6);
      translate([nutoff,-3.22,h-5]) cube([3,6.44,10]);
    } else if(clamp_type==1) {
      translate([-20.01,-.5,-.01]) cube([20,1,h+.02]);
      holec=holes=="auto"?(h>10?2:1):holes;
      zjump=h/(holec+1);
      zstart=h/(holec+1);
      for(z=[zstart:zjump:h-.01])
        translate([-12,-3.01,z]) rotate([-90,0]) cylinder(d=3,h=6.02,$fn=20);
    }
    if(clamp_type>1)
      translate([-20,0,h-5]) rotate([0,90]) cylinder(d=3,h=20,$fn=20);
    translate([0,0,floor<=0?-.01:floor]) cylinder(d=8.2,h=h+2,$fn=24);
  }
}
module shoe_base(bot=0,armt=5,holes=1,vac=1,h=4,skirtlen=10,ex=1)
{
  if(!ex)
  {
    rotate([0,0,-45])
    translate([0,0,h-skirtlen]) {
      difference() {
        union() {
          hull() {
            circle(d=cuthole_id+14,$fn=40);
            translate([70,0]) circle(d=vac_hose_id+16,$fn=60);
          }
          for(r=[90:90:270]) {
            rotate([0,0,r]) translate([cuthole_id/2+4,0]) rotate([0,0,30]) circle(d=10,$fn=6);
            translate([70,0]) rotate([0,0,r+180]) translate([vac_hose_id/2+5,0]) rotate([0,0,30]) circle(d=10,$fn=6);
          }
        }
        hull() {
          circle(d=cuthole_id,$fn=40);
          translate([70,0]) circle(d=vac_hose_id+3,$fn=60);
        }
        
      if(holes) base_holes();
      }
      
          for(r=[90:90:270]) {
            rotate([0,0,r]) translate([cuthole_id/2+4,0]) rotate([0,0,30]) circle(d=5,$fn=30);
            translate([70,0]) rotate([0,0,r+180]) translate([vac_hose_id/2+5,0]) rotate([0,0,30]) circle(d=5,$fn=30);
          }
      if(!bot) rotate([0,0,90+45]) translate([0,-1*dyo]) difference() {
        hull() for(xi=[0:len(anchorx)-1])
        {
          x=anchorx[xi];
          y=anchory[xi]-48;
          translate([x,y]) circle(d=16,$fn=40);
          hull() {
            translate([x,y]) circle(d=20,h=4,$fn=30);
            translate([0,dyo]) circle(d=cuthole_id+14,$fn=30);
          }
          if(xi==0)
            hull() {
              translate([x,y]) circle(d=20,$fn=30);
              translate([0,dyo]) rotate([0,0,-90-45]) translate([70,0]) circle(d=vac_hose_id+16,$fn=60);
            }
        }
        if(holes)
          translate([0,dyo]) rotate([0,0,-90-45]) 
            base_holes(1);
        translate([0,dyo]) rotate([0,0,-90-45]) hull() {
          circle(d=cuthole_id,$fn=40);
          translate([70,0]) circle(d=vac_hose_id+3,$fn=60);
        }
        for(xi=[0:len(anchorx)-1])
          translate([anchorx[xi],anchory[xi]-48]) circle(d=8.2,$fn=24);
        *translate([0,dyo]) circle(d=cuthole_id,$fn=50);
        for(xi=[0:len(anchorx)-1])
          translate([anchorx[xi],anchory[xi]-48]) circle(d=8.2,$fn=24);
      }

          circle(d=cuthole_id-.01,$fn=40);
        translate([70,0]) circle(d=vac_hose_id+2.99,$fn=60);
    }
          
  } else {
  if(!bot)
  {
    if(h>1)
    for(xi=[0:len(anchorx)-1])
      translate([anchorx[xi],-48-dyo+anchory[xi]]) 
        rotate([0,0,90]) rod_boot(floor=0);

    translate([0,-1*dyo]) {
      linear_extrude(h) difference() {
        for(xi=[0:len(anchorx)-1])
        {
          x=anchorx[xi];
          y=anchory[xi]-48;
          translate([x,y]) circle(d=16,$fn=40);
          hull() {
            translate([x,y]) circle(d=armt*2,h=4,$fn=30);
            translate([0,dyo]) circle(d=24,$fn=30);
          }
        }
        translate([0,dyo]) rotate([0,0,-45]) base_holes();
        for(xi=[0:len(anchorx)-1])
          translate([anchorx[xi],anchory[xi]-48]) circle(d=16.01,$fn=24);
        translate([0,dyo]) circle(d=cuthole_id,$fn=50);
        for(xi=[0:len(anchorx)-1])
          translate([anchorx[xi],anchory[xi]-48]) circle(d=8.2,$fn=24);
      }
    }
  }
  rotate([0,0,-45]) {
  if(bot)
    translate([0,0,h-skirtlen]) linear_extrude(skirtlen) difference() {
      hull() {
        //circle(d=dd+17,$fn=60);
        circle(d=cuthole_id+3,$fn=40);
        if(vac<3)
          translate([70,0]) circle(d=vac_hose_id+6,$fn=60);
          //translate([70,0]) circle(d=vac_hose_id+19,$fn=60);
      }
      if(bot==1)
        hull() {
          circle(d=cuthole_id,$fn=40);
          //circle(d=dd+14,$fn=60);
          //translate([70,0]) circle(d=vac_hose_id+16,$fn=60);
          translate([70,0]) circle(d=vac_hose_id+3,$fn=60);
        }
      else if(bot==2) {
        circle(d=20,$fn=60);
        if(holes) base_holes();
      }
        if(vac==1)
          translate([70,0]) circle(d=vac_hose_id,$fn=60);

    }
    if(vac<3)
  linear_extrude(h) {
    difference() {
      hull(){
        circle(d=cuthole_id+14,$fn=60);
        //circle(d=dd+14,$fn=60);
        if(vac)
          translate([70,0]) circle(d=vac_hose_id+16,$fn=60);
      }
      if(holes) base_holes();
      hull() {
        circle(d=cuthole_id,$fn=50);
        if(bot)
      translate([70,0]) circle(d=bot?40:vac_hose_id-3,$fn=50);
      }
      translate([70,0]) circle(d=bot?40:vac_hose_id-3,$fn=50);
    }
    }
  if(vac==2)
  translate([70,0])
    linear_extrude(20) difference() {
      circle(d=vac_hose_id,$fn=50);
      circle(d=vac_hose_id-3,$fn=50);
    }
  }
  }
}
module base_holes(hex=0)
{
  for(r=[90:90:270]) {
    rotate([0,0,r]) translate([cuthole_id/2+4,0]) rotate([0,0,30]) circle(d=hex?7.1:3,$fn=hex?6:20);
    translate([70,0]) rotate([0,0,r+180]) translate([vac_hose_id/2+5,0]) rotate([0,0,30]) circle(d=hex?7.1:3,$fn=hex?6:20);
  }
}
module rod_clamp2(wid=30)
{
  h=25.4*1.5;
  t=25.4/8+.2;
  translate([6,22]) difference() {
    translate([0,0,h/2]) rotate([0,90]) rod_clamp(mid=0,wid=wid,rods=[1],ch=h);
    translate([-5,-10,-.01]) cube([t,20,h+.02]);
    for(z=[h*.25,h*.75])
      translate([-11,0,z]) rotate([0,90]) cylinder(d=3,h=30,$fn=20);
  }
}
module rod_clamp(mid=1,ch=20,wid=34,rods=[1],st=1.5)
{
  //for(r=[0,180]) rotate([0,0,r])
  difference() {
    union() {
      translate([ch*-.5,8]) rotate([90,0]) {
        for(i=rods)
        translate([0,-10,(i<=0?i:i-1)*wid]) cube([ch,13,wid-3]);
        if(mid)
        translate([0,-10]) cube([ch,17,16]);
      }
      for(i=rods)
      {
        if(clamp_type==1)
        {
          translate([ch*-.5,-1*i*wid+8,-6]) rotate([0,90,0]) cylinder(d=18,h=ch,$fn=60);
          translate([ch*-.5,-1*i*wid+4,-6]) rotate([0,90]) cube([19.99,8,ch]);
        } else if(clamp_type>1)
          translate([ch*-.5,-1*i*wid+6,-6]) rotate([0,-90]) translate([0,0,-ch]) rod_boot(floor=0,od=18,h=ch);
      }
    }
    *for(i=rods)
    translate([ch*-1,-1*i*wid+8,-6]) rotate([0,90,0]) translate([0,0,-.01]) cylinder(d=8.2,h=ch*2,$fn=24);
    if(mid) translate([0,0,-20]) {
      cylinder(d=8.2,h=50,$fn=30);
      rotate([0,0,30]) cylinder(d=9/16*25.4+.2,h=18,$fn=6);
      cylinder(d=26,h=18,$fn=30);
      translate([-18,-4]) cube([18,12.4,18]);
    }
    if(clamp_type==1) {
      for(i=rods) {
      translate([ch*-1,-1*i*wid+8-st/2,-8]) rotate([0,90]) cube([20,st,ch*2]);
      for(z=[ch/-4,ch/4])
        translate([z,-1*i*wid+20,-20]) rotate([90,0]) cylinder(d=3,h=50,$fn=20);
      }
    }
  }
}