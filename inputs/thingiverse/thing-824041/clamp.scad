//Radius of tube to clamp to
R=25;
//Width of ring
w=3;
//Bolt screw radius
screwR=3;
//Bolt/nut wrench size
nutR=6;
//Bolt/nut trap size
nutH=4;
//Space of clamp
space=19;



module clamp(R,w,screwR,nutR,nutH,space){
    h=screwR*4;
    difference(){
        union(){
            cylinder(r=R+w,h = h);
            translate([0,-(R+w),0]) cube([(R+w+h),(R+w)*2,h]);
        }
        cylinder(r=R,h=h);
        translate([0,-space/2,0]) cube([(R+w+h),space,h]);
        
        
        translate([(R+w+screwR*2),(R+w),screwR*2]) rotate([90,0,0]) cylinder(r=screwR,h=(R+w)*2);
        translate([(R+w+screwR*2),(R+w),screwR*2]) rotate([90,0,0]) cylinder(r=nutR,h=nutH, $fn=6);
        
    }

}


clamp(R,w,screwR,nutR,nutH,space);