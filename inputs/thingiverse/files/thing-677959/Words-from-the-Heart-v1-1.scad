
// 'Words from the Heart' by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// Version 1.1 (c) March 2015
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
//Version 1.1: OpenSCAD polygon bug workaround

// preview[view:south, tilt:top diagonal]

/* [Text] */
//each word will get a heart. If you want to use a phrase of two or more words concatenate the words with an underscore like in: "I_Love You". For additional empty hearts add a single underscore "_"
text = "I_Love You _";

/* [Neodymium holes] */
// big Neodymium magnet in the center of the heart (value 0 means no hole)
neodym_1_diameter = 8.5;
neodym_1_height = 3.5;

// small Neodymium magnet to support long text (value 0 means no hole)
neodym_2_diameter = 5.5;
neodym_2_height = 2.5;

/* [Appearance] */
// of heart
outline_width = 2;
text_font = "knewave.dxf"; //[orbitron.dxf,Letters.dxf,knewave.dxf,BlackRose.dxf]
text_height = 16;
//corrects the kerning - depends on font
text_space_factor = 0.75;

/* [Output] */
// shift between multiple hearts
build_shift = 40;

// height of link between characters
link_level = 4.0; // transparent

// height of big heart
big_heart_level = 7.0; // white

// height of big heart outline
big_heart_outline_level = 8.0; // red

// height of small heart
small_heart_level = 8.0; // red

// height of small heart outline
small_heart_outline_level = 8.5; // black

// height of words
text_level = 8.5; // black


/* [Hidden] */
char_width = 11 / 16 * text_height * text_space_factor; // this is the formular write.scad internal uses


use <write/Write.scad>

$fn = 50; // only relevant for neodym holes[ 2.45, -148.21, 52.02 ]

//Ok, lets start building by calling process_word()...
process_word(text);

// http://en.wikipedia.org/wiki/File:GJL-fft-herz.svg
function get_heart_x(t) = 12 * sin(t) - 4 * sin(3 * t);
function get_heart_y(t) = 13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t);

function get_link_length(str) = char_width * (len(str) - 0.3);


// Ok, there are some simple string operation missing in OpenSCAD
// This module is called recursivly and splits the text and calls build_heart for each word / phrase
module process_word(text, word="", offset=0, y=0)
{
	if(text[offset] == " ")
	{
		if(len(word) > 0)
		{	
			translate([0, y, 0])
			word_from_heart(word);
			process_word(text, "", offset + 1, y - build_shift);
		}
		else
		{
			process_word(text, "", offset + 1, y);
		}
	}
	else if(text[offset] == "_")
	{
		process_word(text, str(word, " "), offset + 1, y);
	}
	else if(offset < len(text))
	process_word(text, str(word, text[offset]), offset + 1, y);
	else if(len(word) > 0)
	translate([0, y, 0])
	word_from_heart(word);
}

// builds a doubled heart
module double_heart()
union()
{
	difference()
	{
		outline_heart(33,33,big_heart_outline_level,big_heart_level);
	
		translate([10,-12,small_heart_level])
		heart(20,20,small_heart_outline_level-small_heart_level+.1);
	}
	
	translate([10,-12,0])
	outline_heart(20,20,small_heart_outline_level,small_heart_level);
}

// builds an outlined heart
module outline_heart(height, width, outline_level, depth)
difference()
{
	heart(height, width, outline_level);
	translate([0,0,depth])
	heart(height-2*outline_width, width-2*outline_width, outline_level-depth+.1);
}

// builds a simple heart
module heart(height, width, depth)
resize([height, width,depth])
linear_extrude(h=1,convexity=10)
assign(step=5)
polygon(points=heart_points);
//for(a=[0:step:18])
//{
//    echo(get_heart_x(a)/100,get_heart_y(a),get_heart_x(a+step)/100,get_heart_y(a+step)/100);
//polygon(points=[[0,0],[get_heart_x(a)/100,get_heart_y(a)/100],[get_heart_x(a+step)/100,get_heart_y(a+step)/100]]);
//}
// builds the tagged heart sticker
module word_from_heart(word)
translate([-10,-3.5,0])
difference()
{
	union()
	{
		difference()
		{
			translate([10,3.5,0])
			double_heart();
			
			write(word, h=text_height, t=text_level+.1, font=text_font, center=false, space=text_space_factor);
		}

		write(word, h=text_height, t=text_level, font=text_font, center=false, space=text_space_factor);

		//link the characters together...
		if(get_link_length(word) > 25)
		hull()
		for(x=[char_width,get_link_length(word)])
		translate([x,5,0])
		cylinder(r=5,r2=3,h=link_level);
	}

	if(neodym_1_diameter > 0)
	translate([15,3.5,-.1])
	cylinder(r=neodym_1_diameter/2,h=neodym_1_height + .1);

	if(neodym_2_diameter > 0 && get_link_length(word) > 45)
	translate([get_link_length(word),5,-.1])
	cylinder(r=neodym_2_diameter/2,h=neodym_2_height + .1);
}

