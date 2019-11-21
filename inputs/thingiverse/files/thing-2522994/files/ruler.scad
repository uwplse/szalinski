// One ruler to ring them all.
//
// Generate any kind of scale ruler you like.
//
// uses my autoUnits library
//    https://www.thingiverse.com/thing:2422539
//
// Licensed under Creative Commons: Attribution, Share-Alike
//		http://creativecommons.org/licenses/by-sa/3.0/
// For attribution you can direct people to the original file on thingiverse:
// 		http://www.thingiverse.com/thing:2522994

/* [physical shape] */

// one or two sided
sides=2; // [1:1,2:2]

// in any units
au_ruler_width="1in";

// in any units (if 0, length is "best fit") (make sure this is big enough or weirdness may result) (in fact, just leave it alone)
au_ruler_length="0";

// physical thickness of the ruler in any units
au_ruler_thickness="1/8in";

// minimal thickness of the ruler in any units (for a rectangular ruler, set to the same as ruler_thickness)
au_ruler_min_thickness="0.2mm";

// ink channel size in any units (can be 0)
au_ruler_ink_channel="0.5mm";

// in any units
au_center_gullet="2.5mm";


/* [side1 title] */

// leave this blank if you don't want a title
s1_title="Centimeters";

// how tall the title is (in any units)
s1_au_title_height="3mm";


/* [side1 numbering] */

// convert from ruler units to actual mm in any units
s1_au_conversion_factor="10mm";

// can be greater than end_number for a count-down ruler
s1_start_number=1;

s1_end_number=30;

// in any units
s1_au_number_height="4mm";

// rotate individual numbers
s1_number_angle=0;


/* [side1 tick marks] */

// how high the tick is in mm (above the surface of the ruler) (can be negative)
s1_tick_height=-0.5;

// how wide the tick is in mm
s1_tick_width=0.2;

// for instance base2=[1,1/2,1/4,1/8,...] base10=[1,1/10,1/100,...]
s1_tick_base=10; 

// smallest tick value
s1_tick_min_fraction=10;

// shrink each subsequent base by this percent
s1_tick_scale=0.66;


/* [side2 title] */

// leave this blank if you don't want a title
s2_title="Inches";

// how tall the title is (in any units)
s2_au_title_height="3mm";


/* [side2 numbering] */

// convert from ruler units to actual mm in any units
s2_au_conversion_factor="1in";

// can be greater than end_number for a count-down ruler
s2_start_number=1;

s2_end_number=12;

// in any units
s2_au_number_height="4mm";

// rotate individual numbers
s2_number_angle=0;


/* [side2 tick marks] */

// how high the tick is in mm (above the surface of the ruler) (can be negative)
s2_tick_height=-0.5;

// how wide the tick is in mm
s2_tick_width=0.2;

// for instance base2=[1,1/2,1/4,1/8,...] base10=[1,1/10,1/100,...]
s2_tick_base=2; 

// smallest tick value
s2_tick_min_fraction=16;

// shrink each subsequent base by this percent
s2_tick_scale=0.66;


/* [hidden] */

// ------------------------- autoUnits

// This table is the conversion factor from any units to mm.
// Feel free to add to it if you like.
unitsTable=[
	["",1], // whatever you want the default units to be if not specified
	["mm",1],
	["cm",10],
	["in",25.4],
	["ft",304.8],
	["\"",25.4], // handle the " notation for inches
	["'",304.8], // handle the ' notation for feet
	["thou",0.0254],
	["mil",0.0254]
	];
// fetch a conversion factor from the above table (please keep unit in lower case!)
function unit_factor(unit)=unitsTable[search([unit],unitsTable,num_returns_per_match=1)[0]][1];
// convert any value in unit into mm
function tomm(val,unit)=val*unit_factor(unit);

// some useful constants
digits="0123456789";
uppercase="ABCDEFGHIJKLMOPQRSTUVWXYZ";
lowercase="abcdefghijklmopqrstuvwxyz";

// some useful string functions
function isDigit(char)=len(search(char,digits))>0;
function toDigit(char)=search(char,digits)[0];
function isUppercase(char)=len(search(char,uppercase))>0;
function isLowercase(char)=len(search(char,lowercase))>0;
function isAlpha(char)=isLowercase(char)||isUppercase(char);
function isWhitespace(char)=(char==" ");
function toLowerCaseChar(char)=isUppercase(char)?lowercase[search(char,uppercase)[0]]:char;
	
