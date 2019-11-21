// lamp shade by keiko
layerheight=0.2;
basethick=3*layerheight/10;
squaresize=100;
lampheight=200;
sliceheight=lampheight/layerheight;
twistangle=90;
hole=20;
convex=10;


module shade () {
difference() {
linear_extrude(height = lampheight, convexity = convex, slices = sliceheight, twist = twistangle)
translate([0, 0, 0])
square(squaresize, center=true);
    
    linear_extrude(height = lampheight, convexity = convex, slices = sliceheight, twist = twistangle)
translate([0, 0, 0])
square(squaresize-4, center=true);
}
difference() {
linear_extrude(height = lampheight*basethick, convexity = convex, slices = sliceheight*basethick, twist = twistangle*basethick)
//translate([0, 0, 0])
square(squaresize, center=true);

cylinder(r=hole,h=lampheight*basethick);
    
//side grill
    //squared intersection
//intersection() {
//    cube([squaresize-5,squaresize-5,2*lampheight/divider],center=true);
for(a=[0:15:360]) {
	rotate(a)
	translate([33,0,0])
	hull() {        
		cylinder(r=2,h=lampheight*basethick,$fn=12);
        translate([11,0,0])		
        cylinder(r=2.6,h=lampheight*basethick,$fn=12); 
        }
        

//          else
//             translate([abs(7*sin(a*2)),0,0]) ;
//            cube ([10,10,10]);


//	}
}
//}
}
// socket rim
//color(2);
//translate([0,0,-1])
//cylinder(r=29,h=4);
}


shade();
//translate([-200,0,0])
//shade();
//translate([200,0,0])
//shade(twistangle=-twistangle);