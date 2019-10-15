/*

    STONE Generator
    
    Fernando Jerez 2017 
    License: CC-NC

*/

// This is only to force Customizer create many files. Changes doesnt matter. Just click CREATE THING
part = "one"; // [one:Stone #1, two:Stone #2, three:Stone #3, four:Stone #4,five:Stone #5,six:Stone #6,seven:Stone #7,eight:Stone #8,nine:Stone #9,ten:Stone #10]



// : More corners --> More spheric stones
number_of_corners = 20; // [5:30]

// : Deforms stone in vertical
z_scale = 1; // [0.2:0.1:3]


/* [Hidden] */
radius = 20;
corner_size = 2;

// Example
scale([1,1,z_scale])
randomRock(radius,corner_size,number_of_corners);



// Module...
module randomRock(radius,corner_size,number_of_corners){
    // Draw rock
    hull(){
        // Make a hull..
        for(i=[0:number_of_corners]){
            // random position in sphere
            y = rands(0,360,1)[0];
            z = rands(0,360,1)[0];
            rotate([0,y,z])
            
            // translate radius (minus half of corner size)
            translate([radius-corner_size*0.5,0,0])
            
            // draw cube as corner
            rotate([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]]) // random rotation
            cube(rands(corner_size*0.5,corner_size,1)[0],center = true);
            
        }
    }

    // Done
}