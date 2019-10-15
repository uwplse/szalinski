//A logarthmic Spiral has the form r=a*exp(b*theta);

loops=3;
$fn=20; //resolution
steps_per_loop=$fn;
wallThickness = 0.5;
height = 10;

a=0.4;
b=0.2;
incrementBy = 1;

for(i=[0:incrementBy:loops*steps_per_loop]){
hull(){
translate([r(rad(i))*cos(deg(i+0.5)),r(rad(i))*sin(deg(i+0.5)),0])
cylinder(r=wallThickness,height);

translate([r(rad(i+incrementBy))*cos(deg(i+incrementBy+0.5)),r(rad(i+1))*sin(deg(i+incrementBy+0.5)),0])
cylinder(r=wallThickness,height); 
}
}

////////////////// Functions //////////////////////////
function deg(n)=360*n/steps_per_loop;
function rad(n)=2*PI*n/steps_per_loop;
function arc_length(n)= //The length of a line segment = sqrt( (y2-y1)^2 + (x2-x1)^2 )
		sqrt(
			pow(
				r(rad(n+1))*sin(deg(n+1)) -
				r(rad(n))*sin(deg(n))
				,2) 
			+
			pow(
				r(rad(n+1))*cos(deg(n+1)) -
				r(rad(n))*cos(deg(n))
				,2)
			);
function r(th)=a*exp(b*th);
function d(i) =r(rad(i))/3;	