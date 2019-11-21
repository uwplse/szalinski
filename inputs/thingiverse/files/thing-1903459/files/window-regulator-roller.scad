//Adjust these to fit, you may want to leave them a little loose

// Inner Radius
inrad=5.8; 

// Outer Radius
outrad=8.0; 

//Overall Height
height=6;  

// Width of the Slit
slit=0.3;  




// This should be automatic:

$fn=32;
box=(outrad*2)+5;

translate([0,0,(height/2)]){
difference(){
    union(){
        difference(){
            difference(){
                difference(){
                    sphere(outrad);
                    sphere(inrad);
                    };
                    translate([-outrad,-outrad,(height/2)]){
                        cube(box);
                        };
                    };
                    translate([-outrad,-outrad,-(box+(height/2))]){
                        cube(box);
                        };
                    };
                };
            translate([-(slit/2),0,-height]){
                cube([slit,box,box]);
                };
            };
    };