$fn=50;
gap=2.75;
cage=4.1;
slotDepth=7;
length=17;
wall=3;
angle=10;

difference(){
    cube([length,length+slotDepth,(wall*2)+gap]);
    //access slot
    #translate([0,length,wall]) 
        cube([length,slotDepth,gap]);
    //top cage cutout
    #translate([-length*.1,length+cage/2.25,wall+gap/2]) rotate([angle,90,0])
        cylinder(d=cage,length*1.2);
    //top thumb grip
    #translate([length/2,length/2,2*wall+gap+length/3])
        sphere(d = length);
    //botton thumb grip
    #translate([length/2,length/2,-length/3])
        sphere(d = length);
}



