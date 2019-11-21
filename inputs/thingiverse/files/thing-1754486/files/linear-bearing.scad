

// outer diameter in mm
outerD=15;

// inner diameter in mm
innerD=8.5;

// height in mm
height=24;

// amount of spikes
N = 12;

// width of shield in mm
shield = 1.3;

//resolution
res = 80;

/*[hidden]*/
d=outerD;
t=shield;
n=N;
id=innerD;
h=height;


$fn=res;

linear_extrude(height=h) 
difference() {
union() {
difference() {
circle(d=d);
circle(d=d-t*2);
}

a=360/n/2;

for (i=[1:1:n]) {


r=d/2-t/2;
rotate(a*2*(i-1))
polygon([[r,0],[0,0],[cos(a)*r,sin(a)*r]]);
}
}

circle(d=id);
}

