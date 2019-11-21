
/*

Rev 2.2 19/8/15
-Made String_Diameter a variable for customizer, thanks weswitt for suggestion.

Rev 2.1 7/5/15
-Added support for scooter hub


Rev 2.0 6/5/15
-Added support for 5mm hubs with 4 screw holes
-general code clean up.


Rev 1.0  28/3/15
Coded by Siti

Downloaded from http://www.thingiverse.com/thing:744681

**use code as you like but give credit where credit is due!**
*/
Polygon_Count = 128; // [32:low, 64:medium, 128:high, 256:insane]
$fn = Polygon_Count*1;
//Radius of spool between bevelled ends (mm).
spoolR = 15; // [14:100] 
//3, 4 or 6 hole hub
Num_holes = 3;//[6,4,3]
numSides = Polygon_Count;
            
holeR = Num_holes==6 ? 9.5 : (Num_holes==4 ? 6.35:6.2);//PCD changes between mounts
smallHubR = Num_holes==6 ? 6.5 : (Num_holes==4 ? 1:19/2);//no small hub
screwOffset = Num_holes==6 ? 0 : 20;//grub screw holes only for 6 hole

hubOD = Num_holes==6 ? 26.5 : (Num_holes==4 ? 20:22);//OD changes

//Width of spool between bevelled ends (mm). 
spoolW=15;//[2:100] 
numSidesSup = numSides/2;//polygon count of support.
coneW=5*1;//conewidth
edgeW=2*1;//edgewidth
OR = spoolR+coneW;//overall radius
bConeR = min(spoolW,15);
rimW=OR-spoolR;
maxW=edgeW*2+coneW*2+spoolW+2;//total width+2
String_Diameter=2;//diameter of string hole
stringR=String_Diameter/2;//radius of string hole
cutoutH=spoolW;//height of support cutout
supR=3*1;//radius of support cylinders
cubeSide=2*spoolR*((supR+String_Diameter/2)/(spoolR-supR));//side length of cutout cube
Y=sqrt(pow(spoolR-supR,2)-pow(supR+String_Diameter/2,2)); //distance between origin and string hole opening


//cutout for string support
   module cutout()
   { union(){
       // rotate([90,0,0])cylinder(r=d, h=R*2+2);
difference(){
//cylindercutouts
    difference(){
   translate([0,Y+sqrt(pow(cubeSide,2)/2)-String_Diameter/2,0]) rotate([45,0,0])cube([cubeSide,cubeSide,cubeSide],center=true);
        
       translate([0,Y/2,0]) cube([cubeSide+2,Y,cubeSide+2], center=true);
    };//cube cutout
    
    
union(){linear_extrude(height = cutoutH, center = true, convexity = 10 )   
translate([(supR+String_Diameter/2),Y,0])circle (supR,$fn=numSidesSup);
linear_extrude(height = cutoutH, center = true, convexity = 10 ) translate([-(supR+String_Diameter/2),Y,0])circle (supR,$fn=numSidesSup);
}}}}




difference(){
    
    //all solids to keep in this union
union(){    
translate ([0,0,-spoolW/2-coneW/2])cylinder(h=coneW, r1=OR, r2=spoolR, center=true);//bottom cone
translate ([0,0,-spoolW/2-coneW-edgeW/2])cylinder (h=edgeW, r=OR, center = true);//bottom ring
    
  mirror([0,0,1])  translate ([0,0,-spoolW/2-coneW/2])cylinder(h=coneW, r1=OR, r2=spoolR, center=true);//top cone
mirror([0,0,1])  translate ([0,0,-spoolW/2-coneW-edgeW/2])cylinder (h=edgeW, r=OR, center = true);//top ring


difference(){
cylinder (h=spoolW, r=spoolR, center = true); //spool

union(){
rotate([0,0,360/Num_holes/2])cutout();//string support cutout
    rotate([0,0,360/Num_holes/2+180])cutout();//string support cutout
}
}
};


//objects to subtract in this union
union(){
    //insert for hub
        translate([0,0,spoolW/2+coneW+edgeW-5.2])cylinder(6,hubOD/2,hubOD/2, centre =true);
    
    translate ([0,0,spoolW/2+coneW+edgeW-4.6])cylinder(h=10 , r=smallHubR,center=true);//smaller hub
    translate ([0,0,spoolW/2+coneW+edgeW-5+screwOffset])rotate ([0,90,0])cube(size=[4,4,16],center=true);//gap for machine screw
        translate ([0,0,spoolW/2+coneW+edgeW-7+screwOffset])rotate ([0,90,0])cylinder(h=16 , r=2,center=true);//gap for machine screw
        

    
//holes for securing screws
for (i = [0: Num_holes-1]){
    rotate ([0,0,(360/Num_holes)*i])translate ([0,holeR,0])cylinder (h=maxW, r=1.8,$fn=numSidesSup, center = true);//threads
    rotate ([0,0,(360/Num_holes)*i])translate ([0,holeR,spoolW/2+coneW+edgeW-67])cylinder (h=100, r=3.4,center = true);//heads
    rotate ([0,0,(360/Num_holes)*i])translate ([0,holeR,spoolW/2+coneW+edgeW-17+2.99])cylinder (h=6, r1=3.4,r2=0,center = true);//heads cone
    
    
}



//bottom cone 
translate ([0,0,-spoolW/2-coneW+bConeR/2])cylinder(h=bConeR, r1=bConeR, r2=0, center=true);

//bottom ring
translate ([0,0,-spoolW/2-coneW-edgeW/2])cylinder (h=edgeW+0.01, r=bConeR, center = true);


cylinder(h=maxW, r=4,center=true);//centre hole

rotate ([90,0,360/Num_holes/2]) cylinder (OR*2+2, r=stringR,center=true);//hole for string

rotate ([90,0,360/Num_holes/2]) cylinder (10, r=3,center=true);//hole for string nut
};



}



