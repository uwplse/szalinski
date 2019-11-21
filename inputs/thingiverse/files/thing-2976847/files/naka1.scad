
a = 0.8; // [0:5]



intersection(){
    
domino(a,10,10);

translate([30,0,0])
cube([20,20,20]);
    
}


module domino(a){

for (i=[0:10])
translate([i*8,0,0])


cube([a,20,50]);



    
}



