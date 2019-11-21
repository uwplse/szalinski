/* Customizable Skiing Snowman
	This snowman stands on skis and has a cute facial expression that will surely put a smile on any small child unless of course they are afraid of fun plastic snowman. 
	A single openscad file that is customizable through the customizer on thingiverse. 

The parameters below may be changed using the customizer. 
*/

//BEGIN CUSTOMIZER
/*[Skiing Snowman Parameters]*/

//Select scale size of the snowman 
scale_factor = 1; //[.75,1,1.5,1.75,2.25,2,5,2.75,3]
//Draft for preview, production for final
Render_Quality= 60; //[24:Draft, 60:Production]
//Model to Render
render_model=3; //[1:Snowman, 2:Snowman without hat and skis, 3:Split model ready for printing]

//END CUSTOMIZER
 
$fn= Render_Quality; 
//translate([0,0,-3.5]) cube([200,200,2], center=true);

module model (){
scale ([scale_factor, scale_factor, scale_factor]){

	union() {
//---------first sphere--------
	difference () {
	 sphere(r=16, center =	true);  
	translate ([0,-15,0]) {
		cube (size = [30, 8, 30], center= true); 
}

	
}
//-----second sphere-------------

	 translate([0,18,0]){
		sphere(r=12, center= true);
	} 

//------thrid sphere-------------			
	 translate([0,31,0]){
		sphere(r=9,center=true);
	}

//------first arm----------------
 	 rotate ([45,-90,0]	)	{
	 	translate ([0,5,-30]){
			cylinder( h= 20, r=1	, center = 	true	); 
		}
	} 

//-----second stick--------------

	 rotate([-45, -90, 0]) {
		translate ([0,5,30]) {
			cylinder( h=20, r=1, center= true); 
		}
	} 


//--------carrot stick-----------
	 rotate ([0,180,0])		{
		translate ([0,34,-10]){
			cylinder ( h=6, r1= .2, r2= 1.5, center= true ); 
		}
	} 

//-------eye 1-------------------

	translate ([-4,37,4.9]){
		cube( size =2.5, center= true); 
	}
//-------eye 2------------------
	 translate ([4,37,4.9]){
	cube( size =2.5, center= true); 
	}
//----------mouth----------------
	translate ([-6,31.5,6]){
		cube( size =2, center= true); 
	}


	translate ([6,31.5,6]){
		cube( size =2, center= true); 
	}


	translate([-4.5,29.5,7.5]){
		cube( size =2, center= true)	; 
	}


	translate ([4.5,29.5,7.5]){
		cube( size =2, center= true); 
	}


	 translate ([-1.5,28.5 ,8]){
		cube( size =2, center= true); 
	}


	 translate ([1.5,28.5 ,8]){
		cube( size =2, center= true); 
	}

// -----------top hat------------

 	 rotate ([90,0,0]){
		translate ([0,0,-39]){ 
			cylinder	( h= 1, r= 10, center= true); 
		}
	}


	 rotate ([90,0,0]){
		translate ([0,0,-42]){ 
			cylinder	( h= 5, r= 6, center= true); 
		}
	}
//--------skis------------------

intersection(){
	translate ([6,-12,10]) {
		cube(size= [5,2,60], center=true);
		rotate([90,0,0]){
		translate ([0,30,0]){ 
				cylinder (h=2, r=2.5, center=true); 
		}
	}
	}
}

intersection(){
	translate ([-6,-12,10]) {
		cube(size= [5,2,60], center=true);
		rotate([90,0,0]){ 
		translate ([0,30,0]) { 
			cylinder (h=2, r=2.5, center=true); }
		}
		}
		}
	}
}
}


//-------------------------------

// this module does not include the hat or the skis for printing purposes

module withouthatandskis()	{
scale ([scale_factor, scale_factor, scale_factor]){
union() {
//---------first sphere--------
	difference () {
	sphere(r=16, center =	true);  
	translate ([0,-15,0]) {
		cube (size = [30, 8, 30], center= true); 
}
}
//-----second sphere-------------

	 translate([0,18,0]){
		sphere(r=12, center= true);
	} 

//------thrid sphere-------------			
	difference(){
	translate([0,31,0]){
		sphere(r=9,center=true);
	}
	translate([0,39.8,-2.5]) {rotate([68,0,0]){
cylinder(h =1, r=6, center= true);} 
}
}

//------first arm----------------
 	 rotate ([45,-90,0]	)	{
	 	translate ([0,5,-30]){
			cylinder( h= 20, r=1	, center = 	true	); 
		}
	} 

//-----second stick--------------
 rotate([-45, -90, 0]) {
		translate ([0,5,30]) {
			cylinder( h=20, r=1, center= true); 
		}
	}  


//--------carrot stick-----------
	 rotate ([0,180,0])		{
		translate ([0,34,-10]){
			cylinder ( h=6, r1= .2, r2= 1.5, center= true ); 
		}
	} 

//-------eye 1-------------------

	translate ([-4,37,4.9]){
		cube( size =2.5, center= true); 
	}
//-------eye 2------------------
	 translate ([4,37,4.9]){
	cube( size =2.5, center= true); 
	}
//----------mouth----------------
	translate ([-6,31.5,6]){
		cube( size =2, center= true); 
	}


	translate ([6,31.5,6]){
		cube( size =2, center= true); 
	}


	translate([-4.5,29.5,7.5]){
		cube( size =2, center= true)	; 
	}


	translate ([4.5,29.5,7.5]){
		cube( size =2, center= true); 
	}


	 translate ([-1.5,28.5 ,8]){
		cube( size =2, center= true); 
	}


	 translate ([1.5,28.5 ,8]){
		cube( size =2, center= true); 
	}
}
}
}

