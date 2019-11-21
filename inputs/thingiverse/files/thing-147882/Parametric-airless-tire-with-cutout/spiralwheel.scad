/*   	Parametric airless tire
		by Travis Howse <tjhowse@gmail.com>
		2012.   License, GPL v2 or later
**************************************************/
// Customizer begin

/* [Size and thickness] */
dia_in = 8;
dia_out = 70;
spoke_count = 15;
spoke_thickness = 1;
tread_thickness = 2;
hub_thickness = 4;
height = 10;

/* [Cutout] */
cutout_height=6;
//0: Off, 1: Spheric, 2: Exponential, 3: cylindric
cutout_type=2; 
//Controls steepness of exponential cutout (only active with cutout_type=2)
exponential_parameter = 3;

/* [Grip] */
// Set to 0 for no grip.
grip_density = 0.05;
grip_height = 1;
grip_depth = 1;

/* [Extra] */
$fn = 50;
// Set to 1 for a double spiral. Note: single-wall spokes probably won't work with double spirals, as the first layer of the upper spiral would bridge in a straight line, rather than a curve. Successive layers probably wouldn't recover.
double_spiral = 0; 

/* [Hidden] */
spoke_dia = (dia_in/2) + hub_thickness + (dia_out/2) - tread_thickness+spoke_thickness;
pi = 3.14159;
zff = 0.001;

r1=dia_in/2+hub_thickness;
r2=dia_out/2-tread_thickness;
a=2*r2;
h2=cutout_height;
b=sqrt(h2*h2+pow(r2-r1,2));
c=sqrt(h2*h2+pow(r2+r1,2));
alpha=acos((b*b+c*c-a*a)/(2*b*c));
sphereradius=a/(2*sin(alpha));
spherecenter=height-cutout_height+sqrt(pow(sphereradius,2)-r1*r1);

w=exponential_parameter*r2/(r2-r1)*(log(cutout_height/0.1));
//Customizer end

module wheel()
{
	difference()
	{
		cylinder(r=dia_out/2,h=height);
		cylinder(r=(dia_out/2)-tread_thickness,h=height);	
	}

	difference()
	{
		cylinder(r=(dia_in/2)+hub_thickness,h=height);
		cylinder(r=dia_in/2,h=height);	
	}

	for (i = [0:spoke_count-1])
	{
		if (double_spiral)
		{
			rotate([0,0,i * (360/spoke_count)]) translate([(spoke_dia/2)-(dia_in/2)-hub_thickness,0,(height/2)+zff]) spoke();
			rotate([180,0,i * (360/spoke_count)]) translate([(spoke_dia/2)-(dia_in/2)-hub_thickness,0,-height/2]) spoke();			
		} else {
			rotate([0,0,i * (360/spoke_count)]) translate([(spoke_dia/2)-(dia_in/2)-hub_thickness,0,0]) spoke();
		}
	}
	
	if (grip_density != 0)
	{
		for (i = [0:(360*grip_density)])
		{
			rotate([0,0,i*(360/(360*grip_density))]) translate([dia_out/2-grip_height/2,0,0]) cube([grip_height,grip_depth,height]);
		}
	}
}

module spoke()
{
	intersection()
	{
		difference()
		{
			cylinder(r=spoke_dia/2,h=height);
			cylinder(r=(spoke_dia/2)-spoke_thickness,h=height);	
		}
		if (double_spiral)
		{
			translate([-spoke_dia/2,-spoke_dia,0]) cube([spoke_dia,spoke_dia,height/2]);
		} else {
			translate([-spoke_dia/2,-spoke_dia,0]) cube([spoke_dia,spoke_dia,height]);
		}
	}
}

if(cutout_height>height){
	echo ("Cutout must be smaller than height!");
}else{
	if(cutout_type==0){
		wheel();
	}else{
		difference(){
			wheel();
			difference(){
				if(cutout_type==1){
					translate([0,0,spherecenter]){
					sphere(r=sphereradius);
					}
				}else{
					if (cutout_type==2) {
					
						rotate_extrude()
						union(){
							for(i=[0:($fn-1)]){
								polygon(points=[ [r2*(1-i/$fn) , height-cutout_height*(1-exp(-w*i/$fn))] , [r2*(1-(i+1)/$fn) ,  height-cutout_height*(1-exp(-w*(i+1)/$fn)) ] , [r2*(1-(i+1)/$fn) , height] , [r2*(1-i/$fn) , height] ],paths=[[0,1,2,3]]);
							}
						}
					}else{
						if (cutout_type==3){
							translate([0,0,height-cutout_height])
								cylinder(r=r2,h=cutout_height);
						}
					}
				}
					cylinder(r=r1,h=(height-cutout_height));
			}
		}
	}
}