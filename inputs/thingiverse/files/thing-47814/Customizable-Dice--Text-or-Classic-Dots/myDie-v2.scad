include <write/Write.scad>;
// How Wide Is the Die?
die_width = 16;  //[5:20]
//What Color Would You Like The Die
Die_Color = "red"; //[red,green,blue,yellow,white]
//What Color Would You Like The Symbols
Symbol_Color = "white"; //[red,green,blue,yellow,white]
//Adjust the resolution
resolution = 22;//[22:36]
$fn=resolution;
//Max distance from center of side
m_dist = die_width/4; 

// Do you want the corners rounded off?
rounded = 1; //[1:True,0:False]
//Set to output just the symbols for dual extrusion
dual_extrusion = 0;//[0:off,1:Symbols]

//Choose Type: If Dots is Selected Your Character Entry is ignored
side_1_mode = 1; //[0:Dots,1:Characters]
side_1_characters = "!";
side_1_size = 8; 
side_1_rotation = 45;
side_1_font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose]

//Choose Type: If Dots is Selected Your Character Entry is ignored
side_2_mode = 0; //[0:Dots,1:Characters]
side_2_characters = "Two" ;
side_2_size = 3; 
side_2_rotation = 0;
side_2_font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose]
	
//Choose Type: If Dots is Selected Your Character Entry is ignored
side_3_mode = 0; //[0:Dots,1:Characters]
side_3_characters = "Three";
side_3_size = 3; 
side_3_rotation = 0;
side_3_font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose]

//Choose Type: If Dots is Selected Your Character Entry is ignored
side_4_mode = 0; //[0:Dots,1:Characters]
side_4_characters = "Four";
side_4_size = 3;
side_4_rotation = 0; 
side_4_font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose]
	
//Choose Type: If Dots is Selected Your Character Entry is ignored
side_5_mode = 0; //[0:Dots,1:Characters]
side_5_characters = "Five";
side_5_size = 3;
side_5_rotation = 0; 
side_5_font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose]

//Choose Type: If Dots is Selected Your Character Entry is ignored
side_6_mode = 0; //[0:Dots,1:Characters]
side_6_characters = "Six";
side_6_size = 3;
side_6_rotation = 0; 
side_6_font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose]
main(); //runs program

module main(){
	if(dual_extrusion  == 0){
		difference(){

			die_cube();
			color(Symbol_Color)sides();
		}

	}
	else if(dual_extrusion == 1){
		intersection(){
			color(Symbol_Color) die_cube();
			color(Symbol_Color)sides();
		}

	}
	else{
		
		}
}
	






module die_cube(){
	if(rounded){
		intersection(){
			color(Die_Color) cube(size=die_width,center=true);
			color(Die_Color) sphere(r=die_width*.7,center=true);
		}

	}else{
		color(Die_Color) cube(size=die_width,center=true);
	}
}

module sides(){
	side1();
	side2();
	side3();
	side4();
	side5();
	side6();
}
module side1(){
	textDepth= die_width/15;
	if(side_1_mode==1){
		//character mode
		
		writecube(side_1_characters,where=[0,0,0], size=die_width, t=textDepth,h = side_1_size,face = "front",rotate= side_1_rotation,font=side_1_font
);
	}
	else {
		//dot mode
		translate([0,-die_width/2,0])sphere(r=side_1_size/2,center=true);
	}

}
module side2(){
	textDepth= die_width/15;
	if(side_2_mode){
		//character mode
		writecube(side_2_characters, where= [0,0,0], size = die_width, t=textDepth,h = side_2_size,face = "top",rotate = side_2_rotation,font=side_2_font);
	}
	else {
		//dot mode
		rotate(side_2_rotation,[0,0,1]){ 
		
			translate([m_dist,m_dist,die_width/2])sphere(r=side_2_size/2,center=true);
			translate([-m_dist,-m_dist,die_width/2])sphere(r=side_2_size/2,center=true);
		}
	}

}
module side3(){
	textDepth= die_width/15;
	if(side_3_mode){
		//character mode
		writecube(side_3_characters, where= [0,0,0], size = die_width, t=textDepth,h = side_3_size,face = "right",rotate = side_3_rotation,font=side_3_font);
	}
	else {
		//dot mode
		rotate(side_3_rotation,[1,0,0]){ 
		
			translate([die_width/2,-m_dist,m_dist])sphere(r=side_3_size/2,center=true);
			translate([die_width/2,m_dist,-m_dist])sphere(r=side_3_size/2,center=true);
			translate([die_width/2,0,0])sphere(r=side_3_size/2,center=true);
			
		}
	}

}
module side4(){
	textDepth= die_width/15;
	if(side_4_mode){
		//character mode
		writecube(side_4_characters, where= [0,0,0], size = die_width, t=textDepth,h = side_4_size,face = "left",rotate = side_4_rotation,font=side_4_font);
	}
	else {
		//dot mode
		rotate(side_4_rotation,[1,0,0]){ 
			translate([-die_width/2,-m_dist,m_dist])sphere(r=side_4_size/2,center=true);
			translate([-die_width/2,m_dist,-m_dist])sphere(r=side_4_size/2,center=true);
			
			translate([-die_width/2,m_dist,m_dist])sphere(r=side_4_size/2,center=true);
			translate([-die_width/2,-m_dist,-m_dist])sphere(r=side_4_size/2,center=true);
		}
	}

}
module side5(){
	textDepth= die_width/15;
	if(side_5_mode){
		//character mode
		writecube(side_5_characters, where= [0,0,0], size = die_width, t=textDepth,h = side_5_size,face = "bottom",rotate = side_5_rotation,font=side_5_font);
	}
	else {
		//dot mode
		rotate(side_5_rotation,[0,0,1]){ 
		
			translate([-m_dist,m_dist,-die_width/2])sphere(r=side_5_size/2,center=true);
			translate([m_dist,-m_dist,-die_width/2])sphere(r=side_5_size/2,center=true);
			translate([0,0,-die_width/2])sphere(r=side_5_size/2,center=true);
			translate([m_dist,m_dist,-die_width/2])sphere(r=side_5_size/2,center=true);
			translate([-m_dist,-m_dist,-die_width/2])sphere(r=side_5_size/2,center=true);
		}
	}

}
module side6(){
	textDepth= die_width/15;
	if(side_6_mode){
		//character mode
		writecube(side_6_characters, where= [0,0,0], size = die_width, t=textDepth,h = side_6_size,face = "back",rotate = side_6_rotation,font=side_6_font);
	}
	else {
		//dot mode with rotate
		rotate(side_6_rotation,[0,1,0]){ 
		
			translate([-m_dist,die_width/2,m_dist])sphere(r=side_6_size/2,center=true);
			translate([m_dist,die_width/2,-m_dist])sphere(r=side_6_size/2,center=true);
			translate([m_dist,die_width/2,0])sphere(r=side_6_size/2,center=true);
			translate([-m_dist,die_width/2,0])sphere(r=side_6_size/2,center=true);
			translate([m_dist,die_width/2,m_dist])sphere(r=side_6_size/2,center=true);
			translate([-m_dist,die_width/2,-m_dist])sphere(r=side_6_size/2,center=true);
		}
	}

}


