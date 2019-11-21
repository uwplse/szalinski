 ////////////////////
//Dragon Pose generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west,tilt:top diagonal]
//RandomSeed
/* [Dragon] */
// Quick dummy or full
dummy =0;//[1:dummy,0:normal]
seed = 1492; //[1111:9999]
//
crash = "no"; //["yes":Yes please make a mess,"no":No thanks keep it simple] 

// Along curve
detail = 12; //[5:30]
// Spheres detail
fn = 12; //[8:30];

/* [Wings] */
ShowWingTarget=0;//[1:on,0:off]
//make it fat for printability
WingSkin = 2; //[0.1:0.05:2]
Wingsize = 50+crnd(20);//[25:120]
UpDraft=[-0.25,0,0.66];
wind=UpDraft*Wingsize*0.3;
WingTargetHeight=crnd(0.7)+0.5;//[-1:0.05:1]
WingTargetspan=max(0.5,crnd(0.7)+0.3);//[0.0:0.05:2]
WingTargetSideShift=crnd(0.2);//[-1:0.05:1]
WingTargetFront=crnd(WingTargetspan)-0.5;//[-1:0.05:1]

WingTargetRoll=crnd(WingTargetspan*0.5);//[-1:0.05:1]
WingTargetYaw=crnd(WingTargetspan*0.5);//[-1:0.05:1]
//Wingspan = Wingsize * 2 + rands(-Wingsize * 0.4,Wingsize * 0.4,1)[0];
Wingspan = Wingsize * WingTargetspan;
/* [Head] */
ShowHeadTarget=0;//[1:on,0:off]
HeadTargetHeight=crnd(0.5);//crnd(1);//[-1:0.05:1]
HeadTargetFront=crnd(0.5);//[-1:0.05:1]
HeadTargetSideShift=crnd(max(0,HeadTargetHeight));//[-1:0.05:1]
HeadTargetRoll=crnd(0.5);//[-1:0.05:1]
NoseTargetHeight=crnd(2)+1;//[-1:0.05:1]
NoseTargetFront=crnd(0.4)+0.5;//[-1:0.05:1]
NoseTargetSideShift=crnd(1);//[-1:0.05:1]
JawOpen=crnd(0.5)+0.5;//[0.0:0.05:2]
/*[Arms]*/
ShowArmTarget=0;//[1:on,0:off]
ArmsTargetSpan=crnd(0.5)+0.55;//[0.0:0.05:2]
ArmsTargetHeight=-crnd(2)+abs(crnd(ArmsTargetSpan));//crnd(1);//[-1:0.05:1]
ArmsTargetFront=ArmsTargetSpan+crnd(0.4)+1.6;//[-1:0.05:1]
ArmsTargetSideShift=crnd(0.3);//[-1:0.05:1]
ArmsTargetRoll=crnd(ArmsTargetSpan);//[-1:0.05:1]
ArmsTargetYaw=crnd(ArmsTargetSpan);//[-1:0.05:1]
Rightpaw =ArmsTargetSpan*ArmsTargetHeight*0.4+0.1;//[-1:0.05:1]
Leftpaw=ArmsTargetSpan*ArmsTargetHeight*0.4+0.1;//[-1:0.05:1]
/*[Back end]*/
ShowPelvisTarget=0;//[1:on,0:off]
PelvisTargetHeight=crnd(0.5)+0.3;//[-1:0.05:1]
PelvisTargetFront=crnd(0.5)-0.9;//[-1:0.05:1]
PelvisTargetSideShift=crnd(0.3);//[-1:0.05:1]
BackFootSpread=crnd(0.3)+0.6;//[-1:0.05:2]
BackFootYaw=crnd(0.3);//[-1:0.05:1]
BRightpaw =BackFootSpread-1.2;//[-1:0.05:1]
BLeftpaw=BackFootSpread-1.2;//[-1:0.05:1]
/*[Front end]*/
ShowThoraxTarget=0;//[1:on,0:off]
ThoraxTargetHeight=crnd(0.5);//crnd(0.4)+0.4;//[-0.5:0.05:1]
ThoraxTargetFront=crnd(0.10)+0.11 ;//[-1:0.05:1]
ThoraxTargetSideShift=crnd(0.1);//[-1:0.05:1]
BellySize=crnd(0.1)+1.7;//[0.05:0.1:3]
BellySag=crnd(0.5)+1;//[0.05:0.1:3]
/*[Plattform]*/
Plattform=1;//[1:on,0:off]
PlattformH=1.5;//[0:100]
PlattformD=50;//[20:70]
PlattformEdge=1;//[0:0.5:70]

//number of edges
PlattformFn=30;//[3:100]
//rotate
PlattformR=0;//[0:120]
Support=0;//[1:on,0:off]
SupportD=2;//[1:0.5:30]
SupportFn=30;//[3:100]
//part = 0; //[0,2,3,4,5]
/* [Hidden] */
//Zoom
Zoom =160;//[100:300]
//$vpd =Zoom;
//View rotation
Vrot= [80, 0, 300];
//$vpr =Vrot;
//View translation
Vtr= [ -5, 0, 20];
//$vpt = Vtr;
k=1+dummy*2;
rad = 5; //[1:0.5:12];
tang = 1; //[1:10];
sky = [1,0.001,0];
*for (i=[0:10]){   translate([crnd(1)*100,0,0]) sphere(10);}
Base = [0,0,0];


//*********************************************************************************
//*********************************************************************************
//*********************************************************************************
//*********************************************************************************
// calculated values
//*********************************************************************************
//*********************************************************************************
//*********************************************************************************
//*********************************************************************************
//************************************************************************************
BackFootBase = Base + [6,rnd(2),0];
FrontFootBase = BackFootBase + [ 5*ArmsTargetFront,5*ArmsTargetSideShift,15 + 15*ArmsTargetHeight];
CPelvis = BackFootBase+[-6,0,0] + lim3(15,[4*PelvisTargetFront,6*PelvisTargetSideShift,5+6*PelvisTargetHeight+2*ArmsTargetHeight]);
CThorax = ground(CPelvis + lim33(14,20,[15*ThoraxTargetFront ,FrontFootBase[1]*0.1+10*ThoraxTargetSideShift ,5+5*ArmsTargetHeight+10*ThoraxTargetHeight  ]),3);
bll = flip3((CThorax - CPelvis) / len3(CThorax - CPelvis));
bellyik = -IK(15*BellySag,CThorax - CPelvis);
Belly = ground(CPelvis + lim3(8,CThorax - CPelvis) / 2 + [bellyik * bll[0],bellyik * bll[1],bellyik * bll[2]]);
head = ground(CThorax + lim31(15,[10 + 20*HeadTargetFront,20*HeadTargetSideShift,10 + 20*HeadTargetHeight]));
TailT = CPelvis + lim31(30,[-15 + rnd(10),rnd(5),5+ rnd(8)]-(un(CThorax-CPelvis))*4 );
Tail=[TailT[0],TailT[1],max(0,TailT[2])];

