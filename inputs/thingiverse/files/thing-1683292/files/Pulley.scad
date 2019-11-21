outerDia = 13.5;

innerDia = 10.2;

grooveDia = 12.3;

grooveHeight = 1;

overallHeight = 8;

module pulley(outerDia, innerDia, midDia, midHeight, height){
    difference(){
        union(){
            translate([0,0,(height-midHeight)/2]) cylinder(h=midHeight/2, r1=outerDia/2, r2=midDia/2,$fn=50);
            translate([0,0,midHeight+(height-midHeight)/2]) rotate([0,180,0]) cylinder(h=midHeight/2, r1=outerDia/2, r2=midDia/2,$fn=50);
            translate([0,0,midHeight+(height-midHeight)/2]) cylinder(h=(height-midHeight)/2, r=outerDia/2,$fn=50);
            translate([0,0,0]) cylinder(h=(height-midHeight)/2, r=outerDia/2,$fn=50);
        }
        translate([0,0,-0.01]) cylinder(h=height+0.02,r=innerDia/2,$fn=50);
    }
}
     // OD   ID  MD  MH, H
pulley(outerDia, innerDia, grooveDia, grooveHeight, overallHeight);