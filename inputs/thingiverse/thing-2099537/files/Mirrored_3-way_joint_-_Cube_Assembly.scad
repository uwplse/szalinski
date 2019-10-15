//this is the user inputed width of the square shaft
width=9;
//this is the user inputed height of the solid shaft (not including the joint)
height=12;
//this is the user inputed tolerance. may be printer specific. incorporating about 0.01" gap works well on my Makerbot Replicator
tolerance=0.01;

module joint(width, height){
    cube([width, width, height]);
    translate([0,0,height]){cube([width/3-tolerance/2,width, width/3]);}
    translate([0,width/3+tolerance/2,height+width/3]){
        cube([width/3-tolerance/2,width/3-tolerance,2*width/3]);}
    translate([2*width/3+tolerance/2,width/3+tolerance/2,height]){
        cube([width/3-tolerance/2,width/3-tolerance,width]);}

}

module piece1(width, height1){
    joint(width,height1);
}

piece1(width,height/2);
rotate(v=[1,0,0],a=180){
    translate([0,-width,0]){
    piece1(width,height/2);
}}