// Box inner dimensions
width     =  42;
length    = 128;
heigth    =  25;
wallthick =   1.5;
basethick =   2;

//resolution
$fn=50;

//base
cube([width+2*wallthick,length+2*wallthick,basethick]);

//walls
difference (){
	cube([width+2*wallthick,wallthick,heigth+basethick]);
	translate ([width/2+wallthick,-0.1,heigth+basethick])
	rotate([-90,0,0])
		cylinder(wallthick+0.2,width/4,width/4);
}
cube([wallthick,length+2*wallthick,heigth+basethick]);

translate([0,length+wallthick,0])
	cube([width+2*wallthick,wallthick,heigth+basethick]);

translate([width+wallthick,0,0])
	cube([wallthick,length+2*wallthick,heigth+basethick]);



