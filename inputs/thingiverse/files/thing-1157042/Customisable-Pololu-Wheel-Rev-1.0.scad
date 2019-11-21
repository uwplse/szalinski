//Revision 1, released 26 NOV 2015
//Coded by siti


//use code as you like but give credit where it's due

Polygon_Count = 128; // [32:low, 64:medium, 128:high, 256:insane]
$fn = Polygon_Count*1;

//Wheel diameter without tread.
Wheel_Diameter = 35; // [25:250] 
wheelR = Wheel_Diameter/2;
//3, 4 or 6 hole hub
Num_holes = 6;//[6,4,3]
numSides = Polygon_Count;
            
holeR = Num_holes==6 ? 9.5 : (Num_holes==4 ? 6.35:6.2);//PCD changes between mounts
smallHubR = Num_holes==6 ? 6.5 : (Num_holes==4 ? 1:19/2);//no small hub
screwOffset = Num_holes==6 ? 0 : 20;//grub screw holes only for 6 hole


hubOD = Num_holes==6 ? 26.5 : (Num_holes==4 ? 20:22);//OD changes

//Overall width of wheel, minus tread
Wheel_Width=20;//[5:100] 
//polygon count of support.
numSidesSup = numSides/2;
coneW=5*1;//conewidth
//edgeW=2*1;//edgewidth
//OR = wheelR+coneW;//overall radius
bConeR = min(Wheel_Width,15);
//rimW=OR-wheelR;
//total width+2
maxW=Wheel_Width*1;//edgeW*2+coneW*2+Wheel_Width+2;
//Height/width of chamfer
chamferWidth = 1;
//Depth of stud
treadDepth = 1;
//Number of studs around circumference
treadNum = 20;
//Overall Diameter of each stud top
treadODTop = 3;
//Overall Diameter of each stud base
treadODBase = 3;
//Rotate each individual stud
treadRotate = 0;
treadNumSides = 4;//Number of sides for each stud
treadRows = 4 ;//Number of stud rows

faceWidth = Wheel_Width-2*chamferWidth;
treadRowSpacing = faceWidth/(treadRows+1);
//Staggers every second row of tread
offsetTreadRing = 1;//[0:No,1:Yes]
offsetRotation = offsetTreadRing*360/treadNum/2;

module tread(angle){// one tread placed at edge of wheel
    
    rotate([treadRotate,0,angle])translate([wheelR,0,0])rotate([0,90,0])cylinder(h=treadDepth*2, r2 = treadODTop/2,r1 = treadODBase/2, center = true, $fn=treadNumSides);  
}

//draw even numbered rings
for(treadOffset = [-faceWidth/2+treadRowSpacing:faceWidth/(treadRows+1)*2:faceWidth/2-treadRowSpacing])


rotate([0,0,(treadOffset/faceWidth-1)/treadRows*treadNum/360])translate([0,0,treadOffset]){
for(treadRadialSpacing = [0:360/treadNum:360])
{tread(treadRadialSpacing);}
};

//draw even numbered rings

for(treadOffset = [-faceWidth/2+treadRowSpacing*2:faceWidth/(treadRows+1)*2:faceWidth/2-0.1])


rotate([0,0,(treadOffset/Wheel_Width-1)/treadRows*treadNum/360])translate([0,0,treadOffset]){
for(treadRadialSpacing = [0:360/treadNum:360])
{tread(treadRadialSpacing+offsetRotation);}
};

difference(){
    
    //all solids to keep in this union
union(){    

    


//wheel base, minus chamfers
cylinder (h=Wheel_Width-chamferWidth*2, r=wheelR, center = true); 
    
    
//top chamfer
translate([0,0,Wheel_Width/2-chamferWidth/2]) cylinder(h=chamferWidth,r1=wheelR,r2 = wheelR-chamferWidth, center = true);

//bottom chamfer
translate([0,0,-Wheel_Width/2+chamferWidth/2]) cylinder(h=chamferWidth,r1=wheelR-chamferWidth,r2 = wheelR, center = true);
};


//objects to subtract in this union
union(){
    //insert for hub
        translate([0,0,Wheel_Width/2-5.2])cylinder(6,hubOD/2,hubOD/2, centre =true);
    
    translate ([0,0,Wheel_Width/2-4.6])cylinder(h=10 , r=smallHubR,center=true);//smaller hub

          translate ([0,0,Wheel_Width/2-5-screwOffset])rotate ([0,90,0])cube(size=[4,4,16],center=true,$fn = 16);//gap for machine screw
        translate ([0,0,Wheel_Width/2-7-screwOffset])rotate ([0,90,0])cylinder(h=16 , r=2,center=true,$fn = 16);//gap for machine screw
        

    
//holes for securing screws
for (i = [0: Num_holes-1]){
    rotate ([0,0,(360/Num_holes)*i])translate ([0,holeR,0])cylinder (h=maxW, r=1.8,$fn=numSidesSup, center = true);//threads
    rotate ([0,0,(360/Num_holes)*i])translate ([0,holeR,Wheel_Width/2-67])cylinder (h=100, r=3.4,center = true);//heads
    rotate ([0,0,(360/Num_holes)*i])translate ([0,holeR,Wheel_Width/2-17+2.99])cylinder (h=6, r1=3.4,r2=0,center = true);//heads cone     
}



//bottom cone 
translate ([0,0,-Wheel_Width/2-coneW+bConeR/2])cylinder(h=bConeR, r1=bConeR, r2=0, center=true);

//bottom ring //does nothing for three holes
//translate ([0,0,-Wheel_Width/2])cylinder (h=edgeW+0.01, r=bConeR, center = true);


cylinder(h=maxW, r=4,center=true);//centre hole



};



}



