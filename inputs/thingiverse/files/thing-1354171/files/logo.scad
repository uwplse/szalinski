//Width of stick
w = 12;
//Height of stick
h = 4;
//Depth of stick
z = 4;
//Num of stick
num_sticks = 6; // Barrabes = 6

logo(w,h,z,num_sticks);

module logo(a=2, b=2,h=2,n=4) {
    for(i = [0:1:n-1]){
        ii = floor(i/2);
        if(i%2 ==0){
            translate([ii*(a-b), ii*(b-a)])
                cube([b,a,h]);
        }else{
            translate([ii*(a-b), ii*(b-a)])
                cube([a,b,h]);
        }
    }
}