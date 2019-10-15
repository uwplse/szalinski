//Rotating rings in rings

$fn = 50; // [20:preview,50:print]

/* [Scales] */
// Shell thickness (Should be the product of your slicer settings)
thickness = 2;

//The percentage of the part missing of the sphere(for both sides)
cutoff = 27; // [0:50]

//How many shells do you want to print?
count = 4; // [2:10]

size = 30;

space = 1;


height = size*(100-cutoff*2)/100;

module _shell(outerSize, innerSize){
    difference(){
        sphere(d=outerSize);
        sphere(d=innerSize);
    }
}




module shell(outerSize, thickness){
       
    innerSize = outerSize - thickness;
    intersection(){
        _shell(outerSize, innerSize);
        cube([outerSize,outerSize,height], true);
    }
}

module go(){
    
    for (i = [0:count-1]){

        outerSize = size - i * (thickness + space);
        shell(outerSize,thickness=thickness);
        
    }
    
    
}

go();
