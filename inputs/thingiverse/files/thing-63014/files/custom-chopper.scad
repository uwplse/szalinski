// This is a customizable chopper wheel -- derived from
// Parametric encoder wheels http://www.thingiverse.com/thing:61434
// and the shaft lock from the less versatile Parametric open-source chopper wheel http://www.thingiverse.com/thing:28121


//Customizer Variables
//Number of interrupters
NUM_Int=40; // [2:120]
// Outer Radius
R_OUTER = 30;			

// Filled inner radius
R_INNER = 20;				

// Inner radius 2, phase shifted interrupters for direction detection
R_INNER2 = 9.5;			

//Mounting hole radius
R_HOLE = 4;			

// Filled Border Thickness
BORDER = 2;				

//Thickness of wheel
THICKNESS = 5;	   

// Thickness of the mouting hole outline
THICKNESS_MOUNT = 2; 

//Interrupter-width modifier, if =0 then interrupter is hole, if <0 then interrupter > hole and if >0 then interrupter < hole
INT_MODIFIER = -0.2;  // [-1:1] 

//Customizer variables end

//Non-customizer variables
z=R_HOLE; //The diameter of the motor shaft.
a=6; //m3 nut Diameter
b=3; //m3 nut thickness
c=3; //m3 screw diameter
NUM_SECTIONS = NUM_Int*2; //number of sections
R_MOUNT = 3;				/* mounting hole outline radius */
R_CROSS = 1.9;			/* center-cross for 2d encoders*/

shaft_lock();

module shaft_lock(){
difference(){
cylinder(15,(z*3)/2+3,(z*3)/2+3);
rotate([90,0,0])translate([0,10,4])hexagon(b,a/2);
translate([0,-5.5,15])cube([a,b,8],center=true);
translate([0,0,10])#rotate([90,0,0])cylinder(100,(c+1)/2,(c+1)/2);
cylinder(20,(z+1)/2,(z+1)/2);
}
}

module reg_polygon(sides,radius)
{
  function dia(r) = sqrt(pow(r*2,2)/2);  
  if(sides<2) square([radius,0]);
  if(sides==3) triangle(radius);
  if(sides==4) square([dia(radius),dia(radius)],center=true);
  if(sides>4) circle(r=radius,$fn=sides);
}

module hexagon_f(radius)
{
  reg_polygon(6,radius);
}

module hexagon(height,radius) 
{
  linear_extrude(height=height) hexagon_f(radius);
}



$fs = 0.01;

/* generates encoder contour */
module encoder_contour(n,rin,rout,mod){
	 for (i = [1:2:n])
    {
        assign (a1 = i*360/n, a2 = (i+1+mod)*360/n )
        {	
                polygon(points=[
						[cos(a2)*rin,sin(a2)*rin],
						[cos(a1)*rin,sin(a1)*rin],
						[cos(a1)*rout,sin(a1)*rout],
						[cos(a2)*rout,sin(a2)*rout] 
					]);
			}
    }	
}

/* use this to create a hole outline */
module hole2d(rhole,rcross){
	 circle(r = rhole);
	 polygon(points=[[0,0.1],[rcross,0],[0,-0.1],[-rcross,0] ] );
	 polygon(points=[[0.1,0],[0,rcross],[-0.1,0],[0,-rcross] ] );
}

module encoder3d(n,rin,rin2,rout,rhole,rmount,border,mod,t,tm) {
	echo();
	difference(){
		union(){
			cylinder(h=t,r=rout);
			cylinder(h=tm,r=rmount);			
		}
		linear_extrude(height=5*t,center=true) encoder_contour(n,rin,rin2,mod);
		rotate([0,0,360/(4*n)]) linear_extrude(height=5*t,center=true) encoder_contour(n,rin2-$fs,rout-border,mod);
		cylinder(h=5*tm,r=rhole,center=true);
	}
}

module encoder2d(rin,rout,rhole,rcross,mod) {
	hole2d(rhole,rcross);
	encoder_contour(rin,rout,mod);
}


encoder3d(NUM_SECTIONS,R_INNER,R_INNER2,R_OUTER,R_HOLE,R_MOUNT,BORDER,INT_MODIFIER,THICKNESS,THICKNESS_MOUNT);
//encoder2d(NUM_SECTIONS,R_INNER,R_OUTER,R_HOLE,R_CROSS,INT_MODIFIER);