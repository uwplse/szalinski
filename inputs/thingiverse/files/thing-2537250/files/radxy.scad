halfpipe(180,12,9);
union(){
difference(){
translate([10,0,0])cube([48,180,3]);
translate([20,10,-1])cylinder(h=5,r=3);
translate([20,170,-1])cylinder(h=5,r=3);
translate([48,10,-1])cylinder(h=5,r=3);
translate([48,170,-1])cylinder(h=5,r=3);   
translate([20,20,0])  cube([28,110,3]);
}
//translate([24,138,2])kasten(22,18,30);

}
translate([68,0,0])halfpipe(180,12,9);
module halfpipe(lang,radius1,radius2){
difference(){
    rotate([0,90,90])cylinder(h=lang,r=radius1);
    translate([-radius1,0,-12])cube([radius1*2,lang,radius1]);
    rotate([0,90,90])cylinder(h=lang,r=radius2);
}
}

module kasten(breite1,breite2,hoehe){
difference(){
cube([breite1,breite1,hoehe]);
translate([(breite1-breite2)/2,(breite1-breite2)/2,breite1-breite2])cube([breite2,breite2,hoehe]); 
translate([breite1/2,-1,hoehe/2])rotate([0,90,90])cylinder(h=breite1+2,r=4);     
}  
    
    
}