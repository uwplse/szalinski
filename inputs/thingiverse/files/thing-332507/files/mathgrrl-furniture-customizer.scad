// mathgrrl parametrizable furniture
// CODE FOR THINGIVERSE CUSTOMIZER

////////////////////////////////////////////////////////////////////////////

/* [Units and Scaling] */

// Choose the type of units that you will use to measure your actual room and objects.
units = 25.4; // [25.4:Inches,304.8:Feet,10:Centimeters,1000:Meters]

// Choose the scale of your models. For example "50" means 1:50 scale, with models whose linear dimensions are 1/50th of their actual size.
scale = 50;  

// Invisible parameters
$fn = 1*12; 	// facets
s = units/scale;	// scaling factor 
soft = 3*s;	// radius for soft bevels depends on scale
sharp = 1*.2; 	// radius for sharper edges

////////////////////////////////////////////////////////////////////////////

/* [Furniture Type] */

//Choose a type of custom or stock furniture from ONE of the four menus below. Enter your custom dimensions on the next tab. Stock models come with their own dimensions.
custom_furniture = 0; //	[0:None,1:Bookcase in my dimensions,2:Table in my dimensions,3:Desk in my dimensions,4:Corner Desk in my dimensions,5:Chair in my dimensions,6:Stool in my dimensions,7:Sofa in my dimensions,8:Sofa Bed in my dimensions,9:Ottoman in my dimensions,10:Bed in my dimensions,11:Bed Frame in my dimensions,12:Bureau in my dimensions,13:Rug in my dimensions,14:Lamp in my dimensions,15:Tree in my dimensions,16:Arcade in my dimensions,17:Clearance token in my dimensions]

// 
stock_bookcase_selection = 100; // [100:None,101:Wide short IKEA Billy bookcase,102:Wide short extended IKEA Billy bookcase,103:Wide tall IKEA Billy Bookcase,104:Wide tall extended IKEA Billy bookcase,105:Wide tall deep IKEA Billy bookcase,106:Thin short IKEA Billy bookcase,107:Thin short extended IKEA Billy bookcase,108:Thin tall IKEA Billy bookcase,109:Thin tall extended IKEA Billy bookcase,110:Wide tall IKEA Hemnes bookcase,111:Thin tall IKEA Hemnes bookcase,112:Wide tall IKEA Bonde bookcase,113:Thin tall IKEA Bonde bookcase]

// 
stock_bed_selection = 300; // [300:None,301:Twin matrress,302:Frame for twin mattress,303:Full mattress,304:Frame for full mattress,305:Queen mattress,306:Frame for queen mattress,307:King mattress,308:Frame for king mattress,309:IKEA Karlstad sofa bed]

// 
other_stock_selection = 516; // [500:None,501:Small dining table,502:Medium dining table,503:Coffee table,504:Square coffee table,505:Kid's desk,506:Large desk,507:Long desk,508:TV stand,509:Tiny endtable,510:Medium endtable,511:Large endtable,512:Dining chair,513:Office chair,514:Kitchen stool,515:Large sofa,516:Small loveseat,517:Armchair,518:Kid's bureau,519:Large rug,520:Standing lamp,521:Decorative tree,522:Galaga/PacMan arcade,523:Thin clearance token,524:Wide clearance token]

////////////////////////////////////////////////////////////////////////////

/* [Dimensions] */

// What is the length of your object from side to side? (The model may appear on its back or side; answer in terms of the real-life object.)
length = 30;

// What is the depth of your object from front to back?
depth = 30;

// What is the height of your object from bottom to top?
height = 30;

// If your object is a stool, tree, or lamp then enter radius here to be used instead of length and depth.
radius = 7;

// If your object is a bookcase, how many shelves does it have?
shelves = 4;

// If your object is a bureau, how many levels of drawers does it have?
drawers = 4;

// If your object is a chair, which type of chair is it?
chair_type = 1000; // [1000:Straight,1001:Rolling]

// If your object is a sofa bed, what is its depth when fully extended?
sofabed_depth = 65;