// usually all you want to send is string, but you can also pass in:
//    i= the string position to start at
//    multiplier= something to multiply the value by BEFORE unit conversion
function autounits(string,i=0,phase=0,decimalPlace=1,multiplier=1,whole=0.0,numerator=0.0,denominator=0.0,units="")= 
	i==len(string)?(
		//[multiplier,whole,numerator,denominator,units] // uncomment this and comment below for debugging
		tomm(multiplier*(whole+(denominator==0?0:numerator/denominator)),units) // if this is the end, add up the parts and return what we've got
	):phase==3?( // phase 3, so everything from here on out is units string
		isWhitespace(string[i])?( // skip all whitespace
			autounits(string,i+1,phase,decimalPlace,multiplier,whole,numerator,denominator,units)
		):( // lowercase it and append to existing string
			autounits(string,i+1,phase,decimalPlace,multiplier,whole,numerator,denominator,str(units,toLowerCaseChar(string[i])))
		)
	):isDigit(string[i])?(
		phase==0?( // whole number
			decimalPlace==1?( // working on whole numbers
				autounits(string,i+1,phase,decimalPlace,multiplier,whole*10+toDigit(string[i]),numerator,denominator,units)
			):( // working on decimal places
				autounits(string,i+1,phase,decimalPlace*10,multiplier,whole+toDigit(string[i])/decimalPlace,numerator,denominator,units)
			)
		):phase==1?( // numerator
			decimalPlace==1?( // working on whole numbers
				autounits(string,i+1,phase,decimalPlace,multiplier,whole,numerator*10+toDigit(string[i]),denominator,units)
			):( // working on decimal places
				autounits(string,i+1,phase,decimalPlace*10,multiplier,whole,numerator+toDigit(string[i])/decimalPlace,denominator,units)
			)
		):phase==2?( // denominator
			decimalPlace==1?( // working on whole numbers
				autounits(string,i+1,phase,decimalPlace,multiplier,whole,numerator,denominator*10+toDigit(string[i]),units)
			):( // working on decimal places
				autounits(string,i+1,phase,decimalPlace*10,multiplier,whole,numerator,denominator+toDigit(string[i])/decimalPlace,units)
			)
		):undef // this is unreachable code
	):string[i]=="."?( // a decimal point
		autounits(string,i+1,phase,10,multiplier,whole,numerator,denominator,units)
	):isWhitespace(string[i])?( // whitespace
		(phase==0&&whole!=0)?( // advance to phase 1 and reset the decimal place
			autounits(string,i+1,1,1,multiplier,whole,numerator,denominator,units)
		):( // just skip it
			autounits(string,i+1,phase,decimalPlace,multiplier,whole,numerator,denominator,units)
		)
	):string[i]=="/"?( // fraction separator, advance to phase 2 and reset the decimal place
		numerator==0?( // looks what we called a whole should be our numerator. Better swap them!
			autounits(string,i+1,2,1,multiplier,numerator,whole,denominator,units)
		):( // simply advance
			autounits(string,i+1,2,1,multiplier,whole,numerator,denominator,units)
		)
	):string[i]=="-"?( // is it a negative number?
		(phase==0&&whole==0)?( // is this a valid place for a minus sign?
			autounits(string,i+1,phase,decimalPlace,multiplier*(-1),whole,numerator,denominator,units)
		):( // No. So just skip it.
			autounits(string,i+1,phase,decimalPlace,multiplier,whole,numerator,denominator,units)
		)
	):( // Some other character. Advance to phase 3 and start building the units string
		autounits(string,i+1,3,1,multiplier,whole,numerator,denominator,toLowerCaseChar(string[i]))
	);

// ------------------------ ruler stuff

module ruler_frame(len_mm,ruler_width,ruler_thickness,ruler_min_thickness=0.2,ruler_ink_channel=0.5){
	ink_channel=ruler_ink_channel<0?0:ruler_ink_channel;
	offset=ruler_min_thickness+ink_channel;
	angle=atan((ruler_thickness-offset)/ruler_width);
	difference(){
		cube([len_mm,ruler_width,ruler_thickness]);
		if(offset<ruler_thickness){ // cut the angle
			translate([0,0,offset]) rotate([angle,0,0]) translate([-1,0,0]) cube([len_mm+2,ruler_width*2,ruler_thickness]);
		}
		if(ink_channel>0){ // cut the ink channel
			translate([-1,0,0]) rotate([0,90,0]) cylinder(r=ink_channel,h=len_mm+2);
		}
	}
}

