//Number of iterations. Increasing this will make processing time increase exponentially. Avoid large numbers.
stages = 3;
//Width of the menger. The voxel width will be this number divided by 3^n, where n is the number of stages.
totalWidth = 27;


menger(stages,totalWidth);


/*
mengerPattern(1){
cube();
}
*/

module menger(stage, width){
    if(stage==1) {
        mengerPattern(width/3)
        cube(width/3);
    } else {
        mengerPattern(width/3)
        menger(stage-1, width/3);
    } 
}

module mengerPattern(voxelSize=1){
    translations = [
        [0,0,0],
        [1,0,0],
        [2,0,0],
        [0,1,0],
        [2,1,0],
        [0,2,0],
        [1,2,0],
        [2,2,0],
        [0,0,1],
        [2,0,1],
        [0,2,1],
        [2,2,1],
        [0,0,2],
        [0,1,2],
        [0,2,2],
        [1,0,2],
        [1,2,2],
        [2,0,2],
        [2,1,2],
        [2,2,2]
    ];
    for(i=[0:19]){
        translate(translations[i]*voxelSize)
        children();
    }   
}