////////////////////////////////////////////////////////////////////////////
// choose and render the furntiture model //////////////////////////////////

furniture(); // build it!

module furniture(){

	// custom designs with user dimensions
	if (custom_furniture==1) bookcase(depth,length,height,shelves);
	if (custom_furniture==2) table(depth,length,height);
	if (custom_furniture==3) desk(depth,length,height);
	if (custom_furniture==4) cornerdesk(depth,length,height);
	if (custom_furniture==5) chair(depth,length,height,chair_type);
	if (custom_furniture==6) stool(radius,height);
	if (custom_furniture==7) sofa(depth,length,height);
	if (custom_furniture==8) sofabed(depth,sofabed_depth,length,height);
	if (custom_furniture==9) ottoman(depth,length,height);
	if (custom_furniture==10) bed(depth,length,height);
	if (custom_furniture==11) bedframe(depth,length,height);
	if (custom_furniture==12) bureau(depth,length,height,drawers);
	if (custom_furniture==13) rug(width,length);
	if (custom_furniture==14) lamp(radius,height);
	if (custom_furniture==15) tree(radius,height);
	if (custom_furniture==16) arcade(depth,length,height);
	if (custom_furniture==17) clearance_star(length,height);

	// pre-made bookcases
	if (stock_bookcase_selection==101) bookcase(depth=11,length=31.5,height=41.75,shelves=3);
	if (stock_bookcase_selection==102) bookcase(depth=11,length=31.5,height=55.375,shelves=4);
	if (stock_bookcase_selection==103) bookcase(depth=11,length=31.5,height=79.5,shelves=6);
	if (stock_bookcase_selection==104) bookcase(depth=11,length=31.5,height=93.125,shelves=7);
	if (stock_bookcase_selection==105) bookcase(depth=15.375,length=31.5,height=79.5,shelves=6);
	if (stock_bookcase_selection==106) bookcase(depth=11,length=15.75,height=41.75,shelves=3);
	if (stock_bookcase_selection==107) bookcase(depth=11,length=15.75,height=55.375,shelves=4);
	if (stock_bookcase_selection==108) bookcase(depth=11,length=15.75,height=79.5,shelves=6);
	if (stock_bookcase_selection==109) bookcase(depth=11,length=15.75,height=93.125,shelves=7);
	if (stock_bookcase_selection==110) bookcase(depth=13.5,length=35.5,height=78,shelves=6);
	if (stock_bookcase_selection==111) bookcase(depth=13.5,length=19.5,height=78,shelves=6);
	if (stock_bookcase_selection==112) bookcase(depth=16,length=28.5,height=58,shelves=4);
	if (stock_bookcase_selection==113) bookcase(depth=16,length=14.5,height=58,shelves=4);

	// pre-made beds
	if (stock_bed_selection==301) bed(depth=39,length=75,height=20); 
	if (stock_bed_selection==302) bedframe(depth=43,length=81.5,height=17); 
	if (stock_bed_selection==303) bed(depth=54,length=75,height=20);
	if (stock_bed_selection==304) bedframe(depth=57,length=81.5,height=17);
	if (stock_bed_selection==305) bed(depth=60,length=80,height=20); 
	if (stock_bed_selection==306) bedframe(depth=64,length=86.5,height=17); 
	if (stock_bed_selection==307) bed(depth=76,length=80,height=20);
	if (stock_bed_selection==308) bedframe(depth=80,length=86.5,height=17);
	if (stock_bed_selection==309) sofabed(depth=36.625,depth2=55.125+7,length=78.75+10,height=32.625);

