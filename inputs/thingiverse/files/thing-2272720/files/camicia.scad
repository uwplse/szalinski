
//pezzo finito ma senza cambio parametri

/*camicia();

module camicia(R,R1,H,H1,resolution) {
difference(){
    ce(30,85,30);
   translate([7.5,0,0])
    ci(15.5,90,30);
}

module ci(R,H,resolution)
 cylinder(r=R,h=H1,$fn=resolution,center=true);
module ce(R1,H,resolution)
 cylinder(r=R1,h=H,fn=resolution,center=true);
 } 
 */
camicia(15.5,30,85,30);

module camicia(Ri,Re,H,resolution) {
difference(){
    ce(Re,H,resolution);
   translate([7.5,0,0])
    ci(Ri,H,resolution);
}

module ci(Ri,H,resolution)
 cylinder(r=Ri,h=H+2,$fn=resolution,center=true);
module ce(Re,H,resolution)
 cylinder(r=Re,h=H,$fn=resolution,center=true);
 }