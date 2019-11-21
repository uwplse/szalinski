/* [Different Grids] */
//choose the node type to make the grid from
Nodes_To_Use = "tri";//["tri":"All Three modules","smooth":"Only round tops","nubs":"Only the round ones with nubs","ridge":"Only the ridge nodes","dual":"the rough nubs and the ridged node grid"]

//How many do you want across?
Nodes_across = 2;//[1:100]

//How many do you want deep?
Nodes_deep = 2;//[1:100]

/* [Module Spacing] */
//This is how much space between all the modules
spacing = 16; //[16:100]

/* [Module Size] */
//this is the size of each of the middle parts
baseSize = 5;//[5:50]

/* [Arm connector variables] */
//this is the Arm Width 
loopWidth = 5;//[5:100]
//this is the Arm Height
loopHeigh = 4;//[4:10]


wallThickness = .88; // the thickness of the loop wall, smaller is bigger
// the space needed between all the modules so they fit together
offset = (spacing/2)-loopWidth + 1.55;//spacing between the loops
//wallThickness and the 1.5 are related but i did not want to mess with it


//make the bottom cover the loop
function baseFloor(x=4) = (x+1.5)*-1;

/************
section top surfaces
******************************/

// replacing the cylinders on the round top 
module nubs(){
    hull(){
        sphere(1);
        translate([0,0,baseSize])sphere(1);
    }
}

//basic sphere top
module topRound(){
    difference(){
        sphere(baseSize,true);
        translate([0,0,-baseSize])cube(baseSize*2,true);
    }
}


//basic sphere top with ridges
module topRidges(){
    difference(){
        union(){
            sphere(baseSize,true);
            for(t=[-3:8]){
            rotate([0,t*20,0])
                    minkowski(){
                        cylinder(.05,baseSize,baseSize,true);
                        sphere(.5);
                    }
            }
        }
        translate([0,0,-baseSize])cube([baseSize*2.1,baseSize*2.1,baseSize*2],true);
    }
}

// sphere with round nubins on it for more surface areal to scrub
module topNubs(){
    difference(){
       union(){ 
            sphere(baseSize,true);
            for(i=[-2:2],y=[-2:2]){
                rotate([y*25,i*25,0])nubs();
                }
            }
       translate([0,0,-baseSize])cube(baseSize*2,true);
   }
}

/*****************************
section connection loops
******************************/

// the arm that loops together to form the modular nature of the peices
module loop (loopWidth,loopHeigh,wallThickness){
    cutout = loopWidth*wallThickness;
    
    difference(){
     minkowski(){  
            hull(){
                translate([-offset,0,0])cylinder(loopHeigh,loopWidth,loopWidth,true);
                translate([offset,0,0])cylinder(loopHeigh,loopWidth,loopWidth,true);
            }
            sphere(.5);
        }
        hull(){
            translate([-offset,0,0])cylinder(loopHeigh+1,cutout,cutout,true);
            translate([offset,0,0])cylinder(loopHeigh+1,cutout,cutout,true);
            }
    }
}

// another verion of hte above utalising the minkowski funciton to make the connecing arms a bit more round
module min_loop (loopWidth,loopHeigh,wallThickness){
    cutout = loopWidth*wallThickness;
    offset = 3;
    difference(){
     minkowski(){  
            hull(){
                translate([-offset,0,0])cylinder(loopHeigh,loopWidth,loopWidth,true);
                translate([offset,0,0])cylinder(loopHeigh,loopWidth,loopWidth,true);
            }
        sphere(.2);
        }
        hull(){
            translate([-offset,0,0])cylinder(loopHeigh+1,cutout,cutout,true);
            translate([offset,0,0])cylinder(loopHeigh+1,cutout,cutout,true);
            }
        
    }
}

/*****************************
section connection loops and bases
******************************/

// loops together with the round top 
module smoothBase(){
    hull(){
        translate([0,0,3.65]) topRound();
        translate([0,0,baseFloor(loopHeigh)]) cylinder(1,baseSize,true);
    }
    rotate([135,0,0])loop(loopWidth,loopHeigh,wallThickness);
    rotate([-45,0,90])loop(loopWidth,loopHeigh,wallThickness);
}
//smoothBase();

