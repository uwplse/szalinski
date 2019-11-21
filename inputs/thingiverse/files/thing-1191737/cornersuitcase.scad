//+-------------------------------------------------------------+
//|              OPENSCAD CORNER suitecase - coin valise        |
//|         Remix from corner and handle baggage by javitoraz   |
//|                  2015 gaziel@gmail.com                      | 
//+-------------------------------------------------------------+


//height of the corner
taille=50;

//thinkness
ep=3;

// Do You want a hole ?
hole="yes"; //[yes ,no]

// diameter for the hole
dhole=3;

$fn=25+25;

difference(){
    poly();
    if (hole=="yes"){
        rotate([90,0,0]) translate([taille*0.33,taille*0.33,-ep])cylinder(d=dhole, h=666);
        rotate([0,-90,0]) translate([taille*0.33,taille*0.33,-ep])cylinder(d=dhole, h=666);
        translate([taille*0.33,taille*0.33,-ep])cylinder(d=dhole,h=666);
    }
    cube(taille*3);  
}

module poly(){
    hull(){
        angle();
        rotate([0,-90,0])angle();
        rotate([90,0,0])angle();
    }
}
module angle(){
    minkowski(){
        linear_extrude(height = 1)
            polygon(
                points=[[0,0],[taille,0],[0,taille]],
                paths = [ [0,1,2]]);
            sphere(ep);
    }
}


