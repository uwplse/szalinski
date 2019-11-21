/* Flower Pot (twisted) for Succulents */

// Thickness of the walls and floor
thick = 1;

// Heigth of the pot
h = 40;

// Diameter of the pot
d = 78;

// Make the object a little bit rounded and thickier? (recommended)
round = "yes"; //[yes,no]

// Twisting factor (in angles)
curling = 30; //[-90:90]

// Number of sides (the tray has 6 sides, so you may want to keep that)
sides = 6; //[3:36]

/* [Hidden] */
holes_d = d/32;
roundness = thick;

color([1,1,0]) minkowski(){
    linear_extrude(height=h-thick, center=true, twist=curling, slices=3, convexity=10){ 
        difference(){
            circle(r=d/2, $fn=sides, center=true);
            offset(r=-thick) circle(r=d/2, $fn=sides, center=true);
        }
    };
    if(round == "yes"){
        sphere(r=roundness);
    }
}
color([1,0,0]) minkowski(){
    translate([0,0,-h/2]) linear_extrude(height=thick, center=true){
        difference(){
            circle(r=d/2, $fn=sides, center=true);
            circle(r=holes_d, $fn=16, center=true);
            for(i=[1:sides]){
                rotate(a=i*360/sides){
                    translate([d/3-holes_d,0,0]){
                        circle(r=holes_d, $fn=16, center=true);
                    }
                }
            }
        }
    }
    if(round == "yes"){
        sphere(r=roundness);
    }
}