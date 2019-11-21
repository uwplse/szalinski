$fn = 50;
difference() { 
cube (size = [39, 40, 25]);
translate ([3, 4, 10]) cube (size = [36, 40, 15]);


translate ([8, 5, 15]) rotate (a = [90, 0, 0]) cylinder (h = 6, r = 2);
translate ([8, 5, 15]) rotate (a = [90, 0, 0]) cylinder (h = 2, r = 3);
translate ([28, 5, 15]) rotate (a = [90, 0, 0]) cylinder (h = 6, r = 2);
translate ([28, 5, 15]) rotate (a = [90, 0, 0]) cylinder (h = 2, r = 3);


translate ([30, 14, 0]) cylinder (h = 15, r1 = 6, r2 = 7);
translate ([12, 14, 0]) cylinder (h = 15, r1 = 6, r2 = 7);


translate ([10, 24, 0]) cube (size = [20, 12, 15]);


rotate (a = [0, 90, 0]) 
linear_extrude(5,center = false,2,twist = 0,slices = 20){
		polygon([[-25,40],[-10,40],[-25,4]]);}
		

translate ([39, 40, 0]) rotate (a = [0, 0, 45]) cube (size = [6, 6, 25], center = true);
translate ([39, 0, 25]) rotate (a = [90, 45, 0]) cube (size = [6, 6, 10], center = true);
}

translate ([10, 40, 0]) rotate (a = [90, 0, 0]) 
linear_extrude(20,center = false,2,twist = 0,slices = 20){
		polygon([[10,10],[13,0],[7,0]]);}
