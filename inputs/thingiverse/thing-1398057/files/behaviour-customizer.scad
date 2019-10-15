//Author: Lucia Prieto Godino
//mail: lucia.prieto@cantab.net
//February 2016
//Cover tubes behaviour

// Customazible variables

// height
height = 2; 
// diameter
diameter = 35; 

////////////////////////////////////////////////////////
module customizer_off(){};
////////////////////////////////////////////////////////

h1= height;
r1= diameter;
r2 = r1 -1;
h2 = 6 + h1;

module Base() {
cylinder(h= h1, r = r1, center = true);
}

//Base();

module inside() {
cylinder ( h = h2, r = r2, centre = true);
 translate ([0,0,-h2/2]){cylinder ( h = h2, r = r2, centre = true);}
}

//inside();

module final() {
difference () {Base() ; inside();}
}

final();