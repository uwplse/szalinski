//number of fragments
$fn=50;

tabThickness = 1.85;
tabWidth = 3.55;
//Gap between tabs on the inside snap
tabSeperation = 1.3;
//Moves the tabs on the outside part, to allow more room for inside part
tabTolerance = 0.2;

//extends the tabs so that they have room to rotate
pivotTolerance = 1;
//diameter of the ball that is used to make an indent on the inside part
directDiameter = 3;
//use this instead of ball diameter to control indent width
indentWidth = 2.93939;
//Choose to use either directDiameter or indentWidth
diameterOrWidth = 0;//	[0:Use ball diameter, 1:Use indent width]
//difference in radius between bump and indent
ballTolerance = 0.3;
//extends the block that the tabs are connected to
backLength = 5;


//how much of the ball comes from the tab on the range (0 , 0.5]
ballRatio = .4; 





//reverse testing equation for diameter from width
divisor = 4*(.25-pow(.5-ballRatio,2));
dSquared = pow(exposedWidth,2)/divisor;
D = sqrt(dSquared);
echo("D: ", D);


    divisor = 4*(.25-pow(.5-ballRatio,2));
    dSquared = pow(indentWidth,2)/divisor;
    ballDiameter = sqrt(dSquared)*diameterOrWidth+directDiameter*(1-diameterOrWidth);//this works like an if statement
    echo("ballDiameter: ", ballDiameter);

echo("<b>The inner snap is</b> ",tabThickness*2+tabSeperation,"mm tall.");
smallBallDiameter = ballDiameter-2*ballTolerance;
ballHidden = ballDiameter*(.5-ballRatio);
ballExposed = ballDiameter*ballRatio;
exposedWidth = 2*sqrt(pow((ballDiameter/2),2)-pow(ballHidden,2));
echo("<b> distance from sphere to edge of tab: </b>", (tabWidth-exposedWidth)/2);
echo("exposed width: ",exposedWidth);


translate([-2*tabThickness-tabSeperation-2,0,0])
rotate(a=90,v=[0,1,0])
insidePart();

rotate(a=90,v=[0,1,0])
outsidePart();



module maleTab(){
    
    cylinder(h=tabThickness,d=tabWidth);
    translate([-tabWidth/2,0,0])
    cube([
        tabWidth,
        tabWidth/2+pivotTolerance,
        tabThickness]);
    
    
    difference(){
    translate([0,0,tabThickness+(ballRatio-.5)*smallBallDiameter])
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
    
    
    
    translate([0,0,tabThickness-(ballRatio-.5)*ballDiameter])
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


