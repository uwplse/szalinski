// THE SNOWFLAKE MACHINE - FOR COOKIES
// mathgrrl snowflakerator

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
// RANDOM SEED

/* [Make a Flake!] */

// USE THIS ONE WITH OPENSCAD
// comment this out if using Customizer
// OpenSCAD chooses a random seed
//random_seed = floor(rands(1,9999999,1)[0]);

// USE THIS ONE WITH CUSTOMIZER
// comment this out if using OpenSCAD
// Click anywhere in the slider to make a flake. If your flake has disconnected pieces or if you'd prefer another design, then click again to make a new one. When you like a flake then save it before it melts away! 
random_seed = 8707098; // [1:1:9999999]

// OR TYPE IN A SEED MANUALLY
// Overrides the slider seed unless set to 0
custom_seed = 0*0; 
// a dozen nice ones
//custom_seed = 8707098; // 1
//custom_seed = 2425545; // 2
//custom_seed = 3830701; // 3
//custom_seed = 5731231; // 4
//custom_seed = 4685353; // 5
//custom_seed = 4598248; // 6
//custom_seed = 4116185; // 7
//custom_seed = 8180448; // 8
//custom_seed = 6088999; // 9
//custom_seed = 0448431; // 10
//custom_seed = 6461073; // 11
//custom_seed = 1832808; // 12

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
// FIXED SETTINGS

// Likelihood of branching
branchy = 8*1;
// Amount of overlapping
full = -1*1;     
// Chance of extra branch spikes
fuzzy = 1*1;   
// Chance of extra plate rings
ringed = 0*1;   
// Tendency for long branches
long = 5*1;       
// Tendency for wide plates
wide = 1*1;       
// Thickness of the branches
fat = 40*1;        
// Pointiness of the corners
sharp = 5*1;      
// Random/natural style (set to 0 for mathematially perfect flakes)
organic = 0*1;
// Number of design steps
steps = 4*1; 
// Thickness of the inset layer
thickness = 1*1; 
// Height of cutter
cutterHeight = 8*1;
// Approximate desired diameter of snowflake cookie cutter
target_diameter = 70*1; 
// Set this to your 3D printer's nozzle width for best performance
nozzle = .4*1;
// set size of flake before the cutter is made
flakeScale = 1*1;

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
// DETERMINED PARAMETERS

// modify fat to be smaller when organic is activated
fatness = max(fat-1.5*organic/7,0);

// branch Diameter
// minimum=nozzle, when fatness=1
// maximum to be nice with target diameter, when fatness=10
bDiam = nozzle+(target_diameter/600)*(fatness-1);
bRad = bDiam/2;

// corner radius
// minimum=0.01, when sharp=10
// maximum=bRad, when sharp=1
cRad = (bRad)*(1/15)*(10-sharp)+0.01;

// branch length bounds
// minimum depending on branch radius
// maximum to get to target diameter
minLen = 5*bRad;
maxLen = nozzle+(target_diameter/13);

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
// RANDOM SEQUENCE PARAMETERS

// generate a sequence of random numbers
// even-index entries determine type
// odd-index entries determine length
// e.g. random[2] determines type of 2nd step
// and random[3] determines length of 2nd step
// use the same list to get organic circle variation
// and to put in extra fuzz and ring variation

// set the random snowflake seed
seed = (custom_seed==0) ? random_seed : custom_seed;

// construct the main random sequence
maxSteps=300*1;
// make a sequence of random numbers with the chosen seed
random = rands(0,10,maxSteps,seed);

// type sequence for choosing branch or plate
// true=branch, false=plate
type = [for(i=[0:steps]) random[2*i]<=branchy];  

// size sequence for size of each step
size = [for(i=[0:steps]) random[2*i+1]];
         
// branch length sequence
bLen = [for(i=[0:steps]) floor((1+long/8)*(maxLen-minLen)*size[i]/10+minLen)];

