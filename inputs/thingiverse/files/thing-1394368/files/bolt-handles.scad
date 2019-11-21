dia=24; //diameter of object (min=hex)


hex=14.5; //circumscribed diameter of hexagon
head=5.5; //thickness of hex head/nut

bolt=8; //diameter of bolt
thread=5.5; //thickness around threads

res=60; //round resolutions

handleW=8; //width of handle (min=bolt)
handleL=40; //length of handle minus the round

//Calc
height=head+thread; //total height
boltTol=(.5+bolt); //3D printing tolerance


union(){
        translate ([-handleW/2,(dia/2-2),0]) 
        cube([handleW,handleL+2,height], false);
        translate ([0, handleL+dia/2, 0])
        cylinder (height, d=handleW, $fn=res);
difference(){
difference(){
  cylinder (height, d=dia, $fn=res);
  cylinder (height, d=boltTol, $fn=res);
}
translate ([0,0,thread]) cylinder (head,d=hex, $fn=6);
}
}
