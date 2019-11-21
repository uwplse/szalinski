use <fillets2d.scad>;
use <fillets3d.scad>;

length = 124;
stepWidth=31;
stepHeight=25;
thickness=4;
edgeHeight=8;

steps = 4;
game = 1;

slotGame =  0.4;
slotHoleWidth = 3;
slotHoleLength = 4;

slotPinHeight = 3;
slotHoleHeight = slotPinHeight + 0.5;

// Constraints: 
// stepWidth > 0
// Thickness > 2
// edgeHeight>=0
// stepHeight>=0
// steps >= 3?
// game >=0, <2
// PSLenght >=0
// slotGame >=0; <slotHoleWidth; <slotHoleLength
// slotHoleWidth  < Thickness         //should be fixed to the size...
// slotHoleHeight < Thickness
// slotHoleHeight < thickness + length
// slotPinHeight  < slotHoleHeight

// Derivated variables
slotPinLength = slotHoleLength - slotGame;
slotPinWidth  = slotHoleWidth - slotGame; 
holeRadius = 0.4*stepWidth;
upFront = thickness + edgeHeight;

module oneStep(x,y,z){
translate(x,y,z){  
cube([thickness, upFront, length]);
translate([thickness, 0, 0]){
    cube([stepWidth, thickness, length]);
    translate([stepWidth, 0, 0]){
        cube([thickness, stepHeight, length]);        
    }
}
}
}

module oneSide(x,y,z){
translate(x,y,z){  
cube([2*thickness+stepWidth, upFront, thickness]);
}
}


module drawerSide(){
        

        // Series of standard ones
        for(i = [1:steps-2]){
        translate([i*(thickness + stepWidth)+thickness+game, 0, 0]){
            cube([stepWidth + thickness, i*stepHeight-game, thickness]);
        }
        }

        // last drawer side piece
        translate([(steps-1)*(thickness + stepWidth)+thickness+game, 0, 0]){
            cube([stepWidth -2*game, (steps-1)*stepHeight-game, thickness]);
        }
    }

module drawerWalls(){
    // front drawer wall
    translate([stepWidth + 2*thickness + game, 0, 0]){
            cube([thickness, stepHeight-game, length - thickness - game]);
        }

    // Separators
    for(i = [1:steps-1]){
        translate([i*(stepWidth+thickness) +game, 0, 0]){
        cube([thickness, (i-1)*stepHeight-game, length - thickness - game]);
    }
    }
    // last drawer wall
        translate([steps*(stepWidth+thickness) - game - thickness, 0, 0]){
        cube([thickness, (steps-1)*stepHeight-game, length - thickness - game]);
    }
    }

module drawerBottom(){
    
    translate([stepWidth + 2*thickness + game, 0, 0]){
            cube([(steps-1)*(stepWidth+thickness) - 2*thickness, thickness, length - thickness - game]);
        }
    }

module makeStandMiddle(){
        for(i = [0:steps-1]){
        translate(i*[stepWidth+thickness, stepHeight, 0]){
            oneStep([0,0,0]);
            oneSide([0,0,0]);
            translate([0,0,length - thickness]) oneSide([0,0,0]);
        }
        }
    } 

module makeStandMiddleOnly(){
        for(i = [0:steps-1]){
        translate(i*[stepWidth+thickness, stepHeight, 0]){
            oneStep([0,0,0]);
        }
        }
    } 
module makeStandBoarder(){
    for(i = [0:steps-1]){
        translate([i*(stepWidth+thickness), i*stepHeight, 0]){
            oneSide([0,0,0]);
        }
    }
}

module makeBackSupport(){
    translate(steps*[stepWidth+thickness, 0, 0]){
        cube([thickness, stepHeight*steps-1, length]);
    }
    }
    

module makeStandBoarderRight(){
     for(i = [0:steps-1]){       
        translate([i*(stepWidth+thickness), 0*stepHeight, length-thickness]){
                //oneSide([0,0,0]);
            
                cube([2*thickness+stepWidth, i*stepHeight, thickness]);
            }

        
    }
    
}

module makeHole(){
    sth = ceil(steps/2);
    toMoveX = sth*(stepWidth+thickness)+thickness + game + 1/2*stepWidth;
    toMoveY = (sth)*(stepHeight) - game;
    
    translate([toMoveX,toMoveY, 0]){cylinder(h=thickness*2, r1=holeRadius, r2 = holeRadius, center=true);}
    
}

module addpins(slotPinWidth_in, slotPinLength_in, slotPinHeight_in){
    for(i = [0:steps-1]){
    translate([i*(thickness + stepWidth) + thickness + stepWidth/2,i*stepHeight + thickness/2,0]){
        translate([-slotPinLength_in/2,-slotPinWidth_in/2,0]){
        cube([slotPinLength_in, slotPinWidth_in, slotPinHeight_in]);}
        }
    
    
    translate([steps*(thickness + stepWidth) + thickness/2,(i)*stepHeight + stepHeight/2, 0]){
            translate([-slotPinWidth_in/2,-slotPinLength_in/2,0]){
                cube([slotPinWidth_in, slotPinLength_in, slotPinHeight_in]);
               }
          }  
        }
}

module normalPS(){
union(){

// stand
makeStandMiddle();
        
// Right boarder
makeStandBoarderRight();

// Back support
makeBackSupport();
    

    
}
// Drawer
difference(){
union(){
drawerSide();
drawerWalls();
drawerBottom();
translate([0,0,length-2*thickness-game]){drawerSide();}
}
makeHole();
}
}

module ExtensiblePS_Left(){
    union(){
// stand
makeStandMiddleOnly();
        
// Right boarder
makeStandBoarder();
// Back support
makeBackSupport();
// add pins
translate([0,0,length]){
    topFillet(slotPinHeight, 1, stepsPerFillet, enableFillets) addpins(slotPinWidth - slotGame, slotPinLength- slotGame, slotPinHeight);    
}
}
}

module ExtensiblePS_Right(){
    difference(){
    union(){
        // stand
        makeStandMiddleOnly();

        // Left boarder            
        translate([0,0,length - thickness]) makeStandBoarder();
        
        // Back support
        makeBackSupport();   
       
        // Right boarder
        makeStandBoarderRight();   
    }

     // Add pin from the other side
    addpins(slotPinWidth, slotPinLength, slotPinHeight);
    }
}
   
// Make Standard
normalPS();


// Make expandable Left
//ExtensiblePS_Left();

// Make expandable Right
//ExtensiblePS_Right();

// Make expandable Center


            




        