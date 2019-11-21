//Parameterised dovetail template
// Glyn Cowles September 2014

//Thickness
th=2;//[1:5]
//Depth
depth=20;//[5:50] 
//Width
width=20;//[5:50]   
//Slope e.g. 7 = 7:1
slope=6;//[2:9]
/* [Hidden] */
$fn=70;


assemble(); 

//-----------------------------------------------------------------------
module main(d,w,a) {  // d= outside diam
linear_extrude(th)
polygon([[0,0],[w,0],[w-d/slope,d],[d/slope,d]]);
}
//-----------------------------------------------------------------------
module assemble(){
union() {
translate([0,th,0])	main(depth,width,angle);
mirror([0,180,0]) main(depth,width,angle);
cube([width,th,depth]);
}
}