heart_points = [
	[0,5], // degree: 0
	[0.00229361,5.05605], // degree: 3
	[0.0182736,5.22239], // degree: 6
	[0.0612516,5.49364], // degree: 9
	[0.143799,5.86103], // degree: 12
	[0.277401,6.3127], // degree: 15
	[0.472136,6.83406], // degree: 18
	[0.736389,7.40831], // degree: 21
	[1.07661,8.01693], // degree: 24
	[1.49713,8.64031], // degree: 27
	[2,9.25833], // degree: 30
	[2.58492,9.85103], // degree: 33
	[3.2492,10.3992], // degree: 36
	[3.98782,10.8849], // degree: 39
	[4.7935,11.292], // degree: 42
	[5.65685,11.6066], // degree: 45
	[6.5666,11.8175], // degree: 48
	[7.50979,11.9163], // degree: 51
	[8.47214,11.8974], // degree: 54
	[9.43831,11.7585], // degree: 57
	[10.3923,11.5], // degree: 60
	[11.3178,11.1252], // degree: 63
	[12.1986,10.6399], // degree: 66
	[13.0189,10.052], // degree: 69
	[13.7638,9.37132], // degree: 72
	[14.4195,8.60899], // degree: 75
	[14.9738,7.77702], // degree: 78
	[15.4163,6.88789], // degree: 81
	[15.7385,5.9541], // degree: 84
	[15.9343,4.9877], // degree: 87
	[16,4], // degree: 90
	[15.9343,3.00123], // degree: 93
	[15.7385,2.00029], // degree: 96
	[15.4163,1.00464], // degree: 99
	[14.9738,0.0201742], // degree: 102
	[14.4195,-0.948734], // degree: 105
	[13.7638,-1.89919], // degree: 108
	[13.0189,-2.8296], // degree: 111
	[12.1986,-3.73951], // degree: 114
	[11.3178,-4.62931], // degree: 117
	[10.3923,-5.5], // degree: 120
	[9.43831,-6.35287], // degree: 123
	[8.47214,-7.18922], // degree: 126
	[7.50979,-8.01007], // degree: 129
	[6.5666,-8.81594], // degree: 132
	[5.65685,-9.6066], // degree: 135
	[4.7935,-10.3809], // degree: 138
	[3.98782,-11.1369], // degree: 141
	[3.2492,-11.8713], // degree: 144
	[2.58492,-12.5801], // degree: 147
	[2,-13.2583], // degree: 150
	[1.49713,-13.9001], // degree: 153
	[1.07661,-14.4992], // degree: 156
	[0.736389,-15.0488], // degree: 159
	[0.472136,-15.5423], // degree: 162
	[0.277401,-15.9729], // degree: 165
	[0.143799,-16.3347], // degree: 168
	[0.0612516,-16.6222], // degree: 171
	[0.0182736,-16.831], // degree: 174
	[0.00229361,-16.9576], // degree: 177
	[0,-17], // degree: 180
	[-0.00229361,-16.9576], // degree: 183
	[-0.0182736,-16.831], // degree: 186
	[-0.0612516,-16.6222], // degree: 189
	[-0.143799,-16.3347], // degree: 192
	[-0.277401,-15.9729], // degree: 195
	[-0.472136,-15.5423], // degree: 198
	[-0.736389,-15.0488], // degree: 201
	[-1.07661,-14.4992], // degree: 204
	[-1.49713,-13.9001], // degree: 207
	[-2,-13.2583], // degree: 210
	[-2.58492,-12.5801], // degree: 213
	[-3.2492,-11.8713], // degree: 216
	[-3.98782,-11.1369], // degree: 219
	[-4.7935,-10.3809], // degree: 222
	[-5.65685,-9.6066], // degree: 225
	[-6.5666,-8.81594], // degree: 228
	[-7.50979,-8.01007], // degree: 231
	[-8.47214,-7.18922], // degree: 234
	[-9.43831,-6.35287], // degree: 237
	[-10.3923,-5.5], // degree: 240
	[-11.3178,-4.62931], // degree: 243
	[-12.1986,-3.73951], // degree: 246
	[-13.0189,-2.8296], // degree: 249
	[-13.7638,-1.89919], // degree: 252
	[-14.4195,-0.948734], // degree: 255
	[-14.9738,0.0201742], // degree: 258
	[-15.4163,1.00464], // degree: 261
	[-15.7385,2.00029], // degree: 264
	[-15.9343,3.00123], // degree: 267
	[-16,4], // degree: 270
	[-15.9343,4.9877], // degree: 273
	[-15.7385,5.9541], // degree: 276
	[-15.4163,6.88789], // degree: 279
	[-14.9738,7.77702], // degree: 282
	[-14.4195,8.60899], // degree: 285
	[-13.7638,9.37132], // degree: 288
	[-13.0189,10.052], // degree: 291
	[-12.1986,10.6399], // degree: 294
	[-11.3178,11.1252], // degree: 297
	[-10.3923,11.5], // degree: 300
	[-9.43831,11.7585], // degree: 303
	[-8.47214,11.8974], // degree: 306
	[-7.50979,11.9163], // degree: 309
	[-6.5666,11.8175], // degree: 312
	[-5.65685,11.6066], // degree: 315
	[-4.7935,11.292], // degree: 318
	[-3.98782,10.8849], // degree: 321
	[-3.2492,10.3992], // degree: 324
	[-2.58492,9.85103], // degree: 327
	[-2,9.25833], // degree: 330
	[-1.49713,8.64031], // degree: 333
	[-1.07661,8.01693], // degree: 336
	[-0.736389,7.40831], // degree: 339
	[-0.472136,6.83406], // degree: 342
	[-0.277401,6.3127], // degree: 345
	[-0.143799,5.86103], // degree: 348
	[-0.0612516,5.49364], // degree: 351
	[-0.0182736,5.22239], // degree: 354
	[-0.00229361,5.05605], // degree: 357
];


