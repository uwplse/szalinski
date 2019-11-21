//Cube side; 62 will make it 100 high
cs=62;//[10:200]
//Number of dividers
dn=1;//[0,1,2,3,4]
//Bar diameter
ws=4;//[1:0.2:10]
//Base height (0 for none)
dh=0.6;//[0:0.1:5]
//Make it double (rotated 45 degrees)
dbl=1;//[0:single,1:double]
/* [Hidden] */
ds=1.25;
$fn=16;
dl=cs/(dn+1);
a2=35.264;
difference(){
for(ndbl=[0,dbl])translate([0,0,-cs/(dn+1)*sin(a2)+dh])rotate([45,-a2,60*ndbl])rotate([0,0,0])for(n1=[0:dn+1]){
    for(n2=[0:dn+1]){
        hull(){
            translate([n1*dl,n2*dl,0])sphere(ws/2);
            translate([n1*dl,n2*dl,cs])sphere(ws/2);
        }
        hull(){
            translate([n1*dl,0,n2*dl])sphere(ws/2);
            translate([n1*dl,cs,n2*dl])sphere(ws/2);
        }
        hull(){
            translate([0,n1*dl,n2*dl])sphere(ws/2);
            translate([cs,n1*dl,n2*dl])sphere(ws/2);
        }
    }
}
translate([-cs,-cs,-2*cs+dh])cube(2*cs);
}
cylinder(h=dh,r=cs/(dn+1)*cos(a2)*ds);
