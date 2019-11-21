y = 120;
x = 25;
z = 180;
difference(){
    cube([x,z,y], center =false);
    #translate([-x/2,z/7,y/7])
    cube([x*2,z*0.7,200], center =false);
}
translate([-x/2,0,0])
cube([x*2,z,1], center =false);