TailtipT = Tail + lim31(30,[rnd(15),rnd(15),8 + rnd(15)] + [-abs(FrontFootBase[2]) * 1,0,0]);
Tailtip=[TailtipT[0],TailtipT[1],max(0,TailtipT[2])];
Thorax = bez2(0.30,[CPelvis + lim31(2,Tail - CPelvis),CPelvis,Belly,CThorax,head]) + [0,0,-4];
Pelvis = bez2(0.4,[CThorax,Belly,CPelvis,Tail]);
WingBase = Thorax + [Wingsize*WingTargetFront,Wingsize*WingTargetSideShift,Wingsize *WingTargetHeight];
nose = ground(head+ lim31(5,[30+50*NoseTargetFront,50*NoseTargetSideShift,50*NoseTargetHeight]-head));
noselookat =head+ lim31(30,[30+30*NoseTargetFront,30*NoseTargetSideShift,30*NoseTargetHeight]-head);

jaw = head + ((nose - head) * 0.7 + [-1,0,-2]);
RightHip = Pelvis + [4,-6,2];
LeftHip = Pelvis + [4,6,2];
RightSholder = Thorax + [-1,-5,3 + rnd(1)];
LeftSholder = Thorax + [-1,5,3 + rnd(1)];
RightWingSholder = Thorax + [-6,-3,6.3];
LeftWingSholder = Thorax + [-6,3,6.3];
paw = rnd(1);

BackRightFoot = RightHip + lim3(14,BackFootBase + [-10+7*BackFootYaw,-4-6*BackFootSpread,3] - RightHip);
BackLeftFoot = LeftHip + lim3(14,BackFootBase + [-10-7*BackFootYaw ,4+6*BackFootSpread,3] - LeftHip);

FrontRightFootT = RightSholder + lim31(14.5,FrontFootBase + [-20*ArmsTargetYaw,-5-12*ArmsTargetSpan,-20*ArmsTargetRoll]  - RightSholder);
FrontRightFoot=ground([min(RightSholder[0]+5,FrontRightFootT[0]),min(RightSholder[0]+1,FrontRightFootT[1]),min(head[2]-5,FrontRightFootT[2])],2.0+ArmsTargetSpan*1.5);
FrontLeftFootT = LeftSholder + lim31(14.5,FrontFootBase + [20*ArmsTargetYaw, 5+12*ArmsTargetSpan,20*ArmsTargetRoll] - LeftSholder);
FrontLeftFoot=ground([min(LeftSholder[0]+5,FrontLeftFootT[0]),max(LeftSholder[1]-1,FrontLeftFootT[1]),min(head[2]-5,FrontLeftFootT[2])],2.0+ArmsTargetSpan*1.5);

Rightwingfinger0T = RightWingSholder + lim3(Wingsize,WingBase + [-Wingsize*WingTargetYaw,-Wingspan ,-Wingsize*WingTargetRoll] - RightWingSholder);

Rightwingfinger0=[Rightwingfinger0T[0],Rightwingfinger0T[1],max(0,Rightwingfinger0T[2])];

Leftwingfinger0T = LeftWingSholder + lim3(Wingsize,WingBase + [Wingsize*WingTargetYaw,Wingspan ,Wingsize*WingTargetRoll] - LeftWingSholder);
Leftwingfinger0=[Leftwingfinger0T[0],Leftwingfinger0T[1],max(0,Leftwingfinger0T[2])];

//FrontRightleg
frk = flip3((FrontRightFoot - RightSholder) / len3(FrontRightFoot - RightSholder));
frkik = -IK(14,FrontRightFoot - RightSholder);
FrontRightknee =ground( RightSholder + lim3(14,FrontRightFoot - RightSholder) / 2 + [frkik * frk[0],frkik * frk[1],frkik * frk[2]]);
//FrontLeftleg
flk = flip3((FrontLeftFoot - LeftSholder) / len3(FrontLeftFoot - LeftSholder));
flkik = -IK(14,FrontLeftFoot - LeftSholder);
FrontLeftknee = ground(LeftSholder + lim3(14,FrontLeftFoot - LeftSholder) / 2 + [flkik * flk[0],flkik * flk[1],flkik * flk[2]]);
//BackRightleg
brk = flip3((BackRightFoot - RightHip) / len3(BackRightFoot - RightHip));
brkik = -IK(15,BackRightFoot - RightHip);
BackRightknee =ground( RightHip + lim3(15,BackRightFoot - RightHip) / 2 + [brkik * brk[0],brkik * brk[1],brkik * brk[2]]);
//BackLeftleg
blk = flip3((BackLeftFoot - LeftHip) / len3(BackLeftFoot - LeftHip));
blkik = -IK(15,BackLeftFoot - LeftHip);
BackLeftknee = ground(LeftHip + lim3(15,BackLeftFoot - LeftHip) / 2 + [blkik * blk[0],blkik * blk[1],blkik * blk[2]]);
//FrontRightWing
//frj=flip3((FrontRightWing-RightWingSholder)/len3(Rightwingfinger0-RightWingSholder));
//frjik=IK(50,Rightwingfinger0-RightWingSholder);
//FrontRightjoint=RightWingSholder+lim3(40,Rightwingfinger0-RightWingSholder)/2+[ -frjik*frj[0],-frjik*frj[1]*0.5,-frjik*frj[2]];
FrontRightjoint = beckham(Rightwingfinger0,RightWingSholder,Wingsize * 1.1,[0,1,1]);
//Rightwingfinger0=RightWingSholder+lim3(45,Rightwingfinger0-RightWingSholder)/2;
//Rightwingfinger2=FrontRightjoint+lim31(25,Rightwingfinger0-FrontRightjoint);
Rightelbow = beckham(RightWingSholder,FrontRightjoint,len3(RightWingSholder - FrontRightjoint) * 1.1,[0,0,-1],0.3);
Rightwingfinger2 = FrontRightjoint + lim31(Wingsize * 0.56,pele(Rightwingfinger0,Rightelbow,[Wingsize*0.1,Wingsize*0.1,0]) - FrontRightjoint);
Rightwingfinger1 = FrontRightjoint + lim31(Wingsize * 0.56,beckham(Rightwingfinger0,Rightwingfinger2,len3(Rightwingfinger0 - Rightwingfinger2) * 1.02,[0,1,0],0.50) - FrontRightjoint);

