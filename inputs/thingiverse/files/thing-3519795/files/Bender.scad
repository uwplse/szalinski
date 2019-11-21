part="all"; // [all:All Assembled,top:Top of Head (Supported),antenna:Antenna,mouth:Bottom Section (Mouth),opener:Bottle Opener,eyeballs:Eyeballs (Cut Vertically)]
bottle_opener=1;
mouth_size_angle=100;
mouth_angle=0;
opener_angle=0;
eyebrow_angle=27;
eyebrow_thickness=2.5;
teeth_h=5;
eye_rotation=[8,20];
eyeball_clearance=2;
eyeball_dia=45;
eyeball_drop=0;
eyeball_border_depth=6;
eyeball_peg_dia=3;
eyeball_inset=11;
pupil_depth=6;
pupil_size=6;
fnr=$preview?0.35:1;
$frame=$t<0.5?($t)*10:((1-$t)*10);

white="LemonChiffon";
if(part=="clamp")
{
  rotate([0,-90]) clamp(ramp=3,size=10,thick=4,deep=10,xin=0.6,xtra=1);
}
if(part=="clamptest")
{
  difference() {
    cylinder(r=36,h=30,$fn=100);
    translate([0,0,-.01]) cylinder(r=34,h=30.02,$fn=100);
  }
  for(z=[0,26]) translate([0,0,z]) for(r=[0:90:270]) rotate([0,0,r+(z>0?45:0)]) translate([24,-5]) 
    if(z>0)
      clamp(ramp=3,thick=4);
    else
      clamp(0,xtra=1);
}
if(part=="top2")
{
    head_top();
}
if(part=="top"||part=="flat"||part=="all"||part=="top_mod"||part=="top3"||part=="top4")
  color("silver") rotate([0,0]) translate(part=="flat"?[65,-60,6.2]:[0,0]) translate([0,0,part=="all"?120+$frame*4:0])
  {
      *translate([0,0,-.01]) difference() {
        cylinder(d=96,h=6,$fn=fnr*120);
        translate([0,0,-.1]) cylinder(d=90,h=6.2,$fn=fnr*80);
      }
    if(part!="top_mod") difference() { union() {
     *translate([0,0,-6.2]) cylinder(d1=92,d2=100,h=6.21,$fn=fnr*80);
      head_top(mag=0);
      *antenna();
      }
      *translate([0,0,-6.21]) cylinder(d1=88,d2=96,h=6.23,$fn=fnr*80);
      difference() {
        translate([0,0,-.01]) head_top(clearance=2,mag=0,inset=0);
        translate([0,0,20.01]) cylinder(d=80,h=20,$fn=fnr*50);
      }
      *cylinder(d=50,h=40,$fn=fnr*50);
      if(part=="top3")
        translate([0,0,20]) cylinder(d=100,h=20,$fn=fnr*50);
      else if(part=="top4")
        translate([0,0,-.01]) cylinder(d=104,h=20,$fn=fnr*50);
    }
      z=0;
    if(part!="top4")
    intersection() {
      head_top();
      cylinder(d=100,h=30,$fn=fnr*50);
      for(r=[0:120:270]) rotate([0,0,r+(z==40||z==110?45:0)]) translate([34,-5]) {
        if(part!="top_mod")
          clamp(deep=14);
        if(part=="top_mod")
        difference() {
        translate([-2,-2,0]) cube([24,14,30]);
          //translate([5,5,-1]) cylinder(d=3,h=30,$fn=20);
        }
      }
    }
    *if(part!="top_mod")
      antenna();
  }
