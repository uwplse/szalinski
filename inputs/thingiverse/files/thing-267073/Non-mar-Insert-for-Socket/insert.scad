//size of nut to fit in 16ths
inside16=8;
//size of socket to fit in 16ths
outside16=10;
//%shrink to allow for on inside(nut)
shrinkinside=2;
//%shrink to allow for on outside(socket) 
shrinkoutside=1.75;
heightmultiplier=1;

inside=inside16/16*25.4*(1+shrinkinside/100);
outside=outside16/16*25.4*(1+shrinkoutside/100);
th=inside*heightmultiplier;

	difference(){
		union(){
			translate([0,0,th/2])hexagon(outside,th);
			cylinder(h=2,r=(outside+4)/2);
			}
		translate([0,0,th/2-1])hexagon(inside,th+2);
		cylinder(h=1,r2=inside/2,r1=inside/2+1);
		}

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}
