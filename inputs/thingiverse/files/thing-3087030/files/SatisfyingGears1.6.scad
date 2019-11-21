//;) ;P ;) ;P ;) ;P ;) ;P ;) ;P ;) ;P 
//;P ;) ;P ;) ;P ;) ;P ;) ;P ;) ;P ;)
//;) ;P ;) SNAXXUS CODE;P ;) ;P ;) ;P 
//;P ;) ;P ;) ;P ;) ;P ;) ;P ;) ;P ;)
//;) ;P ;) ;P ;) ;P ;) ;P ;) ;P ;) ;P 

//LGPL

PairGears(PressureAngle=20,TeethA=8,TeethB=10,HelixFaceAngle=0); //Bare Bones call

//PolygonGearPatternDirect();

//Quality:
//AngularResolution =.1; //step size for the parameterized involute function// smaller is sharper but more points in the model
//$fn=60;
//M=10000; //Magnify then shrink factor to prevent point culling on the involute gear polygon
//slices=10 The number of slices used in the linear extrusions. More makes it sharper but more points in the model.

//Gear Parameters
//TeethA=14; //Teeth on first gear (Gear A)
//TeethB=30; //Teeth on second gear (Gear B)
//BacklashA=0;// Added Backlash in millimeters along the pitch circle on Gear A. This narrows the teeth and loosens the fit of the gears. Use this instead of the old Rescale parameter. 
//BacklashB=0;// Added Backlash in millimeters along the pitch circle on Gear B. This narrows the teeth and loosens the fit of the gears. Use this instead of the old Rescale parameter. 
//PressureAngle=20; //degrees (Is common to both gears)
//DiametralPitch=0.6; // =Teeth/PitchDiameter (Determines tooth size and together with Teeth determines Pitch diameter. Common to both gears)
//ToothPhaseA=0; //Rotate the first Gear (Gear A) by X of a tooth, 1 is unity. The tooth is centered on the +X axis. Gear B is advanced by 0.5 and rotated 180 gegrees to enguage GearA
//Thickness=10 //The Thickness of the Gears.
//HelixFaceAngle=15 // You can angle the teeth of the gears to create helical gears. Combined with additional layers you can make double, tripple etc.. helical gears, Odd Layers reverse the helix. You still get a meshed pair.
//Layers=1 Additional Layers of the gear are added so you can make double, tripple, etc... helical gears.
//AltLayerToothPhase=0 You can shift the Tooth phase of the odd layers on multi layered gears (Usually Helical Gears) For Reasons???
//ChamferThickness=1 Select how deep you want the Chamfer at the Tooth edges. Zero Means no chamfer on tooth edges.
//InnerChamfers=true // Existance Flag for the chamfers between layers of multi layered gears.
//Rescale=1; // Use BacklashA and BacklashB instead. This is a legacy parameter to that is a Scalar to shrink gears if they printing too tight or loose.(1=normal full size)(Does not scale Z but you have your own scale command)(center distance will remain uneffected) 
//AddendumA=0 Zero is automatic! Set to zero for default of 1/DiametralPitch. This is the distance between the pitch diameter and the outer end of the tooth, on the first gear (Gear A)(This is only for the more studied gearer)
//AddendumB=0 Zero is automatic! Set to zero for default of 1/DiametralPitch. This is the distance between the pitch diameter and the outer end of the tooth, on the second gear (Gear B)(This is only for the more studied gearer)
//GearAExists=true //Existance Flag for GearA. (For generating loose parts)
//GearBExists=true //Existance Flag for GearB. (For generating loose parts)
//GearBCentered=false // Bring GearB to the center(for using on parts)
//debug=false; //Debug mode places colored cylender at PitchDiaiameter of the gears. This mihgt be good for seting up your model without wasting calculation time.
//Example: 
//PolygonPairGears(TeethA=15,TeethB=30,PressureAngle=20,ToothPhaseA=0.5);
module PairGears(AngularResolution =5,M=10000,slices=5,TeethA=12,TeethB=20,BacklashA=0,BacklashB=0,PressureAngle=20,DiametralPitch=.6,ToothPhaseA=0,Thickness=20,HelixFaceAngle=15,Layers=1,AltLayerToothPhase=0,ChamferThickness=1,InnerChamfers=true,Rescale=1,AddendumA=0,AddendumB=0,GearAExists=true,GearBExists=true,GearBCentered=false,GearAGhost=false,GearBGhost=false,debug=false){

PitchDiameterA=TeethA/DiametralPitch;
PitchDiameterB=TeethB/DiametralPitch;
BaseDiameterA=PitchDiameterA*cos(PressureAngle);
BaseDiameterB=PitchDiameterB*cos(PressureAngle);

CircularPitchA=PI*PitchDiameterA/TeethA;
PitchAngleA=CircularPitchA/(PitchDiameterA/2);

CircularPitchB=PI*PitchDiameterB/TeethB;
PitchAngleB=CircularPitchB/(PitchDiameterB/2);

CenterDistance=(PitchDiameterA+PitchDiameterB)/2;

//Test for user defined addendums
AddendumA = AddendumA<=0 ? 1/DiametralPitch : AddendumA; //[1]
AddendumB = AddendumB<=0 ? 1/DiametralPitch : AddendumB; //[1]

ThLayer=(Thickness)/Layers;

//GEAR A    
if (debug || (GearAGhost && GearAExists)){
  scale([Rescale,Rescale,1]){
    #cylinder(h =Thickness, d =PitchDiameterA , center = true);
    %cylinder(h =Thickness, d =PitchDiameterA+2*AddendumA , center = true);
  }
}
if (GearAExists && !GearAGhost){
for(i = [1 : Layers]){
  
translate([0,0,-Thickness/2+(ThLayer/2)+(i-1)*(ThLayer)]){
    
difference(){
linear_extrude(height = ThLayer, center = true, convexity = 10, twist = (180/PI)*(ThLayer*pow((-1),i)*tan(HelixFaceAngle))/(PitchDiameterA/2), slices = slices, scale = 1) {
rotate([0,0,((i-1)%2)*AltLayerToothPhase*(180/PI)*PitchAngleA+((i-1)%2)*(180/PI)*(ThLayer*tan(HelixFaceAngle))/(PitchDiameterA/2)]){
PolygonPairGears(AngularResolution =AngularResolution,M=M,TeethA=TeethA,TeethB=TeethB,BacklashA=BacklashA,BacklashB=BacklashB,PressureAngle=PressureAngle,DiametralPitch=DiametralPitch,ToothPhaseA=ToothPhaseA,Rescale=Rescale,AddendumA=AddendumA,AddendumB=AddendumB,GearAExists=GearAExists,GearBExists=false,GearBCentered=false,debug=false);
}
}
union(){
if((ChamferThickness>0)&&((i==1)||(InnerChamfers))){
translate([0,0,-ThLayer/2]){
ChamferCut(R1=BaseDiameterA/2,R2=PitchDiameterA/2+AddendumA,Thickness=ChamferThickness);
}
}
if((ChamferThickness>0)&&((i==Layers)||(InnerChamfers))){
translate([0,0,ThLayer/2]){
ChamferCut(R1=BaseDiameterA/2,R2=PitchDiameterA/2+AddendumA,Thickness=ChamferThickness);
}
}
}
}
}
}
}

//GEAR B
C = GearBCentered ? 0 : CenterDistance; //[1]
if (debug || (GearBGhost && GearBExists)){
  translate([C,0,0]){
  scale([Rescale,Rescale,1]){
  #cylinder(h =Thickness, d =PitchDiameterB , center = true);
  %cylinder(h =Thickness, d =PitchDiameterB +2*AddendumB , center = true);
  }
  }
}

if (GearBExists && !GearBGhost){
translate([C,0,0]){
  
for(i = [1 : Layers]){
translate([0,0,-Thickness/2+(ThLayer/2)+(i-1)*(ThLayer)]){
difference(){
union(){
    echo(i);
linear_extrude(height = ThLayer, center = true, convexity = 10, twist = -(180/PI)*(ThLayer*pow((-1),i)*tan(HelixFaceAngle))/(PitchDiameterB/2), slices = slices, scale = 1) {
rotate([0,0,-((i-1)%2)*AltLayerToothPhase*(180/PI)*PitchAngleB-((i-1)%2)*(180/PI)*(ThLayer*tan(HelixFaceAngle))/(PitchDiameterB/2)]){    
PolygonPairGears(AngularResolution =AngularResolution,M=M,TeethA=TeethA,TeethB=TeethB,BacklashA=BacklashA,BacklashB=BacklashB,PressureAngle=PressureAngle,DiametralPitch=DiametralPitch,ToothPhaseA=ToothPhaseA,Rescale=Rescale,AddendumA=AddendumA,AddendumB=AddendumB,GearAExists=false,GearBExists=GearBExists,GearBCentered=true,debug=false);
}
}
}
union(){
if((ChamferThickness>0)&&((i==1)||(InnerChamfers))){
translate([0,0,-ThLayer/2]){
ChamferCut(R1=BaseDiameterB/2,R2=PitchDiameterB/2+AddendumB,Thickness=ChamferThickness);
}
}
if((ChamferThickness>0)&&((i==Layers)||(InnerChamfers))){
translate([0,0,ThLayer/2]){
ChamferCut(R1=BaseDiameterB/2,R2=PitchDiameterB/2+AddendumB,Thickness=ChamferThickness);
}
}
}
}
}
}
}
}

}//end module