Rightknuckle0= beckham(FrontRightjoint,Rightwingfinger0,len3(FrontRightjoint - Rightwingfinger0) * 1.02,[0,-1,1],0.5);
Rightknuckle1= beckham(FrontRightjoint,Rightwingfinger1,len3(FrontRightjoint - Rightwingfinger1) * 1.02,[0,-1,-1],0.5);
Rightknuckle2= beckham(FrontRightjoint,Rightwingfinger2,len3(FrontRightjoint - Rightwingfinger2) * 1.02,[0,1,-1],0.5);


Rightelbowfinger = Rightelbow + lim31(-Wingsize*0.2,midpoint(RightWingSholder,FrontRightjoint,0.4) - Rightelbow);
//Leftwingfinger0
//flj=flip3((Leftwingfinger0-LeftWingSholder)/len3(Leftwingfinger0-LeftWingSholder));
//fljik=IK(50,Leftwingfinger0-LeftWingSholder);
//FrontLeftjoint=LeftWingSholder+lim3(43,Leftwingfinger0-LeftWingSholder)/2+[ -fljik*flj[0],-fljik*flj[1]*0.5,-fljik*flj[2]];
FrontLeftjoint = beckham(Leftwingfinger0,LeftWingSholder,Wingsize * 1.1,[0,-1,1]);
//Leftwingfinger1=LeftWingSholder+lim3(45,Leftwingfinger0-LeftWingSholder)/2;
//Leftwingfinger=FrontLeftjoint+lim31(25,Leftwingfinger1-FrontLeftjoint);
Leftelbow = beckham(LeftWingSholder,FrontLeftjoint,len3(LeftWingSholder - FrontLeftjoint) * 1.1,[0,0,-1],0.3);
Leftwingfinger2 = FrontLeftjoint + lim31(Wingsize * 0.56,pele(Leftwingfinger0,Leftelbow,[Wingsize*0.1,-Wingsize*0.1,0]) - FrontLeftjoint);
Leftwingfinger1 = FrontLeftjoint + lim31(Wingsize * 0.56,beckham(Leftwingfinger0,Leftwingfinger2,len3(Leftwingfinger0 - Leftwingfinger2) * 1.02,[0,-1,0],0.5) - FrontLeftjoint);

Leftknuckle0= beckham(FrontLeftjoint,Leftwingfinger0,len3(FrontLeftjoint - Leftwingfinger0) * 1.02,[0,1,1],0.5);
Leftknuckle1= beckham(FrontLeftjoint,Leftwingfinger1,len3(FrontLeftjoint - Leftwingfinger1) * 1.02,[0,1,-1],0.5);
Leftknuckle2= beckham(FrontLeftjoint,Leftwingfinger2,len3(FrontLeftjoint - Leftwingfinger2) * 1.02,[0,-1,-1],0.5);

Leftelbowfinger = Leftelbow + lim31(-Wingsize*0.2,midpoint(LeftWingSholder,FrontLeftjoint,0.4) - Leftelbow);//////
bodyvector = [
q(Tailtip,0.1 + WingSkin * 0.5),q(Tailtip,0.1 + WingSkin * 0.5),
q(Tail,1),q(Tail,1),q(Tail,1),
q(Pelvis,0),q(Pelvis,0),
q(Belly,5*BellySize),q(Belly,7*BellySize),
q(Thorax,6),q(Thorax,1),
q(head,max(WingSkin,0.5)),
q(head,max(WingSkin*2,1)),
q(head,max(WingSkin*3,2)),
q(head,2) + (q(nose,0.5) - q(head,2)) * 0.5];
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//// Redraw
    /////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
