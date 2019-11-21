//Author: Lucia Prieto Godino
//mail: lucia.prieto@cantab.net
//January 2015
//Eppendorf holder for rotator

// Customazible variables

// holder
inner_radius = 5; 
// size of base to fit rotator
base = 6; 

////////////////////////////////////////////////////////
module customizer_off(){};
////////////////////////////////////////////////////////

//someVariable = 10;
r1 = 8;// for the shape of tube slot
h1 = 2;
r2 = base; //size of squre to fit rotator
h2 = 8;
r3 = inner_radius + 2; // tube slot external
h3 = r2;
r3i = inner_radius; // tube slot internal


 


module Base() {

	cylinder(h= h1, r = r1, center = true);
  translate ([0,0,-h2/2]){cube ([r2,r2,h2], center = true);}
  
}


//Base();

module Top_base () {
translate ([0,0,r3]){rotate ([0,90,0]) {cylinder(h =h3,r = r3, center = true);}}
}
//Top_base ();

module Top_sub1() {
translate ([0,0,r1*2.3]){cube(r1*2,r1*2,r1*2, center = true);}
	translate ([0,0,r3]){rotate ([0,90,0]) {cylinder(h =h3,r = r3i, center = true);}}
}

//Top_sub1();

module Top() {

	difference(){Top_base();Top_sub1();}
}

Top();


module Base_sub() {

	translate ([r1+h3/2,0,0]){cube(r1*2,r1*2,r1*2, center = true);}
  
  
}

//Base_sub ();

module basef () {
difference () {Base();Base_sub();}
}

basef();


module topf () {
difference () {Top() ; top_sub2();}
}

topf ();

