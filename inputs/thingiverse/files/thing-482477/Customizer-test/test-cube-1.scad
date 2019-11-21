//customizer test

//width
x_measurement=10; // [5, 10, 15, 20]

//length
y_measurement=10; // [5, 10, 15, 20, 25, 30]

//height
numerical_slider = 10;	//	[0:30]

cube([x_measurement, y_measurement, z_measurement], center=true);

translate ([0, 0, numerical_slider/2]) 

//customizable cube

cube([x_measurement, y_measurement, numerical_slider], center=true);