difference(){
union() {
  rotate([0,0,180]) {
      if(Plattform==1){
      translate([0,0,1.2]) rotate([0,0,PlattformR])union(){
          PE=min(PlattformD/2-7,PlattformEdge);
     translate([0,0,-PE+0.0001])cylinder(d1=PlattformD,d2=PlattformD-PE*2,h=PE,$fn=PlattformFn);
      translate([0,0,-PlattformH-PE])cylinder(d=PlattformD,h=PlattformH,$fn=PlattformFn);
      }}
      if(Support==1){
      translate([0,0,1.2]) rotate([0,0,PlattformR])union(){
          SD=min(SupportD,PlattformD);
     translate([Thorax[0],Thorax[1],0.0001])cylinder(r=SD,h=Thorax[2],$fn=SupportFn);
      }}
    
      
      
      if(ShowHeadTarget){%draw(head,noselookat,1);
          %draw(noselookat,noselookat,2); 
          //%translate(noselookat)cube(60,center=true);
          }  
      
   if(ShowPelvisTarget==1){
%draw(CPelvis+[0,20,0],CPelvis+[0,-20,0],1); 
          %draw(CPelvis+[0,-20,0],CPelvis+[0,20,0],1);  } 
             if(ShowThoraxTarget==1){
%draw(CThorax+[0,20,0],CThorax+[0,-20,0],1); 
          %draw(CThorax+[0,-20,0],CThorax+[0,20,0],1);  } 
          if(ShowArmTarget==1){%draw(FrontFootBase,FrontFootBase,3);
%draw(FrontRightFoot,FrontLeftFoot,1); 
          %draw(FrontLeftFoot,FrontRightFoot,1); }  
      if(ShowWingTarget==1){%draw(WingBase,WingBase,3);
%draw(Rightwingfinger0,Leftwingfinger0,1); 
          %draw(Leftwingfinger0,Rightwingfinger0,1); }  
          
          
          
          
      color("red") {  //draw(RightWingSholder,Rightelbow,1.2);
        color("red") bone(Rightelbow,FrontRightjoint,0.8);
bone(Leftelbow,FrontLeftjoint,0.8);
bone(Rightelbow,Rightelbowfinger,0.5);
bone(Leftelbow,Leftelbowfinger,0.5);

  
bone(FrontRightjoint,Rightknuckle0,0.5);bone(Rightknuckle0,Rightwingfinger0,0.5);
bone(FrontRightjoint,Rightknuckle1,0.5);bone(Rightknuckle1,Rightwingfinger1,0.5);
bone(FrontRightjoint,Rightknuckle2,0.5);bone(Rightknuckle2,Rightwingfinger2,0.5);        

bone(FrontLeftjoint,Leftknuckle0,0.5);bone(Leftknuckle0,Leftwingfinger0,0.5);
bone(FrontLeftjoint,Leftknuckle1,0.5);bone(Leftknuckle1,Leftwingfinger1,0.5);
bone(FrontLeftjoint,Leftknuckle2,0.5);bone(Leftknuckle2,Leftwingfinger2,0.5);        



      }
    FrontRightLeg = [q(Thorax,2),q(RightSholder,2),q(RightSholder,2),q(FrontRightknee,3),q(FrontRightknee,0),q(FrontRightknee,1),q(FrontRightknee,2),q(FrontRightFoot,0),q(FrontRightFoot,1)];
    bline(vsharp(FrontRightLeg),detail*0.5,1) {null();
      null();null();
    };
    FrontLeftLeg = [q(Thorax,2),q(LeftSholder,2),q(LeftSholder,2),q(FrontLeftknee,3),q(FrontLeftknee,0),q(FrontLeftknee,1),q(FrontLeftknee,2),q(FrontLeftFoot,0),q(FrontLeftFoot,1)];
    bline(vsharp(FrontLeftLeg),detail*0.5,1) {null();
      null();null();
    };
    BackRightLeg = [q(Pelvis,2),q(RightHip,2),q(RightHip,3),q(RightHip,1),q(BackRightknee,5),q(BackRightknee,0),q(BackRightknee,1),q(BackRightFoot,0),q(BackRightFoot,1)];
    bline((BackRightLeg),detail*0.5,1) {null();
      null();null();
    };
    BackLeftLeg = [q(Pelvis,2),q(LeftHip,2),q(LeftHip,3),q(LeftHip,1),q(BackLeftknee,5),q(BackLeftknee,0),q(BackLeftknee,1),q(BackLeftFoot,0),q(BackLeftFoot,1)];
    bline((BackLeftLeg),detail*0.5,1) {null();
      null();null();
    };
    bline([q(Thorax,2),q(RightWingSholder,1),q(Rightelbow,0.5)],detail*0.8,1){ {sphere(1.2);null();null();}};
   
 Skinflap( Rightelbowfinger,Rightelbow,FrontRightjoint,FrontRightjoint,Rightknuckle2,Rightwingfinger2,detail*0.65);
 Skinflap( Rightwingfinger2,Rightknuckle2,FrontRightjoint,FrontRightjoint,Rightknuckle1,Rightwingfinger1,detail*0.65);
 Skinflap( Rightwingfinger1,Rightknuckle1,FrontRightjoint,FrontRightjoint,Rightknuckle0,Rightwingfinger0,detail*0.65);
 
    wingbline([q(midpoint(RightWingSholder,Thorax),WingSkin),q(Rightelbow,WingSkin),q(Rightelbowfinger,WingSkin)],8);
   wingbline([q(midpoint(RightWingSholder,Thorax),WingSkin),q(Rightelbow,WingSkin),q(FrontRightjoint,WingSkin)],8);
    
    
    bline([q(Thorax,2),q(LeftWingSholder,1),q(Leftelbow,0.5)],detail*0.8,1){
        sphere(1.2);null();null();}
        
    
    
    
     Skinflap( Leftelbowfinger,Leftelbow,FrontLeftjoint,FrontLeftjoint,Leftknuckle2,Leftwingfinger2,detail*0.65);
 Skinflap( Leftwingfinger2,Leftknuckle2,FrontLeftjoint,FrontLeftjoint,Leftknuckle1,Leftwingfinger1,detail*0.65);
 Skinflap( Leftwingfinger1,Leftknuckle1,FrontLeftjoint,FrontLeftjoint,Leftknuckle0,Leftwingfinger0,detail*0.65);
 
    wingbline([q(midpoint(LeftWingSholder,Thorax),WingSkin),q(Leftelbow,WingSkin),q(Leftelbowfinger,WingSkin)],8){;null();null();null();null();}
   wingbline([q(midpoint(LeftWingSholder,Thorax),WingSkin),q(Leftelbow,WingSkin),q(FrontLeftjoint,WingSkin)],8){;null();null();null();null();}
    //translate(t(head))rotate(uv2euler(lim31(1,nose-head)))scale(0.75)headcase();
   
  *translate([0,0,10])ShowControl(bodyvector);

   bline(bodyvector,40,1) { 
       if (dummy){color(rndc())translate([0,0,0]) rotate([0,-20,0]) cylinder(d = 1,d2 = 0,h = 2);} else{
        translate([0,0,0]) rotate([0,-20,0]) cylinder(d = 1,d2 = 0,h = 2);}//ch1
      
        scale(0.75)  rotate([HeadTargetRoll*90,0,0])headcase();//ch2
      scale(1.5) translate([5,0,0]) union() {  union() {    rotate([0,-90,0]) scale([1 + WingSkin * 0.5,6,8]) rotate([0,0,0]) cylinder(d = 1,d2 = 0,h = 1,$fn = 4);
          rotate([0,90,0]) scale([1 + WingSkin * 0.5,6,4]) rotate([0,0,0]) cylinder(d = 1,d2 = 0,h = 1,$fn = 4);
        }
        rotate([90,0,0]) union() {    rotate([0,-90,0]) scale([1 + WingSkin,4,6]) rotate([0,0,0]) cylinder(d = 1,d2 = 0,h = 1,$fn = 4);
          rotate([0,90,0]) scale([1 + WingSkin,4,3]) rotate([0,0,0]) cylinder(d = 1,d2 = 0,h = 1,$fn = 4);
        }
      }//ch3
      null();null();
    }
    
    translate([1,0,-1]) translate(BackRightFoot) scale([0.5,0.5,0.5]) translate([-2,0,-0.5]) rotate([0,20,BLeftpaw * 90]) foot();
    translate([1,0,-1]) translate(BackLeftFoot) scale([0.5,0.5,0.5]) translate([-2,0,-0.5]) rotate([0,20,-BRightpaw * 90]) foot();
    translate([2,0,-1]) translate(FrontRightFoot) translate([-1.5,0,0]) rotate([45*max(0,ArmsTargetHeight)+45*ArmsTargetSpan+Rightpaw*15 ,-Rightpaw *60,-30]) scale([0.5,0.5,0.5]) foot();
    translate([2,0,-1]) translate(FrontLeftFoot) translate([-1.5,0,0]) rotate([-45*max(0,ArmsTargetHeight)-45*ArmsTargetSpan+Leftpaw*15,-Leftpaw * 60,30]) scale([0.5,0.5,0.5]) foot();
   
   
    /*union() { * color([1 - 2 / FrontRightFoot[2],0,0]) translate([FrontRightFoot[0],FrontRightFoot[1],0.011]) scale([1,0.5,1]) cylinder(r = 3 + FrontRightFoot[2] * 0.2); * color([1 - 2 / FrontLeftFoot[2],0,0]) translate([FrontLeftFoot[0],FrontLeftFoot[1],0.011]) scale([1,0.5,1]) cylinder(r = 3 + FrontLeftFoot[2] * 0.2); * color([max(1 - 4 / Thorax[2],0.5),0,0]) translate([Thorax[0],Thorax[1],0.01 - 0.01 * (1 - 1 / Thorax[2])]) scale([1,0.7,1]) cylinder(r = 3 + Thorax[2] * 0.5); * color([max(1 - 4 / Pelvis[2],0.5),0,0]) translate([Pelvis[0],Pelvis[1],0.01 - 0.01 * (1 - 1 / Pelvis[2])]) scale([1,0.7,1]) cylinder(r = 3 + Pelvis[2] * 0.5); * color("Red") translate(Base) cylinder(r = 25);    }*/  }}
  
  
  
              PE=min(PlattformD/2-7,PlattformEdge);

 translate([0,0,-PlattformH-20])cylinder(d=PlattformD+20,h=20,$fn=PlattformFn);    
    
    
    
    }
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    module yourmodule(i,v) {
  //anything in this module will be copeid and rotatdet along curve (v) at (detail) intevall
  //if ((floor(i*10)%10)>1){translate([0,0,bez2(i,v)[3]])scale([0.3,0.1,0.5])sphere(bez2(i,v)[3]); ;}
  for(j = [rands(0,bez2(i,v)[3] * 2,1)[0]: 360 / rad / bez2(i,v)[3]: 360]) {
    rotate([j,0,0]) translate([0,0,bez2(i,v)[3]])
      // anything here//////////////
    scale(0.5 * bez2(i,v)[3]) scale([2,1,0.5]) translate([0,0,-0.5]) rotate([0,-10,rands(-5,5,1)[0]])
    cylinder(d = 1,d2 = 0.5,h = 0.5,$fn = 4);
    //sphere( [bez2(i,v)[3]/2*tang,bez2(i,v)[3]/2,bez2(i,v)[3]/2],$fn= 8,center=true);
    //////////////////
  }
}

