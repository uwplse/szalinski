//Height of the ant trap:
height = 8;

//Width of the ant trap:
diameter = 67;

//How wide should the lip be?
lip_width = 5;

//How much material under the lowest point of the dish?
min_bottom = 2;

//How much wider is the base than the top of the dish?
base_enlargement = 10;

difference(){

//base of trap:
translate([0,0, height/2]) 
	cylinder(h = height, r1 = diameter/2, r2 = diameter/2-base_enlargement, center = true);

//Poison well:
translate([0,0, height])
	resize(newsize = [diameter-((lip_width+base_enlargement)*2), diameter-((lip_width+base_enlargement)*2), (height*2)-(min_bottom * 2)]) 
		sphere(r=10, center=true);

}