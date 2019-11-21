//the width of the hexagon from face to face.  Hive is 37, Hive Pocket is 25
hexagon_width = 25;

//The size of the border between hexagon cups
border=2;

//The size of the one side of the board in hexagons
side=4;

//The Height of the board without the feet
height=6;

//The depth of the cups. This must be less than the height
depth=3;

//the height of the feet
footHeight=1;

module hexagon(rsmall, rlarge, height){
    fudge=.001;
    union(){
        translate([0,0,-footHeight])
            cylinder($fn = 6, r=rsmall-2,h=footHeight);
        difference (){
            cylinder($fn=6,r=(rlarge+fudge+rsmall)/2,h=height);
            translate([0,0,height-depth])
                cylinder($fn = 6, r1=rsmall, r2=(rlarge+rsmall)/2, h=depth+1);

            };
        }
}


rsmall=hexagon_width / sqrt(3);
rlarge=rsmall+border;
union(){
    for(j=[0:side-1]){
        for (i=[0:side-1+j]){
            translate ([(rlarge+rsmall)*j*3/4,(sqrt(3)*(rlarge+rsmall)/2)*(i-j/2),0]){
                hexagon(rsmall,rlarge,height);
            }
        }
    }
    for(j=[side:side*2-2]){
        for (i=[j+1-side:2*side-2]){
            translate ([(rlarge+rsmall)*j*3/4,(sqrt(3)*(rlarge+rsmall)/2)*(i-j/2),0]){
                hexagon(rsmall,rlarge,height);
            }
        }
    }
}
