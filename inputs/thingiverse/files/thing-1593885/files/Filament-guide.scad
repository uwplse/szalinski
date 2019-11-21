quality=100*1;

//Distance from the hole to the Clamp
holder_length=20; //[15:50]
hole_diameter=5;  //[1:10]
//Thickness of the feeder
holder_thickness=5;//[1:15]
backplate_thickness=holder_thickness;
//Thickness of your shelf/table ... which you clamp to
clamp_distance=30;//[5:100]
inner_diameter=hole_diameter+holder_thickness;
//Length of the clamping part
clamp_length=50;//[1:50]
//Size of the Nut measured on the outside of the Nut (not the flat parts)
nut_size=8;//[1:12]
//Thickness of the nut
nut_height=3;//[1:20]
//Diameter of the Screw (e.g. 4 for M4 skrew)
screw_size=4;//[1:30]


rotate([0,90,0])
{

//Torus:
//color("Lime")
rotate_extrude(convexity = 10,$fn = quality)
translate([inner_diameter, 0, 0])
circle(r = holder_thickness,$fn = quality);


//Round Edge(left)
//color("Red")
translate([0,-(holder_length/2)+5,0])
rotate([90,0,0])
translate([inner_diameter,0,5])
linear_extrude(height = holder_length, center = true, convexity = 10)
circle(r = holder_thickness,$fn = quality);

//Round Edge(right)
translate([0,-(holder_length/2)+5,0])
rotate([90,0,0])
translate([-inner_diameter,0,5])
linear_extrude(height = holder_length, center = true, convexity = 10)
circle(r = holder_thickness,$fn = quality);



//Center Piece
//color("Blue")
translate([
-inner_diameter,
-(holder_length),
-holder_thickness])

cube(size = [
				(inner_diameter*2),
				holder_length-(inner_diameter),
				holder_thickness*2
				]);


//Flat_Top
//color("Gray")

	
difference()
{	
	
	
	difference()
	{



		difference()
		{
		translate([0, 0, -holder_thickness])
		rotate_extrude(angle=180,convexity = 10,$fn = quality)
		translate([inner_diameter, 0, 0])
		square(size=([holder_thickness,(holder_thickness*2)]));

		translate([0,(holder_thickness+inner_diameter)/2,0])
		cube(center=true,
					size = [
					(inner_diameter*2)+holder_thickness*2,
					holder_thickness+inner_diameter,
					holder_thickness*2.1
					]);
		}

		difference()
		{
		translate([-(holder_thickness/2),0,0])
		rotate([90,0,0])
		translate([-inner_diameter,0,5])
		linear_extrude(height = holder_length+1, center = true, convexity = 10)
		square([
				holder_thickness,
				(holder_thickness*2.1)],
				center=true,
				$fn = quality);
	
		rotate([90,0,0])
		translate([-inner_diameter,0,5])
		linear_extrude(height = holder_length, center = true, convexity = 10)
		circle(r = holder_thickness,$fn = quality);
		}


	}


difference()
		{
		
		translate([(holder_thickness/2),0,0])
		rotate([90,0,0])
		translate([inner_diameter,0,5])
		linear_extrude(height = holder_length+1, center = true, convexity = 10)
		square([
				holder_thickness,
				(holder_thickness*2.1)],
				center=true,
				$fn = quality);

		rotate([90,0,0])
		translate([inner_diameter,0,5])
		linear_extrude(height = holder_length, center = true, convexity = 10)
		circle(r = holder_thickness,$fn = quality);	
		}
}
//Flat Top 2
difference()
{

//color("Blue")
translate([
-inner_diameter,
-((inner_diameter)),
-holder_thickness])

cube(size = [
				(inner_diameter*2),
				inner_diameter,
				holder_thickness*2
				]);

translate([0, 0, -holder_thickness*1.1])
		rotate_extrude(angle=180,convexity = 10,$fn = quality)
		square(size=([holder_thickness+inner_diameter,(holder_thickness*2.2)]));



}

//Backplate:

//color("Orange")
translate([
-(inner_diameter+holder_thickness),
-(holder_length),
-clamp_distance/2])

cube(size = [
				(inner_diameter*2)+holder_thickness*2,
				backplate_thickness,
				clamp_distance
				]);

//Top Clamp
difference()
{
translate([0,-(holder_length+clamp_length/2),(clamp_distance/2)+(backplate_thickness/2)])

cube(center=true,size = [
				(inner_diameter*2)+holder_thickness*2,
				clamp_length,
				holder_thickness
				]);

//Nut:
//color("blue")
translate([0,-(holder_length+clamp_length/2),(nut_height/2)+(clamp_distance/2)])
linear_extrude(1.1*nut_height, center = true, convexity = 10)
circle(nut_size/2,$fn=6);

//screw:
//color("Green")
translate([0,-(holder_length+clamp_length/2),clamp_distance/2])
cylinder(r=(screw_size/2)+0.5,h=1.1*holder_thickness);



}

//Bottom Clamp
translate([0,-(holder_length+clamp_length/2),-((clamp_distance/2)+(backplate_thickness/2))])

cube(center=true,size = [
				(inner_diameter*2)+holder_thickness*2,
				clamp_length,
				holder_thickness
				]);
//Round Edges:
//Upper Edge
difference()
{

union()
{

translate([(inner_diameter+holder_thickness),-holder_length,clamp_distance/2])

rotate([0,-90,0])
cylinder(r=holder_thickness,h=2*(inner_diameter+holder_thickness),$fn = quality);






//Lower Edge
translate([(inner_diameter+holder_thickness),-holder_length,-clamp_distance/2])
rotate([0,-90,0])
cylinder(r=holder_thickness,h=2*(inner_diameter+holder_thickness),$fn = quality);
}

//Inside Edge
//color("pink")
translate([0,-(holder_length+holder_thickness/2),0])
cube(center=true,[2.1*(inner_diameter+holder_thickness),holder_thickness,clamp_distance]);
}
}


