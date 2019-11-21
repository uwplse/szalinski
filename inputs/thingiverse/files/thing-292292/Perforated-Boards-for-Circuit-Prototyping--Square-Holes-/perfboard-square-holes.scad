// Perfboard Generator
// Author: Wing Tang Wong
// Description: parametrically create a normal perfboard of a given
//              dimension.
// 

/*Customizer Variables*/
/*[Perfboard]*/
board_width = 1;
board_length = 1;
hole_spacing = 0.10; //[0.05:0.05 inch(compact), 0.10:0.10 inch(normal)]
hole_diameter = 0.042; //[0.028:0.028 inch(compact), 0.035:0.035 inch(normal/plated), 0.042:0.042 inch(normal)]

metric_or_imperial = 25.4; //[1:Metric, 25.4:Imperial]


/*[Hidden]*/
// Perfboard generator
$FN=8;
spacing=hole_spacing * metric_or_imperial  ; // 0.1" spacing or 2.54mm spacing of the holes.
holes=(hole_diameter * metric_or_imperial) ; // 0.042" or 1.0668mm holes

board_w =  board_width * metric_or_imperial ; // 4"
board_l = board_length * metric_or_imperial ; // 4"

board_h = 0.062 * 25.4 ; // 0.062" or 1.6mm height 

x_max = ( ( board_w - ( 2 * spacing ) ) / spacing );
y_max = ( ( board_l - ( 2 * spacing ) ) / spacing );

difference() {
	cube( [ board_w, board_l, board_h ] );

for (x = [0:x_max]) 
{
	for(y = [0:y_max])
	{
    translate([(x * spacing) + spacing , (y * spacing) + spacing ,0]) 
		cube( [holes, holes, board_h * 4] , center = true );
    //translate([(x * spacing) + spacing , (y * spacing) + spacing ,0]) 
	//	cylinder( r=holes/2.00 , h = board_h * 4 );
	};	
};

};