//Lobe Customizer

//Top Diameter in mm
t=60;  // [5:200]

//Middle Diameter
m=40; // [5:200]

//Base Diameter
b=60; // [5:200]

//Vase Height
h=100; // [5:200]

//How many layers should there be?
layers=150; // [5:200]

//How many degrees should each layer rotate?
r=1; // Best with small numbers

//How many lobes should be in each layer?
points = 3; // [3:20]

//Make a double spiral?
d="No"; // [Yes, No]

/*[Hidden]*/
$fa=2;

angle = 360/points;
layersq=layers*layers/4;

for (i=[0:layers]) {
	for (j=[1:points]) {
		rotate([0,0,r*i+angle*j]) translate([(b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m))/4,0,i/layers*h])  cylinder(h=h/layers*1.1, r=(b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m))/4,center=true);
		if (d=="Yes") {
		rotate([0,0,-(r*i+angle*j)]) translate([(b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m))/4,0,i/layers*h])  cylinder(h=h/layers*1.1, r=(b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m))/4,center=true);
		}
	}
}