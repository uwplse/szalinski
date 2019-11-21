// band width[mm]
nauhanleveys = 10; // [1:1:50]
// band thickness[mm] 
nauhanpaksuus = 1; // [0.2:0.1:5]

module takareika(){
hull(){
translate([1.25+nauhanleveys/20,-5,4])  
cube([nauhanleveys+0.5,0.1,nauhanpaksuus+0.5,]);
translate([1.25+nauhanleveys/20,4,14])  
cube([nauhanleveys+0.5,0.1,nauhanpaksuus+0.5,]);
}}

module etureika(){
hull(){
translate([1.25+nauhanleveys/20,-5,12.75+nauhanpaksuus+nauhanleveys/4])  
cube([nauhanleveys+0.5,1,nauhanpaksuus+0.5]);
translate([1.25+nauhanleveys/20,4,12.75+nauhanpaksuus+nauhanleveys/4])  
cube([nauhanleveys+0.5,1,nauhanpaksuus+0.5]);
}}


$fn = 30;

difference(){
hull(){  // vasen reuna
translate([0,0,0.5])
cylinder(h=1, r=1.5+nauhanleveys/20, center=true);
translate([1.5+nauhanleveys/20,0,50])
cylinder(h=1, r=0.5+nauhanleveys/20, center=true);
}
// viiste
hull(){
translate([0,-5,51])
cube([1.5+nauhanleveys/20,10,1]);
translate([-10,-5,40])
cube([10,10,1]);
}
etureika();
takareika();
}

difference(){
hull(){ // oikea reuna
translate([nauhanleveys+3+nauhanleveys/10,0,0.5])
cylinder(h=1, r=1.5+nauhanleveys/20, center=true);
translate([nauhanleveys+1.5+nauhanleveys/20,0,50])
cylinder(h=1, r=0.5+nauhanleveys/20, center=true);
}
//viiste
hull(){
translate([1.5+nauhanleveys+nauhanleveys/20,-5,51])
cube([10,10,1]);
translate([3+nauhanleveys+nauhanleveys/10,-5,40])
cube([10,10,1]);
}
etureika();
takareika();
}


difference(){
hull(){ // keskipötkylä
translate([0,-1.5-nauhanleveys/20,0])
cube([nauhanleveys+3+nauhanleveys/10,3+nauhanleveys/10,1]);

translate([1.5+nauhanleveys/20,-0.5-nauhanleveys/20,50])
cube([nauhanleveys,1+nauhanleveys/10,1]);
}

etureika();
takareika();
}

// kärki:

hull(){
translate([1.5+nauhanleveys/20,-0.5-nauhanleveys/20,50])
cube([nauhanleveys,1+nauhanleveys/10,1]);

translate([1+nauhanleveys/2+nauhanleveys/20,-0.5-nauhanleveys/20,58])
cube([1,1+nauhanleveys/10,1]);
}