function CalcCenterDistance(TeethA,TeethB,DiametralPitch,PressureAngle) = ((TeethA/DiametralPitch+TeethB/DiametralPitch)/2);



//Quality:
//AngularResolution =.1; //step size for the parameterized involute function
//$fn=60;
//M=10000; //Magnify then shrink factor to prevent point culling

//Gear Parameters
//TeethA=14; //Teeth on first gear
//TeethB=30; //Teeth on second gear
//BacklashA=0;// Added Backlash in millimeters along the pitch circle on Gear A. This loosens the fit of the gears. Use this instead of the old Rescale parameter. 
//BacklashB=0;// Added Backlash in millimeters along the pitch circle on Gear B. This loosens the fit of the gears. Use this instead of the old Rescale parameter. 
//PressureAngle=20; //degrees
//DiametralPitch=0.4; // =Teeth/PitchDiameter (tooth and gear size)
//ToothPhaseA=0; //Rotate the first Gear by X of a tooth, 1 is unity. The tooth is centered on the +X axis. Gear B is advanced by 0.5 and rotated 180 gegrees to enguage GearA
//Rescale=1; // Use BacklashA and BacklashB instead. This is a legacy parameter to that is a Scalar to shrink gears if they printing too tight or loose.(1=normal full size)(center distance will remain uneffected) 
//AddendumA is the distance between the pitch diameter and the outer end of the tooth, on the first gear (For the more studied gearer)
//AddendumB is the distance between the pitch diameter and the outer end of the tooth, on the second gear (For the more studied gearer)
//GearAExists=true //Existance Flag for GearA. (For generating loose parts)
//GearBExists=true //Existance Flag for GearB. (For generating loose parts)
//GearBCentered=false // Bring GearB to the center(for using on parts)
//debug=false; //Debug mode places colored circle at PitchDiaiameter
//Example: 
//PolygonPairGears(TeethA=15,TeethB=30,PressureAngle=20,ToothPhaseA=0.5);
module PolygonPairGears(AngularResolution =0.1,M=10000,TeethA=12,TeethB=20,BacklashA=0,BacklashB=0,PressureAngle=20,DiametralPitch=.6,ToothPhaseA=0,Rescale=1,AddendumA=0,AddendumB=0,GearAExists=true,GearBExists=true,GearBCentered=false,debug=false){

//Test for user defined addendums
AddendumA = AddendumA<=0 ? 1/DiametralPitch : AddendumA; //[1]
AddendumB = AddendumB<=0 ? 1/DiametralPitch : AddendumB; //[1]

ToothPhaseB=ToothPhaseA+0.5;

PitchDiameterA=TeethA/DiametralPitch;
PitchDiameterB=TeethB/DiametralPitch;


CenterDistance=(PitchDiameterA+PitchDiameterB)/2;

echo("KNOW THIS!");
echo("GearA to GearB CenterDistance is", CenterDistance, "openScad units");

BaseDiameterA=PitchDiameterA*cos(PressureAngle);
BaseDiameterB=PitchDiameterB*cos(PressureAngle);



//automatically cut root interfereance
RootClearanceB=max(0,0.02*(AddendumA+(PitchDiameterA-BaseDiameterA)/2)+(PitchDiameterA/2 + AddendumA)-(CenterDistance-BaseDiameterB/2));

RootClearanceA=max(0,0.02*(AddendumB+(PitchDiameterB-BaseDiameterB)/2)+(PitchDiameterB/2 + AddendumB)-(CenterDistance-BaseDiameterA/2));

if (GearAExists){
scale([Rescale,Rescale,1]){
PolygonGearPatternDirect(AngularResolution =AngularResolution,M=M,Teeth=TeethA,Backlash=BacklashA,PitchDiameter=PitchDiameterA,PressureAngle=PressureAngle,Addendum = AddendumA,RootClearance=RootClearanceA,ToothPhase=ToothPhaseA,debug=debug);
}
}

if (GearBExists){
CenterDistance = GearBCentered ? 0 : CenterDistance; //[1]

translate([CenterDistance,0,0]){
scale([Rescale,Rescale,1]){
rotate([0,180,0]){
PolygonGearPatternDirect(AngularResolution =AngularResolution,M=M,Teeth=TeethB,Backlash=BacklashB,PitchDiameter=PitchDiameterB,PressureAngle=PressureAngle,Addendum = AddendumB,RootClearance=RootClearanceB,ToothPhase=ToothPhaseB,debug=debug);
}
}
}
}

}//end module


