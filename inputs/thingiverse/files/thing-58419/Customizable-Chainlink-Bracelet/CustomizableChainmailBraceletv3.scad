// preview[view:south east, tilt:top]

///////////////////////////////////////////////////////////////////////////
//////                   User defined parameters           ///////////////
///////////////////////////////////////////////////////////////////////////

//About what length bracelet do you want?
total_approximate_length=195; //[50:220]

//How big should the links be?
link_size=1;//[1:7]

//What's the primary color?
primary_color="black"; //[black,silver,gray,white,maroon,red,purple,fuchsia,green,lime,olive,yellow,navy,blue,teal,aqua]

//What's the secondary color?
secondary_color="white"; //[black,silver,gray,white,maroon,red,purple,fuchsia,green,lime,olive,yellow,navy,blue,teal,aqua]

//What bracelet pattern do you want to use?
design="makerbot logo"; //[makerbot logo,custom,bands,stripes,bold diagonals,diagonals,diagonal gaps,criss cross,criss cross gaps,5 threads,ladder,woven,tight woven]

//Some designs have variable width, including custom designs.  How wide should your bracelet be, in number of links?
bracelet_width=8; //[1:10]

//Number of lines in your custom pattern, up to 10
custom_pattern_lines=3; //[1:10]

//<b>Please follow this format in each row! [1,1,1,1,1,1,1,1,1,1]</b><br/>Use 1 for primary color, 2 for secondary color, 0 for gaps.  <b>Strongly recommend filling these out while a non-custom pattern is selected, then switching to custom when you're ready.</b>
custom_line_1="no input";
custom_line_2="no input";
custom_line_3="no input";
custom_line_4="no input";
custom_line_5="no input";
custom_line_6="no input";
custom_line_7="no input";
custom_line_8="no input";
custom_line_9="no input";
custom_line_10="no input";


//Layer thickness you intend to print at
layer_thick = 0.27;  //filament layer thickness

//Line width you intend to print at
line_width = 0.4;    //filament line width, = layer thickness * width/thickness

//It's possible to adjust the clasp tolerance depending on your printer settings
clasp_tolerance=.6;

//Leave this parameter on 'Solid'.  The parameter is required to allow the design to output 3 files - one for printing in a solid color and 2 for printing using dualstrusion.  
part = "Solid"; //[Solid,PrimaryColor,SecondaryColor]



///////////////////////////////////////////////////////////////////////////
//////                    non-user defined parameters           /////////
module void(){}///////////////////////////////////////////////////////

tol=clasp_tolerance;

b_width = link_size+1;	//block width in lines
b_height = 3*(link_size+1)*round(.27/layer_thick);    //block height in layers
d_height = (link_size+1)*round(.27/layer_thick); 	//diagonals height in lines

echo(round(.27/layer_thick));

r_halfwidth = .95+1.5*line_width*b_width+0.45; //ring inner half width
corner = tan(22.5)*line_width*b_width;  	  //fills in corner between block and diagonal

custom_pattern=[custom_line_1,custom_line_2,custom_line_3,custom_line_4,custom_line_5,custom_line_6,custom_line_7,custom_line_8,custom_line_9,custom_line_10];



///////////////////////////////////////////////////////////////////////////
//////                    Primary Rendering                         /////////
///////////////////////////////////////////////////////////////////////////

if(design=="custom")bracelet(custom_pattern_lines,bracelet_width,custom_pattern);

if(design=="diagonals")bracelet(patlines=3,patrows=bracelet_width,pattern=[
	[1,1,2,1,1,2,1,1,2,1],
	[2,1,1,2,1,1,2,1,1,2],
	[1,2,1,1,2,1,1,2,1,1]
]);

if(design=="bold diagonals")bracelet(patlines=4,patrows=bracelet_width,pattern=[
	[1,1,2,2,1,1,2,2,1,1],
	[2,1,1,2,2,1,1,2,2,1],
	[2,2,1,1,2,2,1,1,2,2],
	[1,2,2,1,1,2,2,1,1,2]
]);

if(design=="stripes")bracelet(patlines=1,patrows=bracelet_width,pattern=[
	[1,2,1,2,1,2,1,2,1,2]
]);

if(design=="bands")bracelet(patlines=4,patrows=bracelet_width,pattern=[
	[1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1],
	[2,2,2,2,2,2,2,2,2,2],
	[2,2,2,2,2,2,2,2,2,2]
]);