module tickmark(d,w,h){
	translate([-w/2,0,0]) cube([w,h,d]);
}

module ruler_ticks(tick_x,tick_span,tick_max_x,tick_len,
	tick_height=0.5,tick_width=0.2,tick_base=2,tick_min=1/8,tick_scale=0.66,tick_level=1)
{
	for(x=[tick_x:tick_span:tick_max_x]) translate([x,0,0]) {
		tickmark(tick_height,tick_width,tick_len);
		if(tick_level/tick_base>=tick_min){
			ruler_ticks(0,tick_span/tick_base,tick_span,tick_len*tick_scale,
				tick_height,tick_width,tick_base,tick_min,tick_scale,tick_level/tick_base);
		}
	}
}

module numbers(start_inset,start_number,conversion_factor,end_number,number_height=10,number_angle=0){
	if(end_number>=start_number){
		for(i=[0:end_number-start_number]){
			translate([i*conversion_factor,0,0]) rotate([0,0,number_angle]) text(str(i+start_number),size=number_height);
		}
	}else{
		for(i=[0:start_number-end_number]){
			translate([i*conversion_factor,0,0]) rotate([0,0,number_angle]) text(str(start_number-i),size=number_height);
		}
	}
}

// covers numbers, title, and tick marks
module markings(
	title="",title_height=5,
	conversion_factor=24.5,start_number=1,end_number=10,number_height=10,number_angle=0,
	tick_height=0.5,tick_width=0.2,tick_base=2,tick_min=1/8,tick_scale=0.66,
	ruler_width=24.5,ruler_thickness=2,start_inset=0,end_inset=0)
{
	title_margin=0.5;
	title_height=(title==""||title_height<=0)?0:title_height;
	span=abs(start_number-end_number)*conversion_factor;
	totalLen=start_inset+span+end_inset;
	//intersection(){
		//cube([totalLen,ruler_width,tick_height]);
		union(){
			if(title_height>0){
				translate([title_margin,ruler_width-title_height+title_margin,0]) linear_extrude(tick_height) {
					if(number_angle%360>90&&number_angle%360<270){ // flip the label
						translate([totalLen-title_margin,title_height-title_margin,0]) rotate([0,0,180]) text(title,size=title_height-title_margin*2);
					}else{
						text(title,size=title_height-title_margin*2);
					}
				}
			}
			ruler_ticks(tick_x=start_inset,tick_span=conversion_factor,tick_max_x=start_inset+span+0.0001,tick_len=ruler_width,
				tick_height=tick_height,tick_width=tick_width,tick_base=tick_base,tick_min=tick_min,tick_scale=tick_scale);
			translate([0,ruler_width-number_height-title_height,0]) linear_extrude(tick_height) numbers(start_inset,start_number,conversion_factor,end_number,number_height,number_angle);
		}
	//}
}

module ruler(
	title="",title_height=5,
	conversion_factor=24.5,start_number=1,end_number=10,number_height=10,number_angle=0,
	tick_height=0.5,tick_width=0.2,tick_base=2,tick_min=1/8,tick_scale=0.66,
	ruler_width=24.5,ruler_thickness=2,ruler_min_thickness=0.2,ruler_ink_channel=0.5,
	start_inset=0,end_inset=0)
{
	span=abs(start_number-end_number)*conversion_factor;
	totalLen=start_inset+span+end_inset;
	ink_channel=ruler_ink_channel<0?0:ruler_ink_channel;
	offset=ruler_min_thickness+ink_channel;
	angle=atan((ruler_thickness-offset)/ruler_width);
	if(tick_height>0){
		ruler_frame(totalLen,ruler_width,ruler_thickness,ruler_min_thickness=ruler_min_thickness,ruler_ink_channel=ruler_ink_channel);
		translate([0,0,offset]) rotate([angle,0,0]) markings(
			title=title,title_height=title_height,
			conversion_factor=conversion_factor,start_number=start_number,end_number=end_number,number_height=number_height,number_angle=number_angle,
			tick_height=abs(tick_height),tick_width=tick_width,tick_base=tick_base,tick_min=tick_min,tick_scale=tick_scale,
			ruler_width=ruler_width,ruler_thickness=ruler_thickness,start_inset=start_inset,end_inset=end_inset);
	} else difference() {
		ruler_frame(totalLen,ruler_width,ruler_thickness,ruler_min_thickness=ruler_min_thickness,ruler_ink_channel=ruler_ink_channel);
		translate([0,0,tick_height+0.01+offset]) rotate([angle,0,0]) markings(
			title=title,title_height=title_height,
			conversion_factor=conversion_factor,start_number=start_number,end_number=end_number,number_height=number_height,number_angle=number_angle,
			tick_height=abs(tick_height),tick_width=tick_width,tick_base=tick_base,tick_min=tick_min,tick_scale=tick_scale,
			ruler_width=ruler_width,ruler_thickness=ruler_thickness,start_inset=start_inset,end_inset=end_inset);	
	}
}

