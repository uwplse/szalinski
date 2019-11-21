//  Plastic Spacer v1.0 by areeve20



//	Measurement of spacer thickness
h_measurement = 20;	//	[0:200]

//  Measurement addition (Fine-tune Thickness)
ha_measurement = 0;  //  [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]

//	Measurement of spacer diameter
D1_measurement = 10;	//	[2:200]

//  Measurement addition (Fine-tune Diameter1)
D1a_measurement = 0;  //  [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]

//  Measurement of spacer hole
D2_measurement = 5; //  [1:200]

//  Measurement addition (Fine-tune Diameter2)
D2a_measurement = 0;  //  [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]



//	This is the spacer we've (hopefully) customized!

difference(){
translate([0,0,0]) cylinder(h_measurement+ha_measurement, D1_measurement+D1a_measurement, D1_measurement+D1a_measurement, center=true);

translate([0,0,0]) cylinder(h_measurement*2, D2_measurement+D2a_measurement, D2_measurement+D1a_measurement, center=true);
}
