//Diameter of rod in centimeters
Rod_Diameter = 3;
//Depth of rod socket in centimeters
Rod_Depth = 5; 
// Wall thickness around rod.
Wall_Thickness = 1;

module GenConnector()
{
	Rod_Radius = (Rod_Diameter/2)*1000;
	Rod_Depth =  Rod_Depth*1000;
	Wall_Thickness = Wall_Thickness*1000;
    
	Distance_From_Core = (Rod_Radius*2)+Wall_Thickness;
	Total_Rod = Distance_From_Core + Rod_Depth; // Full rod size is Rod_Depth+Distance_From_Core
scale(0.01,0.01,0.01){	
	difference() {
		hull(){
			rotate([90,0,0]){
				for(i = [1 :5]){
					rotate([31.720,72.000*i,0]){
                        cylinder(r = (Rod_Radius+Wall_Thickness), h = Total_Rod ); // Outside Shape
					}
				}
			}
		}

		rotate([90,0,0]){
			for(i = [1 :5]){
				rotate([31.720,72.000*i,0]){
					difference() {
						cylinder(r = Rod_Radius, h = Total_Rod ); // Inside holes. h is distance from core, and Rod_Depth.
						cylinder(r = Rod_Radius, h = Distance_From_Core ); // Distance from core. Should be atleast  Diameter of rod //2990 (2540+500) 3040
					}
				}
			}
		}
	}
}
}

GenConnector();