if(part=="opener") rotate([-90,0]) bottle_opener(cutout=2);
if(part=="antenna")
{
  translate([0,0,-22]) antenna();
  linear_extrude(86) difference() { circle(d=51.6); circle(d=50); }
}
if(part=="front"||part=="flat"||part=="bottle")
{
  //rotate(part=="bottle"?[180,0]:[])
  intersection(){
    rotate([-90,0]) head(0);
    translate([-80,-5,0]) cube([160,160,80]);
    if(part=="bottle")
      translate([0,25,30]) rotate([mouth_angle+opener_angle,0]) cylinder(d=29.5,h=30,$fn=fnr*50);
  }
}
if(part=="head1"||part=="head2"||part=="head") {
  //%translate([0,-0]) goggles(pos=1,cutout=1);
  //%translate([0,-50,100]) rotate([180,0])  eyebrows();
  rotate([part=="head2"?180:0,0]) intersection() { union() {
    difference() {
      head(eyes=0,top=0,mouth=0,mid=1);
      translate([-20,-55,65]) cube([40,20,35]);
      translate([0,0,60]) rotate([90,0]) eyeballs(pegs=2);
      intersection() {
        *translate([-60,-60,50]) cube([120,60,65]);
        translate([0,0,60]) rotate([90,0])
      translate([-25,20,0]) goggles(color=1);
        difference() {
          translate([0,0,50]) cylinder(d=110,h=65,$fn=fnr*80);
          eye_groove(-1);
        }
      }
    }
    *translate([0,0]) difference() {
      eyes(color=1);
      eye_groove();
    }
    for(r=[30:120:270]) rotate([0,0,r]) translate([34,-5,110])
        clamp(deep=14);
  }
  if(part=="head2") translate([0,0,70]) cylinder(d=101,h=50,$fn=fnr*80);
  else if(part=="head1") translate([0,0,40]) cylinder(d=101,h=30,$fn=fnr*80);
  }
}
if(part=="goggles")
{
  difference() {
    goggles(cutout=1);
    //eyes(color=0,eyeballs=0,cutout=1);
    
  }
}
if(part=="eyebrows")
{
   eyebrows();
}
if(part=="mouth") {
  head(eyes=0,top=0,mouth=1,mid=0,hollow=2);
  *if(bottle_opener) bottle_opener(cutout=2);
}
if(part=="mouth3") {
  rotate([180,0]) intersection() {
    head(eyes=0,top=0,mouth=1,mid=0,hollow=0);
    translate([-60,-60,26]) cube([120,120,30]);
  }
}
if(part=="mouth2") {
  rotate([0,0,90]) rotate([-90,0]) rotate([0,0,-opener_angle]) intersection() {
    difference() {
      cylinder(d=100,h=39.8,$fn=fnr*120);
      rotate([0,0,(mouth_size_angle-180)/-2+mouth_angle]) teeth(color=color);
    }
    bottle_opener(cutout=3);
  }
}
if(part=="eyeballs") rotate([-90,0]) for(y=[0,50]) translate([0,0,y]) difference(){
    eyes(color=0,eyeballs=1,eyebrows=0,goggles=0,pupils=y>0?2:0,pegs=1,clearance=-eyeball_clearance);
    translate([-60,-40,50]) cube([120,60,60]);
}
if(part=="back"||part=="flat")
{
  translate([130,120]) rotate([180,0]) difference(){
    rotate([-90,0]) head(0);
    translate([-80,-5]) cube([160,160,80]);
  }
}
if(part=="all")
{ //(color=1,eyes=1,top=1,mouth=1,mid=1,hollow=1,bottle_opener=bottle_opener
  head(eyes=0,top=0,mid=0,mouth=1,hollow=2);
  translate([0,0,$frame*2]) {
    color("silver") difference() {
      head(eyes=0,top=0,mid=1,mouth=0);
            translate([0,0,60]) rotate([90,0]) eyeballs(pegs=2);
      intersection() {
        *translate([-60,-60,50]) cube([120,60,65]);
        translate([0,0,60]) rotate([90,0])
      translate([-25,20,0]) goggles();
        difference() {
          translate([0,0,50]) cylinder(d=110,h=65,$fn=fnr*80);
          eye_groove(-1);
        }
      }
    }
    translate([0,$frame*-10]) {
      translate([0,$frame*4,60]) rotate([90,0]) translate([-25,20,0]) {
        color("silver") goggles(cutout=1);
      }
      translate([0,$frame*5]) eyes(color=1,eyeballs=1,eyebrows=0,goggles=0,pupils=1,pegs=1);
    }
    translate([0,-50-$frame*8,100]) rotate([90,0]) eyebrows(pos=0);
  }
  color("silver") translate([0,0,122+($frame*8)]) {
    //head_top();
    antenna();
  }
  if(bottle_opener) translate([0,$frame*-5]) bottle_opener(cutout=2);
}
module clamp(ramp=0,size=10,thick=10,deep=10,xin=1,xtra=0,radius=0)
{
  nutw=6;
  nuth=2.6;
  intersection() {
    difference() {
      if(ramp==1||ramp==3)
        translate([0,0,-size]) cube([deep,size,thick+size]);
      else if(ramp>=2)
        cube([deep,size,thick*2]);
      else
        cube([deep,size,thick]);
      if(ramp==1||ramp==3)
      translate([10,-.01,-size]) rotate([0,-45,0]) mirror([1,0]) cube([size,size+.02,thick+size+.02]);
      if(ramp==2)
      translate([0,-.01,size]) rotate([0,40]) mirror([1,0]) cube([size,size+.02,thick+size+.02]);
      translate([nutw/2+xin,size/2,-size-.01]) {
        cylinder(d=3,h=size*3+2,$fn=20);
        if(ramp==3) cylinder(d=6,h=size,$fn=30);
      }
      if(ramp<3)
      translate([-.01,2,thick/2-nuth/2]) cube([nutw+xin+xtra,nutw,nuth]);
    }
    if(radius>0)
    union() {
      translate([0,0,-thick]) cube([deep,size,thick*2]);
      translate([-radius+deep,thick/2]) cylinder(r=radius,h=thick,$fn=fnr*100);
    }
  }
}
module eye_groove(clearance=0)
{
  translate([0,0,49.9]) cylinder(d=100,h=15.2,$fn=fnr*120);
  translate([0,0,65]) cylinder(d1=100,d2=90+clearance,h=5.01,$fn=fnr*100);
  translate([0,0,70]) cylinder(d=90+clearance,h=25.01,$fn=fnr*100);
  translate([0,0,95]) cylinder(d1=90+clearance,d2=100,h=5.01,$fn=fnr*100);
  translate([0,0,100]) cylinder(d=100,h=15.01,$fn=fnr*120);
}
module diffint(diff=1) {
  if(diff)
    difference() {
      children(0);
      for(i=[1:$children-1]) children(i);
    }
  else
    intersection() {
      children(0);
      for(i=[1:$children-1]) children(i);
    }
}
module head(color=1,eyes=1,top=1,mouth=1,mid=1,hollow=1,bottle_opener=bottle_opener) {
  if(top) translate([0,0,120]) color(color?"silver":false) head_top();
  difference() {
  union() {
    if(mid)
    color(color?"silver":false) translate([0,0,40]) cylinder(d=100,h=80,$fn=fnr*120);
    if(mouth) difference(mouth==1) {
      color(color?"silver":false) cylinder(d=100,h=39.8,$fn=fnr*120);
      if(bottle_opener)
        bottle_opener(cutout=1);
      rotate([0,0,(mouth_size_angle-180)/-2+mouth_angle]) 
      intersection() {
        union(){
      color(color?"silver":false) for(r=[0,mouth_size_angle]) rotate([0,0,r]) translate([-60,0,25]) rotate([0,90]) rotate([0,0]) cylinder(d=30,$fn=fnr*50,h=30);
          rotate([0,0,180]) rotate_extrude(angle=mouth_size_angle,$fn=fnr*80) {
            translate([0,10]) square([60,30]);
            translate([45,-.1]) square([20,10.2]);
          }
          color(color?"silver":false) for(r2=[0,mouth_size_angle]) rotate([0,0,r2]) translate([-47.5,0]) translate([0,-20,-.1]) mirror([1,0]) cube([35,40,25.2]);
        }
        teeth(color=color);
      }
    }
  }
    *color(color?"black":false) translate([0,0,60]) rotate([90,0]) translate([-25,20,40]) {
      for(x=[-5,55])
        translate([x,0,-.1]) cylinder(d=40,h=60.2,$fn=fnr*80);
      translate([-5,-20,0]) cube([60,40,100.2]);
    }
    if(hollow) difference() {
      translate([0,0,-.1]) cylinder(d=86,h=120.2,$fn=fnr*60);
      if(hollow==2&&bottle_opener)
      {
        bottle_opener(clearance=-1.22*2);
        translate([25.4*-1.25/2+.4,-30]) cube([25.4*1.25-.8,30,25]);
        mirrorx() translate([-25,-30]) cube([10,20,26]);
        *cylinder(d=90,h=1.22,$fn=100);
      }
    }
    *if(hollow) translate([0,0,114]) cylinder(d1=86,d2=96,h=6.2,$fn=fnr*60);
  }
  difference() {
    for(z=[0,29.8,40,60,70,110])
    {
      if((z>0||hollow!=1)&&(z<=30&&mouth||(z>=40&&z<110&&mid)))
      union() {
      rots=(z==0?[45:120:300]:(z<=40||z==110?[0:90:270]:[-10,90,190]));
      translate([0,0,z]) for(r=rots) rotate([0,0,r+(z<=40||z==110?45:0)]) translate([34,-5,z==70||(z>0&&z<=28)?5:0]) {
        mirror([0,0,z==70?1:0]) clamp(ramp=z==70||(z>0&&z<=28)?3:(z==80?2:0),thick=z==70||(z>0&&z<=28)?5:10);
        if(z==60)
          translate([0,0,-20]) difference() {
            cube([10,10,20]);
            translate([4,5,-.01])
              cylinder(d=3,h=50,$fn=20);
          }
      }
    }
    }
    if(hollow==2&&bottle_opener)
        bottle_opener(clearance=-1.22*2);

  }
  if(eyes)
  difference() {
    eyes(color, clearance=eyeball_clearance);
    translate([0,0,49]) cylinder(d=80,h=60,$fn=fnr*60);
  }
}
module bottle_opener(cutout=1,clearance=0)
{
  id=25.4*(1.125)+1-clearance;
  od=25.4*2+.4-clearance;
  odo=30+clearance;
  odh=cutout==1?40:16;
  intersection() {
    if(cutout!=1)
    translate([-30,-60,0]) cube([60,50,39.8]);
  difference() {
  rotate([0,0,-90+mouth_angle+opener_angle]) rotate([0,90]) translate([-23,0]) {
    difference() {
      if(!cutout)
        translate([0,0,50]) cylinder(d=od-.4,h=3,$fn=fnr*50);
    union() {
      *cylinder(d=id-.1,h=55,$fn=fnr*50);
      if(cutout==1)
        translate([-30,id/-2]) cube([30,id,40]);
      *if(cutout) translate([-30,od/-2,odo-.02]) cube([30,od,odh]);
      translate([0,0,odo]) {
        cylinder(d=od,h=odh,$fn=fnr*50);
        if(cutout==1) for(m=[-1,1]) translate([0,m*(id/2+(od/2-id/2)/2),0]) rotate([180,0]) {
          if(clearance==0)
          {
            translate([0,0,-30]) cylinder(d=3,h=60,$fn=20);
            translate([-3,m>0?-3:-3,3]) cube([6,6,3]);
          }
        }
      }
      difference() {
        //scale([.8,1.2,1])
        union() {
          if(cutout==1) cylinder(d=id,h=55,$fn=fnr*40);
          if(cutout==1) sphere(d=id,$fn=fnr*40);
          if(cutout==1) rotate([0,90,0]) translate([0,0,-17]) cylinder(d=id,h=45,$fn=fnr*40);
        }
        if(cutout==1) translate([20,0,42]) cylinder(d=28,h=10,$fn=fnr*40);
        if(cutout==1) translate([-22,0,42]) cylinder(d=28,h=10,$fn=fnr*40);
      }
    }
    if(cutout>1) {
      translate([2,0,54]) rotate([0,75,0]) cylinder(d1=id,d2=id,h=30,$fn=fnr*50);
      translate([10,-20,46]) cube([16,40,10]);
      cylinder(d=id,h=55,$fn=fnr*40);
      if(cutout==2) for(m=[-1,1]) translate([0,m*(id/2+(od/2-id/2)/2),0]) rotate([180,0]) translate([0,0,-43]) {
        cylinder(d=3,h=60,$fn=20);
        cylinder(d=7,h=4,$fn=fnr*30);
      }
    }
  }
  //%translate([3,0,50]) rotate([0,-110,0]) cylinder(d=30,h=8,$fn=50);
  if(cutout>1) {
    difference() {
    intersection() {
      translate([0,0,30]) cylinder(d=id,h=18,$fn=fnr*40);
      union() {
        translate([0,0,46]) mirror([0,0,1]) {
          translate([-25,0]) cylinder(d=40,h=4,$fn=fnr*40);
          translate([-25,0,4]) cylinder(d1=40,d2=22,h=12,$fn=fnr*40);
          translate([18,0,5]) cylinder(d=28,h=2,$fn=fnr*40);
          translate([18,0,7]) cylinder(d1=20,d2=16,h=9,$fn=fnr*40);
        }
      }
    }
      translate([5,-10,42]) rotate([0,-20]) rotate([0,0,90]) cube([20,10,10]);
  } 
  }
}
  if(cutout==2)
  rotate([0,0,(mouth_size_angle-180)/-2+mouth_angle]) teeth();
  }
}
}
module teeth(color=1) {
  rotate([0,0,180]) translate([0,0]) {
          color(color?"silver":false) rotate_extrude($fn=fnr*80)
            translate([47.5,-.1]) square([6,10.2]); 
          color(color?white:false) rotate_extrude($fn=fnr*80)
          translate([45,10]) {
            rotate([0,0,-2]) square([10,30]);
            //for(y=[10,18]) translate([1.5,y]) circle(r=2,$fn=fnr*20);
          }
          teeth_r=(mouth_size_angle+20)/(teeth_h-1);
          color(color?"black":false) for(r=[teeth_r/2-10:teeth_r:mouth_size_angle]) rotate([0,0,r]) translate([45,0,10]) rotate([0,2]) cylinder(r=1.2,h=30,$fn=fnr*10);
          color(color?"black":false) rotate_extrude($fn=fnr*80)
          translate([45,10]) for(y=[10,18]) translate([y/30,y]) circle(r=1.2,$fn=fnr*10);
        }
}
module goggles(pos=0,cutout=0,clearance=0)
{
  translate(pos?[0,0,60]:[0,0]) rotate(pos?[90,0]:[0,0]) translate(pos?[-25,20,0]:[0,0])
  difference() {
    union() {
      hull()
      {
        for(y=[-10,14]) mirrorx(50) translate([-20,y]) sphere(d=20+clearance,$fn=fnr*30);
        mirrorx(50)
          translate([-5,0,50]) cylinder(d=50+clearance,h=16,$fn=fnr*50);
      }
      mirrorx(50)
        translate([-5,0,66]) rotate([0,0,90]) rotate_extrude($fn=fnr*50,angle=180) {
          translate([22.5,0]) circle(d=5,$fn=fnr*20);
        }
        for(y=[-22.5,22.5])
        translate([-5,y,66]) rotate([0,90]) rotate([0,0,90]) cylinder(d=5,h=60,$fn=fnr*20);
    }
    if(cutout) {
      translate([25,-20,0]) eyeballs(0,clearance=1);
      //hull()
      for(x=[-5,55])
        translate([x,0,46.6]) {
          cylinder(d=40,h=40,$fn=fnr*60);
          mirror([0,0,1]) translate([0,0,-.01]) cylinder(d1=40,d2=30,h=8,$fn=fnr*60);
        }
      translate([-5,-20,40]) cube([60,40,40]);
      translate([25,-80]) rotate([-90,0]) ///cylinder(d=100,h=50,$fn=fnr*80);
      eye_groove();
    }
  }
}
module eyes(color=1,pos=1,goggles=1,eyeballs=1,eyebrows=1,pupils=1,pegs=0,clearance=0) {
  translate(pos?[0,0,60]:[]) rotate(pos?[90,0]:[]) union() {
    if(goggles)
    translate(pos?[-25,20,0]:[]) difference() {
      color(color?"silver":false) goggles();
      
       color(color?"black":false) translate([0,0,45]) {
        hull() for(x=[-5,55])
          translate([x,0,-.1]) cylinder(d=40,h=30.2,$fn=fnr*80);
      }
    }
    if(eyeballs==1)
      eyeballs(color=color,pegs=pegs,clearance=clearance,pupils=pupils==2?2:1);
  }
    if(eyebrows)
    color(color?"black":false) mirrorx() translate([-24,-40,79-eyeball_drop]) intersection() {
      sphere(d=eyeball_dia+eyebrow_thickness*2,$fn=fnr*80);
      translate([-30,-41,30]) rotate([0,eyebrow_angle]) cube([60,30,9]);
    }
    if(goggles||eyebrows)
  color(color?"black":false) translate([-25,-47,60]) {
    cube([50,4,40]);
    rotate([90,0]) linear_extrude(eyeball_border_depth) hull() {
      translate([-4,20]) circle(d=40,$fn=fnr*60);
      translate([54,20]) circle(d=40,$fn=fnr*60);
    }
  }
  if(eyeballs&&pupils)
  color(color?"black":false) translate([0,0,60]) rotate([90,0]) translate([0,0,-eyeball_inset]) for(x=[-25,23]) translate([x,20,eyeball_dia-1]) rotate(eye_rotation) translate([0,-eyeball_drop,23.5]) cube(6,center=true);
}
module eyeballs(color=1,clearance=0,pegs=0,pupils=1) {
  translate([0,0,-eyeball_inset]) intersection()
    {
      translate([-50,-1-clearance/2]) cube([100,42+clearance,80]);
      for(x=[-24,24]) translate([x,20,50]) rotate(eye_rotation) difference() {
        color(color?white:false) translate([0,-eyeball_drop]) rotate(-eye_rotation) {
          sphere(d=eyeball_dia+clearance,$fn=fnr*80);
        }
        if(pegs==1)
          translate([0,-eyeball_drop]) rotate([-eye_rotation[0],0]) rotate([90,0]) cylinder(d=eyeball_peg_dia+.4,h=eyeball_dia+2,center=true,$fn=20);
        if(pupils==1)
        translate([0,-eyeball_drop,eyeball_dia/2+clearance/2-pupil_depth]) {
          translate([pupil_size/-2,pupil_size/-2]) cube([pupil_size,pupil_size,pupil_depth+2]);
          *rotate([0,0,45]) cylinder(d=8,h=2,$fn=4);
        }
      }
    }
    if(pegs==2) for(m=[0,1]) mirror([0,m])
      translate([0,m==1?-40:0,-eyeball_inset]) for(x=[-24,24]) translate([x,20,50]) rotate([90,0]) {
      cylinder(d=eyeball_peg_dia,h=40,$fn=fnr*20);
      translate([0,0,30]) cylinder(d=5.5,h=10.1,$fn=30);
    }
}
module eyebrows(pos=1)
{
  translate(pos?[0,0,-eyeball_inset+10]:[0,0]) rotate(pos?[-90,0]:[0,0]) intersection() {
    translate([-100,-40,-3]) cube([200,40,30]);
    translate([0,-100,-50]) rotate([-90,0]) 
  difference() {
    eyes(color=1,eyeballs=0,eyebrows=1,goggles=0,pupils=0);
    translate([-0,0,60]) rotate([90,0]) eyeballs(clearance=0.4);
  }
}
}
module head_top(mag=1,inset=1,clearance=0) {
  difference() {
  rotate_extrude(convexity=4,$fn=fnr*80) {
    intersection() {
      translate([0,0]) square([100,160]);
      union() {
        hull()
        {
          translate([20,0])  circle(r=30-clearance,$fn=fnr*70);
          translate([0,14]) circle(r=16-clearance,$fn=fnr*40);
        }
      }
    }
  }
  if(mag)
  translate([0,0,18.8-clearance]) cylinder(d=10.4+clearance*2,h=3.21+clearance,$fn=fnr*30);
  if(inset)
  translate([0,0,22-clearance]) cylinder(d=36+clearance*2,h=50+clearance,$fn=fnr*40);
}
  //antenna();
}
module antenna(mag=0) {
  difference() {
    rotate_extrude(convexity=4,$fn=fnr*60) {
      intersection() {
        translate([0,0]) square([100,160]);
        union() {
          translate([0,22]) square([18,8]);
          translate([10,30]) circle(d=16,$fn=fnr*50);
          translate([0,100]) circle(d=16,$fn=fnr*50);
          polygon([[0,30],[0,100],[3,100],[10,30]]);
        }
      }
    }
    if(mag) translate([0,0,21.9]) cylinder(d=10.4,h=3.21,$fn=fnr*30);
  }
}
module mirrorx(off=0) { translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children(); }