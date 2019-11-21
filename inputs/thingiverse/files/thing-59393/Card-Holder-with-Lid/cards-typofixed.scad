//Game card holder with lid
// 1 to 1 copy of previous blender version but with parameters for changeing dimension

//Constants
// Card short side in mm (Default settlers card 54mm)
card_x = 54;

// Card long side in mm (Default settlers card 80mm)
card_y = 80;

show_logo = "yes"; // [yes,no]

connectors = "yes";  // [yes,no]

// Produce a lid
lid = 1; // [1,0]

// Gap between card and the walls of the holder
card_space = 3; //original 2
wall_thickness = 3; //original 2
plate_height = 3; //original 2
wall_height = 12; //original 12

// Prevents corner pull-up for FDM processes (e.g. PLA on Replicator/RepRap etc)
use_sticky_corners = "no"; // [yes,no]

shortwall_cut = card_x/(card_y/card_x);
shortwall = (card_x-shortwall_cut)/2+wall_thickness+card_space/2;

longwall=(card_y-card_x)/2+wall_thickness+card_space/2;

hinge_r = 2;
hinge = min(0.6*longwall/2, wall_height/2);
lid_slop = 0.5*lid; //0.5mm
lid_height = hinge*2;

lid_reveal = hinge*2+0.5;

connector_extra = lid * (wall_thickness*2 + lid_slop*2);
circ_ratio =2.5;

//Connecting piece
//the "female" part is 21mm at the biggest point and 12.5mm at the smallest and 10mm deep
//the "male" part is  19.8mm at the biggest point and 10.46mm at smallest and 11.4mm long
//the odd numbers are because i used a manualy freehand modifed box with no real grid snapping, and some random scaling
// ignore variable values
female_con_x = 10+1-1;
female_con_y1 = 21+1-2;
female_con_y2 = 12.5+1-1;
male_con_x = 11.4+1-1;
male_con_y1 = 19.8+1-1;
male_con_y2 = 10.46+1-1;
angle = atan( ((female_con_y1-female_con_y2)/2) / female_con_x ); // same for both

module logo() {
    union() {
	translate([0, -4.5, 0])
	cube(size = [19,9,10], center = true);
	difference() {
	    translate([-4.5, 0.5 ,0])
	    cube(size = [10,19,10], center = true);
	    translate([0.5, 12 ,0])
	    rotate([0, 0, 45])
	    cube(size = [10,12,11], center = true);
	    translate([-9.5, 12 ,0])
	    rotate([0, 0, 45])
	    cube(size = [12,10,11], center = true);
	}
    }};

module bump(rad,dir) {
    difference() {
	sphere(r=rad, center=true, $fn = 40);
	translate(dir*rad)
	cube([rad*2,rad*2,rad*2],center=true);
    }
};

module round_cut1() {
    //Round Cut
    // was made with a cylinder with radius=32 scaled in x and y by 0.8, resulting in R=25.6 and that is aprox card_x
    translate([0,card_y/1.27,-card_x/4])
    cylinder(card_x/2, card_x/2, card_x/2, $fa=2);
    };

