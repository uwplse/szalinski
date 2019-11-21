Shell=2;
//Fineness of the curves
$fn=90;
//heigth
PYD=120;
//cavity length (add 2mm for tolerance)
QXD=25; //
//cavity width (add 2mm for tolerance)
QYD=17;
//belt holder width
BXD=16;
//belt width - inner height of the holder
BYD=35; 
//gap for the belt (a part disappears in the rounding)
BZD=6; 


rotate([90,0,0]){ //suggested print orientation (no need for support)
difference(){
    //quiver
    union(){
        translate([Shell+QXD/2,0,QYD/2+Shell])
        rotate([-90,0,0])
        scale([(QXD+2*Shell)/(QYD+2*Shell),1,1])
        cylinder(h=PYD,d=QYD+2*Shell);
        //belt holder
        BT=3; //thickness
        translate([(QXD+2*Shell)/2-(BXD/2),PYD*2/3-(BYD+6*Shell)/2,QYD+Shell]){
            difference(){
                cube([BXD,BYD+6*Shell,BZD+BT]);
                translate([-1,3*Shell,0])
                cube([BXD+2,BYD,BZD]);
            }
            translate([BXD,-15,0])
            rotate([0,0,90])
            keil(15,BXD,BZD+BT);
            translate([0,BYD+6*Shell+10,0])
            rotate([0,0,-90])
            keil(10,BXD,BZD+BT);
        }
    }

    //quiver cavity
    translate([Shell+QXD/2,Shell,QYD/2+Shell])
    rotate([-90,0,0])
    scale([QXD/QYD,1,1])
    cylinder(h=PYD+Shell,d=QYD);
}

} //end rotate print orientation

module keil(xd,yd,zd){
    translate([0,yd,0])
    rotate([90,0,0])
    linear_extrude(height = yd)
    polygon(points=[[0,0],[xd,0],[xd,zd]]);
}

