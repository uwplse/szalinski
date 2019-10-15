//Cube side; 62 will make it 100 high
cs=62;//[10:250]
//Number of dividers
dn=1;//[0,1,2,3,4,5]
//Bar width
ws=4;//[1:0.2:10]
//Bar type
bt="round";//[round,sqare]
//Base height (0 for none)
dh=0.6;//[0:0.1:5]
//Make it double or more
dbl=2;//[1:single,2:double,3:tripple,4:quadruple,5:5,6:6,7:7,8:8,9:9,10:10,11:11,12:12]
/* [Hidden] */
ds=1.25;
$fn=16;
dl=cs/(dn+1);
a2=35.264;
module node(){
    if (bt=="round"){
        sphere(ws/2); 
    } else {
        cube(ws,true);
    }
}

difference(){
for(ndbl=[1:dbl])translate([0,0,-cs/(dn+1)*sin(a2)+dh])rotate([45,-a2,120/dbl*ndbl])rotate([0,0,0])for(n1=[0:dn+1]){
    for(n2=[0:dn+1]){
        hull(){
            translate([n1*dl,n2*dl,0])node();
            translate([n1*dl,n2*dl,cs])node();
        }
        hull(){
            translate([n1*dl,0,n2*dl])node();
            translate([n1*dl,cs,n2*dl])node();
        }
        hull(){
            translate([0,n1*dl,n2*dl])node();
            translate([cs,n1*dl,n2*dl])node();
        }
    }
}
translate([-cs,-cs,-2*cs+dh])cube(2*cs);
}
cylinder(h=dh,r=cs/(dn+1)*cos(a2)*ds);
