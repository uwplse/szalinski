$fn=64*1; //make Rounted Edges smoother.

//Enter the size of the board you want to insert.
insertSize=9;

//Make outer wall thicker for added Strength
insertWall=3; //[2:10]

//Enter 0 for no screws, else put diameter of screw hole
screwSize = 4;

//how deep the pieces is
cubeDepth=50;

//how wide the piece is
cubeSize=85;

//Global Values
logoRadius = 5*1;   //Make Customizer not use as control
cornerRadius = 5*1; //Make Customizer not use as control

//Customizer craps out if all vars aren't at the top
cubeCenter = (cubeSize / 2) * -1;

insertCenterA = insertSize / 2;
insertCenterDistance = 2 + logoRadius;
insertCenterB = (cubeSize+2) / 2;

chunkSize = (cubeSize/2) + insertSize;
chunkDist = (insertSize / 2) + insertWall;

screwCenter = cubeSize / 2;
screwCenterHeight = cubeDepth / 2;
screwPos1 = (cornerRadius*2) + chunkDist;
screwPos2 = (cubeSize / 2) - (screwSize) - (screwSize/2);

logoSize = insertSize + (insertWall*2) + (cornerRadius/2);
logoCenter = (logoSize/2) * -1;

union(){
    difference(){
        //.....................................
        //Base shape to chizzle away at.
        translate([cubeCenter,cubeCenter,0]) cube([cubeSize,cubeSize,cubeDepth]);
                
        //.....................................
        //Inserts
        translate([-insertCenterA,-insertCenterB,3])
            cube([insertSize,cubeSize+2,cubeDepth]);
        
        translate([-insertCenterB,-insertCenterA,3])
            cube([cubeSize+2,insertSize,cubeDepth]);

        //.....................................
        //Remove corners chunks        
        //Top-Right
        translate([chunkDist,chunkDist,-1])
            roundedCube(chunkSize,chunkSize,cubeDepth+2,cornerRadius);
        
        //Top-Left
        translate([-(chunkDist+chunkSize),chunkDist,-1])
            roundedCube(chunkSize,chunkSize,cubeDepth+2,cornerRadius);
        
        //Bottom-Right    
        translate([chunkDist,-(chunkDist + chunkSize),-1])
            roundedCube(chunkSize,chunkSize,cubeDepth+2,cornerRadius);
        
        //Bottom-left    
        translate([-(chunkDist+chunkSize),-(chunkDist + chunkSize),-1])
            roundedCube(chunkSize,chunkSize,cubeDepth+2,cornerRadius);
            
        //.....................................
        //Remove corners chunks
        if(screwSize > 0){
            //Top
            translate([-screwCenter,screwPos1,screwCenterHeight]) rotate([0,90,0]) cylinder(cubeSize+10,screwSize,screwSize);
            translate([-screwCenter,screwPos2,screwCenterHeight]) rotate([0,90,0]) cylinder(cubeSize+10,screwSize,screwSize);
            
            //Bottom
            translate([-screwCenter,-screwPos1,screwCenterHeight]) rotate([0,90,0]) cylinder(cubeSize+10,screwSize,screwSize);
            translate([-screwCenter,-screwPos2,screwCenterHeight]) rotate([0,90,0]) cylinder(cubeSize+10,screwSize,screwSize);
            
            //Right
            translate([screwPos1,screwCenter,screwCenterHeight]) rotate([90,0,0]) cylinder(cubeSize+10,screwSize,screwSize);
            translate([screwPos2,screwCenter,screwCenterHeight]) rotate([90,0,0]) cylinder(cubeSize+10,screwSize,screwSize);
            
            //Left
            translate([-screwPos1,screwCenter,screwCenterHeight]) rotate([90,0,0]) cylinder(cubeSize+10,screwSize,screwSize);
            translate([-screwPos2,screwCenter,screwCenterHeight]) rotate([90,0,0]) cylinder(cubeSize+10,screwSize,screwSize);
        }//if
    }//dif

    //.....................................
    //Center Box with Logo
    difference(){
        translate([logoCenter,logoCenter,0])
            cube([logoSize,logoSize,cubeDepth]);
            
        translate([0,0,cubeDepth-3])
            cylinder(4,logoRadius,logoRadius);
    }//dif
    
    
    translate([0,0,cubeDepth-3]) linear_extrude(height=3){
        text(text="m",size=7,halign="center",valign="center");
    }
}//union

module roundedCube(x,y,z,r){
    hull(){
        translate([r,r,0]) cylinder(z,r,r);
        translate([x-r,r,0]) cylinder(z,r,r);
        translate([r,y-r,0]) cylinder(z,r,r);
        translate([x-r,y-r,0]) cylinder(z,r,r);
    }//hull
}//mod