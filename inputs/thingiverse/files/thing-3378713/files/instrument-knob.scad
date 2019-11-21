$fn=100; //smoothness

radius=9;
height=18;
numteeth=7;
pivotDiameter=6;
pivotHeight=11;
difference(){
    intersection(){
    hull(){
        cylinder(r=radius,h=1);
        translate([0,0,height-1])cylinder(r=radius-2,h=1);
    }
    sphere(height);
    }
    union(){
        translate([0,0,-1]) cylinder(r=pivotDiameter/2,h=pivotHeight+1);
        for (i=[0:numteeth]){
        rotate(a=360/numteeth*i,v=[0,0,1]) hull(){
            translate([radius+1,0,1]) cylinder(r=2.5,h=height+2);
            translate([radius-2,0,1]) cylinder(r=1,h=height+2);
        }
        }
    }
}


