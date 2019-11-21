
Resolution=30; // Resoultion

Length=30; // Side Length of base

Height=34; // Height of base

Radius=2; // Radius of posts

/* Hidden */
r=Radius;

$fn=Resolution;

lng=Length-r-r;

// Customizable Square Pyramid wireframe by skitcher



module sphere1(){
    sphere(r);
}

module sphere2(){
    translate([lng,0,0]) sphere(r);
}

module sphere3(){
    translate([lng,lng,0]) sphere(r);
}

module sphere4(){
    translate([0,lng,0]) sphere(r);
}

module sphere5(){
    translate([lng/2,lng/2,Height-r]) sphere(r);
}




// HULL //

//base
hull(){
    sphere1();
    sphere2();
}

hull(){
    sphere2();
    sphere3();
}

hull(){
    sphere3();
    sphere4();
}

hull(){
    sphere4();
    sphere1();
}

//top
hull(){
    sphere1();
    sphere5();
}

hull(){
    sphere2();
    sphere5();
}

hull(){
    sphere3();
    sphere5();
}

hull(){
    sphere4();
    sphere5();
}

// END //






