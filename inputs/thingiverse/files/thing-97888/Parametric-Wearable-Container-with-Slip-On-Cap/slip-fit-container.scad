use <write/Write.scad>

/* [Text Options] */
// Text for Top
myIn = "2N2R5";
// Text Size
ts = 10 ;// [1:20]
// Text Extrusion (how far it sticks out)
th = 1.5 ;// [1,1.5,2]
// Text Font (orbitron prints best for me, but feel free to experiment) 
tf = "write/orbitron.dxf"; //[write/letters.dxf,write/BlackRose.dxf,write/braille.dxf,write/knewave.dxf,write/orbitron.dxf]

/* [Container Size and Shape] */

// The inside Diameter of the base.
id_width = 12.7 ;// [5:150]
// Height of cap 
microh = 37 ;// [10:100]
// Height of base (side without loop)
microhb = 86 ;// [10:150]
// Strap loop size (0 for none)
ring_size = 5 ;// [0:10]
// Loop Thickness
loop_wall = 2; // [1,2,3,4,5]
// Wall width 
walls = 2 ;// [.5,1,1.5,2,2.5,3,3.5,4,5,6,7,8,9,10]
// Number of sides (Wall counts >50 not recommended, It will take a long time to render)
fn2 = 50 ;// [3:100]
// Number of sides on inside of container (Wall counts >50 not recommended, It will take a long time to render)
fn1 = 50 ;// [3:100]


// Tolerences to make sure you have a tight fit for cap. I suggest you try it at this setting first then adjust as needed
tol=0.18 ;

/* [Hidden] */

id=id_width/2;




module geoMicroLid()
{
	difference()
	{
		union()
		{
			color("green")
			{
			hull(){
			translate([0,0,microh])
			sphere(r=id+(2*walls),convexity=10,$fn=fn2,center=true);		
		
			translate([0,0,microh/2])
			cylinder(r=id+(2*walls),h=microh,$fn=fn2,center=true);
			}
				difference()
				{
				translate([0,0,microh+id+(2*walls)])	
				rotate([90,0,0])
				cylinder(r=ring_size,h=id/4,center=true);
			
				translate([0,0,microh+id+(2*walls)])	
				rotate([90,0,0])
				cylinder(r=ring_size-loop_wall,h=id/4,center=true);
				}
			}
						
				
			
			
			writesphere(myIn,where=[0,0,microh/2],radius=id+2*walls,h=ts,t=th,font=tf,$fn=fn2,center=true);
		}
		
		union()
		{
			
			hull(){
			translate([0,0,microh])
			sphere(r=id+walls+tol,convexity=10,$fn=fn2,center=true);		
			
			translate([0,0,microh/2])	
			cylinder(r=id+walls+tol,h=microh,$fn=fn2,center=true);
			}

			
			translate([0,0,-2*id])	
			cube([id*4,id*4,id*4],center=true);
					
		}

	}

}
module geoMicroBase()
{
	difference()
	{
		union()
		{
			color("green")
			{
			hull(){
			translate([(3*id)+(2*walls),0,microhb])
			sphere(r=id+walls,convexity=50,$fn=fn2,center=true);		
		
			translate([(3*id)+(2*walls),0,microhb/2])
			cylinder(r=id+walls,h=microhb,$fn=fn2,center=true);
			}
						
				
			}
			
		}
		
		union()
		{
			color("blue")
			{
			hull(){
			translate([(3*id)+(2*walls),0,microhb])
			sphere(r=id+tol,convexity=50,$fn=fn1,center=true);		
			
			translate([(3*id)+(2*walls),0,microhb/2])	
			cylinder(r=id+tol,h=microhb,$fn=fn1,center=true);
			}
			color("red",.2)
			translate([(3*id)+(2*walls),0,-2*id])	
			cube([id*4,id*4,id*4],center=true);
			
			
			}		
		}

	}

}

//Print

{
geoMicroLid();
}
{
geoMicroBase();
}