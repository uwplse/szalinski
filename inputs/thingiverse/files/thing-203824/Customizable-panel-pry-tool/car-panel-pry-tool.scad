//car panel pry tool
//Alex Tanchoco (LionAlex)
//Dec 14,2013

handle_length = 100;
handle_width = 10;
handle_thickness = 4;

rotate( [0,0,90] ) 
{
	difference() {
	intersection() {


		translate( [0,0,-handle_thickness*0.8] )
			rotate( [90,0,0] )
				rotate( [0,0,45] )
					cylinder( h=handle_length+handle_width, r2=handle_width+handle_thickness, r1=0, $fn=4, center=true );
			base_shape();

		}
		translate( [0,-handle_length*0.375,0] )
				cylinder( h=handle_thickness, r=handle_width/4, $fn=32, center=true );
	}
}

module base_shape() {
			cube( [handle_width,handle_length*0.75,handle_thickness],center=true );
			translate( [0,-handle_length*0.375,0] )
				cylinder( h=handle_thickness, r=handle_width/2, $fn=32, center=true );
		}
