//inner diameter of hole circle is 7.63 mm
//diameter of  void is 31.7mm
//diameter of flange is 37.4mm
//height of flange is 1.06mm
//height of flange plus wall is 8.6mm
//height at center 9.2mm

module flangeod(od1,od2,fn,height,delta)
     {
    cylinder(h=height/2.0, r1=od1, r2=od2);
    translate([0,0,height/2])
        cylinder(h=height/2.0, r1=od2, r2=od1);
    }
    

module flange(od1,od2,id,fn=40,height=1,delta=0.1){
difference()
//   linear_extrude(height=height) circle(r=od/2.0,$fn=fn);
{
    flangeod(od1,od2,fn,height,delta);
    translate([0,0,-height-delta/2]) 
    //linear_extrude(height=2*height+4*delta) 
    cylinder(r1=id,r2=id,h=2*height+delta,$fn=fn);
}
}

module hollowCylinder(od,id,height,delta,fn=40){
difference(){
    linear_extrude(height=height) circle(r=od/2.0,$fn=fn);
translate([0,0,-delta]) linear_extrude(height=(height+2*delta)) circle(r=id/2.0,$fn=fn);
}
}

translate([0,0,-2.305])
//flange(od1=34.78/2,od2=24,17/2,id=7.63,height=4.61,fn=40);
flange(od1=24.17/2,od2=26.78/2,id=7.63,height=4.61,fn=40);
translate([0,0,-16.39]){
hollowCylinder(od=24.17,id=7.63,height=32.78,delta=0.5);
zoffset = 9.2-2.5;
}
//
//difference()
////   linear_extrude(height=height) circle(r=od/2.0,$fn=fn);
//{
//  flangeod(od1=34.78,od2=34.78,fn=fn,height=4.61,delta=delta);
////    translate([0,0,-height-delta]) //
//    //linear_extrude(height=2*height+4*delta) 
//    cylinder(r1=7.63,r2=7.63,h=20,$fn=fn,center=true);
//}


//translate([0,8,zoffset]) rotate([0,180,0]) letterExtrude("Farley",size=8,height=zoffset);
//translate([0,0,zoffset]) rotate([0,180,0]) letterExtrude("Pepper",size=8,height=zoffset);
//translate([0,-8,zoffset]) rotate([0,180,0]) letterExtrude("Shaker",size=8,height=zoffset);