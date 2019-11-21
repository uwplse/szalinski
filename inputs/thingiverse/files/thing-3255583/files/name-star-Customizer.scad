
include <write/Write.scad>

Text = "Claudia";
Text_Height=12;//[1:60]
n_points = 124;
// radius of the  star
radius=50;
// Random Seed
seed = 44;//[10:70]
Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/BlackRose.dxf":BlackRose,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille,"write/knewave.dxf":knewave]
thickness=2;
Hole_Di=3;
border=5;
Text_depth=1;
test_pos=8;
function normalize(v) = v/(sqrt(v[0]*v[0] + v[1]*v[1]));

module voronoi(points, L=200, thickness=1, round=6, nuclei=true){
	for (p=points){
		difference(){
			minkowski(){
			intersection_for(p1=points){
				if (p!=p1){
					translate((p+p1)/2 - normalize(p1-p) * (thickness+round))
					assign(angle=90+atan2(p[1]-p1[1], p[0]-p1[0])){
						rotate([0,0,angle])
						translate([-L,-L])
						square([2*L, L]);
					}
				}
			}
			circle(r=round, $fn=20);
			}
			if (nuclei)
			translate(p) circle(r=1, $fn=20);
		}
	}
}


module random_voronoi(n=20, nuclei=true, L=200, thickness=1, round=6, min=0, max=100, seed=42){

	x = rands(min, max, n, seed);
	y = rands(min, max, n, seed+1);

	for (i=[0:n-1]){
		difference(){
			minkowski(){
			intersection_for(j=[0:n-1]){
				if (i!=j){
					assign(p=[x[i],y[i]], p1=[x[j],y[j]]){
						translate((p+p1)/2 - normalize(p1-p) * (thickness+round))
						assign(angle=90+atan2(p[1]-p1[1], p[0]-p1[0])){
							rotate([0,0,angle])
							translate([-L,-L])
							square([2*L, L]);
						}
					}
				}
			}
			//circle(r=round, $fn=20);
			}
			if (nuclei)
			translate([x[i],y[i]]) circle(r=1, $fn=20);
		}
	}
}


module parametric_star(N=5, h=2, ri=15, re=30) {

  //-- Calculate and draw a 2D tip of the star
 //-- INPUT: 
 //-- n: Number of the tip (from 0 to N-1)
  module tipstar(n) {
     i1 =  [ri*cos(-360*n/N+360/(N*2)), ri*sin(-360*n/N+360/(N*2))];
    e1 = [re*cos(-360*n/N), re*sin(-360*n/N)];
    i2 = [ri*cos(-360*(n+1)/N+360/(N*2)), ri*sin(-360*(n+1)/N+360/(N*2))];
    polygon([ i1, e1, i2]);
  }

  //-- Draw the 2D star and extrude
  
   //-- The star is the union of N 2D tips. 
   //-- A inner cylinder is also needed for filling
   //-- A flat (2D) star is built. The it is extruded
    linear_extrude(height=h) 
    union() {
      for (i=[0:N-1]) {
         tipstar(i);
      }
      rotate([0,0,360/(2*N)]) circle(r=ri+ri*0.01,$fn=N);
    }
}


module star(N=5, thick=2,re=40,hd=2){
  difference(){  
parametric_star(N=5,h=thick, ri=re/2.62,re=re);
      translate([re,0,0]) cylinder(thick,hd,hd,f=100,$fn=100);
  }
}




module staroutline(N=5, thick=2,  re=40, border=5,hd=2){//difference(){
difference(){
    union(){
   translate([re,0,0]) cylinder(thick,hd+2,hd+2,$fn=100);
   parametric_star(N=5,h=thick, ri=re/2.62,re=re);
   rotate(a=[0,0,(360/5)*1])translate([re-1,0,0]) cylinder(thick,hd,hd,$fn=100);
        rotate(a=[0,0,(360/5)*1])translate([re-1,0,0]) cylinder(thick,hd,hd,$fn=100);
        rotate(a=[0,0,(360/5)*2])translate([re-1,0,0]) cylinder(thick,hd,hd,$fn=100);
        rotate(a=[0,0,(360/5)*3])translate([re-1,0,0]) cylinder(thick,hd,hd,$fn=100);
        rotate(a=[0,0,(360/5)*4])translate([re-1,0,0]) cylinder(thick,hd,hd,$fn=100);
   }

 parametric_star(N=5,h=thick, ri=(re-border)/2.62,re=re-border); 
   translate([re,0,0]) cylinder(thick,hd,hd,$fn=100);
   
}
}



rotate(a=[0,0,135])
union(){
staroutline(thick=thickness,re=radius,hd=Hole_Di,border=border);
    translate([test_pos,0,(Text_depth+thickness)/2])rotate([180,180,90])write(Text,h=Text_Height,t=thickness+Text_depth, font = Font,center=true);
difference() {
  star(thick=thickness,re=radius,hd=Hole_Di);
translate([-100,-100,0])
        linear_extrude(thickness+2)
          random_voronoi(n=n_points, round=3, min=0, max=200, nuclei=false, seed=seed);
      // Camera
      
    }
  

}