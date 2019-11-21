// ************* Credits part *************
// "Parametric Desicant Box" 
// Programmed by Marcel Chabot - Feburary 2016
// Optimized for Customizer
//
//
//********************** License ******************
//**        "Parametric Desicant Box"            **
//**                  by Marcel Chabot           **
//**  is licensed under the Creative Commons     **
//** - Attribution - Non-Commercial license.     **
//*************************************************

// ************* Declaration part *************
//Box Width
width = 100;
//Box Depth
depth = 150;
//Box Height
boxHeight = 30;
//Pan Height
panHeight = 10;
//Lid Height
lidHeight = 8;
//Wall depth
wall = 3.5;
//Sciv Size
scivSize = 3;

pan(width,depth,panHeight,wall);
translate([width+1,0,0])
lid(width,depth,lidHeight,wall);
translate([2*width+5,0,0])
Box(width,depth,boxHeight,wall);

module pan(width, depth, height, wall){
    difference(){
        cube([width, depth, height], true);
        translate([0,0,1])
        cube([width-wall, depth-wall, height], true);
            
        translate([0,0,height-2])
        cube([width-wall/2+0.5,depth-wall/2+0.5,height],true);
    }
}

module lid(width, depth, height, wall){
    difference(){
        cube([width, depth, height], true);
        translate([0,0,1])
        cube([width-wall, depth-wall, height], true);
        
        translate([0,0,height-4])
        cube([width-wall/2+0.5,depth-wall/2+0.5,height],true);
        
        translate([0,0,-1*(height/2-1)])
        sciv(width, depth, height/2, scivSize, scivSize);
    }
}
module Box(width, depth, height, wall){
    difference(){
        union(){
            cube([width, depth, height], true);
            
            translate([0,0,height/2])
            cube([width-wall/2,depth-wall/2,4], true);
            
            translate([0,0,-height/2-1])
            cube([width-wall/2-0.5,depth-wall/2-0.5,2], true);
        }
        
        translate([0,0,1])cube([width-wall, depth - wall, height+4], true);
        
        translate([width/2-wall/2, depth/2, 2])
        slats(width, depth, height-2, wall, 1, 2);
        
        translate([-1*(width/2-wall/2), -depth/2, 2])
        rotate([0,0,180])
        slats(width, depth, height-2, wall, 1, 2);
        
        translate([-width/2,depth/2-wall/2,2])
        rotate([0,0,90])
        slats(depth, width, height-2, wall, 1, 2);
        
        translate([width/2,-1*(depth/2-wall/2),2])
        rotate([0,0,-90])
        slats(depth, width, height-2, wall, 1, 2);
      
        translate([0,0,-1*(height/2)])
        sciv(width, depth, height/2, scivSize, scivSize);
    }
}

module sciv(width, depth, height, size, space){
    xHoles = (width)/(size+space);
    yHoles = (depth)/(size+space);
    
    for(y = [1:yHoles-1]){
        translate([0,depth/2 - ((size+space) * y),0]){
            for(x = [1:xHoles-1]){
                translate([width/2 - ((size+space) * x) ,0,0])
                rotate([0,0,45])
                cube([size, size, height], true);
            }
        }
    }
}

module slats(width, depth, height, wall, thickness, space){
    slatsW = depth /(thickness+ space);
    
    for(i=[1:slatsW-1]){
        rotate([0,0,90])
        translate([(-i*(thickness+space)), 0, 0])
        cube([thickness, wall*2, height-2], true);
    }
}