//this module does not have a flat bottom and the skis are moved further down

module withoutflatbottom (){
scale ([scale_factor, scale_factor, scale_factor]){

	union() {
//---------first sphere--------
	difference () {
	sphere(r=16, center =	true);  
	translate ([0,-15,0]) {
		cube (size = [30, 8, 30], center= true); 
}
}
//-----second sphere-------------

	 translate([0,18,0]){
		sphere(r=12, center= true);
	} 
//-----third sphere--------------
			
 translate([0,31,0]){
	sphere(r=9,center=true);
}


//------first arm---------------
 	 rotate ([45,-90,0]	)	{
	 	translate ([0,5,-30]){
		cylinder( h= 20, r=1	, center = 		true	); 
		}
	} 

// -------second stick ----------

	  rotate([-45, -90, 0]) {
		translate ([0,5,30]) {
			cylinder( h=20, r=1, center= true); 
		}
	} 
//--------carrot stick-----------
	 rotate ([0,180,0])		{
		translate ([0,34,-10]){
			cylinder ( h=6, r1= .2, r2= 1.5, center= true ); 
		}
	} 

//-------eye 1-------------------

	translate ([-4,37,4.9]){
		cube( size =2.5, center= true); 
	}
//-------eye 2------------------
	 translate ([4,37,4.9]){
	cube( size =2.5, center= true); 
	}
//----------mouth----------------
	translate ([-6,31.5,6]){
		cube( size =2, center= true); 
	}


	translate ([6,31.5,6]){
		cube( size =2, center= true); 
	}


	translate([-4.5,29.5,7.5]){
		cube( size =2, center= true)	; 
	}


	translate ([4.5,29.5,7.5]){
		cube( size =2, center= true); 
	}


	 translate ([-1.5,28.5 ,8]){
		cube( size =2, center= true); 
	}


	 translate ([1.5,28.5 ,8]){
		cube( size =2, center= true); 
	}

// -----------top hat------------

 	 rotate ([90,0,0]){
		translate ([0,0,-39]){ 
			cylinder	( h= 1, r= 10, center= true); 
		}
	}


	 rotate ([90,0,0]){
		translate ([0,0,-42]){ 
			cylinder	( h= 5, r= 6, center= true); 
		}
	}

//------skis---------------------
intersection(){
	translate([0,-7,0]){
		translate ([6,-12,10]) {
		cube(size= [5,2,60], center=true);
		rotate([90,0,0]){
		translate ([0,30,0]) { 
			cylinder (h=2, r=2.5, center=true); }
		}
		}
	}
}


intersection(){
	translate([0,-7,0]){
		translate ([-6,-12,10]) {
			cube(size= [5,2,60], center			=true);
		rotate([90,0,0]){ 
		translate ([0,30,0]) { 
			cylinder (h=2, r=2.5, center=true); }
			}
		}
		}
	}
	}
}
}

// this module divides the snowman into pieces for printing
module split() {
scale ([scale_factor, scale_factor, scale_factor]){
//------top hat------------------
	translate ([15,-41,0]){
		difference () { 
			model (); 
			cube ([52,77,90], center 		=true);

		}
	}
//---------front half of the snowman with the arms and face-------
	
translate ([-10,-2,0]){
rotate([-90,90,0]){
	difference () {
		withouthatandskis(); 
		translate ([0,0,-20.5]){ 
				cube ([52,80,40], center= true); 
	}
		}
} 
} 

//------skis------------------
translate([40,17.5,0]) {
	difference(){ 
		withoutflatbottom(); 
		translate ([0,22,0]){
			cube ([52,80,85], center= true); 

		}
	}
}
//-----backside of snowman-------
	translate([0,-3.5,-40]){
	rotate([90,180,0]){
		difference(){
			withouthatandskis (); 
			translate ([0,0,19.1]){
				cube ([52,80,40], center= true);
	}
	}
	}
}
}
}
if (render_model==1){
rotate([90,0,0]) model(); 
}
if (render_model==2){
rotate([90,0,0]) withouthatandskis(); 
}
if (render_model==3){
rotate([90,0,0])split (); 
}

