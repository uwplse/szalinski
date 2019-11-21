X_Bullets=10;
Y_Bullets=5;
Height=0.5;
Block_Corner=0.25;
Pad=0;

Case_Diameter=0.452;
Hole_Slack=0.048;
Depth=0.4;
Bullet_Space=0.1;
Chamfer=0.025;
Block_Chamfer=0.1;

Convert = "mm"; // [mm, inches]

dia=Case_Diameter+Hole_Slack; //diameter of hole
web=Height-Depth;
W=X_Bullets*(dia+Bullet_Space)-Block_Corner+Pad*2;
L=Y_Bullets*(dia+Bullet_Space)-Block_Corner+Pad*2;

/* [Hidden] */
$fs=0.01;

module base(){
    //render(){
    translate([W/2+Block_Corner,L/2+Block_Corner,Height/2-Block_Chamfer/2])
    minkowski(){
        cube([W,L,Height-Block_Chamfer],true);
        cylinder(r1=Block_Corner,r2=Block_Corner-Block_Chamfer,h=Block_Chamfer, $fs=0.01);
}}//}

module hole(){
    //render(){
        union(){
            $fs=0.01;
            translate([0,0,web])cylinder(h = Height, r=dia/2);
            translate([0,0,Height-0.125-Chamfer])cylinder(h=0.25, r1=dia/2-0.125, r2=dia/2+0.125);
        }
    //}
}

module row(){
    //render(){
        for (y =[1:1:Y_Bullets]){
            translate([0,y*(Bullet_Space+dia),0])hole();
        }
    //}
}
module holes(){
    OffSet=0.25-0.5*Block_Corner;
    translate([-Bullet_Space/2-OffSet+Pad,-Bullet_Space/2-OffSet+Pad,0])
    for (x =[1:1:X_Bullets]){
        translate([x*(Bullet_Space+dia),0,0])row();
    }
}

module block(){
difference(){
    base();
    holes();
}
}

if (Convert == "mm"){
    scale([25.4,25.4,25.4])block();
} else {
    block();
}
