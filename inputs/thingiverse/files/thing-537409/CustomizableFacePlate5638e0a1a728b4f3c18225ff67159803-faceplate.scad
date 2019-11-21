
// preview[view:north west, tilt:top]
/* [Overall Dimensions] */

//length of the faceplate in mm
length=78;

//width of the faceplate in mm
width=43;

//thickness of the faceplate in mm
depth=3;

//the length scaling factor 0-1 ( use decimals )
scale_length=1; //[0.1,0.2,0.25,0.3,0.4,0.5,0.6,0.7,0.75,0.8,0.9,1]

//the width scaling factor 0-1 ( use decimals )
scale_width=1;//[0.1,0.2,0.25,0.3,0.4,0.5,0.6,0.7,0.75,0.8,0.9,1]

/* [Simple Ports] */

//the x,y location in mm (i.e. 25,21 34,31 )
usb_a="";

//the x,y location in mm (i.e. 25,21 34,31 )
usb_b="";

//the x,y location in mm (i.e. 25,21 34,31 )
usb_b_mini="";

//the x,y location in mm (i.e. 25,21 34,31 )
usb_b_micro="";

//the x,y location in mm (i.e. 25,21 34,31 )
usb_ab_micro="";

//the x,y location in mm (i.e. 25,21 34,31 )
sd="";

//the x,y location in mm (i.e. 25,21 34,31 )
sd_mini="";

//the x,y location in mm (i.e. 25,21 34,31 )
sd_micro="";

//the x,y location in mm (i.e. 25,21 34,31 )
ethernet="";

//the x,y location in mm (i.e. 25,21 34,31 )
coax_5_5mm="";

//the x,y location in mm (i.e. 25,21 34,31 )
coax_6mm="";

//the x,y location in mm (i.e. 25,21 34,31 )
coax_3_8mm="";

//the x,y location in mm (i.e. 25,21 34,31 )
coax_3_4mm="";

//the x,y location in mm (i.e. 25,21 34,31 )
vga="41,23";

//the x,y location in mm (i.e. 25,21 34,31 )
hdmi_micro="";

//the x,y location in mm (i.e. 25,21 34,31 )
dvi="";

//the x,y location in mm (i.e. 25,21 34,31 )
xlr="";

/* [Rotateable Ports] */

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
usb_a_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
usb_b_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
usb_b_mini_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
usb_b_micro_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
usb_ab_micro_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
sd_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
sd_mini_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
sd_micro_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
ethernet_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
vga_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
hdmi_micro_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
dvi_rotate="";

//the x,y,rotation_angle in mm (i.e. 25,21,45 34,31,90 )
xlr_rotate="";

/* [Generic Shapes] */

//the x,y,size in mm (i.e. 25,21,27 34,31,6 )
circle_new="14,31,6 22,31,6 30,31,6 3,3,3 72,3,3 72,37,3 3,37,3";

//the x,y,length,width in mm ( i.e. 32,23,43,54 76,87,23,1 )
rect="";

/* [Hidden] */
$fn=100;

