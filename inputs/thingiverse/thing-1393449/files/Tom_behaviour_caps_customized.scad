//Author: Lucia Prieto Godino
//mail: lucia.prieto@cantab.net
//February 2016
//Cover tubes behaviour

// Customazible variables

// height
height = 30; 
// diameter
diameter = 9; 

////////////////////////////////////////////////////////
module customizer_off(){};
////////////////////////////////////////////////////////

h1= height;
r1= diameter;
r2 = r1-1;


module Base() {
cylinder($fn=50,h= h1, r = r1, center = true);
}

//Base();

module inside() {
cylinder ( $fn=50,h = h1, r = r2, centre = true);
 translate ([0,0,-h1/2]){cylinder ($fn=50, h = h1, r = r2, centre = true);}
}

//inside();

module final() {
difference () {Base() ; inside();}
}

final();