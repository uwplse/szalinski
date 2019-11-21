
//CUSTOMIZER VARIABLES

//	This section is displays the box options
//	Measurement of box on the X axis
inside_dimension = 50;		

//	Measurement of box on the Y axis
//y_measurement = 30;		

//	Measurement of box on the Z axis
//z_measurement = 50;

//	This creates a drop down box of numbered options
//number_drop_down_box = 1;	//	[0,1,2,3,4,5,6,7,8,9,10]

//	This creates a drop down box of text options
//text_drop_down_box = "yes";	//	[yes,no,maybe]

//	This creates a drop down box of text options with numerical values
//labeled_drop_down_box = 5;	//	[1:small, 5:medium, 10:large, 50:supersized]

//	This creates a slider with a minimum and maximum
//numerical_slider = 1;	//	[30:80]



//CUSTOMIZER VARIABLES END

//	This is the cube we've customized!
difference() {
    
     cube([inside_dimension+4,30,50], center=true);
     translate([0,-2,0]) {
           cube([inside_dimension,30,52], center=true); 
        }
      translate([0,-8,10]) {
         cube([100,30,10], center=true); 
       } 
      translate([0,-8,-10]) {
         cube([100,30,10], center=true); 
       } 

}
