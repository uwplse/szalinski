/**
* Simple parametrical funnel
* @author itzco
* @version 1.0.2
*/

/* [Main] */

// Height of bottom pipe
baseHeight=5;          // [2:1:100] 
// Bottom pipe diameter
baseDiam = 50;         // [5:200] 
// Height of top cone
funnelHeight = 20;     // [10:100] 
// Top opening
funnelTopDiam = 80;    // [10:100] 
// Wall thickness
tk = 1;                // [0.3:0.1:10]  


/* [Internal] */
// Non zero wall adjustments should need any change
nz = 0.5;
nzm= 0.25;
// Quality 10-100
$fn=100;                // [10:100]

//funnel();
funnel (baseHeight, baseDiam, funnelHeight, funnelTopDiam, tk);

module funnel(
    baseHeight=30, 
    baseDiam=10, 
    funnelHeight=50,
    funnelTopDiam=80,
    tk=1) {
    union(){
        pipe(baseHeight, baseDiam,tk);
        translate([0,0,baseHeight])
        cone(funnelHeight, baseDiam, funnelTopDiam,tk);
    }
}
module pipe(h,d,tk=1) {
    difference(){
        cylinder(h=h,d=d);
        translate([0,0,-nzm])
        cylinder(h=h+nz,d=d-tk*2);
    }
}
module cone(h,d1,d2,tk=1) {
    difference(){
        cylinder(h=h,d1=d1,d2=d2);
        translate([0,0,-nzm])
        cylinder(h=h+nz,d1=d1-tk*2, d2=d2-tk*2);
    }
}