if(design=="diagonal gaps")bracelet(patlines=4,patrows=7,pattern=[
	[1,2,0,0,1,2,1],
	[1,0,0,1,2,0,1],
	[1,0,1,2,0,0,1],
	[1,1,2,0,0,1,1]
]);

if(design=="makerbot logo")bracelet(patlines=10,patrows=9,pattern=[
	[1,1,1,1,1,1,1,1,1,0],
	[1,1,2,2,2,2,2,1,1,0],
	[1,2,1,1,1,1,1,2,1,0],
	[2,1,2,2,2,2,2,1,2,0],
	[2,1,2,1,2,1,2,1,2,0],
	[2,1,2,1,2,1,2,1,2,0],
	[2,1,2,1,2,1,2,1,2,0],
	[1,2,1,1,1,1,1,2,1,0],
	[1,1,2,2,2,2,2,1,1,0],
	[1,1,1,1,1,1,1,1,1,0]
]);

if(design=="criss cross")bracelet(patlines=7,patrows=7,pattern=[
	[2,1,1,1,1,1,2],
	[1,2,1,1,1,2,1],
	[1,1,2,1,2,1,1],
	[1,1,1,2,1,1,1],
	[1,1,2,1,2,1,1],
	[1,2,1,1,1,2,1],
	[2,1,1,1,1,1,2]
]);

if(design=="criss cross gaps")bracelet(patlines=6,patrows=7,pattern=[
	[2,2,0,0,0,1,2],
	[2,1,0,0,0,2,2],
	[1,1,1,0,2,2,1],
	[1,0,1,2,2,0,1],
	[1,0,2,2,1,0,1],
	[1,2,2,0,1,1,1]
]);

if(design=="5 threads")bracelet(patlines=1,patrows=9,pattern=[
	[1,0,1,0,1,0,2,0,2],
]);

if(design=="ladder")bracelet(patlines=3,patrows=7,pattern=[
	[1,1,1,1,1,1,1],
	[2,0,0,0,0,0,2],
	[2,0,0,0,0,0,2]
]);

if(design=="tight woven")bracelet(patlines=4,patrows=9,pattern=[
	[1,1,2,1,1,1,2,1,1],
	[2,0,2,0,2,0,2,0,2],
	[2,1,1,1,2,1,1,1,2],
	[2,0,2,0,2,0,2,0,2]
]);

if(design=="woven")bracelet(patlines=6,patrows=10,pattern=[
	[1,1,1,2,1,1,1,1,1,2],
	[2,0,0,2,0,0,2,0,0,2],
	[2,0,0,2,0,0,2,0,0,2],
	[2,1,1,1,1,1,2,1,1,1],
	[2,0,0,2,0,0,2,0,0,2],
	[2,0,0,2,0,0,2,0,0,2]
]);




///////////////////////////////////////////////////////////////////////////////////////////
////////////////////////        Pattern Handling  & Bracelet Build    /////////////////
///////////////////////////////////////////////////////////////////////////////////////////


module bracelet(patlines,patrows,pattern){

	clasplen=2*1.7*(r_halfwidth+b_width*line_width);
	claspw=(patrows-1)*(2*r_halfwidth-.45)+2*(r_halfwidth+b_width*line_width);
	clasph=layer_thick*b_height;
	numteeth=mod((claspw-4)/clasplen);
	toothspace=(claspw-4)/numteeth;
	toothoffset=toothspace/2+2;

	totlines=mod((total_approximate_length-clasplen)/(2*r_halfwidth-.45));
	patlen=(totlines-1)*(2*r_halfwidth-.45);
	totlen=patlen+clasplen;
	totpats=mod(totlines/patlines);
	remlines=totlines-totpats*patlines;
	
	echo(patlen,totlen,totlines,totpats,remlines);

