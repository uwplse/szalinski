//Curve quality
$fn=50;//[10:1:300]
/*[LED ribbon parameters]*/
//LED ribbon width
r_laius=10;//[3:1:15]
//LED ribbon height
r_korgus=3;//[2:1:6]
/* [LED ribbon mounting brace parameters] */
//Mounting brace curvature radius
raadius=25;//[20:1:100]
//Mounting brace with one mounting hole
yksik=0;//[0:No,1:Yes]
/* [Hidden] */
korgus=r_korgus*1.5;
kruvi_d=3;
laius=kruvi_d*3;
pikkus=r_laius+4*kruvi_d;
if (yksik!=0) rotate([-90,0,0]) klamber(); else klamber();
module klamber(){
difference(){
translate([0,0,-raadius+korgus])
intersection(){
rotate([90,0,0]) cylinder(laius,r=raadius,center=true);
translate([0,0,raadius-korgus/2]) cube([pikkus,laius,korgus], center=true);
}
cube([r_laius,laius,r_korgus*2], center=true);
translate([r_laius/2+(pikkus/2-r_laius/2)/2,0,0]) cylinder(laius,d=kruvi_d);
translate([-(r_laius/2+(pikkus/2-r_laius/2)/2),0,0]) cylinder(laius,d=kruvi_d);
translate([r_laius/2+(pikkus/2-r_laius/2)/2,0,r_korgus-1]) cylinder(kruvi_d*2,d=kruvi_d+kruvi_d/1.6);
if (yksik==0)
translate([-(r_laius/2+(pikkus/2-r_laius/2)/2),0,r_korgus-1]) cylinder(kruvi_d*2,d=kruvi_d+kruvi_d/1.6);
else{
translate([-(pikkus/2+r_laius/2+1),0,r_korgus]) cube([pikkus,laius,r_korgus*2], center=true);
translate([-r_laius/2,0,0]) cube([r_korgus,laius,r_korgus], center=true);}
}
}