	// other pre-made models
	if(other_stock_selection==501) table(depth=33,length=55,height=29); // small dining table
	if(other_stock_selection==502) table(depth=33,length=71,height=29); // medium dining table
	if(other_stock_selection==503) table(depth=24,length=46.5,height=18); // coffee table
	if(other_stock_selection==504) table(depth=35.5,length=35.5,height=18); // square coffee table
	if(other_stock_selection==505) desk(depth=21,length=42,height=29.5); // kid's desk
	if(other_stock_selection==506) desk(depth=29.5,length=55,height=30); // large desk
	if(other_stock_selection==507) desk(depth=24,length=75.5,height=29); // long desk
	if(other_stock_selection==508) bookcase(depth=21.5,length=60,height=20.5,shelves=1); // TV stand
	if(other_stock_selection==509) desk(depth=12,length=12,height=24); // tiny endtable
	if(other_stock_selection==510) desk(depth=15,length=23,height=23); // medium endtable
	if(other_stock_selection==511) bookcase(depth=24,length=28,height=22,shelves=1); // large endtable
	if(other_stock_selection==512) chair(depth=23,length=17,height=40,chair_type=1000); // dining chair
	if(other_stock_selection==513) chair(depth=21,length=23,height=44.5,chair_type=1001); // office chair
	if(other_stock_selection==514) stool(radius=7.25,height=29); // kitchen stool
	if(other_stock_selection==515) sofa(depth=39,length=90,height=32); // large sofa
	if(other_stock_selection==516) sofa(depth=36,length=54,height=34); // small loveseat
	if(other_stock_selection==517) sofa(depth=36,length=35,height=34); // armchair
	if(other_stock_selection==518) bureau(depth=17,length=37,height=36,drawers=4); // kid's bureau
	if(other_stock_selection==519) rug(width=79,length=116); // large rug
	if(other_stock_selection==520) lamp(radius=7,height=70); // standing lamp
	if(other_stock_selection==521) tree(radius=18,height=75); // decorative tree
	if(other_stock_selection==522) arcade(depth=31,length=25,height=70.5); // Galaga/PacMan arcade
	if(other_stock_selection==523) clearance_star(length=22,height=72); // limited access clearance
	if(other_stock_selection==524) clearance_star(length=30,height=72); // regular access clearance
}

////////////////////////////////////////////////////////////////////////////
// module for cuboids //////////////////////////////////////////////////////
// thanks, kitwallace! /////////////////////////////////////////////////////