// plate radius sequence
pRad = [for(i=[0:steps]) floor((.5+wide/10)*(maxLen-minLen)*size[i]/10+minLen)];

// Define the lenghts for each growth step
// Takes into account whether the step is a branch or a plate
// thanks to ricswika, Parkinbot, EvilTeach, samkass, daozenciaoyen, and many more
// for replying to my OpenSCAD forum question about how to generate a list defined recursively
// http://www.thingiverse.com/groups/openscad/topic:3916#comment-732582
function stepLocation(k) = 
    (k==0 ? pRad[0]-(bRad-cRad) 
          : (type[k]==true) ? stepLocation(k-1)+bLen[k]+cRad 
                            : stepLocation(k-1)+2*pRad[k]-2*(bRad-cRad)); 
stepLocation = [for (i=[0:steps]) stepLocation(i)];
// uncomment to visualize the step locations
//for (i=[0:steps]) translate([stepLocation[i],0,0]) cylinder(h=3,r=1,$fn=48);
//echo(stepLocation);

// circle variation sequence
wiggle = [for(i=[0:98]) (organic/7)*nozzle*random[i]/10];
    
// create a string to output the random seed
// thank you laird for showing me how to do this with your code
// from http://www.thingiverse.com/thing:188481
labelString=str(floor(seed/1000000)%10, floor(seed/100000)%10, floor(seed/10000)%10, 
                floor(seed/1000)%10, floor(seed/100)%10, floor(seed/10)%10, floor(seed/1)%10);
    
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
// ECHO

echo(labelString);

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
// RENDERS

// preview[view:south, tilt:top]

// MAKE THE FLAKE!
color("white")
linear_extrude(height=thickness)
difference(){
    offset(r=2) scale(flakeScale) flatFlake();
    offset(r=-.3) scale(flakeScale) flatFlake(); 
}
color("lightgray")
linear_extrude(height=cutterHeight)
difference(){
    offset(r=.45) scale(flakeScale) flatFlake();
    offset(r=-.3) scale(flakeScale) flatFlake(); // total thickness .75
}

// SIZE TESTING
//%circle(target_diameter/2);
//%translate([0,10.825,0]) cylinder(r=.8/2,h=10,$fn=40);

/////////////////////////////////////////////////////
// module for unextruded flake

module flatFlake(){
    color("lightgrey")
    rotate(-1*(wiggle[42]+wiggle[43]+wiggle[44]+wiggle[45]+wiggle[46]+wiggle[47]))
    difference(){
        // the snowflake
        union(){
            // STEP 0: create inner hexagon
            zeroStep();
            // STEP 1: create the first branch/plate step
            firstStep(stepLocation[0]);
            // STEPS 2 and beyond: create the next branch/plate step
            for(k=[2:steps]){
                if(k<=steps){
                    nextStep(k,stepLocation[k-1]);
                }
            }
            // the outer loop, if desired
            //if(loop=="yes"){loopOutside();}
        }
        // the inner loop, if desired
        //if(loop=="yes"){loopInside();}
    }
}

/////////////////////////////////////////////////////
// module for hexagon with given radius and position

module hexagon(xPos,yPos,size){
    //difference(){
        // main hexagon shape
        translate([xPos,yPos])
            hull(){
                for(i=[0:5]){
                    translate([size*cos(60*i),size*sin(60*i)])
                        circle(r=cRad+3*wiggle[i],$fn=24);
                }
            }
}

/////////////////////////////////////////////////////
// module for hexagonal plate with rings

module plate(xPos,yPos,size,ring){
    hexagon(xPos,yPos,size);
    // first-level extra rings
    if(ring+ringed>=9 && size-4*bRad>=6*bRad){
        hexagon(xPos,yPos,size-3.5*bRad);
    }
    // second-level extra rings (less likely)
    if(ring+ringed>=12 && size-7*bRad>=8*bRad){
        hexagon(xPos,yPos,size-7*bRad);
    }
}

/////////////////////////////////////////////////////
// module for branch with given start position, angle, length, and orientation

