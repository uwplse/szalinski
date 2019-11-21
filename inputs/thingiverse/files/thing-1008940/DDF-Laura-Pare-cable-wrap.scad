//Height
h=50; //[20,30,50,70]

//Width
b=20; 

//Length
l=50;

//Cable_gap
f=4; //[2,3,4,5,6,7,8,9]


difference () {linear_extrude (h) {union () {square([l,b]);
translate ([0,b/2,0]) circle (b/2);
    translate ([l,b/2,0]) circle (b/2);
    }
}

linear_extrude (h) {union () {translate ([0,b/2,h]) circle ((b-
  6)/2);
translate ([0,3,h]) square ([(l/2)-2,b-6]);
    translate ([-b/2,(b/2)-(f/2),h]) square ([10,f]);
}
}

linear_extrude (h) {union () {translate ([l+(b/4),(b/2)-(f/2),h]) square ([10,f]); 
    translate ([l,0,0]) {mirror () {translate ([0,b/2,h]) circle ((b-6)/2);
translate ([0,3,h]) square ([(l/2)-2,b-6]);
    }
}
}
}
}


    


           
          
          