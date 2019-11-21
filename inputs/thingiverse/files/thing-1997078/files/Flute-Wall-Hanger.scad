/* Flute Wall Hanger
Inner Bore of flute 18.25mm
give a 19mm berth
30mm engagement height
45 degree gusset
rounded lead in
*/
/////////////////////////////////////////
fluteInnerBore = 18.25;
fluteEngagementHeight = 30;
flutePlatenDiameter = 23;
fluteInstallWiggleRoom = 19;
screwHeadDiameterMax = 8.7;
screwHeadDiameterRoot = 3.8;
screwHeadTaperHeight = 3.85;
screwThreadWidth = 4.8;
gussetWidth = fluteInstallWiggleRoom+flutePlatenDiameter/2+flutePlatenDiameter/2;
gussetThickness = 10;
wallPlateShaftHeight = fluteEngagementHeight+gussetWidth+fluteInnerBore/2+screwHeadDiameterMax*2;
/////////////////////////////////////////
wallPlate();
gusset();
fluteEngagement();
/////////////////////////////////////////
module wallPlate(){
    translate([gussetWidth*.95,0,-gussetWidth-screwHeadDiameterMax]){
        wallPlateShaft();  
    }
}
module wallPlateShaft(){
    difference(){
        union(){
            cylinder(d=flutePlatenDiameter,h=wallPlateShaftHeight,$fn=100);
            sphere(d=flutePlatenDiameter,center=true,$fn=100);
            translate([0,0,wallPlateShaftHeight]){
                sphere(d=flutePlatenDiameter,center=true,$fn=100);
            }
        }   
        wallModel();
        screwHoleLower();
        screwHoleUpper();
    }
}
module wallModel(){
translate([flutePlatenDiameter/2,0,wallPlateShaftHeight/2]){
        cube([flutePlatenDiameter,flutePlatenDiameter,wallPlateShaftHeight+flutePlatenDiameter],center=true);
    }
}
module screwHoleLower(){
    translate([-flutePlatenDiameter/2+2,0,screwHeadDiameterMax/2]){
        rotate([0,90,0]){
            screwHole();
        }
    }
}
module screwHoleUpper(){
    translate([-flutePlatenDiameter/2+2,0,wallPlateShaftHeight-screwHeadDiameterMax/2]){
        rotate([0,90,0]){
            screwHole();
        }
    }
}
module screwHole(){
        cylinder(d1 = screwHeadDiameterMax, d2 = screwHeadDiameterRoot,h = screwHeadTaperHeight,$fn = 100);
    cylinder(d=screwThreadWidth,100,$fn = 100);
    translate([0,0,-100]){
        cylinder(d=screwHeadDiameterMax,100,$fn=100);
    }    
}
/////////////////////////////////////////
module gusset(){
    difference(){
    gussetPrimal();
    uglyAngleCutoff();
    angleCutoff();
    }
}    
module uglyAngleCutoff(){
        translate([-gussetWidth/2-flutePlatenDiameter/2+(flutePlatenDiameter-fluteInnerBore)/2,0,-gussetWidth/2]){
          cube([gussetWidth,gussetThickness,gussetWidth],center=true);
            } 
}
module gussetPrimal(){
    translate([gussetWidth/2-flutePlatenDiameter/2,0,-gussetWidth/2]){
cube([gussetWidth,gussetThickness,gussetWidth],center=true);
    }
}
module angleCutoff(){
    translate([gussetWidth/2-flutePlatenDiameter/2,0,-gussetWidth/2]){      
        rotate([0,135,0]){
            translate([gussetWidth,0,0]){
                cube([gussetWidth*2,gussetThickness*2,gussetWidth*2],center=true);
            }
        }    
    }
}
/////////////////////////////////////////
module fluteEngagement(){
flutePlaten();
fluteShaft();
}
module flutePlaten(){
    difference(){
 sphere(d=flutePlatenDiameter,$fn=100);
        cylinder(d=flutePlatenDiameter*2,h=flutePlatenDiameter);
    }
}
module fluteShaft(){
 cylinder(d = fluteInnerBore,h = fluteEngagementHeight,$fn=100);
    translate([0,0,fluteEngagementHeight]){
    sphere(d=fluteInnerBore, $fn=100);
    }
}