
/*
This is a simple script to generate 3d model base for the 3d printable game (name TBD)
You can customize it and use it as far as you refer to the original.
Author: Simmons http://www.thingiverse.com/Simmons/about
more information: www.randomlandscape.com
*/

// Dimension of the single prism
a= 30; //  [30:Small, 50:Medium, 70:Large]
//h= 10; //altezza standard


// Height prism 1
h1 = 10; // [10:35]
// Height prism 2
h2 = 20;// [10:35]
// Height prism 3
h3 = 10; // [10:35]
// Height prism 4
h4 = 18; // [10:35]
// Height prism 5
h5 = 30; // [10:35]
// Height prism 6
h6 = 10; // [10:35]
// Height prism 7
h7 = 15; // [10:35]
// Height prism 8
h8 = 10; // [10:35]
// Height prism 9
h9 = 25; // [10:35]
// Height prism 10
h10 = 10; // [10:35]

l = a*tan(30); //lato dell'esagono

// esagono 1
translate([0,0,h1/2]){
esagono(h1,a);
}

// esagono 2
translate([0,a,h2/2]){
esagono(h2,a);
}

// esagono 3
translate([0,a*2,h3/2]){
esagono(h3,a);
}

//seconda colonna
translate([l/2 + l,a/2,0]){ //l/2 + l è lo spostamento per la seconda linea
// esagono 4
translate([0,0,h4/2]){
esagono(h4,a);
}
// esagono 5
translate([0,a,h5/2]){
esagono(h5,a);
}

}//fine seconda colonna

//terza colonna
translate([l*3,0,0]){ //l*3 è lo spostamento per la terza linea
// esagono 6
translate([0,0,h6/2]){
esagono(h6,a);
}

// esagono 7
translate([0,a,h7/2]){
esagono(h7,a);
}

//esagono 8
translate([0,a*2,h8/2]){
esagono(h8,a);
}

}//fine terza colonna

//quarta colonna
translate([l/2 + 4* l,a/2,0]){ //l/2 + l è lo spostamento per la seconda linea
// esagono 9
translate([0,0,h9/2]){
esagono(h9,a);
}

// esagono 10
translate([0,a,h10/2]){
esagono(h10,a);
}

}//fine quarta colonna

module esagono ( h, distanza_lati ) {

lato= distanza_lati*tan(30);

diagonale_angoli = (lato/(sin(30)));
echo("diagonale:",diagonale_angoli);

cube([lato,distanza_lati,h], center=true);
rotate(a=[0,0,60]) {
cube([lato,distanza_lati,h], center=true);
}
rotate(a=[0,0,120]) {
cube([lato,distanza_lati,h], center=true);
}
}//fine esagono
        