use <write/Write.scad>;

//The target average of the set
ave=4.5;
//The target standard deviation of the set
std=1.5;
//Size of the matrix (columns and rows)
size=10;

/* [Hidden] */
$fn=50;

for (x = [0:size-1])
{
	for (y = [0:size-1])
	{
	difference ()
		{
			translate([x*15,y*15,0]) cylinder (r=6.8,h=10,center=true);
			translate([x*15,y*15,5])rotate([0,0,n*35]) write(str(round(std*sqrt(-2*ln(rands(0,1,1)[0]))*cos(360*rands(0,1,1)[0])+ave)),h=8,t=3, center=true);
			
		}
	}
}