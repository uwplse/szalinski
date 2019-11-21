$fn=500;
base="on"; //[off,on]
cradle="flat"; //[off,flat,slanted_30, slanted_90,all]
caps="on"; //[off,on]
cup="on"; //[on,off]
cup_style="tall"; //[short,tall]
disk="off"; //[on,off]

module Base(){
//base cylinder
	difference (){
		cylinder (d=215,h=2);
		//cylinder (d=65,h=2);
	}

//side squares

difference(){
		translate ([-104,-25,0]) cube ([2,50,125]);
		rotate ([90,90,90]) translate ([-65,26.5,-105]) scale ([ 6,1.8,2]) cylinder (r=7, h=2);
		rotate ([90,90,90]) translate ([-65,-26.5,-105]) scale ([ 6,1.8,2]) cylinder (r=7, h=2);
		rotate ([90,0,90]) translate ([0,125,-105]) cylinder (r=3.25, h=5);   
	}
	rotate ([90,90,90]) translate ([-65,15,-104]) scale ([ 10,1.8,2]) cylinder (r=2, h=1);
	rotate ([90,90,90]) translate ([-65,-15,-104]) scale ([ 10,1.8,2]) cylinder (r=2, h=1);
difference(){
		translate ([102.5,-25,0]) cube ([2,50,125]);
		rotate ([90,90,90]) translate ([-65,26.5,101.5]) scale ([ 6,1.8,2]) cylinder (r=7., h=2);
		rotate ([90,90,90]) translate ([-65,-26.5,101.5]) scale ([ 6,1.8,2]) cylinder (r=7., h=2);
		//rotate ([90,90,90]) translate ([-30,0,102.5]) scale ([ 4,1.8,2]) cylinder (r=5, h=1);
		rotate ([90,0,90]) translate ([0,125,102]) cylinder (r=3.25, h=4);
	}
	rotate ([90,90,90]) translate ([-65,15,102.5]) scale ([ 10,1.8,2]) cylinder (r=2, h=1);
	rotate ([90,90,90]) translate ([-65,-15,102.5]) scale ([ 10,1.8,2]) cylinder (r=2, h=1);

//side rounds
	//left
	difference(){
		rotate ([90,0,90]) translate ([0,125,-104]) 
		scale ([ 4,1.8,2]) cylinder (r=6.25, h=1);
		rotate ([90,0,90]) translate ([0,125,-105]) cylinder (r=3.25, h=4);
	}
	//right
	difference(){
		rotate ([90,0,90]) translate ([0,125,102.5]) scale ([ 4,1.8,2]) cylinder (r=6.25, h=1);
		rotate ([90,0,90]) translate ([0,125,102]) cylinder (r=3.25, h=4);
	}

//Cup holder
	difference(){
		translate ([0,-0,0]) cylinder (r=20,h=8);
		translate ([0,-0,0]) cylinder (r=19,h=8.1);
	}

//supports
	translate ([99,-7,0]) cube ([5,14,85]);
	translate ([-103,-7,0]) cube ([5,14,85]);
	difference (){
		translate ([99,0,0]) cylinder (d=14,h=85);
		translate ([100,-7,0]) cube ([6,14,90]);
	}
	difference (){
		translate ([-99,0,0]) cylinder (d=14,h=85);
		translate ([-107,-7,0]) cube ([6,14,90]);
	}

//catch ring
	difference(){
			cylinder (d=215,h=14);
			cylinder (d=212.5,h=15);
	}
}

module cradle(){//mounting swing
	translate ([-102,-17.5,0]) cube ([204,35,4.5]);
	translate ([-102,-17.5,0]) cube ([2,35,22]);
    translate ([-102,0,7.5]) cube ([2,25.3,10]);
    translate ([-105,25.3,7.5]) cube ([5,3,10]);
	rotate ([90,0,90]) translate ([0,25,-102]) scale ([ 4,1.8,2]) cylinder (r=6.25, h=1);
	rotate ([90,0,90]) translate ([0,25,-109]) cylinder (r=2.55, h=9);
	translate ([102,-17.5,0]) cube ([2,35,22]);
    translate ([102,0,7.5]) cube ([2,25.3,10]);
    translate ([102,25.3,7.5]) cube ([5,3,10]);
	rotate ([90,0,90]) translate ([0,25,102]) scale ([ 4,1.8,2]) cylinder (r=6.25, h=1);
	rotate ([90,0,90]) translate ([0,25,102]) cylinder (r=2.55, h=9);
    cylinder (d=170,h=4.5);
}
//handle
    
	//finger ring
	module rounded(){
		translate([0,0,0]){
		rotate_extrude(convexity = 10, $fn = 100)
		translate([17, 0, 0])
		circle(r = 2, $fn = 100);
	}
}
 
