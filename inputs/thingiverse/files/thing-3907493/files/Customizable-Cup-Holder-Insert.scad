
//height
h=40;

//inside cup depth
d=35;

//outside diameter
d2=40;

//inside diameter
d1=35;


difference(){
cylinder(h,d2/2,d2/2,center);
translate([0,0,h-d+1])
cylinder(d+1,d1/2,d1/2,center);
    }