module branch(xPos,yPos,angle,length,orientation){
    xOff = cos(90+angle)+2*wiggle[70];
    yOff = sin(90+angle)+2*wiggle[71];
    xPush = cos(angle);
    yPush = sin(angle);
    rotation = 
        (orientation=="left")  ?  60+wiggle[52] :
        (orientation=="right") ? -60+wiggle[53] : 
                                  0;
    //linear_extrude(height=thickness)
    translate([xPos,yPos])
    rotate(rotation,[0,0,1])
        hull(){
            // one side of base
            translate((bRad-cRad)*[xOff,yOff]) 
                circle(r=cRad+wiggle[12],$fn=24);
            // other side of base
            translate(-(bRad-cRad)*[xOff,yOff]) 
                circle(r=cRad+2*wiggle[13],$fn=24);
            // one side of arrow
            translate((bRad-cRad)*[xOff,yOff]+length*[xPush,yPush]) 
                circle(r=cRad+wiggle[14],$fn=24);
            // other side of arrow
            translate(-(bRad-cRad)*[xOff,yOff]+length*[xPush,yPush]) 
                circle(r=cRad+wiggle[15],$fn=24);
            // center tip of arrow
            if(orientation=="center"){
                translate((length+1*(1/sqrt(3))*(bRad-cRad))
                          *[xPush+.5*wiggle[19],yPush+.5*wiggle[21]]) 
                    circle(r=cRad+wiggle[16],$fn=24);
            }
            if(orientation=="left"){
                translate(-(bRad-cRad)*[xOff,yOff]
                          +(length+2*(1/sqrt(3))*(bRad-cRad))
                          *[xPush+.5*wiggle[51],yPush]) 
                    circle(r=cRad,$fn=24);  
            }
            if(orientation=="right"){
                translate((bRad-cRad)*[xOff,yOff]
                          +(length+2*(1/sqrt(3))*(bRad-cRad))
                          *[xPush+.5*wiggle[58],yPush]) 
                    circle(r=cRad,$fn=24);  
            }
        }   
}

/////////////////////////////////////////////////////
// module for triple of branches

module tripleBranch(xPos,yPos,angle,length,fuzz){
    branch(xPos,yPos,angle,length+2*wiggle[80],orientation="left");
    branch(xPos,yPos,angle,length,orientation="center");
    branch(xPos,yPos,angle,length-wiggle[82],orientation="right");
    // first-level extra fuzz
    if(fuzz+fuzzy>=9 && 2*length/3>=5*bRad){
        branch( xPos+cos(angle)*length/3,yPos+sin(angle)*length/3,angle,
                2*length/3-wiggle[44],orientation="left");    
        branch( xPos+cos(angle)*length/3,yPos+sin(angle)*length/3,angle,
                2*length/3+2*wiggle[45],orientation="right");
    }
    // second-level extra fuzz (less likely)
    if(fuzz+fuzzy>=12 && length/3>=5*bRad){
        branch( xPos+cos(angle)*2*length/3,yPos+sin(angle)*2*length/3,angle,
                length/3+2*wiggle[46],orientation="left");    
        branch( xPos+cos(angle)*2*length/3,yPos+sin(angle)*2*length/3,angle,
                length/3-wiggle[47],orientation="right");
    }
}

/////////////////////////////////////////////////////
// module for k=0 inner hexagon step

module zeroStep(){
    plate(xPos=0,yPos=0,size=pRad[0],ring=random[71]);
}

/////////////////////////////////////////////////////
// module for k=1 branch/plate step

module firstStep(startLength){
    // IF FIRST STEP = BRANCH
    if(type[1]==true){
        circle(pRad[0]+1.3);
        for(i=[0:5]){
            rotate(60*i+10*wiggle[42+i],[0,0,1])
                tripleBranch(xPos=pRad[0]-bRad+cRad,yPos=0,angle=0,
                             length=bLen[1],fuzz=random[87]); 
        }  
    }
    // IF FIRST STEP = PLATE
    else{
        circle(pRad[0]+1.3);
        for(i=[0:5]){
            rotate(60*i+10*wiggle[42+i],[0,0,1])
                plate(xPos=startLength+pRad[1]-(bRad-cRad),yPos=0,size=pRad[1],ring=random[72]); 
        }
    }   
}

