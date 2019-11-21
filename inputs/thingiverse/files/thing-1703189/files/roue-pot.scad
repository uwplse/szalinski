$fn=100;
hcyl=29.6;
dcylgros=24.6;
dcylpetit=22.8;
daxe=4.7;
haxe=5;
hplat=5;

module demi(){
	translate([0,0,0]) cylinder(d=dcylgros, h=hplat, center=false);
	translate([0,0,hplat]) cylinder(d1=dcylgros, d2=dcylpetit, h=hcyl/2-hplat, center=false);
    translate([0,0,hcyl/2-hplat-1+hplat]) cylinder(d=daxe, h=haxe+1, center=false);
}

module entier(){
demi();
mirror([0,0,1]) demi();
}

module entiersansaxe(){
 
difference(){    
translate([0,0,hcyl/2]) entier();
translate([0,0,-haxe-0.5]) cylinder(d=5, h=hcyl+2*haxe+1, center=false);   
}
}

translate([-dcylgros*1.5,0,hcyl/2+haxe]) entier(); // vertical

translate([dcylgros*1.5,0,dcylgros/2])  rotate([90,0,0]) entier(); // horizontal

entiersansaxe(); // sans axe pour mettre un tige M5

