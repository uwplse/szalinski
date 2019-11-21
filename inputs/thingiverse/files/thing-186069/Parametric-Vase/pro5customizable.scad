// preview[view:south, tilt:side]


/*
*
*	Creator: Meiying Cheung
*	MCP-lab: http://hci.rwth-aachen.de/mcp
*	It draws a Vase
*
*/

/* [Parameters] */
//it changes the radio of the lower part:   
radio_body = 0;//[0:5]
//resize the hole figure but it may deform it:   
resize = 10;//[5.1:18.1]
//it changes the thick of the Vase:  
neck = 0;//[0:1]

/* [Hidden] */
union(){

	//handlers
	translate([0,0,15])rotate([90,0,0])rotate_extrude(convexity = 10)
	translate([resize, 0, 0])
	circle(r = 1);
	//

	//main body
	rotate_extrude(convexity = 10)
	union(){
		union()
		{
			difference()
			{
				difference()
				{
					square([resize,resize+resize*2]);
					translate([resize,resize*2,0])circle(r=resize*0.7-neck);
				}

				translate([5,5,0])
				circle(r=resize+radio_body);
			}
			intersection(){
			translate([5,5,0])
			circle(r=resize+radio_body);
			translate([0,-5,0])square([2*resize+radio_body,2*resize+radio_body]);
			}
		}	

	}

}