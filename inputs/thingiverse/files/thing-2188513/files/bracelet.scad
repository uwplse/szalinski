//General Parameters 

// filled / solid for slicing in vase mode
fill = "no"; //[yes,no]
// Base radius in mm
outerRadius = 37.5; //[10:300]
// Height in mm
height = 20; //[30:600] 
// number of sides that make up the outside (bigger than 3)
sides = 9; //
//Thickness of wall
wallThickness = 1.6; //[1:50]
// degree to twist between base and top
degree2twist = 30; //[0:360] 0 for no twist
// how many slices? 
numberSlices = 2; //[0:100]


//General Calculated Values
innerRadius = outerRadius - wallThickness; 
extrudeHeight = height;


module rim(filled){
difference(){
    circle(r=outerRadius, $fn=sides);
    if(filled=="no"){
        circle(r=innerRadius, $fn = sides);
        }
    }
}

module bracelet(){
    linear_extrude(height = extrudeHeight, twist=degree2twist, slices = numberSlices) rim(filled=fill);
}

bracelet();
