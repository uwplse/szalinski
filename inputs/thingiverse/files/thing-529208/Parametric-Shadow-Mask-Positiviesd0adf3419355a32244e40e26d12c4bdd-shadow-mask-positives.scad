// Enter the length of the shadow mask in mm
length = 100;

// Enter the width of the shadow mask in mm
width = 100;

// Enter the thickness of the shadow mask in mm
thickness = 2;

// Choose the desired shape from the drop down menu:
$fn = 25; //[3: Triangle, 4:Square, 5:Pentagon, 6:Hexagon, 25:Circle]

//Enter the size of the shape
shape_size = 3;

//Enter the spacing between shapes (Center-to-Center in mm)
spacing = 9;



module ShowPegGrid(Size) {
difference(){ 

//Creates the the general rectangular shape of the shadow mask based on parameters defined above
cube ([length,width,thickness],center = true);

//Based on parameters defiend, a shape is cut out of the rectangle in a 2D array
 for (i=[-length/((spacing+1)*2) : length/((spacing+1)*2)])
  for (j=[-width/((spacing+1)*2) : width/((spacing+1)*2)])
   
// Shape being created at position determined by double 4-loop  
   translate([i*spacing, j*spacing ,0])
	cylinder(h = 10,r = Size, center=true);
}
}

ShowPegGrid(shape_size);
