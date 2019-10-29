/* [Frame] */
frameThickness = 3;
frameWidth = 4;
bridge = 20;
earDistance = 140;

/* [Temples] */
templeWidth=6;
templeThickness=2;
templeLength=100;
//0 is completely straight, 90 points straight down
templeBend=50;

//the fillet will add osme length after
lengthAfterTempleBend=20;
templeBendFillet=20;
templeCornerFillet=1;

/* [Connector Tabs] */
tabThickness = 1.85;
tabWidth = 3.55;
tabSeperation = 1.3;

tabTolerance = 0.5;
ballTolerance = 0.5;
pivotTolerance = 1;
ballDiameter = 3.5;
smallBallDiameter = ballDiameter-2*ballTolerance;
backLength = 5;
//how much of the sphere comes from the tab on the range (0 , 0.5]
ballRatio = .3; 

echo("<b>The inner snap is</b> ",tabThickness*2+tabSeperation,"mm tall.");
ballHidden = ballDiameter*(.5-ballRatio);
ballExposed = ballDiameter*ballRatio;
exposedWidth = 2*sqrt(pow((ballDiameter/2),2)-pow(ballHidden,2));
echo("<b> distance from sphere to edge of tab: </b>", (tabWidth-exposedWidth)/2);

mirror([0,1,0])
translate([-templeLength/2,-(earDistance-bridge)/4-10,0])
temple(width=templeWidth,thickness=templeThickness,length=templeLength,bend=templeBend,lengthAfterBend=lengthAfterTempleBend,bendFillet=templeBendFillet,cornerFillet=templeCornerFillet);
translate([-templeLength/2,-(earDistance-bridge)/4-10,0])
temple(width=6,thickness=2,length=100,bend=50,lengthAfterBend=20,bendFillet=20,cornerFillet=1);
circleFrames(frameThickness,frameWidth,bridge,earDistance);




module circleFrames(frameThickness = 3,frameWidth = 4,bridge = 20,earDistance = 140){
    rotate(a=180,v=[0,0,1]){
    translate([tabWidth/2+earDistance/2-frameWidth,-2*tabThickness-tabTolerance-tabSeperation/2,tabWidth/2+pivotTolerance+backLength])
    rotate(a=270,v=[1,0,0])
    outsidePart();
}
$fn=50;
translate([tabWidth/2+earDistance/2-frameWidth,-2*tabThickness-tabTolerance-tabSeperation/2,tabWidth/2+pivotTolerance+backLength])
    rotate(a=270,v=[1,0,0])
    outsidePart();

outerDiameter = earDistance/2 - bridge/2;
innerDiameter = outerDiameter - 2*frameWidth;
eyeCenter = (earDistance/2 + bridge/2)/2;

translate([-eyeCenter,innerDiameter/2,0])
cube([eyeCenter*2,frameWidth,frameThickness]);

difference(){
    cylinder(d=bridge+2*frameWidth,h=frameThickness);
    translate([0,-bridge/2-frameWidth,0])
    cube([bridge+3*frameWidth,bridge+2*frameWidth,frameThickness*2+2],center=true);
    translate([0,0,-1]){
        cylinder(d=bridge,h=frameThickness+2);
    }
}

translate([eyeCenter,0,0]){
    difference(){
    cylinder(d=outerDiameter,h=frameThickness);
        translate([0,0,-1]){
            cylinder(d=innerDiameter,h=frameThickness+2);
        }
    }
}
translate([-eyeCenter,0,0]){
    difference(){
    cylinder(d=outerDiameter,h=frameThickness);
        translate([0,0,-1]){
            cylinder(d=innerDiameter,h=frameThickness+2);
        }
    }
}
}

module temple(width=6,thickness=2,length=100,bend=50,lengthAfterBend=20,bendFillet=20,cornerFillet=1){
    
    translate([tabWidth/2+frameThickness,(width-2*tabThickness-tabSeperation)/2,tabWidth/2+
pivotTolerance+backLength])
rotate(a=270,v=[1,0,0])
insidePart();
    
    
translate([length,-bendFillet,0]){
difference(){
    difference(){
        cylinder(h=thickness,r=(bendFillet+width));
        translate([0,0,-1]){cylinder(h=thickness+2,r=bendFillet);}
    }
    union(){
        rotate(a=-bend){
            translate([0,-(bendFillet+width),-1]){
                cube([bendFillet+width,2*(bendFillet+width),thickness+2]);
            }
        }
        translate([-(bendFillet+width),-(bendFillet+width),-1]){
            cube([bendFillet+width,2*(bendFillet+width),thickness+2]);
        }
    }
}
translate([-length,bendFillet,0]){    
    roundedBox(length,width,thickness,cornerFillet);
}
rotate(a=-bend,v=[0,0,1]){
    translate([0,bendFillet,0]){
    
    roundedBox(lengthAfterBend,width,thickness,cornerFillet,180);
    }
}
}
}


module roundedBox(x,y,z,radius,rotation=0){
translate([x/2,y/2,0]){
    rotate(rotation){
        translate([-x/2+radius,y/2-radius,0])
        cylinder(h=z,r=radius);
            
        translate([-x/2+radius,-y/2+radius,0])
        cylinder(h=z,r=radius);

        translate([-x/2,-y/2+radius,0])
        cube([radius,y-(2*radius),z]);

        translate([-x/2+radius,-y/2,0])
        cube([x-radius,radius,z]);

        translate([-x/2+radius,y/2-radius,0])
        cube([x-radius,radius,z]);
               

        translate([-x/2+radius,-y/2+radius,0])
        cube([x-radius,y-(2*radius),z]);
        }
    }
}






module maleTab(){
    
    cylinder(h=tabThickness,d=tabWidth);
    translate([-tabWidth/2,0,0])
    cube([
        tabWidth,
        tabWidth/2+pivotTolerance,
        tabThickness]);
    
    
    difference(){
    translate([0,0,tabThickness+.5-ballRatio*smallBallDiameter])
    sphere(d=smallBallDiameter);
        
    translate([-tabWidth/2-1,-tabWidth/2-1,-smallBallDiameter+tabThickness])
    cube([tabWidth+2,tabWidth+2,smallBallDiameter]);
    }
}
module femaleTab(){
    difference(){
    union(){
    cylinder(h=tabThickness,d=tabWidth);
    translate([-tabWidth/2,0,0])
    
    cube([
        tabWidth,
        tabWidth/2+pivotTolerance,
        tabThickness]);
    }
    
    
    
    translate([0,0,tabThickness-.5+ballRatio*ballDiameter])
    sphere(d=ballDiameter);
        
    }
}
module insidePart(){
    translate([0,0,tabThickness]){
        rotate(a=180,v=[0,1,0])
            femaleTab();
        
        
        translate([0,0,tabSeperation])
        femaleTab();
    }
    translate([-tabWidth/2,.5*tabWidth+pivotTolerance,0])
        cube([tabWidth,backLength,2*tabThickness+tabSeperation]);
}

module outsidePart(){
    outerSeperation = 2*(tabThickness+tabTolerance)+tabSeperation;
    maleTab();
    
    translate([0,0,2*tabThickness+outerSeperation])
        rotate(a=180,v=[0,1,0])
            maleTab();
    translate([-tabWidth/2,.5*tabWidth+pivotTolerance,0])
        cube([tabWidth,backLength,2*tabThickness+outerSeperation]);
}
