// New caterpillar chain wheel
// Inspiraded in Caterpillator by Olalla Bravo Conde
// Daniel Gomez Lendinez
// 2011
radius=45;//[30:50]
width=7;//[5:15]
resolution=50;//[16:128]
bore_hole=3.5;//[1:5]
height=6;//[2:10]
module star_wheel (radio, width, quality, drill, edge)
{


difference () {

cylinder (r=radio, h=width, $fn=quality);

	for ( i = [0:edge-1] ) { 
	rotate( i*360/edge, [0, 0, 1]) translate( [0, radio*2-radio/4.5, 0] ) cylinder (r=radio, h=width*2,$fn=quality);

	rotate( i*360/edge, [0, 0, 1]) translate( [radio/5.5, radio*1.075, -1] ) 
cylinder (r=radio/3, h=width*2,$fn=quality);
	rotate( i*360/edge, [0, 0, 1]) translate( [-radio/5.5, radio*1.075, -1] ) 
cylinder (r=radio/3, h=width*2,$fn=quality);
	}

			for (i=[0:3])
		{
			translate([0.75*(radio-5)*cos(360/4*i),0.75*(radio-5)*sin(360/4*i),0])
cylinder(r=drill/2,h=2*width,$fn=100,center=true);
		}
}


}

difference (){

star_wheel (radius, width, resolution, bore_hole, height);

	translate([0,0,2])union(){
// -- Carved cicle for the Futaba plate
  translate([0,0,10]) cylinder(r=21.5/2, center=true,h=20,$fn=100);

    //-- Carved circle por the Futaba shart
  cylinder(center=true, h=30, r=4.2,$fn=100);
}
}