/* SPILIS LATHE BOWL
design by Daniel Spielmann, May 2015
//_________________________________
sorry, no cleanup, just changed for Customizer, May 2017
*/

// Scale X
scale_x = 2;
// Scale Y
scale_y = 2;
// Scale Z
scale_z = 1;


calotradius = 750; //[700:800]

/* [Hidden] */ 
cr = calotradius; 		

xscale = scale_x/10;
yscale = scale_y/10;
zscale = scale_z/10;

translate ([0,0,0])
bowl();


module bowl() {

scale([xscale,yscale,zscale]) {



difference()	{
difference()	{
	difference()	{
	calots();
	frame();
		}
	translate ([0,0,cr+80]) 
	scale([1,1,0.6])
	sphere((cr/2), $fn=100); 
}
translate ([0,0,80])
cube(size = [cr*2,cr*2,cr], center = true);
}
}
}

module calot() {
difference()	{
sphere(cr, $fn=100); 
translate ([0,0,-cr+550])
cube(size = [cr*2,cr*2,cr*2], center = true);
}
}

module calots() {
hull() {
calot();
translate ([0,0,cr*2-350])
mirror([0,0,1]) calot();
 }
}

module frame() {
difference()	{
translate ([0,0,cr/2])
cube(size = [cr*2,cr*2,1000], center = true);
translate ([0,0,cr/2])
cube(size = [cr-50,cr-50,1000], center = true);
}
}
