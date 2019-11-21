use <write/Write.scad>

/* [Global] */

letter_height = 7;
letter_depth = 2.5;
line_1_text = "i am ";
line_2_text = "a";
line_3_text = "hip";
line_4_text = "gamer";

/* [Hidden] */

plate_width  = 78;
plate_height = 38;
plate_depth  = 12;
cube([plate_width,plate_height,plate_depth],center=true);	

mirror([ 1, 0, 0 ])
{
writecube(line_1_text,
			[0,plate_height/2-letter_height*0-letter_height/2-2,plate_depth/2+letter_depth/2],
			0,
			face="top",
			t=letter_depth,
			h=letter_height);

writecube(line_2_text,
			[0,plate_height/2-letter_height*1-letter_height/2-2,plate_depth/2+letter_depth/2],
			0,
			face="top",
			t=letter_depth,
			h=letter_height);

writecube(line_3_text,
			[0,plate_height/2-letter_height*2-letter_height/2-2,plate_depth/2+letter_depth/2],
			0,
			face="top",
			t=letter_depth,
			h=letter_height);

writecube(line_4_text,
			[0,plate_height/2-letter_height*3-letter_height/2-2,plate_depth/2+letter_depth/2],
			0,
			face="top",
			t=letter_depth,
			h=letter_height);
}