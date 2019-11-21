
// Adjust this to the number of cards. 11 mm is sufficient for ~10 cards.
innerHeight = 11;

// Diameter of the hole for pushing up the stack of cards.
holeDiameter = 20;

// Change this to change the thickness and roundness of the frame. 
frameThickness = 3;

// Thickness of the thinnest features, including the base. 1.5 should be just fine. 
wall = 1.5;

// Card size in X. Adjust it if the cutout is too small or too large for your cards. 
cardSizeX = 87;

// Card size in X. Adjust it if the cutout is too small or too large for your cards. 
cardSizeY = 56;

// Rounding radius.
cornerRad = 4;

// Width of the cutouts for the rubber bands.
cutoutSize = 3.0;

// Depth of the cutouts for the rubber band.
cutoutDepth = 0.5;




$fn=40;


module frameslice_2d()
{
	intersection()
	{
		h = innerHeight+wall;
		translate([-frameThickness*2,0])
			square([frameThickness*2,h]);
		translate([0,h/2])
		resize([frameThickness*2,h])
			circle(r=h/2);
	}
}

module frame_corner()
{
	rotate(-90,[0,1,0])
	rotate(-90,[1,0,0])
	rotate_extrude(r=cornerRad, angle=90)
	{
		translate([-cornerRad,0])
			frameslice_2d();
	}
}

module raw_frame()
{
	union()
	{
		translate([0,0,cornerRad])
		linear_extrude(cardSizeY-2*cornerRad)
		{
			frameslice_2d();
		}
		translate([cardSizeX,0,cardSizeY-cornerRad])
		rotate(180,[0,1,0])
		linear_extrude(cardSizeY-2*cornerRad)
		{
			frameslice_2d();
		}
		translate([cornerRad,0,cardSizeY])
		rotate(90,[0,1,0])
		linear_extrude(cardSizeX-2*cornerRad)
		{
			frameslice_2d();
		}
		translate([cardSizeX-cornerRad,0,0])
		rotate(-90,[0,1,0])
		linear_extrude(cardSizeX-2*cornerRad)
		{
			frameslice_2d();
		}

		translate([cornerRad,0,cornerRad])
			frame_corner();

		translate([cornerRad,0,cardSizeY-cornerRad])
		rotate(90,[0,1,0])
			frame_corner();

		translate([cardSizeX-cornerRad,0,cardSizeY-cornerRad])
		rotate(180,[0,1,0])
			frame_corner();

		translate([cardSizeX-cornerRad,0,cornerRad])
		rotate(270,[0,1,0])
			frame_corner();
	}
}


module full_cutouts_2d()
{
	translate( [cardSizeX / 4, cardSizeY/2])
		circle( holeDiameter/2, center=true);
	translate([cardSizeX / 1.5, -frameThickness-wall])
		square([cutoutSize, frameThickness]);
	translate([cardSizeX / 1.5, cardSizeY+wall])
		square([cutoutSize, frameThickness]);
	translate([cardSizeX / 1.5+5*cutoutSize, -frameThickness-wall])
		square([cutoutSize, frameThickness]);
	translate([cardSizeX / 1.5+5*cutoutSize, cardSizeY+wall])
		square([cutoutSize, frameThickness]);
}

module top_cutouts_2d()
{
	translate([cardSizeX / 1.5, -frameThickness])
		square([cutoutSize, 2*frameThickness]);
	translate([cardSizeX / 1.5, cardSizeY-frameThickness])
		square([cutoutSize, 2*frameThickness]);
	translate([cardSizeX / 1.5+5*cutoutSize, -frameThickness])
		square([cutoutSize, 2*frameThickness]);
	translate([cardSizeX / 1.5+5*cutoutSize, cardSizeY-frameThickness])
		square([cutoutSize, 2*frameThickness]);
}


module bottom_cutouts_2d()
{
	translate([cardSizeX / 1.5, -wall])
	square([cutoutSize, cardSizeY*2]);
	translate([cardSizeX / 1.5+5*cutoutSize, -wall])
	square([cutoutSize, cardSizeY*2]);
}


module inner_base_2d()
{
	translate([cornerRad, cornerRad])
	offset( cornerRad )
	square(  [cardSizeX - 2*cornerRad, cardSizeY - 2*cornerRad] );
}

module outer_base_2d()
{
	offset( wall )
	inner_base_2d();
}


module full_cutouts()
{
	translate([0,0,-wall])
	linear_extrude( 2*wall+innerHeight)
		full_cutouts_2d();
}

module bevel_cutouts()
{
	dx1 = cardSizeX/1.5;
	dx2 = cardSizeX/1.5+5*cutoutSize;

	translate([dx1,-wall,-wall/4])
	rotate(45,[1,0,0])
		cube([cutoutSize,wall,wall]);

	translate([dx2,-wall,-wall/4])
	rotate(45,[1,0,0])
		cube([cutoutSize,wall,wall]);

	translate([dx1,cardSizeY+wall,-wall/4])
	rotate(45,[1,0,0])
		cube([cutoutSize,wall,wall]);

	translate([dx2,cardSizeY+wall,-wall/4])
	rotate(45,[1,0,0])
		cube([cutoutSize,wall,wall]);

}

module container()
{
	difference()
	{
		union()
		{
			translate([0,0,innerHeight+wall])
			rotate(-90,[1,0,0])
				raw_frame();
			linear_extrude(wall)
				inner_base_2d();			
		}
	
		translate( [0, 0, wall] )
		linear_extrude(innerHeight)
		inner_base_2d();
		
		full_cutouts();
		bevel_cutouts();

		translate([0,0,innerHeight/2 + 2*wall])
		linear_extrude(innerHeight)
		top_cutouts_2d();

		translate([0,0,-wall*4/10])
		linear_extrude(wall)
		bottom_cutouts_2d();
	}

}


container();
