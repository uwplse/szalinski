
stoplength=35; // change the length of stopper

rotate ([180, 0,0]) union(){
difference (){
    union (){
        cube ([stoplength, 30, 3]);
        translate ([0,15,0]) cylinder (3, 15, 15);
        translate ([stoplength,15,0]) cylinder (3, 15, 15);
        translate ([(stoplength-5),15,-12])  cylinder (15, 15, 13);
    }
translate ([(stoplength-5),15,-16]) rotate ([0, 0, 0]) cylinder (20, 13, 11);
}
}


//For - www.homedepot.com/p/Everbilt-Stainless-Steel-Decorative-Sliding-Door-Hardware-14455/205706155