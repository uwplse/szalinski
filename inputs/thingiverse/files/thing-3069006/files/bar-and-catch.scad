//Bar and catch
//Print with a brim for stability
//
//Daniel Urquhart 2018


// Which one would you like to see?
part = "both"; // [bar,catch,both]

//height of slot for tie 
slotHeight = 7;

//height for catch, bar is slightly larger
catchHeight = 10;

/* [Hidden] */
$fa=6 ;
$fs=0.2;

module bar(a,b)
{
difference()
{
	for(i = [0,180]) rotate([i,0,0])
	{
		cylinder(a, r=4);
		translate([0,0,a])
			cylinder(b, d1=8,d2=6);
	}
	cube([10,3,slotHeight], center=true);
}

}

module catch(h=12)
{
	thickness=4;
	difference()
	{
		union(){
			cylinder(h*2, d=8, center=true);
			translate([5,0,0])
				cube([10,thickness,h*2], center=true);
		}
		rotate([0,0,60])
			cube([10,3,slotHeight], center=true);
	}
	
	translate([9,-(9+thickness )/2,0])scale([1.1,1,1])
	difference()
	{
		cylinder(h*2, r=4.5+thickness, center=true);
		cylinder(1+h*2, r=4.5, center=true);
		translate([-10,0,0])
			cube([20,20,h*2+1], center=true);
		translate([4,-h*0.7,0])scale([1,1.4,1])rotate([0,90,0])
			cylinder(15, r=h/2, center=true);
	}

}

if(part == "both" || part == "catch")
translate([0,0,10])
	catch(catchHeight);

if(part == "both" || part == "bar")
translate([-11,0,catchHeight*0.1*(7+5)])color([0.6,0.6,0.6])
	bar(catchHeight*7/10,catchHeight*5/10);
