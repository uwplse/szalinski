//custom rake

// diameter handle
d=30;
// thickness of handle holder
t=3;
// height of handle holder
h=10;

// number of teeth +1
n=2;
// radius of teeth
r=5;
//spacing of teeth
s=15;
//length of teeth
l=50;
// pointiness
p=20;


//calls

translate([12,-n/2*(2*r+s),0])rake();
handleholder();

module handleholder(){
difference(){
hull(){
translate([d*2/3+t*2,0,h/2])cube([d/2,n*(2*r+s)+2*r,h],center=true); //manifold
translate([0,0,h/2])cylinder(h,d/2+t,d/2+t,center=true,$fn=50);
		}
	translate([0,0,h/2])cylinder(h+1,d/2,d/2,center=true,$fn=50);
			}
				}
					


module rake(){
	for(i=[0:n]) {
hull(){
union(){
		translate([l/2+(d+t)/2,i*(s+2*r),r])rotate([0,90,0])cylinder(l,r,r,center=true,$fn=50);
		translate([l/2+(d+t)/2,i*(s+2*r),r/2])cube([l,r*2,r], center=true);
}
translate([p+l+(d+t)/2,i*(s+2*r),0.5])cube([1,1,1], center=true);
				}
	
			}
}