// loops together with the rough top 
module roughBase(){
    translate([0,0,3.65]) topNubs();
    translate([0,0,baseFloor(loopHeigh)]) cylinder(9.2,baseSize,baseSize);
    rotate([135,0,0])loop(loopWidth,loopHeigh,wallThickness);
    rotate([-45,0,90])loop(loopWidth,loopHeigh,wallThickness);
}
//roughBase();

// loops together with the ridge top 
module ridgeBase(){
    translate([0,0,3.65])topRidges();
    translate([0,0,baseFloor(loopHeigh)]) cylinder(9.2,baseSize,baseSize);
    rotate([135,0,0])loop(loopWidth,loopHeigh,wallThickness);
    rotate([-45,0,90])loop(loopWidth,loopHeigh,wallThickness);
}

//ridgeBase();

// experiment that works but is super cpu intensive
module min_base(){
 minkowski(){  
        hull(){
            translate([0,0,3]) topRound();
            translate([0,0,-4]) cylinder(1,5,true);
        }
        sphere(1.35);
    }
    rotate([135,0,0])loop(loopWidth,loopHeigh,wallThickness);
    rotate([-45,0,90])loop(loopWidth,loopHeigh,wallThickness);
}

/*****************************
section grid implementation of the different modules 
******************************/

// funciton that utalises all the different tops with a modulus switch 
module spoongeGridTri(xnum, ynum){
    for(y = [0:ynum-1],x= [0:xnum-1]){
        flip = ((x+y)%2)?180:0;
            chooseTop(flip,x,y);   
    }
}
// utility (switch) function for the trigrid
module chooseTop(flip,x,y){
    if((x+y)%3==1){
         translate([spacing*x,spacing*y,0])rotate([0,0,flip])ridgeBase();
    }else if ((x+y)%2){ 
         translate([spacing*x,spacing*y,0])rotate([0,0,flip])roughBase();
    }else{
         translate([spacing*x,spacing*y,0])rotate([0,0,flip])smoothBase();
        }
}

// this is the binding function that creates the interlocking grid 
// aka every other one need to be turned 180 degrees to join
module spoongeGrid(xnum, ynum){
    for(i = [0:ynum-1],t= [0:xnum-1]){
        if((i+t)%2){
                translate([spacing*t,spacing*i,0])rotate([0,0,0])ridgeBase();
            }else{
                translate([spacing*t,spacing*i,0])rotate([0,0,180])roughBase();
            }
    }
}


// modulus is fun and usefull :)
// if you are wondering this if statement means 
// (if) the remainer of (x+y)/2 = 0 do this
module spoongeGridRough(xnum, ynum){
    for(i = [0:ynum-1],t= [0:xnum-1]){
        flip = ((i+t)%2)?180:0;
        translate([spacing*t,spacing*i,0])rotate([0,0,flip])roughBase();
    }
}

//only the smooth tops
module spoongeGridSmooth(xnum, ynum){
    for(i = [0:ynum-1],t= [0:xnum-1]){
        flip = ((i+t)%2)?180:0;
        translate([spacing*t,spacing*i,0])rotate([0,0,flip])smoothBase();
    }
}

//only the ridge tops
module spoongeGridRidge(xnum, ynum){
    for(i = [0:ynum-1],t= [0:xnum-1]){
        flip = ((i+t)%2)?180:0;
        translate([spacing*t,spacing*i,0])rotate([0,0,flip])ridgeBase();
    }
}

// magic :)
//spoongeGridTri(1,2);
if(Nodes_To_Use == "tri"){
        spoongeGridTri(Nodes_across,Nodes_deep);
    }else if(Nodes_To_Use == "smooth"){
        spoongeGridSmooth(Nodes_across,Nodes_deep);
    }else if(Nodes_To_Use == "nubs"){
        spoongeGridRough(Nodes_across,Nodes_deep);
    }else if(Nodes_To_Use == "ridge"){
        spoongeGridRidge(Nodes_across,Nodes_deep);
    }else{
        spoongeGrid(Nodes_across,Nodes_deep);
        }
   
