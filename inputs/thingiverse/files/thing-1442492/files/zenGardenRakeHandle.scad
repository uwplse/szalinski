
$fn=50;
cubeSize = 100;
halfCube = cubeSize/2;
holeRadius = 25; 
numberOfAdditionalHoles = 6;
spacingBetweenRakeHoles = 20;
angleOfRakeHandle=50;
rakeSpokeLength = 400;
rakeHandleLength = 800;

rakeWidth =  (numberOfAdditionalHoles *(cubeSize+spacingBetweenRakeHoles) - spacingBetweenRakeHoles);


module rake_with_hole(){
//RAKE WITH HOLE MODULE
translate([0,0,halfCube])
difference(){ 
    //BASE CUBE
    minkowski()
    { 
        cube(cubeSize, center =true);
        rotate([90,0, 90]){ 
            cylinder(r=5,h=1);
        }
    }
    //HOLE
    color("blue") cylinder (cubeSize *2, holeRadius , holeRadius, true);
}
}
module rake_without_hole(){
//RAKE WITH HOLE MODULE
translate([0,-halfCube ,0 ]) 
    //BASE CUBE  
    minkowski()
    { 
        cube([spacingBetweenRakeHoles,cubeSize,cubeSize ], center =false);
        rotate([90,0, 90]){ 
            cylinder(r=5,h=1);
        }
    } 
}




moduleLength = cubeSize+spacingBetweenRakeHoles;
module rake_body(){
rake_with_hole(); 
for(i=[1:numberOfAdditionalHoles]){
    translate([halfCube + (i-1)*(cubeSize+spacingBetweenRakeHoles),0,0])
        rake_without_hole();
    translate([spacingBetweenRakeHoles+cubeSize+ (i-1)*(cubeSize+spacingBetweenRakeHoles),0,0])rake_with_hole();
}
}

 

 


module spokes(){
    if(rakeSpokeLength >0){
for(i=[0:numberOfAdditionalHoles]){
translate ([i* (cubeSize+spacingBetweenRakeHoles+5),2*cubeSize, 0]){
    cylinder (rakeSpokeLength, holeRadius, holeRadius, false);
    translate([0,0,rakeSpokeLength]) sphere (holeRadius);
}}}}

module handle(){
    if(rakeHandleLength > 0){
translate ([0, -2*cubeSize, holeRadius]) {
    difference(){
        union(){
        rotate([0,90,0]) cylinder (rakeHandleLength, holeRadius, holeRadius); 
        sphere(holeRadius); 
    }
    
        cylinder(cubeSize, holeRadius/2, holeRadius/2, true);
    }}
}}

handle();
spokes();
difference(){
    //BODY
    union(){
    rake_body();
    //attachment to rake handle
    translate([rakeWidth/2, 0, cubeSize+halfCube])
    minkowski()
        { 
            cube(cubeSize, center =true);
            rotate([90,0, 90]){ 
                cylinder(r=5,h=1);
            }
        }
    }
    //SUBTRACT HOLE FOR HANDLE
    translate([rakeWidth/2, 0, cubeSize+halfCube]) 
    rotate([angleOfRakeHandle,0,0]) cylinder(cubeSize*2, holeRadius, holeRadius, true); 
}
