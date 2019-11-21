//CUSTOMIZER VARIABLES

//Radius of the bearing not including the flange (all values in mm by default)
Bearing_Radius = 27;

//Height of the entire bearing (also diameter of the internal balls)
Bearing_Height = 12.5;

//Flange width 
Flange_Width = 2.8;

//Flange height
Flange_Height = 2.0;

//Thickness of the wall
Bearing_Wall = 1.4;

//Minimum radius of the certer portion of the bearing
Bearing_Internal_Radius = 10.5;

//Number of balls within the bearing
Bearing_Number = 8;

//Space between the balls and the internal bearing walls (on each side, must be greater than 0 or balls will print fused)
Bearing_Tolerance = 0.5;

//Bearing shell thickness
Bearing_Shell = 1.05;

//Cleaning up of the rough edges on the exterior of the bearing (recommended on)
Debur = "on"; // [on,off]

//Amount of material removed by the deburring process (try it till you find a good result)
Debur_Severity = 4;

//Radius of the bearing hole
Hole_Radius = 7;

//Number of sides of the bearing hole (only enabled if Hole Type is set to "userdef")
Hole_Facets = 6;

//Type of hole
Hole_Type = "circle"; // [circle,square, userdef]

//Definition of the entire model
Definition = 100;

module bearing (radius, height, flangew, flangeh, wallthk, intthickness, bearingnum, shellthk, bearingtol, debur, deburseverity, holerad, holefacet, holetype) {
    
    
    //Flange
    translate([0,0,-height/2]) {
        difference(){
            cylinder(flangeh, radius+flangew, radius+flangew, false);
            cylinder(height, radius, radius, true);
        }
    }

    //Outer wall
    difference(){
        cylinder(height, radius, radius, true);
        cylinder(height+2, radius-wallthk, radius-wallthk, true);
    }
        
    //Bearing shells       
	difference(){
        union(){
            intersection(){
                cylinder(height, intthickness+bearingtol*2+height + shellthk, intthickness+bearingtol*2+height + shellthk, true);
                rotate_extrude()translate([intthickness+bearingtol+height/2,0,0])circle(bearingtol+height/2+wallthk);   
            }
            
            //Reinforcements 
            for (n = [0: 10]) {
                rotate([0,0,(360/10)*n])translate([(radius+holerad)/2, 0, 0])cube([radius-holerad-wallthk,wallthk,height],true);    
            }
        }
    
        rotate_extrude()translate([intthickness+bearingtol+height/2,0,0])circle(bearingtol+height/2);
    
        if(debur == "on"){
            difference(){
                cylinder(height+2, intthickness+bearingtol+height/2+deburseverity, intthickness+bearingtol+height/2+deburseverity, true);
                cylinder(height+2, intthickness+bearingtol+height/2-deburseverity, intthickness+bearingtol+height/2-deburseverity, true);
            }
        }
    }    	
        
	// Inner hub
    difference() {
        cylinder(height, holerad+wallthk, holerad+wallthk, true);    
        
		if(holetype == "circle"){
			cylinder(height+2,holerad,holerad,true);
		}

		if(holetype == "square"){
			cube([holerad*sqrt(2),holerad*sqrt(2),height+2],true);
		}

		if(holetype == "userdef"){
			cylinder(height+2,holerad,holerad,true, $fn = holefacet);
		}  
    }

	for(n = [0:bearingnum-1]){
        rotate([0,0,(360/bearingnum)*n])translate([intthickness+bearingtol+height/2,0,0])sphere(height/2);
	}

} 

bearing(Bearing_Radius,Bearing_Height,Flange_Width,Flange_Height,Bearing_Wall, Bearing_Internal_Radius,Bearing_Number,Bearing_Shell,Bearing_Tolerance,Debur,Debur_Severity,Hole_Radius,Hole_Facets,Hole_Type,$fn = Definition);
