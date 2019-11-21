/*
    Skyscrapers
    
    Fernando Jerez 2016

*/

// : Number of faces in towers
sides = 4; // [3:6]

// : Max levels for towers
levels = 15; // [0:20]

// : Twisted towers factor (0=no twist)
twist = 5; //[0:10]

//: Used for customizer to generate many files (irrelevant for you)
part="sky1"; // [sky1: sky1,sky2: sky2,sky3: sky3 ]

/* [Hidden] */
separation = 0.16;


/*
    3 'parts' for customizer (generate 3 STL's)
*/
if(part=="sky1"){
    difference(){
        skyscraper(120);
        // 'cut' the columns under ground level
        translate([0,0,-250]) cube([500,500,500],center = true);
    }
}
if(part=="sky2"){
    difference(){
        skyscraper(120);
        // 'cut' the columns under ground level
        translate([0,0,-250]) cube([500,500,500],center = true);
    }
}
if(part=="sky3"){
    difference(){
        skyscraper(120);
        // 'cut' the columns under ground level
        translate([0,0,-250]) cube([500,500,500],center = true);
    }
}



// Recursive module
module skyscraper(d){
    if(d>20){
        for(i=[1:sides]){
            rotate([0,0, (360/sides)*i]){
                translate([d*separation,0,0])
                rotate([0,0,180/sides]){
                    n = round(rands(0,levels,1)[0]);
                    tower(d/2,n);
                    translate([0,0,n*(d/12)]){
                        skyscraper(d/2);
                    }
                }
            }
        }
        
    }
}



// 'tower' module
module tower(d,n){
    l=sides;
    h=d;

    // twist
    g = twist*round(rands(-1,1,1)[0]);
    
    //top
    translate([0,0,n*(h/6)]) rotate([0,0,g*(n)]) cylinder(r1=d/2,r2=0,h=h/2,$fn=l);
    
    //middle
    if(n>0){
        for(i=[0:n-1]){
            translate([0,0,i*h/6]){
                rotate([0,0,g*i]){
                    cylinder(r1=d/2,r2=d/4,h=h/6,$fn=l);
                    cylinder(r=d/2.3,h=h/6,$fn=l);
                    
                }
                rotate([0,0,g*(i+1)]) cylinder(r1=d/4,r2=d/2,h=h/6,$fn=l);
            }
        }
    }
    //bottom
    rotate([180,0,0])cylinder(r1=d/2,r2=d/2,h=250,$fn=l);
   
    
}

 

