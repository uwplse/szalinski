radius=50;
sides=7;
twist=135;
topscale=13;
slices=10;
wholescale=1;
//base
scale(wholescale){
scale(.2){
union(){
linear_extrude(height=1300, twist=twist, scale=topscale, slices=slices, radius=radius)
    circle(radius, $fn=sides, twist, scale, slices);   
sphere(radius);
}
cylinder(1700,50,100);
translate([0,0,1300])
scale([1,1,.15])
sphere(600);
}
}