module horn(){
 hornv= [[0,0,0,1],[0.2,0,1,0.5],[0.001,0,2,0.2]];
extrudeT(hornv,8){
rotate([0,90,0])cylinder(d=1,h=0.1, $fn=10);    null();null();    }
       
    
    }
module tooth(){
 toothv= [[0,0,0,1],[0.2,0,1,0.5],[0.001,0,2,0.2]];
extrudeT(toothv,8){
rotate([0,90,0])cylinder(d=1,h=0.1);    null();null();    }
       
    
    }
module wisker(){
 wiskerv= [[0,0,0,1],[0.2,0,1,0.5],[5,0.001,1,0.2],[5,0.001,2,0.2]];
extrudeT(wiskerv,8){
rotate([0,90,0])cylinder(d=1,h=0.1);    null();null();    }
       
    
    }
    
    
module foot() {
  { if (dummy){color(rndc())translate([-3,-4,-2])cube([10,8,4]);}else{
    v = [
      [-3,0,2,1],[0,0,-1,1],[0,0,3,4],[0,0,3,4],[4,0,0,2],[8,0,-4,1],[8,0,10,0],[12,0,7,1],[15,0,-3,0],[15,0,-3,0]
    ];
    v2 = [
      [-3,0,0,0],[2,5,3,5],[0,0,1,1],[10,5,-5,1],[6,5,8,1],[9,6,5,1],[11,6,-2,0],[11,6,-2,0]
    ];
    v3 = [
      [-3,0,0,0],[2,-5,3,5],[0,0,1,1],[10,-5,-5,1],[6,-5,8,1],[9,-6,5,1],[11,-6,-2,0],[11,-6,-2,0]
    ];
    bline(v,detail*0.8,1) {null();
      null();null();
    };
    bline(v2,detail*0.8,1) {null();
      null();null();
    };
    bline(v3,detail*0.8,1) {null();
      null();null();
    };
}}
}
module headcase() {
    if(ShowHeadTarget==1){%draw([0,0,0],[0,0,15],0.3);
          %draw([0,0,15],[0,0,15],2); 
        %rotate([0,90,0]) cylinder(r=10,h=1,center=true);
        }  
    if (dummy){color(rndc())translate([-3,-4,-5])cube([18,8,10]);}else{
  //head trunk      
  headv1 = [ [0,0,0,5],[3,0,1,5],[6,0,0.2,3.6],[9,0,-0.50,3.3],[12,0,-1,3.1],[13,0,-2.7,2.7],[14.9,0,-4.5,0.8],[14.9,0,-4.5,1.2],[14.9,0,-4.5,1.2]
  ];
  //upper tooth
  headv12 = [ [7,0,-1.3,2],[13.8,0,-4.0,1.1]
  ];
  //nose ridge
  headv2 = [ [-0.1,0,-0.1,4.8],[0,0,0,5],[0,0,0,5],[-0.5,0,2,4.5],[4.1,0,2,5.3],[4.1,0,2,5.3],[8,0,2,0],[8,0,2,0],[11,0,1.1,2],[12.5,0,0,2],[13.5,0,-1.5,2],[14.5,0,-3.5,1.5]
  ];
  //eye ridge-nostrils
  headv3 = [ [0,0,0,5],[0,0,0,5],[-1.7,2.2,4.2,2],[1.5,3.3,3.7,2],[4.9,3.7,4.3,1],[7.3,2.9,6.8,1],[4,-0.5,1.1,0],[10.5,2.4,-4,1],[12.5,3.7,5,1],[14.5,1.0,-2.5,0.2]
  ];
  headv4 = [ [0,0,0,5],[0,0,0,5],[-1.7,-2.2,4.2,2],[1.5,-3.3,3.7,2],[4.9,-3.7,4.3,1],[7.3,-2.9,6.8,1],[4,0.5,1.1,0],[10.5,-2.4,-4,1],[12.5,-3.7,5,1],[14.5,-1.0,-2.5,0.2]
  ];
  //Jaw
        gape=[-0.7,0,-0.7,0]*JawOpen*6;
  headv5 = [ [0,0,0,3],[0,4.0,0.0,2]+gape*0.1,[3,5.5,-1,2.5]+gape*0.3,[9,1,0.5,0.0]+gape*1,[9,1,0.8,2.6]+gape*1,[3,0,-6.55,2.2]+gape*1,[8,2,-3.5,1.6]+gape*1.3,[10,2,-4.6,1.4]+gape*1,[11.9,1,-5.5,1.0]+gape*1.3,[11.9,-0,-5.5,1.0]+gape*1.6
  ];
  headv6 = [ [0,0,0,3],[0,-4.0,0.0,2]+gape*0.1,[3,-5.5,-1,2.5]+gape*0.3,[9,-1,0.5,0.0]+gape*1,[9,-1,0.8,2.6]+gape*1,[3,-0,-6.55,2.2]+gape*1,[8,-2,-3.5,1.6]+gape*1.3,[10,-2,-4.6,1.4]+gape*1,[11.9,-1,-5.5,1.0]+gape*1.3,[11.9,-0,-5.5,1.0]+gape*1.6
  ];
  headv7 = [ [0,0,0,5],[0,0.0,0.5,4],[3,0,-0.2,3.5],[6,-0,0.2,2.6]+gape*1,[4,-0,-6.55,2.2]+gape*1,[8,-0,-3.5,1.6]+gape*1,[10,-0,-4.6,1.4]+gape*1.3,[11.9,0,-5.5,1.0]+gape*1.3,[11.9,-0,-5.5,1.0]+gape*1.6
  ];
  union() {
    translate([-0.2,0,0]) scale([1,1,0.9]) sphere(r = 5.1);
     translate([0.4,0,-0.5]) scale([1,1,0.9]) sphere(r = 5.1);
     bline(headv1,detail,1,0.1,0.7) {color("white") union(){
       translate ([0,0.5,0]) rotate([180,0,0]) translate ([0,0,0.5])scale(0.5)tooth();
         //cylinder(d = 0.5,d2 = 0,h = 0.8);
        translate ([0,-0.5,0]) rotate([180,0,0]) translate ([0,0,0.5]) scale(0.5)tooth();
         //cylinder(d = 0.5,d2 = 0,h = 0.8);
         }
      null();null();
    }; 
  
    bline(headv1,detail,1,0.5,1) {union(){
        /*
         rotate([-80,0,220]) translate ([0,0.4,0.4])scale(0.5)wisker();
         rotate([80,0,-220]) translate ([0,-0.4,0.4])scale(0.5)wisker();*/

       translate ([0,0,0]) rotate([100,0,-45]) translate ([0,0,0.5])scale(0.5)tooth();
        //cylinder(d = 0.5,d2 = 0,h = 2.0);
        translate ([0,0,0]) rotate([-100,0,45]) translate ([0,0,0.5])scale(0.5)tooth();
        //cylinder(d = 0.5,d2 = 0,h = 2.0);
        }
      null();null()
        ;
    };
    
    
    scale([1,0.9,1])bline(headv12,detail*0.7,1,0.1,0.95) {color("white")union() { 
        translate([0,1.3,0.8]) rotate([-15,170,15])scale(0.5)tooth();
       // cylinder(d = 1,d2 = 0,h = 2.3);
        translate([0,-1.3,0.8]) rotate([15,170,15]) scale(0.5)tooth();
        //cylinder(d = 1,d2 = 0,h = 2.3);
        
      };
      null();null();
    };
    color("Red") bline(headv2,detail*0.9,1,0,0.9) {union() {  rotate([0,-45,180]) translate([0,0,0.8])scale(0.75)horn();
        //cylinder(d = 0.7,d2 = 0,h = 1.5);
      };
      null();null();
    };
    
    bline(headv3,detail*2,1) {translate([0,0,0.2]) rotate([-65,60,0]) cylinder(d = 1,d2 = 0,h = 1.7);
      null();null();
    };
    bline(headv4,detail*2,1) {translate([0,0,0.2]) rotate([65,60,0]) cylinder(d = 1,d2 = 0,h = 1.7);
      null();null();
    };
     
    bline(headv3,detail*0.5,1,0.8,1) { rotate([-80  ,50,-20])translate([0,0,0.5])scale(1.5)horn();
       // cylinder(d = 1,d2 = 0,h = 3.7,$fn=fn);
      null();null();
    };
    bline(headv4,detail*0.5,1,0.8,1) { rotate([80,50,20])translate([0,0,0.5])scale(1.5)horn();
        // cylinder(d = 1,d2 = 0,h = 3.7,$fn=fn);
      null();null();
    };
    bline(headv5,detail*2,1,0.1,0.34) {union(){
        //rotate([-150,125,-10]) translate ([0,-1,0])wisker();
        rotate([-130,00,0]) translate ([0,0,0.8])scale(0.8) cylinder(d = 1,d2 = 0.02,h = 1.5);
       color("white")   translate ([0,-0,0]) rotate([-30,0,0]) translate ([0,0,0.8])scale(0.8)tooth();
        //cylinder(d = 0.5,d2 = 0,h = 1.8);
      translate([0,0.1,0.3]) rotate([-75,60,0]) translate ([0,0,0.5])cylinder(d = 0.5,d2 = 0,h = 1.1);
        }
      null();null();
    };
    bline(headv6,detail*2,1,0.1,0.34) {union(){
        //rotate([150,125,10]) translate ([0,1,0])wisker();
        rotate([130,00,0]) translate ([0,0,0.8])scale(0.8) cylinder(d = 1,d2 = 0.02,h = 1.5);
        color("white") translate ([0,-0,0]) rotate([30,00,0]) translate ([0,0,0.8])scale(0.8)tooth();
        //cylinder(d = 0.5,d2 = 0,h =1.8);
       translate([0,-0.1,0.3]) rotate([75,60,0]) translate ([0,0,0.5])cylinder(d = 0.5,d2 = 0,h = 1.1);
        }null();null();
    };
    bline(headv7,detail,1,0.0,0.5) {rotate([0,120,0]) 
        cylinder(d = 2,d2 = 0.25,h = 3);
        
      null();null();   }
  }
}}

