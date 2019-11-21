width = 120; //Plate width
length = 60;	//Plate length
height = 3;	//Plate height
fillet = 2;	//Plate fillet radius
hole_radius = 1.55;
hole_spacing = 5;
//--------
module roundedRect(size, r) {
	x = size[0];
	y = size[1];
	z = size[2];
	linear_extrude(height = z){
		hull(){
   			translate([r, r, 0])
    			circle(r=r, $fn = 36);

   			translate([r, y-r, 0])
    			circle(r=r, $fn = 36);

   			translate([x-r, y-r, 0])
   		 		circle(r=r, $fn = 36);

   			translate([x-r, r, 0])
   				circle(r=r, $fn = 36);
		}
	}
}
module holes(w, h, d, hr, hs){
	union(){
		for(i = [1 : w / hs - 1]){
			for(j = [1 : h / hs - 1]){
				translate([i * hs, j * hs, -0.1])
					cylinder(r = hr, h = d + 0.2, $fn = 36);
			}
		}
	}
}
module plate(w, h, d, f, hr, hs){
	difference(){
		roundedRect([w, h, d], f);
		holes(w, h, d, hr, hs);
	}
}
plate(width, length, height, fillet, hole_radius, hole_spacing);