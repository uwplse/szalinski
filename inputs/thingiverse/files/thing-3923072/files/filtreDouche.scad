radius=20.5;          //[10:.5:30]
heightHole=15;       //[2.5:.5:16]
height = 10;   //[2:.25:20]
thikness = 1;      //[.5:.5:3]
flange = 3;        //[0:.5:4]

heightHole2=heightHole/2;

module hole(height=3,depth=1){
    cylinder($fn=200,h = depth, r1 = height/3, r2 = height/3);
    translate([0,-height/3,0])
        cube(size = [height,height/3*2,depth]);
    translate([height,0,0])
    cylinder($fn=200,h = depth, r1 = height/3, r2 = height/3);
}

module matrixHoles(nbColumn=6,nbRow=12,heightHole2=3){
    for (j=[0:nbRow/2-1]){
    translate([heightHole2,j*heightHole2*1.8,0])
    for(i = [0 : heightHole2*2 : (nbColumn-1)*heightHole2*2])
        translate([i,0,0])
            hole(heightHole2,thikness);
   translate([0,heightHole2*0.9+j*heightHole2*1.8,0])
    for(i = [0 : heightHole2*2 : (nbColumn-1)*heightHole2*2])
        translate([i,0,0])
            hole(heightHole2,thikness);
    }   
}



/******   Base Plate   *****/
difference(){
    translate([radius-thikness,radius-thikness,0.1])
        cylinder($fn=200,h = thikness-.2, r1 = radius, r2 = radius);
    matrixHoles(radius/heightHole2*2,radius/heightHole2*3,heightHole2);
}



/*******   Cylindre   ******/
translate([radius-thikness,radius-thikness,0]){
    ring(radius-thikness,thikness);
    translate([0,0,thikness])
        ring(radius-thikness);
    difference(){
        cylinderEmpty(heightHole2,radius-thikness,thikness);
        cylinderHoles(height/heightHole2,heightHole2*5/radius*20,radius-thikness,heightHole2);
    }
    translate([0,0,height])
    ring(radius,thikness);
}

//****** Higher plate *******
if (flange>0){
    translate([radius-thikness,radius-thikness,0])
        translate([0,0,height]){
          ring2(radius-thikness,thikness,flange);
          translate([0,0,thikness])
            ring2(radius-thikness+flange-.5,thikness,flange);
        }
}
module cylinderEmpty(heightHole2,radius=20,thikness=1){
  
    difference(){
        cylinder ($fn=200,h=height,r1=radius+thikness,r2=radius+thikness);
        translate([0,0,-.1])
            cylinder ($fn=200,h=height+.2,r1=radius+.1,r2=radius+.1);
    }
}

module ring2(radius=20,thikness=1,tks2){
    difference(){
        cylinder ($fn=200,h=thikness,r1=radius+tks2,r2=radius+tks2);
        translate([0,0,-.1])
        cylinder ($fn=200,h=thikness+.2,r1=radius,r2=radius);
    }
}


module ring(radius=20,thikness=1){
    difference(){
        cylinder ($fn=200,h=thikness,r1=radius+thikness,r2=radius+thikness);
        translate([0,0,-.1])
        cylinder ($fn=200,h=thikness+.2,r1=radius,r2=radius);
    }
}
module cylinderHoles(nbRows=3,stepAngle=13,radius=20,heightHole2=3){
    translate([0,0,heightHole2*1.5])
    for (y=[0:nbRows-1])
        for (i=[0:stepAngle:360]){
            angle= i-y*(stepAngle/2);
            translate([radius*cos(angle),radius*sin(angle),y*heightHole2])
            rotate(90,[0,1,0])
            rotate(-angle,[1,0,0])
                hole(heightHole2,thikness);
        }
}