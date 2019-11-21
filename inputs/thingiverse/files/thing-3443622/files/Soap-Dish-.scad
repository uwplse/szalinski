

////////////////////////////////////////////////////////////////
// simple custom Soap Plate Mesh 

/* [Size] */

// width of the grate (in mm) keep between 6 and 200
diameter = 20;

// number of polygon sides (works better above 3) 
sides =6;

// thickness of the grate shape 
thickness = 1.5;

///////NOT CHANGEABLE 
$fn=200*1;

length = 152*1;
width= 72*1;
height = 28*1;
cornerRadius = 10*1;

// height of the main part (in mm) (Don't change)
bodyHeight = 3*1;

// height of the base and lower rim (in mm)
baseHeight = .05*1;

// height of the upper rim (in mm)
rimHeight = .05*1;

radius = diameter/2*1; ///(do not change)  

/* [Style] */


//////////////////////////////////////////////////////
// RENDERS

translate([10, 10, 0]){
    difference() {
            roundedBox(length, width, height, cornerRadius); 
            translate([1,1,1]) {
                roundedBox(length-2, width-2, height--1, cornerRadius); 
            }
    }
}

/////////////////////////////Lid 
        translate  ([100, 9, 0]) {
        difference() {
            translate([1,1,0]) {
                roundedBox(length-2,width-2,4,cornerRadius);

            }
            ///lidhole
            translate([2,2,-3]) {
                roundedBox(length-4,width-4,height-5,cornerRadius);
            }    
        }
    }
    



// body
intersection() {
    
translate([86.5,-4,baseHeight])
linear_extrude( height = bodyHeight, slices = 2*bodyHeight )
    polyShape( solid="no" );

solidlid();
}


//////////////////////////////////////////////////////
// MODULES

///BOX    
module roundedBox(length, width, height, radius)
{
    dRadius = 2*radius;
    //base rounded shape
    minkowski() {
        cube(size=[width-dRadius,length-dRadius, height]);
        cylinder(r=radius, h=0.01);
    }
  
    
  
}
    
/////////////////////////////SolidLid 
module solidlid(){
translate  ([100, 9, 0]) {
        translate([1,1,0]) 
                roundedBox(length-2,width-2,4,cornerRadius);
    }
}

module polyShape(solid){
    for ( i = [1: 5] ){
        translate(i * [13.2,0,0])
        for ( i = [1: 11] ){
            translate(i * [0,13.2,0])
            difference(){
                // start with outer shape
                offset( r=5, $fn=48 )
                    circle( r=radius, $fn=sides );
                // take away inner shape
                if (solid=="no"){
                offset( r=5-thickness, $fn=48 )
                    circle( r=radius, $fn=sides );
                    }
                }
            }
        }

}
////Handle 
translate([92,149,0]) {
    difference() {
        difference() {
            cylinder(h=2, r=10);
            cylinder(h=2, r=5);

        }
        translate([0,-10,0]) {
            cube(size=[10,10,2]);        
        }
    }
}