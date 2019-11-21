/*


10PRINT for OpenScad (for customizer, no title option)

Fernando Jerez



*/
// preview[view:south, tilt:top]
// Random Seed
seed= 1;

// Number of horizontal cells
gridx = 36;
// Number of vertical cells
gridy = 20;

/* [Hidden] */
$fn = 4;
random = rands(0,1,10000,seed);

w = 2; // width of 'stick'
h = 8; // height of 'stick'
gridsize = h*0.707;
 

color("Blue")
translate([-0.5*gridsize,-0.5*gridsize,0.5])
    cube([(2+gridx)*gridsize,(2+gridy)*gridsize,1],center=true);
    
color("White")

translate([-gridsize*gridx/2,-gridsize*gridy/2,1]){
    linear_extrude(1){
        for(x = [0:gridx-1]){
            for(y = [0:gridy-1]){
                translate([x*gridsize,y*gridsize,0]){
                    if(random[x*(gridy-1)+y]>=0.5){
                        rotate([0,0,45]) squareRounded(w,h,1);
                    }else{
                        rotate([0,0,-45]) squareRounded(w,h,1);
                    }
                }
            }
        }
    }
}


    





module squareRounded(w,h,r){
    w1 = 0.5*w-r;
    h1 = 0.5*h-r;
    union(){
        translate([-w1,-h1,0]) circle(r);
        translate([-w1,h1,0]) circle(r);
        translate([w1,h1,0]) circle(r);
        translate([w1,-h1,0]) circle(r);
        square([w-2*r,h],center=true);
        square([w,h-2*r],center=true);
    }
}