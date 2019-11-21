//BuildPlate.scad
//by Alain Martel 3DFabXYZ.com

//cube([width,depth,height], center)
            //      200x200    200x300    300x300
            //240, 219 (209), 219 (209), 327 (320)      
//240:Custom, 219:Standard 200X, 280:Standard 300X, 327:Long 300X                       
BuildPlatform_X = 240; // [214:1:350]
//340:Custom, 219:Standard 200X, 280:Standard 300X, 327:Long 300X
BuildPlatform_Y = 340; // [214:1:350]
//Thickness of platorm. Default 3mm
BuildPlatform_Z = 5;   // [2.5:0.25:10]
ScrewHole = 3.40*1;
ScrewTapperDia = 6.72*1;
ScrewTapperHeight = 3.3631*1;
ScrewTapperOffset = BuildPlatform_Z-(ScrewTapperHeight-.05);
SmBldPlateDisC = 209*1;
LgBldPlateDisC = 309*1;
//Radius of corners
EdgeRadius = 5; // [0:0.1:10]
//Holes for standard build plate. 209mm X 209mm
SmallCarriage = "yes"; // [yes,no]
//Holes for large build plate. 209mm X 309mm
LargeCarriage = "no"; // [yes,no]
//Holes
RightCenter = "no"; // [yes,no]
//Holes
LeftCenter = "no"; // [yes,no]
//Holes
FrontCenter = "no"; // [yes,no]
//Holes
BackCenter = "no"; // [yes,no]
//Smoothness of rounded elements.
$fn = 64;

module screwhole(){
    union(){        // combine 1st and 2nd children
        cylinder(r=ScrewHole,h=BuildPlatform_Z*2, center = true);
        cylinder(r1=0,r2=ScrewTapperDia,h=ScrewTapperHeight, center = false);
    }    
}

module roundededges(){
    translate([(BuildPlatform_X/2),(BuildPlatform_Y/2),(BuildPlatform_Z/2)])
    union(){
        cube([BuildPlatform_X-(EdgeRadius*2),BuildPlatform_Y,BuildPlatform_Z], center = true);
        cube([BuildPlatform_X,BuildPlatform_Y-(EdgeRadius*2),BuildPlatform_Z], center = true);
        translate([((BuildPlatform_X/2)-EdgeRadius),((BuildPlatform_Y/2)-EdgeRadius),0])
            cylinder(r=EdgeRadius,h=BuildPlatform_Z, center = true);
        translate([-((BuildPlatform_X/2)-EdgeRadius),((BuildPlatform_Y/2)-EdgeRadius),0]) 
            cylinder(r=EdgeRadius,h=BuildPlatform_Z, center = true);
        translate([((BuildPlatform_X/2)-EdgeRadius),-((BuildPlatform_Y/2)-EdgeRadius),0]) 
            cylinder(r=EdgeRadius,h=BuildPlatform_Z, center = true);
        translate([-((BuildPlatform_X/2)-EdgeRadius),-((BuildPlatform_Y/2)-EdgeRadius),0]) 
            cylinder(r=EdgeRadius,h=BuildPlatform_Z, center = true);
    }   
}

difference(){
    roundededges();
    union(){            
         translate([BuildPlatform_X/2,BuildPlatform_Y/2,0]){
            //translate([0,0,ScrewTapperOffset])screwhole();     //Center
            if (FrontCenter == "yes"){ //Lower Center
                translate([SmBldPlateDisC/2,0,ScrewTapperOffset]) 
                    screwhole(); 
            }
            if (BackCenter == "yes"){ //Upper Center
                translate([-SmBldPlateDisC/2,0,ScrewTapperOffset]) 
                    screwhole();            
            }
            if (SmallCarriage == "yes"){ 
                translate([SmBldPlateDisC/2,SmBldPlateDisC/2,ScrewTapperOffset]) 
                    screwhole();     //Sm Lower Right
                if (RightCenter == "yes"){ 
                    translate([0,SmBldPlateDisC/2,ScrewTapperOffset]) 
                        screwhole(); //Sm Right Center            
                }
                translate([-SmBldPlateDisC/2,SmBldPlateDisC/2,ScrewTapperOffset]) 
                    screwhole();     //Sm Upper Right
                translate([SmBldPlateDisC/2,-SmBldPlateDisC/2,ScrewTapperOffset]) 
                    screwhole();     //Sm Lower Left
                if (LeftCenter == "yes"){
                translate([0,-SmBldPlateDisC/2,ScrewTapperOffset]) 
                    screwhole();     //Left Center
                }
                translate([-SmBldPlateDisC/2,-SmBldPlateDisC/2,ScrewTapperOffset]) 
                    screwhole();     //Sm Upper Left
            }
            if (LargeCarriage == "yes"){
                translate([SmBldPlateDisC/2,LgBldPlateDisC/2,ScrewTapperOffset]) 
                    screwhole();     //Lg Lower Right
                if (RightCenter == "yes"){
                    translate([0,LgBldPlateDisC/2,ScrewTapperOffset]) 
                        screwhole(); //Lg Right Center
                }
                translate([-SmBldPlateDisC/2,LgBldPlateDisC/2,ScrewTapperOffset]) 
                    screwhole();     //Lg Upper Right
                translate([SmBldPlateDisC/2,-LgBldPlateDisC/2,ScrewTapperOffset]) 
                    screwhole();     //Lg Lower Left
                if (LeftCenter == "yes"){
                    translate([0,-LgBldPlateDisC/2,ScrewTapperOffset]) 
                        screwhole(); //Lg Left Center
                }
                translate([-SmBldPlateDisC/2,-LgBldPlateDisC/2,ScrewTapperOffset]) 
                    screwhole();     //Lg Upper Left
            }
        }
    }
}