union() {
    if (use_sticky_corners == "yes") {
	union() {
	    translate([(card_x+card_space+wall_thickness*2)/2, (card_y+card_space+wall_thickness*2)/2,-plate_height/2])
	    cylinder(r=15,h=0.35,center="yes");
	    translate([-(card_x+card_space+wall_thickness*2)/2, (card_y+card_space+wall_thickness*2)/2,-plate_height/2])
	    cylinder(r=15,h=0.35,center="yes");
	    translate([(card_x+card_space+wall_thickness*2)/2, -(card_y+card_space+wall_thickness*2)/2,-plate_height/2])
	    cylinder(r=15,h=0.35,center="yes");
	    translate([-(card_x+card_space+wall_thickness*2)/2, -(card_y+card_space+wall_thickness*2)/2,-plate_height/2])
	    cylinder(r=15,h=0.35,center="yes");
	    if(lid == 1) {
	    	translate([card_x+card_space+wall_thickness*2+4+lid_slop+connector_extra,-lid_reveal/2,-plate_height/2]) {
		    
		    translate([(card_x+card_space+wall_thickness*4+lid_slop)/2, (card_y+card_space+wall_thickness*2+lid_reveal)/2,0])		
		    cylinder(r=15,h=0.35,center="yes");
		    translate([-(card_x+card_space+wall_thickness*4+lid_slop)/2, (card_y+card_space+wall_thickness*2+lid_reveal)/2,0])		
		    cylinder(r=15,h=0.35,center="yes");
		    translate([(card_x+card_space+wall_thickness*4+lid_slop)/2, -(card_y+card_space+wall_thickness*2-lid_reveal)/2,0])		
		    cylinder(r=15,h=0.35,center="yes");
		    translate([-(card_x+card_space+wall_thickness*4+lid_slop)/2, -(card_y+card_space+wall_thickness*2-lid_reveal)/2,0])		
		    cylinder(r=15,h=0.35,center="yes");
		}
	    }
	
	}
    }
    difference() {
		//Base plate
		union() {
		    cube(size = [card_x+card_space+wall_thickness*2, card_y+card_space+wall_thickness*2,plate_height], center = true);
		    if (connectors == "yes" && lid == 1) {
			translate( [ (card_x/2) + card_space/2 + wall_thickness, -female_con_y1, -plate_height/2])

			cube(size = [connector_extra/2, female_con_y1*2, plate_height], center = false);		    
			
		    }
		}

		round_cut1();
		translate([0,-card_y/1.27,-card_x/4])
		cylinder(card_x/2, card_x/2, card_x/2, $fa=2);
		
		cylinder(card_x/circ_ratio, card_x/circ_ratio, card_x/circ_ratio, $fa=2);

		//Logo
		if (show_logo == "yes") {
		    logo();
		}
		
		//female con
		if (connectors == "yes") {
			translate( [ (card_x/2) - female_con_x + card_space/2 + wall_thickness +connector_extra/2+0.01 , -female_con_y1/2, -plate_height ] ) //0.01 is for overlapping
			difference() {
				cube(size = [female_con_x, female_con_y1, plate_height*2], center = false);
				translate( [ 0,female_con_y1,-1 ] )
				rotate([0, 0, -angle])
				cube(female_con_x*2);
				translate( [ 0,0,-1 ] )
				rotate([0, 0, angle-90])
				cube(female_con_x*2);
			}
		}
	}

	//male con
	if (connectors == "yes") {
		translate( [ -(card_x/2) - card_space/2 - wall_thickness - male_con_x-connector_extra/2, -male_con_y1/2, -plate_height/2 ] )
		union() {
		    difference() {
			cube(size = [male_con_x, male_con_y1, plate_height], center = false);
			translate( [ 0,male_con_y1,-1 ] )
			rotate([0, 0, -angle])
			cube(male_con_x*2);
			translate( [ 0,0,-1 ] )
			rotate([0, 0, angle-90])
			cube(male_con_x*2);
		    }
		    translate( [male_con_x, -male_con_y1/2, 0] )
		    cube(size = [connector_extra/2, male_con_y1*2, plate_height], center = false);		    
		}
	}

	//Cards for reference
	//%cube(size = [card_x,card_y,9], center = true);
	//%cube(size = [card_y,card_x,9], center = true);
	
	//%cube(size= [shortwall_cut, 100,20], center = true);
	
