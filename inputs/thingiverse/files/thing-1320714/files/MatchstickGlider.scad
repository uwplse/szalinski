//How Long the Glider is
size = 150;//[50:300]

//How Thick Is your First Printing Layer
flthick = .4;//

module fuse(){
    linear_extrude(size*.05)
    union(){
    circle(size*.04);
translate([-size*.04,0]){    
    square([size*.08,size/4]);}
    translate([0,size/4]){ 
circle(size*.04);}
translate([-flthick*1.5,0]){

square([flthick*3,size]);}
}}

module wing (){
translate([0,size*.4]){
square([size*.35,.22*size]);}
}

module tailfin(){
    difference(){
translate([0,.8*size]){  
square([.2*size,.2*size]);}
translate([0,size-flthick*10]){
square([flthick*5,flthick*10]);
    }}
}

module vstab(){
translate([-flthick*1.5,.85*size]){
        linear_extrude(.125*size)
square([flthick*3,.15*size]);}
}



fuse();
vstab();

linear_extrude(flthick)

union(){
wing();
mirror([1,0]){wing();}
tailfin();
mirror([1,0]){tailfin();}}
