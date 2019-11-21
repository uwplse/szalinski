//Top Diameter in mm
t=70;  // [5:200]

//Middle Diameter
m=50; // [5:200]

//Base Diameter
b=40; // [5:200]

//Vase Height
h=80; // [5:200]

//How many layers should there be?
layers=100; // [5:800]

//How many degrees should each layer rotate?
r=1; // Best with small numbers

//How many squares should be in each layer?
points = 1; // [1:20]

//Make a double spiral?
d="No"; // [Yes, No]

//Force Hollow?
hollow="Vase"; // [No, Vase, Bracelet]

angle = 90/points;
layersq=layers*layers/4;
b2=b-4;
m2=m-4;
t2=t-4;

for (i=[0:layers]) {
	if (hollow=="No") {
		for (j=[1:points]) {
			translate([0,0,i/layers*h]) rotate([0,0,r*i+angle*j]) cube([b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),h/layers*1.1],center=true);
			if (d=="Yes") {
				translate([0,0,i/layers*h]) rotate([0,0,-(r*i+angle*j)]) cube([b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),h/layers*1.1],center=true);
			}
		}
	} if (hollow=="Bracelet") {
		difference() {
		union() {
			for (j=[1:points]) {
				translate([0,0,i/layers*h]) rotate([0,0,r*i+angle*j]) cube([b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),h/layers*1.1],center=true);
				if (d=="Yes") {
					translate([0,0,i/layers*h]) rotate([0,0,-(r*i+angle*j)]) cube([b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),h/layers*1.1],center=true);
				}
			}
		}
			for (j=[1:points]) {
				translate([0,0,i/layers*h]) rotate([0,0,r*i+angle*j]) cube([b2+i/layers*(t2-b2)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b2+t2)/2-m2),b2+i/layers*(t2-b2)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b2+t2)/2-m2),h/layers*1.3],center=true);
				if (d=="Yes") {
					translate([0,0,i/layers*h]) rotate([0,0,-(r*i+angle*j)]) cube([b2+i/layers*(t2-b2)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b2+t2)/2-m2),b2+i/layers*(t2-b2)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b2+t2)/2-m2),h/layers*1.3],center=true);
				}
			}
		}
	} if (hollow=="Vase") {
		difference() {
		union() {
			for (j=[1:points]) {
				translate([0,0,i/layers*h]) rotate([0,0,r*i+angle*j]) cube([b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),h/layers*1.1],center=true);
				if (d=="Yes") {
					translate([0,0,i/layers*h]) rotate([0,0,-(r*i+angle*j)]) cube([b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),b+i/layers*(t-b)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b+t)/2-m),h/layers*1.1],center=true);}
			}
		} if (i/layers*h > 2) {
				for (j=[1:points]) {
					translate([0,0,i/layers*h]) rotate([0,0,r*i+angle*j]) cube([b2+i/layers*(t2-b2)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b2+t2)/2-m2),b2+i/layers*(t2-b2)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b2+t2)/2-m2),h/layers*1.2],center=true);
					if (d=="Yes") {
						translate([0,0,i/layers*h]) rotate([0,0,-(r*i+angle*j)]) cube([b2+i/layers*(t2-b2)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b2+t2)/2-m2),b2+i/layers*(t2-b2)+((i-layers/2)*(i-layers/2)-layersq)/layersq*((b2+t2)/2-m2),h/layers*1.2],center=true);
					}
				}
			}
		}
	}
}