/////////////////////////////////////////////////////
// module for k>=2 branch/plate steps

module nextStep(k,startLength){
    // IF TYPE = BRANCH
    if(type[k]==true){
        for(i=[0:5]){
            rotate(60*i+10*wiggle[42+i],[0,0,1])
            union(){ 
                // center triple 
                tripleBranch(xPos=startLength,yPos=0,angle=0,
                             length=bLen[k],fuzz=random[3*k]);
                // IF PREVIOUS TYPE = BRANCH 
                if(type[k-1]==true && bLen[k]<=bLen[k-1]*sqrt(2-1)*full/3){
                    // left triple
                    translate(-(bLen[k-1]+cRad)*[cos(-60),sin(-60)])
                        tripleBranch(xPos=startLength,yPos=0,angle=60,
                                     length=bLen[k],fuzz=random[3*k]); 
                    // right triple
                    translate(-(bLen[k-1]+cRad)*[cos(60),sin(60)])
                        tripleBranch(xPos=startLength,yPos=0,angle=-60,
                                     length=bLen[k],fuzz=random[3*k]);
                }
                // IF PREVIOUS TYPE = PLATE
                if(type[k-1]==false && bLen[k]<=2*pRad[k-1]*sqrt(2-1)*full/3){
                    // left triple
                    translate(-(pRad[k-1]-(bRad-cRad))*[cos(60),sin(60)])
                        tripleBranch(xPos=startLength,yPos=0,angle=-60,
                                     length=bLen[k],fuzz=random[3*k]);
                    // right triple
                    translate(-(pRad[k-1]-(bRad-cRad))*[cos(-60),sin(-60)])
                        tripleBranch(xPos=startLength,yPos=0,angle=60,
                                     length=bLen[k],fuzz=random[3*k]);
                }
            }
        }          
    }
    // IF TYPE = PLATE
    else{
        for(i=[0:5]){
            rotate(60*i+10*wiggle[42+i],[0,0,1])
            union(){
                // center hex
                plate(xPos=startLength+pRad[k]-(bRad-cRad),yPos=0,
                      size=pRad[k],ring=random[4*k]); 
                // IF PREVIOUS TYPE = BRANCH
                if(type[k-1]==true && pRad[k]<=bLen[k-1]*sqrt(2-1)*full/6){
                    // left hex
                    translate(-(bLen[k-1]+pRad[k]-(bRad-2*cRad))*[cos(60),sin(60)])
                        plate(xPos=startLength+pRad[k]-(bRad-cRad),yPos=0,
                              size=pRad[k],ring=random[4*k]);
                    // right hex
                    translate(-(bLen[k-1]+pRad[k]-(bRad-2*cRad))*[cos(-60),sin(-60)])
                        plate(xPos=startLength+pRad[k]-(bRad-cRad),yPos=0,
                              size=pRad[k],ring=random[4*k]);
                }
                // IF PREVIOUS TYPE = PLATE
                if(type[k-1]==false && pRad[k]<=pRad[k-1]*sqrt(2-1)*full/3){
                    // left hex
                    translate(-(pRad[k-1]+pRad[k]-2*(bRad-cRad))*[cos(-60),sin(-60)])
                        plate(xPos=startLength+pRad[k]-(bRad-cRad),yPos=0,
                              size=pRad[k],ring=random[4*k]);
                    // right hex
                    translate(-(pRad[k-1]+pRad[k]-2*(bRad-cRad))*[cos(60),sin(60)])
                        plate(xPos=startLength+pRad[k]-(bRad-cRad),yPos=0,
                              size=pRad[k],ring=random[4*k]);
                }
            }
        }
    }
}
