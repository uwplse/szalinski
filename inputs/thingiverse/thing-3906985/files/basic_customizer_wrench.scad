
//Size Of Wrench Opening
w=12;
//wrench thickness
t=4; //[1,2,3,4,5,6,8,10]


union(){
//wrench head
difference(){

        translate([4*w,0,0])cylinder(h=t,r=w);
    translate([3.75*w,-w/2,-t])cube([2*w,w,50*t]);
    
    }
//wrench body
    translate([-w*.75,-w,0])cube([w*4.75,2*w,t]);
}