module draw(s,f,h){
  hull() {
    translate(t(s)) sphere(h);
    translate(t(f)) sphere(h / 2);
  }
}

module null() {  cube(0,001);
  cube(0,001);
  cube(0,001);
}
  // Bline module
module bline(v,d,op=1,startat=0,stopat=1) {
 
    
    detail = 0.99999 / floor(d/k);
    // head pos 
    translate(t(bez2(1 - detail,v))) rotate(t(bez2euler(1 - detail,v))) {children(2); }
      // tail pos 
    translate(t(bez2(0,v))) rotate(t(bez2euler(0,v))) {children(1);}
    
    if(startat==0){translate(t(bez2(0,v))) rotate(bez2euler(0,v)) scale(bez2(0,v)[3]) children(0);}
    for(i = [detail: detail: 1]) {if(op == 1 ) { 
if(crash == "yes"){
translate([bez2(i,v)[0],bez2(i,v)[1],bez2(i,v)[2]])rotate(bez2euler(i,v))yourmodule(i,v);}
if(i>=startat&&i<=stopat){
translate([bez2(i,v)[0],bez2(i,v)[1],bez2(i,v)[2]])rotate(bez2euler(i,v))scale(bez2(i,v)[3]){children(0);}}
        //translate([0,0,1])sphere(d =1,$fn = fn);
      }
       if (dummy){color(rndc())translate([bez2(i,v)[0],bez2(i,v)[1],bez2(i,v)[2]]) rotate(bez2euler(i,v))rotate([0,90,0]) cylinder(r=bez2(i,v)[3],h=bez2(i,v)[3],$fn=8,center=true);}else{
      hull() {  translate([bez2(i,v)[0],bez2(i,v)[1],bez2(i,v)[2]]) rotate(bez2euler(i,v)) rotate([0,90,0]) {    sphere(r = bez2(i,v)[3],$fn = fn);
        };
        translate(t(bez2(i - detail,v))) rotate(bez2euler(i - detail,v)) rotate([0,90,0]) sphere(r = bez2(i - detail,v)[3],$fn = fn);
      }}
    }
  }
  // Bline module