	difference() {
	    union() {
		// Long wall 1 of 4
		translate([  (card_x+card_space+wall_thickness*2)/2 , (card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
		rotate([0,0,180])
		cube(size = [wall_thickness,longwall,wall_height] ,center = false);
		
		// Long wall 2 of 4
		translate([  -(card_x+card_space+wall_thickness*2)/2 +wall_thickness , (card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
		rotate([0,0,180])
		cube(size = [wall_thickness,longwall,wall_height] ,center = false);
		
		// Long wall 3 of 4
		translate([  (card_x+card_space+wall_thickness*2)/2 -wall_thickness, -(card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
		rotate([0,0,0])
		cube(size = [wall_thickness,longwall,wall_height] ,center = false);
		
		// Long wall 4 of 4
		translate([  -(card_x+card_space+wall_thickness*2)/2 , -(card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
		rotate([0,0,0])
		cube(size = [wall_thickness,longwall,wall_height] ,center = false);

	//Shortwall 1 of 4
	//the cut to make the space between the walls was originaly 37mm
	translate([  -(card_x+card_space+wall_thickness*2)/2  , (card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
	rotate([0,0,270])
	cube(size = [wall_thickness, shortwall , wall_height] ,center = false);
	
	//Shortwall 2 of 4
	//the cut to make the space between the walls was originaly 37mm
	translate([  (card_x+card_space+wall_thickness*2)/2 , -(card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
	rotate([0,0,90])
	cube(size = [wall_thickness, shortwall , wall_height] ,center = false);
	
	//Shortwall 3 of 4
	//the cut to make the space between the walls was originaly 37mm
	translate([  -(card_x+card_space+wall_thickness*2)/2 , -(card_y+card_space+wall_thickness*2)/2 +wall_thickness ,plate_height/2])
	rotate([0,0,270])
	cube(size = [wall_thickness, shortwall , wall_height] ,center = false);
	
	//Shortwall 4 of 4
	//the cut to make the space between the walls was originaly 37mm
	translate([  (card_x+card_space+wall_thickness*2)/2 , (card_y+card_space+wall_thickness*2)/2 -wall_thickness ,plate_height/2])
	rotate([0,0,90])
	cube(size = [wall_thickness, shortwall , wall_height] ,center = false);
	

		
	    }
	
	    if (lid == 1) { //create hinge hole
		rotate([0,90,0]) {
		    union () {
			translate([-(plate_height/2+wall_height)+hinge,card_y/2+card_space/2+wall_thickness-hinge,0])
			cylinder(h=card_x+card_space+wall_thickness*2+2,r=hinge_r, center=true, $fn = 40);
			translate([-(plate_height/2+wall_height)+hinge,-card_y/2-card_space/2-wall_thickness+hinge,0])
			cylinder(h=card_x+card_space+wall_thickness*2+2,r=hinge_r, center=true, $fn = 40);

			//round off walls
			    union () {
				translate([-(plate_height/2+wall_height)+hinge,card_y/2+card_space/2+wall_thickness-hinge,0])
				difference() {
				    translate([-hinge,hinge,0])
				    cube([hinge*2,hinge*2,card_x+card_space+wall_thickness*2+1],center=true);
				    cylinder(h=card_x+card_space+wall_thickness*2+2,r=hinge, center=true, $fn = 40);
				}
			    }
			
		    }
		}
	    }
	    
	}
	


	if (lid == 1) {
	    translate([card_x+card_space+wall_thickness*2+4+lid_slop+connector_extra,0,0]) {
		union() {
		    difference() {
			translate([0,-lid_reveal/2,0])
	    		cube(size = [card_x+card_space+wall_thickness*4+lid_slop, card_y+card_space+wall_thickness*2-lid_reveal,plate_height], center = true);

		cylinder(card_x/circ_ratio, card_x/circ_ratio, card_x/circ_ratio, $fa=2);

		translate([0,-lid_reveal,0])
			round_cut1();
			
			if (show_logo == "yes") {
			    rotate([180,0,180])
			    logo();
			}
		    }
		    translate([0,-(card_y+card_space+wall_thickness)/2,hinge/2+plate_height/2])		    
		    cube(size=[card_x - (2*shortwall+1),wall_thickness,hinge],center=true);

		    
		    // Long wall 1 of 4
		    translate([  (card_x+card_space+wall_thickness*4+lid_slop)/2 , (card_y+card_space+wall_thickness*2)/2 ,-plate_height/2])
		    rotate([0,0,180])
		    cube(size = [wall_thickness,longwall,lid_height+plate_height] ,center = false);
		    
		    // Long wall 2 of 4
		    translate([  -(card_x+card_space+wall_thickness*4+lid_slop)/2 +wall_thickness , (card_y+card_space+wall_thickness*2)/2 ,-plate_height/2])
		    rotate([0,0,180])
		    cube(size = [wall_thickness,longwall,lid_height+plate_height] ,center = false);

		    // Long wall 3 of 4
		    translate([  (card_x+card_space+wall_thickness*4+lid_slop)/2 -wall_thickness, -(card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
		    rotate([0,0,0])
		    cube(size = [wall_thickness,longwall,lid_height] ,center = false);
		    
		    // Long wall 4 of 4
		    translate([  -(card_x+card_space+wall_thickness*4+lid_slop)/2 , -(card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
		    rotate([0,0,0])
		    cube(size = [wall_thickness,longwall,lid_height] ,center = false);

		    translate([((card_x+card_space)/2+lid_slop+hinge_r),(card_y+card_space)/2+wall_thickness-hinge,lid_height+plate_height/2-hinge]) {
			bump(hinge_r,[1,0,0]);
		    }
		    translate([-((card_x+card_space)/2+lid_slop+hinge_r),(card_y+card_space)/2+wall_thickness-hinge,lid_height+plate_height/2-hinge]) {
			bump(hinge_r,[-1,0,0]);
		    }
		    //1.5 means less bumpy for clip end
		    translate([((card_x+card_space)/2+lid_slop+1.5*hinge_r),-((card_y+card_space)/2+wall_thickness-hinge),lid_height+plate_height/2-hinge]) {
			bump(hinge_r,[1,0,0]);
		    }
		    translate([-((card_x+card_space)/2+lid_slop+1.5*hinge_r),-((card_y+card_space)/2+wall_thickness-hinge),lid_height+plate_height/2-hinge]) {
			bump(hinge_r,[-1,0,0]);
		    }
		    
		}
	    }
	}
	
}
