//  ***********************************
//Seal Wine Bottle CC Henry Piller 2017
// variable description
//text oben
text1="2016";
//text unten
text2="VINO";
/* [Hidden] */
$fn=45; siegelrad=15;
 translate([0,0,2]){
translate([-(len(text1)+2),3,0]) linear_extrude(height = 3) {
       text(text = str(text1), size = 5, font="Liberation Sans:style=Bold Italic");     }
translate([-(len(text2)+4),-7,0]) linear_extrude(height = 3) {
       text(text = str(text2), size = 6, font="Liberation Sans:style=Bold Italic");     }
difference(){ union(){
minkowski(){ union(){
 translate([siegelrad/2,siegelrad/6,0]) cylinder(h=3,r1=siegelrad*0.75,r2=siegelrad*0.75,center=false);
 translate([-siegelrad/3,0,0]) cylinder(h=3,r1=siegelrad*0.8,r2=siegelrad*0.8,center=false);
 translate([siegelrad/2,siegelrad*0.7,0]) cylinder(h=3,r1=siegelrad*.6,r2=siegelrad*.6,center=false);
 translate([siegelrad*.4,-siegelrad*.6,0]) cylinder(h=3,r1=siegelrad*.58,r2=siegelrad*.58,center=false);
 translate([-siegelrad*1.1,-siegelrad*.65,0]) cylinder(h=3,r1=siegelrad*.4,r2=siegelrad*.4,center=false);
 translate([0,0,0]) cylinder(h=3,r1=siegelrad,r2=siegelrad,center=false);}
    rotate([90,0,0])
    cylinder(r=2,h=2);}}
union(){
 translate([1,-1,1.5]) cylinder(h=4,r1=siegelrad,r2=siegelrad,center=false);
translate([siegelrad-2,0,2]) rotate([0,90,0])
 cylinder(h=8,r1=1,r2=2.5,center=false);
translate([-siegelrad-4,0,2]) rotate([0,90,0])
 cylinder(h=8,r1=2.5,r2=1,center=false); }}
}