module cuboid(depth,length,height,r) {
	hull(){
		translate([r,r,r]) sphere(r);
		translate([depth-r,r,r]) sphere(r);
		translate([depth-r,length-r,r]) sphere(r);
		translate([r,length-r,r]) sphere(r);
		translate([r,length-r,height-r]) sphere(r);
		translate([depth-r,length-r,height-r]) sphere(r);
		translate([depth-r,r,height-r]) sphere(r);
		translate([r,r,height-r]) sphere(r);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for making bookcases /////////////////////////////////////////////

module bookcase(depth,length,height,shelves){
	scale(s)
	union(){
		difference(){
			// body of the bookcase
			cuboid(length,height,depth,sharp);
			// minus an inside
			translate([.1*length,.1*length,-depth/2])
				cuboid(.8*length,height-.2*length,2*depth,sharp);
		}
		// put in some shelves
		for (i = [1:1:shelves-1]){
			translate([0,i*(height-.1*length)/shelves,0]) 
				cuboid(length,.1*length,depth,sharp);
		}
	}
}

////////////////////////////////////////////////////////////////////////////
// module for making tables ////////////////////////////////////////////////

module table(depth,length,height){
	scale(s)
	union(){
		// top of table
		cuboid(depth,length,depth/5,sharp);
		// four legs
		translate([0,0,0]) cuboid(depth/5,depth/5,height,sharp);
		translate([depth-depth/5,0,0]) cuboid(depth/5,depth/5,height,sharp);
		translate([0,length-depth/5,0]) cuboid(depth/5,depth/5,height,sharp);
		translate([depth-depth/5,length-depth/5,0]) cuboid(depth/5,depth/5,height,sharp);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for making desks /////////////////////////////////////////////////

module desk(depth,length,height){
	scale(s)
	rotate(270,[0,1,0])
	union(){
		// top of desk
		translate([0,0,height*.8]) cuboid(depth,length,height*.2,sharp);
		// left side
		cuboid(depth,length*.15,height,sharp);
		// right side
		translate([0,length*.85,0]) cuboid(depth,length*.15,height,sharp);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for making corner desks //////////////////////////////////////////

module cornerdesk(depth,length,height){
	scale(s)
	translate([0,0,height]) rotate(180,[0,1,0])
	difference(){
		// regular desk
		union(){
			// top of desk
			translate([0,0,height*.8]) cuboid(depth,length,height*.2,sharp);
			// left side
			cuboid(depth,length*.15,height,sharp);
			// right side
			translate([0,length*.85,0]) cuboid(depth,length*.15,height,sharp);
		}
		// take out a corner circle
		translate([0,0,-1]) cylinder(r=depth/2,h=height+2);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for chairs ////////////////////////////////////////////////////////

module chair(depth,length,height,chair_type){
	scale(s)
	rotate(90,[1,0,0])
	union(){
		// top of chair
		if (chair_type==1000) // straight desk chair
			translate([0,0,height*.4]) 
				cuboid(depth,length,height*.1,sharp);
		if (chair_type==1001) // rolling office chair
			translate([0,0,height*.4]) 
				cuboid(depth,length,height*.1,soft);
		// back
		if (chair_type==1000) // straight desk chair
			cuboid(depth*.15,length,height,sharp);
		if (chair_type==1001) // rolling office chair
			translate([0,0,height*.4]) 
				cuboid(depth*.15,length,height*.6,soft);
		// front
		if (chair_type==1000) // straight desk chair
			translate([depth*.85,0,0]) 
				cuboid(depth*.15,length,height*.5,sharp);
		if (chair_type==1001) // rolling office chair
			union(){
				translate([depth*.85/2,0,0]) 
					cuboid(depth*.15,length,height*.45,sharp);
				translate([depth/2,length/2,0]) 
					cylinder(r=length/2,h=height*.1);
			}
	}
}

////////////////////////////////////////////////////////////////////////////
// module for stools ///////////////////////////////////////////////////////

module stool(radius,height){
	scale(s)
	union(){
		// top
		cylinder(r=radius,h=height*.1);
		// legs
		rotate(0,[0,0,1])
			translate([radius*.6,0,0]) 
				cylinder(r=radius*.3,h=height);
		rotate(90, [0,0,1])
			translate([radius*.6,0,0]) 
				cylinder(r=radius*.3,h=height);
		rotate(180, [0,0,1])
			translate([radius*.6,0,0]) 
				cylinder(r=radius*.3,h=height);
		rotate(270, [0,0,1])
			translate([radius*.6,0,0]) 
				cylinder(r=radius*.3,h=height);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for making sofas /////////////////////////////////////////////////

module sofa(depth,length,height){
	scale(s)
	union(){
		// back of sofa
		cuboid(depth/4,length,height,soft);
		// left arm of sofa
		cuboid(depth,depth/4,height*.6,soft);
		// right arm of sofa
		translate([0,length-depth/4,0]) cuboid(depth,depth/4,height*.6,soft);
		// cushions of sofa
		cuboid(depth,length,height*.4,soft);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for making sofa beds /////////////////////////////////////////////

module sofabed(depth,sofabed_depth,length,height){
	scale(s)
	union(){
		// back of sofa
		cuboid(depth/4,length,height,soft);
		// left arm of sofa
		cuboid(depth,depth/4,height*.6,soft);
		// right arm of sofa
		translate([0,length-depth/4,0]) cuboid(depth,depth/4,height*.6,soft);
		// cushions of sofa
		cuboid(depth,length,height*.4,soft);
		// image of bed
		cuboid(sofabed_depth,length,height*.1,soft);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for making ottomans //////////////////////////////////////////////

module ottoman(depth,length,height){
	scale(s)
	cuboid(depth,length,height,soft);
}

////////////////////////////////////////////////////////////////////////////
// module for making beds //////////////////////////////////////////////////

module bed(depth,length,height){
	scale(s)
	union(){
		// mattress
		cuboid(depth,length,height,soft);
		// pillow
		cuboid(depth,.2*length,1.2*height,soft);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for making bed frames ////////////////////////////////////////////

module bedframe(depth,length,height){
	scale(s)
	difference(){
		// total outer size
		cuboid(depth,length,height,sharp);
		// take out inside
		translate([2,2,-1]) cuboid(depth-4,length-4,height+2,sharp);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for bureaus //////////////////////////////////////////////////////

module bureau(depth,length,height,drawers){
	scale(s)
	union(){
		// body of the bureau
		cuboid(length,height,depth,sharp);
		// put in some drawers
		for (i = [1:1:drawers]){
			translate([.075*length,i*(height-.1*height)/drawers-.15*height,0]) 
				cuboid(.4*length,.15*height,depth*1.1,sharp);
			translate([.525*length,i*(height-.1*height)/drawers-.15*height,0]) 
				cuboid(.4*length,.15*height,depth*1.1,sharp);
		}
	}
}

////////////////////////////////////////////////////////////////////////////
// module for rugs ////////////////////////////////////////////////////////

module rug(width,length){
	scale(s)
	cuboid(width,length,soft,sharp);
}

////////////////////////////////////////////////////////////////////////////
// module for lamps ////////////////////////////////////////////////////////

module lamp(radius,height){
	scale(s)
	union(){
		// top
		translate([0,0,height*.8])
			cylinder(r1=radius*.5,r2=radius,h=height*.2);
		// leg
		cylinder(r=radius*.4,h=height*.8);
		// base
		cylinder(r=radius,h=height*.1);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for trees ////////////////////////////////////////////////////////

module tree(radius,height){
	scale(s)
	union(){
		// branches
		translate([0,0,height*.5]) 
			rotate(40,[1,0,0]) 
				cylinder(r=radius*.2,h=height*.5);
		translate([0,0,height*.5]) 
			rotate(200,[0,0,1]) rotate(40,[1,0,0]) 
				cylinder(r=radius*.2,h=height*.5);
		translate([0,0,height*.4]) 
			rotate(80,[0,0,1]) rotate(50,[1,0,0]) 
				cylinder(r=radius*.2,h=height*.3);
		translate([0,0,height*.6]) 
			rotate(140,[0,0,1]) rotate(405,[1,0,0]) 
				cylinder(r=radius*.2,h=height*.3);
		translate([0,0,height*.45]) 
			rotate(260,[0,0,1]) rotate(50,[1,0,0]) 
				cylinder(r=radius*.2,h=height*.3);
		translate([0,0,height*.8]) 
			rotate(100,[0,0,1]) rotate(30,[1,0,0]) 
				cylinder(r=radius*.2,h=height*.2);
		translate([0,0,height*.7]) 
			rotate(280,[0,0,1]) rotate(30,[1,0,0]) 
				cylinder(r=radius*.2,h=height*.3);
		// leg
		cylinder(r=radius*.2,h=height*.8);
		// base
		cylinder(r=radius*.8,h=height*.1);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for arcade machine ///////////////////////////////////////////////

module arcade(depth,length,height){
	scale(s)
	rotate(-90,[0,1,0])
	difference(){
		// overall size of the machine
		cuboid(depth,length,height,sharp);
		// cutout for screen and controls
		translate([depth*.9,length*.9,height*.7]) 
			rotate(90,[1,0,0]) 
				cylinder(r=height*.25,h=length*.8);
	}
}

////////////////////////////////////////////////////////////////////////////
// module for clearance star ///////////////////////////////////////////////
// code modified from Catarina Mota's shape library ////////////////////////
// http://svn.clifford.at/openscad/trunk/libraries/shapes.scad /////////////

module 12ptstar(length,height) {
	starNum = 3;
	starAngle = 360/starNum;
	// place StarNum cubes rotated evenly
	for (s = [1:starNum]) {
		rotate([0, 0, s*starAngle]) cube([length/sqrt(2),length/sqrt(2),height], true);
  	}
}

module clearance_star(length,height) {
	scale(s)
	translate([0,0,height/2])
	difference(){
		12ptstar(length,height);
		12ptstar(length-6,height+2);
	}
}