// Radius of the bottle neck
bottlerad=9.25;
// The thick of the bottle border
border=3.4; 

// The printed thickness of the borders
thick=1.5; 
// How long the bottle will penetrate into the cap
depth=7; // [5:15]


// Extra value for the printed top of the cap
top=1.5;

// Examples

// Danacol Dia
//bottlerad=28.4/2;
//border=2.7;

// Naturhouse
//bottlerad=18.5/2;
//border=3.4;

// Rose wine
//bottlerad=28/2;
//border=6;

difference(){
cylinder(h=depth+top, r=bottlerad+thick, $fn=60, center=true);
translate([0,0,top]) cylinder(h=depth+top, r=bottlerad, $fn=60, center=true);    
}
difference(){
translate([0,0,0]) cylinder(h=depth+top, r=bottlerad-border, $fn=60, center=true);
translate([0,0,top+2]) cylinder(h=depth+top, r=bottlerad-border-thick, $fn=60, center=true);    
}