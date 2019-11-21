rCal = 40; //external radius of diffuser
hCal = 25; //height of diffuser
hBase = 0.5; //height of the "base ring" around the diffuser
thickness = 1; //thickness of the diffuser

radius = ((rCal*rCal)+(hCal*hCal))/(2*hCal);
resol = 180;
sphere_height = radius-hCal;
translate([0,0,-sphere_height]){
    difference(){
        sphere(r = radius,$fn=resol);
        sphere(r = radius-thickness,$fn=resol);    
        translate([0,0,-hCal]){
            cube(radius*2,center=true);
        }
    }
}
translate([0,0,0]){
    difference(){
        cylinder(hBase,r=rCal+1,center=true,$fn=resol);
        cylinder(hBase,r=rCal,center=true,$fn=resol);
    }
}