//+-------------------------------------------------+
//|OPENSCAD manche de tampon - stamp Holder         |
//|        2017 gaziel@gmail.com                    |
//+- -----------------------------------------------+   

//your choice...   
type="square";//[round,square]

//external diameter or length for the stamp base
l=50; 

//lenght for square
L=10; 

//thinkness
ep=2; 

if (type=="square"){

    color("green",0.55)hull(){
        cube([l,L,ep]);
        translate([l/4,L/4,0])cube([l/2,L/2,2*ep]);
    }
    color("pink",0.55)hull(){
        translate([l/2,L/2,min(l,L)])sphere(d=min(l,L)/2,$fn=100);
        translate([l/2,L/2,min(l,L)/2])cylinder(d=min(l,L)/4,$fn=100);
    }
    color("blue",0.55)hull(){
        translate([l/2,L/2,min(l,L)/2])cylinder(d=min(l,L)/4,$fn=100);
        translate([l/4,L/4,0])cube([l/2,L/2,2*ep]);
    }
}

if (type=="round"){

    color("green",0.55)hull(){
        translate([l/2,l/2,0])cylinder(d=l,h=ep,$fn=100);
        translate([l/2,l/2,0])cylinder(d=l/2,h=2*ep,$fn=100);
    }
    color("pink",0.55)hull(){
        translate([l/2,l/2,min(l,L)])sphere(d=min(l,L)/2,$fn=100);
        translate([l/2,l/2,min(l,L)/2])cylinder(d=min(l,L)/4,$fn=100);
    }
    color("blue",0.55)hull(){
        translate([l/2,l/2,min(l,L)/2])cylinder(d=min(l,L)/4,$fn=100);
        translate([l/2,l/2,0])cylinder(d=l/2,h=2*ep,$fn=100);
    }
}


