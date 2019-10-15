//Constants
stuffz = 2/1;
fuzz = 0.2/1+.5;
real_card_length = 34.95/1;
real_card_width = 32.75/1;
real_card_thick = 3.8/1;
card_length = real_card_length + fuzz;
card_width = real_card_width + fuzz;
card_thick = real_card_thick + fuzz;

//DS Box
number_of_cards = 11; //[1:20]
box_height_addition = 15; //[10: 32]
gutter_height = 2; //[1:5]
gutter_width = 3; //[1:5]
card_spacing = 10; //[2:10]
card_spacing_ends = 2.5;
$fn = 20;
cube_r = 3; //[1 : 5]

box(number_of_cards);

//----------------------------

module card()
{
  cube([card_width,card_thick,card_length]);
}

module box(number)
{
  	box_x = card_width + stuffz*2;
  	box_y = 2*card_spacing_ends - card_spacing + (card_thick + card_spacing) * number;
  	box_z = gutter_height+ stuffz + box_height_addition;
  	card_x_trans = box_x / 2 - card_width /2;
 
	cutout=0.80/1;
 	//%cube([box_x, box_y, box_z]);

  	difference()
	{
    	roundCornerCube(box_x,box_y,box_z,cube_r);

		//hollow out
		translate([card_x_trans+card_width*(1-cutout)/2, card_spacing_ends,gutter_height+stuffz]) 
			cube([card_width*cutout, (card_thick + card_spacing) * number , box_z]);

    	//gutter
    	translate([(box_x/2) - (gutter_width/2),-fuzz,-fuzz]) 
			cube([gutter_width, box_y + (fuzz*2),gutter_height+fuzz]);

    	//cards
    	for (i = [0 : number-1])
		{
      		translate([card_x_trans, card_spacing_ends + (card_thick + card_spacing)*i,gutter_height+stuffz]) 
				rotate([0,0,0]) card();
    	}

  	}
}

module roundCornerCube(x,y,z,r_sphere)
{
r = r_sphere;
if (x < r) {echo ("roundCornerCube: error: x < r !!");}
if (y < r) {echo ("roundCornerCube: error: y < r !!");}
if (z < r) {echo ("roundCornerCube: error: z < r !!");}
	hull(){
		translate([r,y-r,z-r]) sphere(r_sphere); //1!
		translate([x-r,y-r,z-r]) sphere(r_sphere); //2
		translate([r,r,z-r]) sphere(r_sphere); //3
		translate([x-r,r,z-r]) sphere(r_sphere); //4
		translate([r,y-r,r]) sphere(r_sphere); //5!
		translate([x-r,y-r,r]) sphere(r_sphere); //6		
		translate([r,r,r]) sphere(r_sphere); //7
		translate([x-r,r,r]) sphere(r_sphere); //8
	}
}