function actualLength(start_number,end_number,conversion_factor,start_inset=0,end_inset=0)=start_inset+(abs(start_number-end_number)*conversion_factor)+end_inset;



s1_title_height=autounits(s1_au_title_height);
s1_conversion_factor=autounits(s1_au_conversion_factor);
s1_number_height=autounits(s1_au_number_height);
s1_tick_min=1/s1_tick_min_fraction;

s2_title_height=autounits(s2_au_title_height);
s2_conversion_factor=autounits(s2_au_conversion_factor);
s2_number_height=autounits(s2_au_number_height);
s2_tick_min=1/s2_tick_min_fraction;

ruler_length=(au_ruler_length==""||au_ruler_length=="0")?
		max(
			actualLength(s1_start_number,s1_end_number,s1_conversion_factor),
			sides>1?actualLength(s2_start_number,s2_end_number,s2_conversion_factor):0
		)
	:
		autounits(au_ruler_length);

center_gullet=autounits(au_center_gullet);
ruler_width=autounits(au_ruler_width);
ruler_thickness=autounits(au_ruler_thickness);
ruler_min_thickness=autounits(au_ruler_min_thickness);
ruler_ink_channel=autounits(au_ruler_ink_channel);

side_w=sides>1?ruler_width/2-center_gullet:ruler_width;
s1_inset=(ruler_length-actualLength(s1_start_number,s1_end_number,s1_conversion_factor))/2;
s2_inset=(ruler_length-actualLength(s2_start_number,s2_end_number,s2_conversion_factor))/2;

translate([-ruler_length/2,-center_gullet/2-side_w,0]) ruler(
	title=s1_title,title_height=s1_title_height,
	conversion_factor=s1_conversion_factor,start_number=s1_start_number,end_number=s1_end_number,number_height=s1_number_height,number_angle=s1_number_angle,
	tick_height=s1_tick_height,tick_width=s1_tick_width,tick_base=s1_tick_base,tick_min=s1_tick_min,tick_scale=s1_tick_scale,
	ruler_width=side_w,ruler_thickness=ruler_thickness,ruler_min_thickness=ruler_min_thickness,ruler_ink_channel=ruler_ink_channel,
	start_inset=s1_inset,end_inset=s1_inset);
if(sides>1){
	// the other side of the ruler
	rotate([0,0,180]) translate([-ruler_length/2,-center_gullet/2-side_w,0]) ruler(
		title=s2_title,title_height=s2_title_height,
		conversion_factor=s2_conversion_factor,start_number=s2_start_number,end_number=s2_end_number,number_height=s2_number_height,number_angle=s2_number_angle,
		tick_height=s2_tick_height,tick_width=s2_tick_width,tick_base=s2_tick_base,tick_min=s2_tick_min,tick_scale=s2_tick_scale,
		ruler_width=side_w,ruler_thickness=ruler_thickness,ruler_min_thickness=ruler_min_thickness,ruler_ink_channel=ruler_ink_channel,
		start_inset=s2_inset,end_inset=s2_inset);
	// the center gullet
	if(center_gullet>0) difference() {
		translate([-ruler_length/2,-center_gullet/2,0]) cube([ruler_length,center_gullet,ruler_thickness]);
		rotate([0,90,0]) translate([0,0,-ruler_length/2-1]) cylinder(r=center_gullet/2,h=ruler_length+2);
	}
}