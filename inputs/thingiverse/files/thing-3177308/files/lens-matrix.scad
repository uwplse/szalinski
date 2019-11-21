Rows=5;
Columns=7;
Focal_Distance=10;
Multiplier=1.5; // [.1:.1:2]
Base_Thickness=.5; // [.2:.1:5]
XY_Ratio=.6; // [.2:.05:1]
// Experimental
Apply_Ratio_To_Lenses=0; // [0,1]
Surface_Quality=80; // [40:40:200]
/* [Hidden] */
$fn=Surface_Quality;
k=sqrt(.5);
color("lightblue",.8)rotate([0,90,270])
union()for(i=[1:Rows],j=[0:Columns-1])translate([-XY_Ratio*i*Focal_Distance*k*k*2,j*Focal_Distance*k*k*2,0])
intersection(){
translate([XY_Ratio*Focal_Distance*k*k,Focal_Distance*k*k,Base_Thickness-(Apply_Ratio_To_Lenses?k/XY_Ratio:1)*Focal_Distance*k*Multiplier])scale([1,Apply_Ratio_To_Lenses?1/XY_Ratio:1,Multiplier])rotate([90])sphere(Focal_Distance);
cube([XY_Ratio*Focal_Distance*k*k*2,Focal_Distance*k*k*2,Focal_Distance*Multiplier*k]);
}