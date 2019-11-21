//start angle for the sine function
a = 140;

//width of the cube
width =1;

//size determines the dimension of the matrix
size = 50;

//height determines the z height of the sin wave
height=20;

//determines the shape of the Cube Wave
shape = 10;

//to calculate the relative distance between a cube and the origin
function dist(x,y) = sqrt(pow(x,2)+pow(y,2));

/*** MAIN ***/

    difference() {
        
        /*** Create Sin Wave Cubes ***/
        for (j = [-size:size]) {
            for (i = [-size:size]) {
                offset = shape * dist(i,j);
                        
                
                        if (j==0 || i==0 && abs(sin(a-offset)) > 10){
                            offset = shape * dist(i,j);
                            translate([i * width, j * width, 0])
                            cube([width,width,height*abs(sin(a - offset))], center =false);
                        }
                        
                        else {
                            offset = shape * dist(i,j);
                            translate([i * width, j * width, 0])
                            cube([width,width,height*abs(sin(a - offset))], center = false);
                        
                        }
    
            }
        }
    
        /*** Cut Away Cylinder ***/
        translate([0,0,0]) color( "Black", 1.0 ) cylinder(5,200,200, center = true);
        translate([0,0,0]) color( "Black", 1.0 ) cylinder( 90, 15, 15);
        
        difference(){
            translate([0,0,0]) color( "SpringGreen", 1.0 ) cylinder(100,200,200, center = true);
            translate([0,0,0]) color( "SpringGreen", 1.0 ) cylinder(51,50,50, center = true);
        }
    }

difference(){
    translate([0,0,-1]) cylinder( 5, 50, 50);
    translate([0,0,-2]) cylinder( 12, 8, 8); 
}
