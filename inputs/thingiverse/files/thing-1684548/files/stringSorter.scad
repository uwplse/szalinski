// ************* Credits part *************
// "Dynamic Floss Sorter" 
// Programmed by Marcel Chabot - July 2016
// ****************************************
//
//********************** License ******************
//**                 "Dynamic Floss Sorter"      **
//**                  by Marcel Chabot           **
//**  is licensed under the Creative Commons     **
//** - Attribution - Non-Commercial license.     **
//*************************************************


// ************* Declaration part ********
//Length of holder
Holder_Length = 140;
//Width of holder
Holder_Width = 50;
//Thickness of separator  edge
Edge_Thickness = 5;
//Thickness of base
Base_Thickness = 3;
//Hole Diameter
Hole_Size = 10;

/* [Hidden] */
$fn=25;

difference(){
    createBase(Holder_Length, Holder_Width, Edge_Thickness, Base_Thickness, Hole_Size);
    generateHoles(Holder_Length, Holder_Width, Hole_Size);

    translate([Holder_Length - Holder_Width, 0, 0])
    //mirror([1,0,0])
    rotate([0,0,180])
    generateHoles(Holder_Length, Holder_Width, Hole_Size);
}

module createBase(length, width, edge, base, hole){
    difference(){
        hull(){
            cylinder(h=edge, d=width, center=true);
            translate([length-width,0,0])
            cylinder(h=edge, d=width, center=true);
        }
        
        translate([0,0,Base_Thickness])
        hull(){
            cylinder(h=edge, d=width-2, center=true);
            translate([length-width,0,0])
            cylinder(h=edge, d=width-2, center=true);
        }
        
        translate([0,0,-10])
        hull(){
            cylinder(h=40, d=width - hole*3, center=true);
            translate([length-width,0,0])
            cylinder(h=40, d=width - hole*3, center=true);
        }
    }
}

module generateHoles(length, width, hole){
    noh = (width/hole)-1;
    rotate(90){
        for(i=[0:noh]){
            rotate((180*i)/noh){
                translate([width/2 - hole/2-2,0,0]){
                    translate([0,0,-25])
                    cylinder(h=50, d=hole, center=false);
                    translate([5,0,hole/2])
                    cube(hole, true);
                }
            }
        }
    }
    
    //starting gap between holes
    longsideHoleSpace = 5;
    //distance the holes must cover
    distance = length-width;
    //Number of complete holes that can fill the space
    holeCount = floor(((distance)/(hole+longsideHoleSpace))-1);
    
    //Calculate the little bit that remains from an incomplete hole
    bitWidth = (distance - (hole+longsideHoleSpace) * (holeCount+1))/(holeCount+1);

    //Distribute the remainder
    finalHoleSpace = longsideHoleSpace + bitWidth;
    
    for(i=[0:holeCount]){
        translate([i*(hole+finalHoleSpace),width/2 - hole/2-2,0]){
            translate([0,0,-25])
            cylinder(h=50, d=hole, center=false);
            translate([0,5,hole/2])
            cube(hole, true);
        }
    }
}