module cradle(){//mounting swing
	translate ([-102,-17.5,0]) cube ([204,35,4.5]);
	translate ([-102,-17.5,0]) cube ([2,35,22]);
    translate ([-102,0,7.5]) cube ([2,25.3,10]);
    translate ([-105,25.3,7.5]) cube ([5,3,10]);
	rotate ([90,0,90]) translate ([0,25,-102]) scale ([ 4,1.8,2]) cylinder (r=6.25, h=1);
	rotate ([90,0,90]) translate ([0,25,-109]) cylinder (r=2.55, h=9);
	translate ([102,-17.5,0]) cube ([2,35,22]);
    translate ([102,0,7.5]) cube ([2,25.3,10]);
    translate ([102,25.3,7.5]) cube ([5,3,10]);
	rotate ([90,0,90]) translate ([0,25,102]) scale ([ 4,1.8,2]) cylinder (r=6.25, h=1);
	rotate ([90,0,90]) translate ([0,25,102]) cylinder (r=2.55, h=9);
    cylinder (d=170,h=4.5);
}
//handle
    
	//finger ring
	module rounded(){
		translate([0,0,0]){
		rotate_extrude(convexity = 10, $fn = 100)
		translate([17, 0, 0])
		circle(r = 2, $fn = 100);
	}
}
module Cradle(){
difference (){
    cradle();
    translate ([0,0,-.05]) cylinder (d=120,h=3.6);
    translate ([0,0,0]) cylinder (d1=120,d2=160,h=4.6);
}

	difference(){
		translate ([102,-10,35]) cube ([2,20,27]);
		rotate ([90,0,90]) translate ([0,70,101.5]) cylinder (r=15, h=3);
    }
	rotate ([90,0,90]) translate ([0,71,103]) rounded ();

}
module Cap (){
    difference (){
		translate ([10,0,0]) cylinder (r1=6.25,r2=3,h=5);
		translate ([10,0,-1]) cylinder (r=2.9, h=4.5); 
	}
}
module Cup(){
     //Base bowl
	difference(){
		cylinder (r1=30,r2=40,h=12);
		translate ([0,0,6]) cylinder (r1=32,r2=40,h=7);
		translate ([0,0,1]) cylinder (r1=14,r2=17,h=12);
		translate ([0,0,-1,]) cylinder (r=21,h=6);
    }
if (cup_style=="tall") {
    difference (){
        translate ([0,0,11.5]) cylinder (r1=40, r2=43, h=12);
		translate ([0,0,11]) cylinder (r1=38, r2=41, h=13.5);
		}
	}
	difference (){
		cylinder (r=18,h=6);
		translate ([0,0,1]) cylinder (r1=14,r2=17,h=12);
	}
}

module Disk(){
    // r[adius], h[eight], [rou]n[d]
module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}

rounded_cylinder(r=101.5,h=38,n=18.5,$fn=200);
}


  
//done with modules  
   //buildit
   
//base
if (base=="on") translate ([0,0,0]) Base();
    
//cradle
if (cradle=="flat") {translate ([-.75,0,100.25]) Cradle();
    if (disk=="on") translate ([0,0,103]) Disk();
}
//rotated cradle 30 degrees
if (cradle=="slanted_30"){ rotate ([30,0,0])translate ([0,62.75,83.25]) Cradle();
    //if (disk=="on") rotate ([30,0,0]) translate ([0,65,85]) cylinder (d=200,h=20);
    if (disk=="on") rotate ([30,0,0]) translate ([0,65,85]) Disk();
}
//rotated cradle 90 degrees
if (cradle=="slanted_90") {rotate ([90,0,0])translate ([0,125,-25]) Cradle();
    if (disk=="on") rotate ([90,0,0]) translate ([0,127,-23]) Disk();
}

//all
if (cradle=="all") {
    //flat
    translate ([0,0,100.25]) Cradle();
    //rotated cradle
    rotate ([30,0,0])translate ([0,62.75,83.25]) Cradle();
    // 90 degree
    rotate ([90,0,0])translate ([0,125,-25]) Cradle();
}

//caps
if (caps=="on"){
    rotate ([0,90,0]) translate ([-135.5,0,106.5]) Cap();
    rotate ([0,90,180]) translate ([-135.5,0,105.5]) Cap();
}
//cup
if (cup=="on"){
    translate ([ 0,0,2]) Cup();
}

