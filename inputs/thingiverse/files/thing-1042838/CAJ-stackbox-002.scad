// written by Intog
// intogria@gmail.com


////// CUSTOMIZATIONS /////

// (internal) Container Width
cWidth = 40;  

// (internal) Container Height
cHeight = 20; 

// (internal Container Depth
cDepth = 40; 

// Wall Thickness
wThick = 2.25;

// Front Opening Size
frontGap = 1.4;

// Amout of Wiggle Room ( set to 2 for a tight fit)
lipOffset = 2.25;

railHeight = .25;

// Model Size Info ///////////////////////////////

echo("(Z) height:", cHeight*.2+cHeight); 
echo("(Y) Width", cWidth+lipAdj*2-wThick*2);
echo("(X) Depth", cDepth+lipAdj-wThick);

// maths ////////////////////////////////////////

lipAdj = lipOffset*wThick;

railHeightCalc = cHeight*railHeight;

// renders ////////////////////////////////////////

stackBox();

// uncomment below to view stacked...
//translate([0,0,cHeight+wThick]) stackBox();

// modules ////////////////////////////////////////

module container(){
    
 // floor
    translate ([0,0,wThick/2])
   cube  ([cDepth,cWidth,wThick], center = true); 
   
// left wall
    translate([ -cDepth/2,-cWidth/2, 0 ])
       cube  ([ cDepth, wThick, cHeight ]); 
    
// right wall
    translate([ -cDepth/2, cWidth/2-wThick, 0 ])
       cube  ([ cDepth, wThick, cHeight ]); 
    
// back wall
    translate([-cDepth/2, -cWidth/2, 0 ])
       cube  ([ wThick,cWidth, cHeight ]); 
    
// lip
    translate([cDepth/2-wThick, -cWidth/2, 0 ])
       cube  ([ wThick, cWidth, cHeight/frontGap]); 
}

module railConstruct(){
    
    
//left rail
    translate([-cDepth/2-lipAdj+wThick, -cWidth/2-lipAdj+wThick, cHeight])
    railSide();
    
//right rail
     rotate([0,0,180])
    translate([-cDepth/2,-cWidth/2-lipAdj+wThick,cHeight])
    railSide();
    
//backrail
    
    translate([ -cDepth/2-lipAdj+wThick, -cWidth/2-lipAdj+wThick, cHeight])
    railBack();
    
}


module railSide(){
    
//floor
    cube  ([ cDepth+lipAdj-wThick, lipAdj, wThick ]); 
    
//side
  cube  ([ cDepth+lipAdj-wThick,wThick, railHeightCalc ]); 
    
}

module railBack(){
    
//floor
    cube  ([ lipAdj, cWidth+lipAdj, wThick]); 
    
//side
    cube  ([ wThick, cWidth+lipAdj*2-wThick*2, railHeightCalc]); 
    
}


module stackBox(){
    
railConstruct();

container();
    
}