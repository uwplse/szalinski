//CUSTOMIZER VARIABLES

//Radius of the entire bearing (all values in mm by default)
Bearing_Radius = 50;

//Height of the bearing balls (and the entire bearing if Custom_Height is off)
Ball_Height = 19.5;

//Use a different height for the bearing than the balls (this overrides the debur toggle if on)
Custom_Height_Toggle = "on"; // [on,off]

//Height of the entire bearing (only used if Custom_Height is on, should be greater than Race_Height)
Bearing_Height = 30;

//Minimum radius of the certer portion of the bearing
Bearing_Internal_Radius = 25;

//Number of balls within the bearing
Ball_Number = 11;

//Space between the balls and the internal bearing walls (on each side, must be greater than 0 or balls will print fused)
Ball_Tolerance = 0.5;

//Cleaning up of the rough edges on the exterior of the bearing (recommended on)
Debur = "on"; // [on,off]

//Amount of material removed by the deburring process (try it till you find a good result)
Debur_Severity = 5;

//Radius of the bearing hole
Hole_Radius = 20;

//Number of sides of the bearing hole (only enabled if Hole Type is set to "userdef")
Hole_Facets = 6;

//Type of hole
Hole_Type = "userdef"; // [circle,square,userdef]

//Definition of the entire model
Definition = 100;

//Cuts the bearing in half to aid with the design process
Design_Aid = "off"; // [on,off]

module bearing (radius, height, htoggle, customheight, intthickness, bearingnum, bearingtol, debur, deburseverity, holerad, holefacet, holetype) {

	difference(){

		if(htoggle == "off")cylinder(height, radius, radius, true);
        else cylinder(customheight, radius, radius, true);

		rotate_extrude()translate([intthickness+bearingtol+height/2,0,0])circle(bearingtol+height/2);

		if(debur == "on" || htoggle == "on"){

			difference(){

			cylinder(max(height, customheight)+2, intthickness+bearingtol+height/2+deburseverity, intthickness+bearingtol+height/2+deburseverity, true);

			cylinder(max(height, customheight)+2, intthickness+bearingtol+height/2-deburseverity, intthickness+bearingtol+height/2-deburseverity, true);

			};

		};

		if(holetype == "circle"){

			cylinder(max(height, customheight)+2,holerad,holerad,true);

		};

		if(holetype == "square"){

			cube([holerad*2,holerad*2,max(height, customheight)+2],true);

		};

		if(holetype == "userdef"){

			cylinder(max(height, customheight)+2,holerad,holerad,true, $fn = holefacet);

		};

	};

	for(n = [0:bearingnum-1]){

	rotate([0,0,(360/bearingnum)*n])translate([intthickness+bearingtol+height/2,0,0])sphere(height/2);

	};

}; 

difference(){

bearing(Bearing_Radius,Ball_Height, Custom_Height_Toggle, Bearing_Height, Bearing_Internal_Radius,Ball_Number,Ball_Tolerance,Debur,Debur_Severity,Hole_Radius,Hole_Facets,Hole_Type,$fn = Definition);

if(Design_Aid == "on")translate([-1-Bearing_Radius,0,0])cube([Bearing_Radius*2+2,Bearing_Radius*2, max(Ball_Height, Bearing_Height)]);
    
};
