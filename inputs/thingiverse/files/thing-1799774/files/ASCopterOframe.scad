// ASCopter_openscad Version 1.1
//O Frame
//Frame size parameters
motorType = 13; // [13:Brushed 8.5, 12:Brushed 8, 18:1306, 20:1104, 23:1806, 27.5:2204, 27.85:2206, 27.9:2213, 28.5:2822]
quadWidth = 65; // [40:200]
bodyDepth = 2; // [2.0:15.0]
mainBodyWidth = 25; // [25:50] 
//Weight Saving parameters
bodyCutOutStyle = 50; //[3:Triangle, 4:Square, 5:Pentagon, 6:Hexagon, 50:circle]
bodyCutOutSize =2.5; // [1.0:10.0] 
mountingPostHoleRadius = 2; //[0.5:2.5] 

// Variables calculated
bodyCutOutPitch = 2.5*bodyCutOutSize; // Pitch of main body weight savingholes
mountRadius=motorType/2;

//armCutOutPitch = 2.5*armCutOutSize;

quadDiameter= sqrt((quadWidth/2*quadWidth/2) + (quadWidth/2*quadWidth/2));

// Check for maximums 
if (mainBodyWidth > (quadWidth/3)) {
    mainBodyWidth=quadWidth/3;
}
//Modules
module brushedMount (spindleRadius, outsideRadius, insideRadius, supportHeight,wireCutOut) {
    linear_extrude(height = supportHeight, center = false, convexity = 10, twist = 0)
    rotate(a=[0,0,-90]) 
    difference() {
         
        circle(outsideRadius , $fn=50);
        circle(insideRadius, $fn=50);  
     
        square([2*wireCutOut,2],center=true);   
        }
} 
module brushlessMount (spindleRadius, holeRadius, fixingRadius, fixingRadius2) {
    linear_extrude(height = bodyDepth, center = false, convexity = 10, twist = 0)
    difference() {
        circle(mountRadius+0.1, $fn=50); 
        //centre hole    
        circle(spindleRadius, $fn=50);
        // mounting holes at the fixing radius    
        translate([fixingRadius,0,0])  
        circle(holeRadius, $fn=50);      
        translate([0,fixingRadius2,0])  
        circle(holeRadius, $fn=50);       
        translate([-fixingRadius,0,0])  
        circle(holeRadius, $fn=50);      
        translate([0,-fixingRadius2,0])  
        circle(holeRadius, $fn=50);         
      }
} 

//Main Body 

translate([0, 0, 0])


    linear_extrude(height = bodyDepth, center = false, convexity = 10, twist = 0) 
    
union(){
    difference(){
          
            circle(quadDiameter+mountRadius/5, $fn=200);
            circle(quadDiameter-mountRadius/5, $fn=200);
         
            //Add motor mount circles join to frame half   
            translate([-quadWidth/2,-quadWidth/2,0])
            circle(mountRadius, $fn=50);   
            translate([-quadWidth/2,quadWidth/2,0])   
            circle(mountRadius, $fn=50);  
            translate([quadWidth/2,quadWidth/2,0])
            circle(mountRadius, $fn=50);   
            translate([quadWidth/2,-quadWidth/2,0])   
            circle(mountRadius, $fn=50);      
    
    } 
    difference(){
            translate([-quadWidth/2,0,0])
            square([mountRadius/3,quadWidth-mountRadius*1.75], center=true);
    }
    
    difference(){
            translate([quadWidth/2,0,0])
            square([mountRadius/3,quadWidth-mountRadius*1.75], center=true);
    }   
    difference(){
            translate([0,0,0])
            square([quadWidth,mainBodyWidth], center=true);
        
        //Mounting holes//left side
            for (x=[-quadWidth/2+2*mountingPostHoleRadius:(quadWidth+2*mountRadius-4*mountingPostHoleRadius)/9:quadWidth+2*mountRadius-2*mountingPostHoleRadius]){
                translate([x,mainBodyWidth/2-mountingPostHoleRadius*1.75,0])
                circle(mountingPostHoleRadius, $fn=20);
        }         
        
       //Mounting holes//right side
            for (x=[-quadWidth/2+2*mountingPostHoleRadius:(quadWidth+2*mountRadius-4*mountingPostHoleRadius)/9:quadWidth+2*mountRadius-2*mountingPostHoleRadius]){
                translate([x,-mainBodyWidth/2+mountingPostHoleRadius*1.75,0])
                circle(mountingPostHoleRadius, $fn=20);
        }    
    
          //Main body weight saving cutouts //left Side
        for (x=[-quadWidth/2+2*mountingPostHoleRadius:bodyCutOutPitch:quadWidth/2-bodyCutOutSize]){
            for (y=[mainBodyWidth/2-4.5*mountingPostHoleRadius:-bodyCutOutPitch:0]) {
                translate([x,y,0])
                circle(bodyCutOutSize, $fn=bodyCutOutStyle);
             }
         }
         //Main body weight saving cutouts //right Side
       for (x=[-quadWidth/2+2*mountingPostHoleRadius:bodyCutOutPitch:quadWidth/2-bodyCutOutSize]){
            for (y=[-mainBodyWidth/2+4.5*mountingPostHoleRadius:bodyCutOutPitch:0]) {
                   translate([x,y,0])             
                circle(bodyCutOutSize, $fn=bodyCutOutStyle);
             }
         } 
    }
    
    
}

//Motor fixings 

for (x=[-quadWidth/2:quadWidth:quadWidth/2]){

    for (y=[-quadWidth/2:quadWidth:quadWidth/2]){
        
        if(motorType==13){    
           linear_extrude(height = bodyDepth, center = false, convexity = 10, twist = 0)    
            translate([x, y, 0])
            difference(){
                circle(mountRadius+0.1, $fn=50);
                circle(mountRadius-3, $fn=50); 
            }   
            translate([x, y, bodyDepth])
            brushedMount(3.5,mountRadius-0.5, 4.5,8,8);
        }    
        if(motorType==12){    
           linear_extrude(height = bodyDepth, center = false, convexity = 10, twist = 0)    
            translate([x, y, 0])
            difference(){
                circle(mountRadius+0.1, $fn=50);
                circle(mountRadius-3, $fn=50); 
            }              
            translate([x, y, bodyDepth])
            brushedMount(3.5,mountRadius, 4.15,8,8);
        }   
    //motor holes for brushless motors
        if(motorType==18){                      
            translate([x, y, 0])
            brushlessMount (2.5,1.2,6,6);
        }        
        if(motorType==20){                 
            translate([x, y, 0])
            brushlessMount (1.2,1.2,4.5,4.5);
        }

        if(motorType==23){                      
            translate([x, y, 0])
            brushlessMount (2.5,1.2,6,8);
        }
        if(motorType==27.5){                      
            translate([x, y, 0])
            brushlessMount (3.5,1.75,8,9.5);
        }
        if(motorType==27.85){                      
            translate([x, y, 0])
            brushlessMount (4,1.3,9.5,9.5);
        }        
       if(motorType==27.9){                      
            translate([x, y, 0])
            brushlessMount (3.5,1.75,8,9.5);
        }   
       if(motorType==28.5){                      
            translate([x, y, 0])
            brushlessMount (3.5,1.65,11,11);
        }
    }
}
