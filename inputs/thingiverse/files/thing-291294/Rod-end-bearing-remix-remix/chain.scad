//thing 290371 remix redux, more parametric less pedantic
/* [Options] */
//housing diameter
base=12;
//hole diameter in ball
rod=8.5;
//hole diameter in shaft 
shaft=8.5;
//space between housing and ball
gap=.4;
//shaft length
len=24;
//smoothing
$fn=96;
render(){
	knuckle();
	difference(){
		housing();
		sphere(r=base);
	}
	difference(){
		shaft();
		housing();
	}
}
module knuckle(){
	difference(){
		ball();
		cylinder(r=rod/2,h=base,center=true);
	}
}
module housing(){
	cylinder(h=base,r=base*1.25,center=true);
}
module ball(){
	intersection(){
		sphere(r=base-gap);
		cylinder(r=base,h=base,center=true);
	}
}
module shaft(){
	translate([len/2+base,0,0]){
		difference(){
			cube([len,base,base],center=true);
			rotate([0,90,0])cylinder(r=shaft/2,h=len*2,center=true);
		}
	}
}