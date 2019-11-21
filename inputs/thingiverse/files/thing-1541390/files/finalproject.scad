/*
Andi Scarcello
May 2016
*/

///////////// Variables ///////////////////////

// Choose the inital branch length.
branchLength = 10;

// Choose the factor by which the branch length decreases in each layer.
branchTaper = .75*1;

branchAngle = 15; //[0:50] 

numBranches = 3; // [1:10]

// Choose the number of levels of branching.
number_of_levels=3; // [1:7]

BaseRadius = 10;

BaseHeight = 2;

base = 2*1;
top = 2*1;
scale = .7*1;
$fn=30*1;

///////////// Renders /////////////////////////

cylinder(BaseHeight, BaseRadius, BaseRadius);
translate([0,0, BaseHeight])
    recursiveTree(base, top, branchLength, 1);

///////////// Modules /////////////////////////

module recursiveTree(base, top, length, depth)
{
    cylinder(length, base, top);
    if(depth<=number_of_levels) {
        for(i=[1:numBranches]) {
            translate([0, 0, length]){
               rotate([branchAngle,0,i*360/numBranches]){
                    recursiveTree(base*scale, top*scale, length*branchTaper, depth+1);
               }
           }
       }
    }
}
