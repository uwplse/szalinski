a = 7; //[5:10]
b = 2; //[2:10]
c = 10; //[10:20]
d = 20; //[20:50]


line(a,b,c);

module line(a,b,c){

for(i=[0:1:50]){
    
    translate([i*10,0,0])
    rotate([i*d,0,0])
    cube([a,b,c], 0);
    
    };
}




