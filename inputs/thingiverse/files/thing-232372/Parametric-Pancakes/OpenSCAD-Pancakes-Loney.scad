//KevanLoney
//www.KevanLoney.com
//2014

difference(){

union() {

	color("GhostWhite")
	cylinder (h = .2, r= 1.8, center = true, $fn=100);
	color("GhostWhite")
	translate (0, 1.2, 0) cylinder (h = .1, r = 2, $fn=100);

}

color("LightGrey")
translate (0, 1.5, 0) cylinder (h = .3, r = 1.7,$fn=100);
}



pancake(height= .1, width =.2);

butter();
translate ([.2, 0, .6])
syrup();
//translate ([.9, 0, -1.15])
//scale([2, -1.5, 1])
//syrup();

module batter() {
	minkowski(){
	cylinder(h = .1, r = 1, $fn=100);
    sphere( r =.1,  $fn=10);
}
}

module pancake(height, width){
	color("Sienna")
	translate ([0, 0, height]) batter();
	color("Sienna")
	translate ([width, 0, height*3.7]) batter();
	color("Sienna")
	translate ([0, 0, height*6.5]) batter();
	color("Peru")
	translate ([width-.5, 0, height*9.5]) batter();
	color("Sienna")
	translate ([width-.5, 0, height*12.5]) batter();
	color("Peru")
	translate ([width-.5, 0, height*15.5]) batter();

}

module butter(){
intersection(){
	translate([-.5,-.5,1.7])
	scale([.6,.5, .1])
     cube([.5]);
}
}

module syrup(){
	color("SaddleBrown")
	scale([.5,.5,1])
	translate([-1,-.8,0])
	hull() {
   	translate([1,0,1.15]) cylinder(r= .6, h = .03,$fn=100);
   	translate([1,1.5,1.15]) cylinder(r= .2, h = .03,$fn=100);
	translate([-1,1,1.15]) cylinder(r= .5, h = .03,$fn=100);
	translate([0,1,1.15]) cylinder(r= .8, h = .03,$fn=100);
	translate([0,2,1.15]) cylinder(r= .8, h = .03,$fn=100);
 }
}