	translate([-patlen/2,-claspw/2,0]){

		if(part=="Solid" || part=="PrimaryColor")difference(){
	
			union(){
			
				for(k=[0:totpats-1])
					translate([k*patlines*(2*r_halfwidth-.45),0,0])
					buildpattern1(pattern,patlines,patrows);
				if(remlines!=0)translate([totpats*patlines*(2*r_halfwidth-.45),0,0])
					buildpattern1(pattern,remlines,patrows);
				
				color(primary_color){
					translate([-clasplen*2/3,-r_halfwidth-b_width*line_width,0])
						cube([clasplen*2/3,claspw,clasph]);
					translate([patlen,-r_halfwidth-b_width*line_width,0])
						cube([clasplen/3,claspw,clasph]);
				}
	
				color(primary_color)for(i=[0:numteeth-1])
					translate([patlen+clasplen/3,-r_halfwidth-b_width*line_width+toothoffset+i*toothspace,0])
					linear_extrude(height = clasph)
					polygon([[0,clasplen/6],[clasplen/3,clasplen/3],[clasplen/3,-clasplen/3],[0,-clasplen/6]],[[0,1,2,3]]);
	
			}
	
			color(primary_color)for(i=[0:numteeth-1])
				translate([-clasplen*2/3,-r_halfwidth-b_width*line_width+toothoffset+i*toothspace,-.05])
				linear_extrude(height = clasph+.1)
				polygon([[0,clasplen/6+tol],[clasplen/3,clasplen/3+tol],[clasplen/3,-clasplen/3-tol],[0,-clasplen/6-tol]],[[0,1,2,3]]);
	
		}
	
	
		if(part=="Solid" || part=="SecondaryColor")difference(){
		
			union(){
				for(k=[0:totpats-1])
					translate([k*patlines*(2*r_halfwidth-.45),0,0])
					buildpattern2(pattern,patlines,patrows);
				if(remlines!=0)translate([totpats*patlines*(2*r_halfwidth-.45),0,0])
					buildpattern2(pattern,remlines,patrows);
			}
			
			color(primary_color)
				for(i=[-r_halfwidth-b_width*line_width,patlen])
				translate([i,-r_halfwidth-b_width*line_width,-.05])
					cube([r_halfwidth+b_width*line_width,
						(patrows-1)*(2*r_halfwidth-.45)+2*(r_halfwidth+b_width*line_width),
						layer_thick*b_height+.1]);
	
		}
	}
}


module buildpattern1(pattern,lines,rows){
	for(j=[0:min(len(pattern),lines)-1]){
		translate([j*(2*r_halfwidth-.45),0,0])readline1(pattern[j],rows);
	}
}

module buildpattern2(pattern,lines,rows){
	for(j=[0:min(len(pattern),lines)-1]){
		translate([j*(2*r_halfwidth-.45),0,0])readline2(pattern[j],rows);
	}
}

module readline1(linearray,rows){
	for(i=[0:min(len(linearray),rows)-1]){
		translate([0,i*(2*r_halfwidth-.45),0]){
			if(linearray[i]==1)ring1();
		}
	}
}

module readline2(linearray,rows){
	for(i=[0:min(len(linearray),rows)-1]){
		translate([0,i*(2*r_halfwidth-.45),0]){
			if(linearray[i]==2)ring2();
		}
	}
}

module ring1(){
	color(primary_color)ring();
}

module ring2(){
	color(secondary_color)ring();
}

function mod(num)=round(num)+min((num+.000001-round(num))/abs(num+.000001-round(num)),0);

/////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////          Core chainmail code      //////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

module ring(){

	module blocks()  {		//four blocks
		for (i = [0:3]){		
		rotate([0,0,90*i])
			translate([-0.6001,r_halfwidth,0])
				cube([1.2002,line_width*b_width,layer_thick*b_height]); }
	}

	module diagonal() 	{	//thin diagonals
		mirror([-1,1,0])
		translate([0.6,r_halfwidth,0])
		union() {
			cube([corner,line_width*b_width,layer_thick*d_height]);
			rotate([0,0,-45])
				translate([-corner,0,0])
				cube([corner,line_width*b_width,layer_thick*d_height]);
		}
		translate([0.6,r_halfwidth,0])
		union() {
			cube([corner,line_width*b_width,layer_thick*d_height]);
			rotate([0,0,-45])
				translate([-corner,0,0])
				cube([corner,line_width*b_width,layer_thick*d_height]);
			rotate([0,0,-45])
				cube([sqrt(2)*(r_halfwidth-0.6),line_width*b_width,layer_thick*d_height]);
		}	
	}

	module 4_diagonals()	{ //all four diagonals
		union(){
			diagonal();
			mirror([1,1,0]) diagonal(); 
		}
		translate([0,0,layer_thick*(b_height-d_height)]) 
		union(){
			rotate([0,0,90]) diagonal();
			rotate([0,0,-90]) diagonal(); 
		}				
	}

	union(){
		blocks();
		4_diagonals();	
	}	
}