module wingbline(vv,d) {
    detail = 0.99999 / floor(d/k);
    v = vsmooth(vv);
    for(i = [detail: detail: 1]) {
         if (dummy){color(rndc())
             
        hull() {  translate(t(vv[1])) sphere(r = vv[1][3]);
        translate([bez2(i,v)[0],bez2(i,v)[1],bez2(i,v)[2]]) rotate(bez2euler(i,v)) rotate([0,90,0]) {    sphere(r = bez2(i,v)[3],$fn = 1);
        };
        translate(t(bez2(i - detail,v))) rotate(bez2euler(i - detail,v)) rotate([0,90,0]) sphere(r = bez2(i - detail,v)[3],$fn = 1);
        }}else{
        hull() {  translate(t(vv[1])) sphere(r = vv[1][3]);
        translate([bez2(i,v)[0],bez2(i,v)[1],bez2(i,v)[2]]) rotate(bez2euler(i,v)) rotate([0,90,0]) {    sphere(r = bez2(i,v)[3],$fn = 1);
        };
        translate(t(bez2(i - detail,v))) rotate(bez2euler(i - detail,v)) rotate([0,90,0]) sphere(r = bez2(i - detail,v)[3],$fn = 1);
      }
  }
      
    }
  }
  //The recusive
module bez(t,v) {    unt = 1 - t;
    if(len(v) > 2) {;
      v2 = [
        for(i = [0: 1: len(v) - 2]) v[i] * t + v[i + 1] * unt
      ];
      bez(t,v2);
    } else {//echo (v[0]);
      p = v[0] * t + v[1] * unt;
      translate([p[0],p[1],p[2],]) sphere(r = p[3],$fn = 10);
    }
  }
module poly(p1,p2,p3,h1) {
    if (dummy){color(rndc())draw(p1,p2,0.2);draw(p2,p3,1);draw(p3,p1,0.2);}else{
  hull() {
      h=max(h1,WingSkin);
    translate(t(p1)) sphere(h);
    translate(t(p2)) sphere(h);
    translate(t(p3)) sphere(h);
  }}
}

 
module Skinflap(e3, e2, e1, f1, f2, f3, detail=detail) {
   c = (e3 + e2 + e1 + f2 + f3) / 5 + wind;
   c2=(e2+f2)/2    ;
  // translate(t(c)) sphere(5);
   v1 = [e3, (f1 + c + c+ c) / 4, f3];v2 = [e2, (f1 + c2 + c2) / 3, f2];v3 = [e3, e2];
   v4 = [f3, f2];v5 = [e1, f1];v6 = [e2, e1];v7 = [f2, f1];
   bpatch(v1, v2, v3, v4, detail);
   bpatch(v2, v5, v6, v7, detail*0.5);
 }