scale( [ scale_length, scale_width,  1 ] )
difference( )
{
cube( [ length, width, depth ] );

//standard shapes
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( usb_a, "usb_a" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( usb_b, "usb_b" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( usb_b_mini, "usb_b_mini" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( usb_b_micro, "usb_b_micro" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( usb_ab_micro, "usb_ab_micro" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( sd, "sd" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( sd_mini, "sd_mini" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( sd_micro, "sd_micro" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( ethernet, "ethernet" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( coax_5_5mm, "coax_5_5mm" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( coax_6mm, "coax_6mm" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( coax_3_8mm, "coax_3_8mm" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( coax_3_4mm, "coax_3_4mm" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( vga, "vga" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( hdmi_micro, "hdmi_micro" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( dvi, "dvi" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( xlr, "xlr" );

//rotatable shapes
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( usb_a_rotate, "usb_a_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( usb_b_rotate, "usb_b_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( usb_b_mini_rotate, "usb_b_mini_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( usb_b_micro_rotate, "usb_b_micro_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( usb_ab_micro_rotate, "usb_ab_micro_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( sd_rotate, "sd_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( sd_mini_rotate, "sd_mini_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( sd_micro_rotate, "sd_micro_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( ethernet_rotate, "ethernet_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( vga_rotate, "vga_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( hdmi_micro_rotate, "hdmi_micro_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( dvi_rotate, "dvi_rot" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( xlr_rotate, "xlr_rot" );

//rotateable shapes

//generic shapes
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( circle_new, "circle" );
scale( [ 1/scale_length, 1/scale_width,  1 ] )
each_element( rect, "rectangle" );
}

module each_element( input_arr, type )
{
	input = [ " ", input_arr, " " ];
	result = search( " ", strcat( input ), 80 );
	//echo(result);
	for ( i = [ 0:len( result[ 0 ] ) - 2 ] )
	{
		if (len(search(",",substr(input_arr,result[0][i],result[0][i+1]-result[0][i]-1),80)[0]) == 1)
		{
			assign( input2 = [",",substr(input_arr,result[0][i],result[0][i+1]-result[0][i]-1),"," ] )
			scan_string_two( strcat(input2), type );
		}
		if (len(search(",",substr(input_arr,result[0][i],result[0][i+1]-result[0][i]-1),80)[0]) == 2)
		{
			assign( input2 = [",",substr(input_arr,result[0][i],result[0][i+1]-result[0][i]-1),"," ] )
			scan_string_three( strcat(input2), type );
		}
		if (len(search(",",substr(input_arr,result[0][i],result[0][i+1]-result[0][i]-1),80)[0]) == 3)
		{
			assign( input2 = [",",substr(input_arr,result[0][i],result[0][i+1]-result[0][i]-1),"," ] )
			scan_string_four( strcat(input2), type );
		}
	}
}

module scan_string_two( input_string, type )
{
	result = search(",", input_string,80);
	for ( i = [ 0:2:len(result[0])-2 ] )
	{	
		assign( first = strToInt(substr(substr(input_string,result[0][i],result[0][i+1]-result[0][i]),1,len(substr(input_string,result[0][i],result[0][i+1]-result[0][i]))-1)),
		second = strToInt(substr(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]),1,len(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]))-1)),
		third = 1,
		fourth = 0 )
		call_type( type, first, second, third, fourth );
	}
}

module scan_string_three( input_string, type )
{
	result = search(",", input_string,80);
	for ( i = [ 0:3:len(result[0])-3 ] )
	{	
		assign( first = strToInt(substr(substr(input_string,result[0][i],result[0][i+1]-result[0][i]),1,len(substr(input_string,result[0][i],result[0][i+1]-result[0][i]))-1)),
		second = strToInt(substr(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]),1,len(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]))-1)),
		third = strToInt(substr(substr(input_string,result[0][i+2],result[0][i+3]-result[0][i+2]),1,len(substr(input_string,result[0][i+2],result[0][i+3]-result[0][i+2]))-1)),
		fourth = 0 )
		call_type( type, first, second, third, fourth );
	}
}

module scan_string_four( input_string, type )
{
	result = search(",", input_string,80);
	for ( i = [ 0:4:len(result[0])-4 ] )
	{	
		assign( first = strToInt(substr(substr(input_string,result[0][i],result[0][i+1]-result[0][i]),1,len(substr(input_string,result[0][i],result[0][i+1]-result[0][i]))-1)),
		second = strToInt(substr(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]),1,len(substr(input_string,result[0][i+1],result[0][i+2]-result[0][i+1]))-1)),
		third = strToInt(substr(substr(input_string,result[0][i+2],result[0][i+3]-result[0][i+2]),1,len(substr(input_string,result[0][i+2],result[0][i+3]-result[0][i+2]))-1)),
		fourth = strToInt(substr(substr(input_string,result[0][i+3],result[0][i+4]-result[0][i+3]),1,len(substr(input_string,result[0][i+3],result[0][i+4]-result[0][i+3]))-1)) )
		call_type( type, first, second, third, fourth );
	}
}


module call_type ( type, first, second, third, fourth )
{
	if ( type == "usb_a" )
	{
		USB_A(first, second, 0);
	}
	if ( type == "usb_a_rot" )
	{
		USB_A(first, second, third);
	}
	if ( type == "usb_b" )
	{
		USB_B(first, second, 0);
	}
	if ( type == "usb_b_rot" )
	{
		USB_B(first, second, third);
	}
	if ( type == "usb_b_mini" )
	{
		Mini_USB_B(first, second, 0);
	}
	if ( type == "usb_b_mini_rot" )
	{
		Mini_USB_B(first, second, third);
	}
	if ( type == "usb_b_micro" )
	{
		Micro_USB_B(first,second, 0);
	}
	if ( type == "usb_b_micro_rot" )
	{
		Micro_USB_B(first, second, third);
	}
	if ( type == "usb_ab_micro" )
	{
		Micro_USB_AB(first, second, 0);
	}
	if ( type == "usb_ab_micro_rot" )
	{
		Micro_USB_AB(first, second, third);
	}
	if (type == "sd")
	{
		SD_Card(first,second, 0);
	}
	if ( type == "sd_rot" )
	{
		SD_Card(first, second, third);
	}
	if ( type == "sd_mini" )
	{
		Mini_SD_Card(first, second, 0);
	}
	if ( type == "sd_mini_rot" )
	{
		Mini_SD_Card(first, second, third);
	}
	if ( type == "sd_micro" )
	{
		Micro_SD_Card(first, second, 0);
	}
	if ( type == "sd_micro_rot" )
	{
		Micro_SD_Card(first, second, third);
	}
	if ( type == "ethernet" )
	{
		Ethernet( first, second, 0 );
	}
	if ( type == "ethernet_rot" )
	{
		Ethernet( first, second, third );
	}
	if ( type == "coax_5_5mm" )
	{
		Type_A_Coax_Pwr_5_5mm(first, second);
	}
	if ( type == "coax_6mm" )
	{
		Type_B_Coax_Pwr_6mm(first, second);
	}
	if ( type == "coax_3_8mm" )
	{
		Type_C_Coax_Pwr_3_8mm(first,second);
	}
	if ( type == "coax_3_4mm" )
	{
		Type_E_Coax_Pwr_3_4mm(first, second);
	} 	
	if ( type == "vga" )
	{
		VGA(first,second, 0);
	}
	if ( type == "vga_rot" )
	{
		VGA(first, second, third);
	}
	if ( type == "hdmi_micro" )
	{
		microHDMI(first,second, 0);
	}
	if ( type == "hdmi_micro_rot" )
	{
		microHDMI(first, second, third);
	}
	if ( type == "dvi" )
	{
		dvi(first, second, 0);
	}
	if ( type == "dvi_rot" )
	{
		dvi(first, second, third);
	}
	if ( type == "xlr" )
	{
		XLR(first, second, 0);
	}
	if ( type == "xlr_rot" )
	{
		XLR(first, second, third);
	}
	if ( type == "circle" )
	{
		GenericCircle(first, second, third);
	}
	if ( type == "rectangle" )
	{
		GenericRectangle( first, second, third, fourth );
	}

}

// modules
module USB_A (X,Y, angle ) 
{
	translate([X,Y,0])
	rotate( [ 0, 0, angle ] )
	cube([13.5,6.12,25]);
}

module USB_B (X,Y, angle ) 
{
	translate([X,Y,0])
	rotate( [ 0, 0, angle ] )
	cube([9.45,8.78,25]);
}

module Mini_USB_B (X,Y, angle ) 
{
	translate([X,Y,0])
	rotate( [ 0, 0, angle ] )
	cube([7.9,4.1,25]);
}

module Micro_USB_B (X,Y, angle ) 
{
	translate([X,Y,0])
	rotate( [ 0, 0, angle ] )
	cube([7.92,2.88,25]);
}

module Micro_USB_AB (X,Y, angle ) 
{
	translate([X,Y,0])
	rotate( [ 0, 0, angle ] )
	cube([7.92,2.88,25]);
}

module SD_Card (X,Y, angle ) 
{
	translate([X,Y,0])
	rotate( [ 0, 0, angle ] )
	cube([25,3.1,25]);
}

module Mini_SD_Card (X,Y, angle ) 
{
	translate([X,Y,0])
	rotate( [ 0, 0, angle ] )
	cube([21,2.4,25]);
}

module Micro_SD_Card (X,Y, angle ) 
{
	translate([X,Y,0])
	rotate( [ 0, 0, angle ] )
	cube([12,2,25]);
}

module Ethernet (X,Y, angle ) 
{
	translate([X,Y,0])
	rotate( [ 0, 0, angle ] )
	cube([12.56,8.82,25]);
}

module Type_A_Coax_Pwr_5_5mm(X,Y ) 
{
	rotate([-90])
	translate([X+(6.5/2),Y-(6.5/2),0])
	cylinder(h=20,d=6.5);
}

module Type_B_Coax_Pwr_6mm(X,Y, angle ) 
{
	rotate([-90])
	translate([X+(7/2),Y-(7/2),0])
	cylinder(h=20,d=7);
}

module Type_C_Coax_Pwr_3_8mm(X,Y, angle ) 
{
	rotate([-90])
	translate([X+(4.8/2),Y-(4.8/2),0])
	cylinder(h=20,d=4.8);
}

module Type_D_Coax_Pwr_6_3mm(X,Y, angle ) 
{
	rotate([-90])
	translate([X+(7.3/2),Y-(7.3/2),0])
	cylinder(h=20,d=7.3);
}

module Type_E_Coax_Pwr_3_4mm(X,Y, angle ) 
{
	rotate([-90])
	translate([X+(4.4/2),Y-(4.4/2),0])
	cylinder(h=20,d=4.4);
}

module VGA ( x, y, angle )
{
	translate([x,y,0])
	{
		rotate( [ 0, 0, angle ] )
		linear_extrude(25, center = true)
		union()
		{
			translate([4.6,0,0])
			difference()
			{
				square([19,10]);
				square([1,2.2]);
				translate([18,0]) square([1,2.2]);
				polygon(points = [[1,0],[2.75,0],[1,2.2]], paths = [[0,1,2]]);
				polygon(points = [[0,2.2],[0,7.4],[1,2.2]], paths = [[0,1,2]]);
				polygon(points = [[0,7.4],[0,10],[2,10]], paths = [[0,1,2]]);
				polygon(points = [[16.25,0],[18,2.2],[18,0]], paths = [[0,1,2]]);
				polygon(points = [[18,2.2],[19,7.4],[19,2.2]], paths = [[0,1,2]]);
				polygon(points = [[19,7.4],[17,10],[19,10]], paths = [[0,1,2]]);
			}//difference;//translate
			translate([1.6,5,0])circle(d = 3.2);
			translate([26.6,5,0])circle(d = 3.2);
		}
	}
}//end of vga

module microHDMI(x,y, angle )
{
	translate([x,y,0])
	{
		rotate( [ 0, 0, angle ] )
		linear_extrude(25,center = true)
		{
			difference() 
			{
				square([6.5,2.9]);
				polygon(points=[[0,0],[1.03,0],[0,1.07],[5.47,0],[6.5,0],[6.5,1.07]], paths=[[0,1,2],[3,4,5]]);
			}
		}
	}
}//end of microHDMI

module dvi(x,y, angle )
{
	translate([x,y,0])
	{
		rotate( [ 0, 0, angle ] )
		linear_extrude(25,center = true)
		{
			translate([4.95,0])
			{
				difference() 
				{
					square([25.8,9.3]);
					polygon(points=[[0,0],[.75,0],[0,4.5],[25.05,0],[25.8,0],[25.8,4.8]], paths=[[0,1,2],[3,4,5]]);
				}
			}
			translate([1.6,4.65]) {circle(d=3.2);
			}
			translate([34.1,4.65]) {circle(d=3.2);
			}
		}
	}
}//end of dvi

module XLR (x,y, angle )
{
	translate([x,y,0])
	rotate( [ 0, 0, angle ] )
	translate([12,12,0])linear_extrude(50,center = true) {union()
		{
			circle(d = 24);
			translate([-4.5,0,0])square([9,13]);
			translate([-9,11.5,0])circle(d = 3.2);
			translate([9,-11.5,0])circle(d = 3.2);
		}
	}
}//end of xlr

module GenericCircle (x,y, circleDia )
{

		translate([x,y,0]){
		translate([circleDia/2,circleDia/2])
		{
			cylinder(25, circleDia/2, center=true);
		}
	}
}// end of AudioJack

module GenericRectangle(x,y,length,width)
{
	translate([x,y,0])
	cube([length, width, 25]);
}


//openscad string library
//http://www.thingiverse.com/thing:202724
function strToInt(str, base=10, i=0, nb=0) = (str[0] == "-") ? -1*_strToInt(str, base, 1) : _strToInt(str, base);
function _strToInt(str, base, i=0, nb=0) = (i == len(str)) ? nb : nb+_strToInt(str, base, i+1, search(str[i],"0123456789ABCDEF")[0]*pow(base,len(str)-i-1));

function substr(data, i, length=0) = (length == 0) ? _substr(data, i, len(data)) : _substr(data, i, length+i);
function _substr(str, i, j, out="") = (i==j) ? out : str(str[i], _substr(str, i+1, j, out));

function strcat(v, car="") = _strcat(v, len(v)-1, car, 0);
function _strcat(v, i, car, s) = (i==s ? v[i] : str(_strcat(v, i-1, car, s), str(car,v[i]) ));