//Quality:
//AngularResolution =.1; //step size for the parameterized involute function
//$fn=60;
//M=10000; //Magnify then shrink factor to prevent point culling

//Gear Parameters
//Teeth=14;
//Backlash=0;// Added Backlash in millimeters along the pitch circle on the Gear. This loosens the fit of the gear.
//PitchDiameter=10;
//PressureAngle=20; //degrees
//Addendum = 1;
//RootClearance=0; //This inverts if you make it larger that the latter calculated BaseRadius
//ToothPhase=0; //Rotate Gear by X of a tooth, 1 is unity. The tooth is centered on the +X axis.

//Example: It makes a polygon that needs extruding
//PolygonGearPatternDirect(Teeth=15,PitchDiameter=19,PressureAngle=30,Addendum = 1,RootClearance=0,ToothPhase=0);

module PolygonGearPatternDirect(AngularResolution =.1,M=10000,Teeth=20,Backlash=0,PitchDiameter=20,PressureAngle=20,Addendum = 1,RootClearance=0,ToothPhase=1,debug=false){
//Dependent Values
BaseDiameter=PitchDiameter*cos(PressureAngle);
BaseRadius=BaseDiameter/2;
PitchRadius=PitchDiameter/2;
OutsideRadius = PitchRadius + Addendum;
CircularPitch=PI*PitchDiameter/Teeth;
PitchAngle=CircularPitch/PitchRadius; //(radian)
  
BacklashAngle = Backlash/PitchRadius; //(radian)

Beta_RoI=sqrt(pow(OutsideRadius,2)-pow(BaseRadius,2))/BaseRadius; //(radian)

Beta_RI=sqrt(pow(PitchRadius,2)-pow(BaseRadius,2))/BaseRadius; //(radian)
Theta_RI=(PI/180)*atan2(sin((180/PI)*Beta_RI)-Beta_RI*cos((180/PI)*Beta_RI),cos((180/PI)*Beta_RI)+Beta_RI*sin((180/PI)*Beta_RI));

Theta_RoI=PitchAngle/4-(PI/180)*atan2(sin((180/PI)*Beta_RoI)-Beta_RoI*cos((180/PI)*Beta_RoI),cos((180/PI)*Beta_RoI)+Beta_RoI*sin((180/PI)*Beta_RoI));

//if (Theta_RoI < Theta_RI){
//  echo("Exception! Gear outside radius smaller than the pitch radius");
//}

Beta_A=Beta_RoI;
A=PitchAngle/4-BacklashAngle/2;
invpoints = [ for (theta = [0 : AngularResolution : (180/PI)*Beta_A]) BaseRadius*M * ([ cos(theta-(180/PI)*(Theta_RI+A)), sin(theta-(180/PI)*(Theta_RI+A)) ] + (PI/180)*theta * [sin(theta-(180/PI)*(Theta_RI+A)),-cos(theta-(180/PI)*(Theta_RI+A))]) ];


invpointcorner= BaseRadius*M * ([ cos((180/PI)*Beta_A-(180/PI)*(Theta_RI+A)), sin((180/PI)*Beta_A-(180/PI)*(Theta_RI+A)) ] + (PI/180)*(180/PI)*Beta_A * [sin((180/PI)*Beta_A-(180/PI)*(Theta_RI+A)),-cos((180/PI)*Beta_A-(180/PI)*(Theta_RI+A))]);
  
//=$B$1*(COS(C3-$B$2)+C3*SIN(C3-$B$2))

//=$B$1*(SIN(C3-$B$2)+C3*(-COS(C3-$B$2)))

invpointsR = [ for (theta = [(180/PI)*Beta_A : -AngularResolution : 0]) BaseRadius*M * ([ cos(-theta+(180/PI)*(Theta_RI+A)), sin(-theta+(180/PI)*(Theta_RI+A)) ] + (PI/180)*theta * [-sin(-theta+(180/PI)*(Theta_RI+A)),cos(-theta+(180/PI)*(Theta_RI+A))] ) ];

invpointsRcorner=BaseRadius*M * ([ cos(-0+(180/PI)*(Theta_RI+A)), sin(-0+(180/PI)*(Theta_RI+A)) ] );

//=$B$1*(COS(-C3+$B$2)+C3*(-SIN(-C3+$B$2)))

//=$B$1*(SIN(-C3+$B$2)+C3*(COS(-C3+$B$2)))

Theta_A=Theta_RoI-BacklashAngle/2;
AddendumPoints = [ for (theta = [-Theta_A*(180/PI) : AngularResolution : Theta_A*(180/PI)]) OutsideRadius*M* ([ cos(theta), sin(theta) ]) ];

Theta_B=Theta_RI+A;
Theta_C=0.001+3*PitchAngle/4+BacklashAngle/2-Theta_RI;
RootPoints = [ for (theta = [Theta_B*(180/PI) : AngularResolution : Theta_C*(180/PI)]) (BaseRadius-RootClearance)*M* ([ cos(theta), sin(theta) ]) ];

RootPointcorner = (BaseRadius-RootClearance)*M* ([ cos(Theta_C*(180/PI)), sin(Theta_C*(180/PI)) ]);

scale([1/M,1/M,1]){


//linear_extrude(height = 10, center = true, convexity = 10,slices=100){
rotate([0,0,ToothPhase*(180/PI)*PitchAngle]){  
for (a =[0:PitchAngle*(180/PI):360]){
rotate(a = a){
polygon(concat(invpoints,[invpointcorner],AddendumPoints,invpointsR,[invpointsRcorner],RootPoints,[RootPointcorner],[[0,0]]));
}
}
}
}
//text("OpenSCAD");
//sphere(2, $fs = 0.03);
if (debug){
#circle(d=PitchDiameter);
}

}//end module


module ChamferCut(R1,R2,Thickness){
  T=Thickness*2;
  difference(){
  cylinder(h =T, r = 10*R2, center = true);
    
  union(){
  translate([0,0,-T/4]){
  cylinder(h =0.002+T/2, r1 = R2, r2 = R1, center = true);
  }
  translate([0,0,T/4]){
  cylinder(h =0.002+T/2, r1 = R1, r2 = R2, center = true);
  }
}
}
}

//;D ;P ;D ;P ;D ;P ;D ;P ;D ;P ;D ;P 
//;P ;D ;P ;D ;P ;D ;P ;D ;P ;D ;P ;D
//;D ;P ;D SNAXXUS CODE;P ;D ;P ;D ;P 
//;P ;D ;P ;D ;P ;D ;P ;D ;P ;D ;P ;D
//;D ;P ;D ;P ;D ;P ;D ;P ;D ;P ;D ;P 