module bpatch(v1, v2, v3, v4, d) {
   detail = 0.999 / floor(d); 
   for (i = [detail: detail: 1]) {
     for (j = [detail: detail: 1]) {
         if (dummy){translate(bez4(i, j, v1, v2, v3, v4))sphere(WingSkin);}
         
         else{hull(){
       poly(bez4(i, j, v1, v2, v3, v4), bez4(i, j - detail, v1, v2, v3, v4),
         bez4(i - detail, j, v1, v2, v3, v4), WingSkin);
       poly(bez4(i, j - detail, v1, v2, v3, v4), bez4(i - detail, j - detail,
         v1, v2, v3, v4), bez4(i - detail, j, v1, v2, v3, v4), WingSkin);}}
     }
   }
 }
module bone(v1,v2,s1){
    s=s1/3;
 v3=midpointjust(v1,midpointjust(v1,midpointjust(v1,v2)))+rndV()*s;
 v4=midpointjust(midpointjust(midpointjust(v1,v2),v2),v2)+rndV()*s;
 v5=midpointjust(v1,v2)+rndV()*s;

    union(){


hull()
{
color("red")translate(v1) scale(s)knuckel();
color("pink")translate(v3)scale(s*0.9)sphere(3) ;
}

hull(){
   color("pink")translate(v3)scale(s*0.9)sphere(3) ;
 
    color("Lightblue")translate(v5)scale(s*0.8)sphere(3) ;

    }
hull(){
   color("pink")translate(v5)scale(s*0.8)sphere(3) ;
 
    color("Lightblue")translate(v4)scale(s*0.6)sphere(3) ;

    }
    
    
hull(){
color("Lightblue")translate(v4)scale(s*0.7)sphere(3) ;
color("blue")translate(v2)scale(s*0.7)knuckel();
}
}

}

module knuckel(){
rotate(rndR())translate([0,0,1])rotate([90,0,0])sphere(4,$fn=5)    ;
rotate(rndR())translate([0,0,1])rotate([90,0,0])sphere(3,$fn=5)    ;
rotate(rndR())translate([0,0,3])rotate([90,0,0])sphere(3,$fn=5)    ;
}



module ShowControl(v)    {   translate(t(v[0])) sphere(1);
      for(i=[1:len(v)-1]){
         translate(t(v[i])) sphere(1);
          hull(){
              translate(t(v[i])) sphere(0.5);
              translate(t(v[i-1])) sphere(0.5);
              }          }
      }  
  
module extrudeT(v,d=8,start=0,stop=1) {
         detail=1/d;
    for(i = [start+detail: detail: stop]) {
       for (j=[0:$children-1]) 
      hull() {
        translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) children(j);
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v))scale(bez2(i- detail  , v)[3]) children(j);
      }
    }
  }

function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];
function midpointjust(start,end) = start + (end  - start )/2;

 function bez4(i, j, v1, v2, v3, v4) = ((bez2(j, v3)) * i + (bez2(j, v4)) * (1 -
   i)) * 0.5 + ((bez2(i, v1)) * j + (bez2(i, v2)) * (1 - j)) * 0.5;
 
function bez2(t,v) = (len(v) > 2) ? bez2(t,[
  for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);
//
function len3(v) = sqrt(pow(v[0],2) + pow(v[1],2) + pow(v[2],2));

function lim3(l,v) = v / len3(v) * min(len3(v),l);

function lim33(l1,l2,v) = v / len3(v) * min(max(len3(v),l1),l2);

function lim32(l,v) = v / len3(v) * max(l,1);

function lim31(l,v) = v / len3(v) * l;

function bez2euler(i,v) = [0,-asin(bez2v(i,v)[2]),atan2(bez2xy(bez2v(i,v))[1],bez2xy(bez2v(i,v))[0])];

function uv2euler(v) = [0,-asin(v[2]),atan2(bez2xy(v[1]),bez2xy(v[0]))];

function bez2xy(v) = lim31(1,[v[0],v[1],0]); // down xy projection
function bez2v(i,v) = lim31(1,bez2(i - 0.0001,v) - bez2(i,v)); // unit vector at i
function t(v) = [v[0],v[1],v[2]];

function rnd(r) = rands(-r,r,1)[0];
function crnd(r) = min(1,max(-1,(rands(-r,r,1)[0]+rands(-r,r,1)[0])*0.7));


function IK(l,v) = sqrt(pow(l / 2,2) - pow(min(len3(v),l) / 2,2));

function flip3(v) = [-v[2],-v[1],v[0]];

function q(v,i) = [v[0],v[1],v[2],i];

function vsmooth(v) = [
  for(i = [0: 1 / len(v): 1]) bez2(i,v)
];

function vsharp(v) = [
  for(i = [0: 0.5: len(v) - 1]) v[floor(i)]
];

function flipxz(v) = un(crosst(t(v),flipxy(v,sky))) * len3(v); // X flip blå
function flipxy(v) = un(crosst(sky,t(v))) * len3(v); // X flip GUL
function midpoint(start,end,bias = 0.5) = start + (end  - start )* bias;
function crosst(p1,p2)=[p1[1]*p2[2]-p1[2]*p2[1],p1[2]*p2[0]-p1[0]*p2[2],p1[0]*p2[1]-p1[1]*p2[0]];
function un(v) = v / len3(v);

function mmul(v1,v2) = [v1[0] * v2[0],v1[1] * v2[1],v1[2] * v2[2]];
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];
function beckham(start,end,length,lookat = [0,1,0],bias = 0.5) = midpoint(start,end,bias) + (un(flipxy(end - start)) * un(lookat)[1] * IK(length,(end - start)) + un(flipxz(end - start)) * un(lookat)[2] * IK(length,(end - start)) + un(end - start) * un(lookat)[0] * IK(length,(end - start)));

function pele(start,end,lookat = [0,0,4]) = midpoint(t(start),t(end)) + un(flipxy(t(end) - t(start))) * lookat[1] + un(flipxz(t(end) - t(start))) * lookat[2] + un(t(end) - t(start)) * lookat[0];

function ground(v,h=2)=[v[0],v[1],max(h,v[2])];