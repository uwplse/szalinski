$fn=128;
Disk_Radius=45;
Disk_Height=2;
Fin_Count=33;
Fin_Length=20;
Fin_Height=5;

union(){
    difference(){
        union(){cylinder(r=45,h=Disk_Height);cylinder(r=9,h=5.25-1.3);
            translate([0,0,Disk_Height-0.1])rim(8.95,5.25-1.3-2);
            translate([0,0,Disk_Height+5.25-1.3-2])difference(){
                sphere(r=9,$fn=512);
                translate([-9,-9,-18])cube(18);
            }
        }
        for(i=[1:3]){rotate([0,0,i*120]){
                                    translate([6,0,5.25-2.6])cylinder(r=2.2,h=30);
                                    translate([6,0,0])cylinder(r=1.1,h=6);}
            }
            cylinder(r=4.6,h=2.4);
    } 
    for(i=[1:Fin_Count]){rotate([0,0,i*(360/Fin_Count)])translate([0,Disk_Radius,0])fish(Fin_Height+Disk_Height,Fin_Length);}
}

module fish(h,l){
linear_extrude(height=h){scale([l/1.75,l/1.75,1])translate([0,-1.04,0])union(){
intersection(){
difference(){
        scale([1.25,1.04,1])circle(r=1);
        scale([1.025,1,1])circle(r=1);
    }
    union(){square(2);
    rotate([0,0,-45/2])square(2);}}
    rotate([0,0,-45/2.1])translate([(1.25+1.025)/2.03,0,0])scale([1-1/8*1.25/1.01,1,1])rotate([0,0,-360/32])scale([1,2.5,1])circle((1.25-1.025)/2, $fn=64);
    }}}
    
    module rim(R,r){
        rotate_extrude($fn=256){translate([R,0,0])
            difference(){
                square(r);
                translate([r,r,0])circle(r,$fn=256);}}
        }