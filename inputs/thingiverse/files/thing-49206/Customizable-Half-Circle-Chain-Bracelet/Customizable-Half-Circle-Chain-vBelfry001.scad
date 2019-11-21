// Filename: Customizable Half Circle Chain vBelfry001.scad
// Author: Belfry ( John Gardner - JGPC )
// Date: 02/10/2013
// Phone: 901-366-9606
// Project: Half Circle Chain Scad File


// Creates a chain of 'Half Circle' objects.


// use <MCAD/boxes.scad>
use <utils/build_plate.scad>
// use <write/Write.scad>


//: Number of Links
number_links = 16; // [6,8,10,12,14,16,18,20,22,24,26,28,30,32,48] 

echo ( "Number of Links" , number_links );

pi_value = 3.14159 *1;	// pi

echo ( "Pi" , pi_value );

//: Size of Links
default_size = 10;	// [5:Tiny,8:Small,10:Medium,12:Large,15:Extra Large]

echo ( "Link Size" , default_size );

//: Default Thickness (%) for links
how_thick = 0.15;	//	[0.1:Thin,0.15:Medium,0.2:Thick]
// how_thick = 0.2;

echo ( "Thickness %" , how_thick );

//: Inner Ring Spacing Multiplier
inner_separation = 1.05;

//: Outer Ring Spacing Multiplier
outer_separation = 1.05;

//: Print Quality-used by $fn parameter(s)
polygon_count = 16;	// [8,12,16,20,24,28,32]

echo( "Print Quality / Polygon Count" , polygon_count );

//: Show Overlap (intersection) Between Links
show_overlap = 0; // [0:No,1:Yes]
//show_overlap = 1;

link_radius = default_size * how_thick;
link_offset = default_size + link_radius;
link_length = link_offset * 2;	// total (outside) length of link

echo ( "Inner Separation" , inner_separation );
echo ( "Outer Separation" , outer_separation );
echo ( "Link Radius" , link_radius );
echo ( "Link Offset" , link_offset );
echo ( "Link Length" , link_length );

circle_links = round( number_links / 2 );
circle_loops = circle_links - 1;
offset_angle = (360/number_links);
echo ( "Angle" , offset_angle);

inner_circumference = link_length * circle_links;
inner_diameter = ( inner_circumference / pi_value );
inner_radius = inner_diameter / 2;

echo ( "Inner Circumference" , inner_circumference );
echo ( "Inner Diameter" , inner_diameter );
echo ( "Inner Radius" , inner_radius );

// find the 'long' side of the right triangle
x_translate = sqrt( pow( inner_radius , 2 ) - pow( default_size , 2 ) );

inner_trans = x_translate * inner_separation;

//outer_trans = ( x_translate + ( link_radius * 2 )) * outer_separation;
outer_trans = ( x_translate + default_size - ( link_radius * 4 )) * outer_separation;

total_diameter = ( ( inner_trans + default_size + link_radius ) * 2 );
echo ( "Total Diameter" , total_diameter );

echo ( "Show Overlap / Intersection" , show_overlap );



//---[ Build Plate ]----------------------------------------------------------

//: for display only, doesn't contribute to final object
build_plate_selector = 2; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//: when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100 + 0;
//: when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100 + 0;

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//-------------------------------------------------



if ( show_overlap == 1 )
{
#circle(inner_radius);

intersection()
{
inner_circle();
outer_circle();
}

}

else
{
inner_circle();
outer_circle();
}




// ---[ End of program ]---





//----------------------------------------------------------------------------

// ---[ Start of module definitions ] ---


// ----- [ inner circle ]-----
module inner_circle()
{
for(i=[0:circle_loops])
	{
	echo ( "Inner Circle Count" , i );
	rotate([0,0,(360/circle_links) * i])
	{
	translate([inner_trans,0,0]) rotate([0,0,270]) chain_link( link_size=default_size );
	}
	}
}


// ----- [ Outer circle ]-----
module outer_circle()
{
for(i=[0:circle_loops])
	{
	echo ( "Outer Circle Count" , i );
	rotate([0,0,((360/circle_links) * i)+offset_angle])
	{
	translate([outer_trans,0,0]) rotate([0,0,90]) chain_link( link_size=default_size);
	}
	}
}


// --- Dougnut Shape ------
module doughnut( r1=4 , r2=1 )
{
echo ("Doughnut Shape");
rotate_extrude($fn=polygon_count)
	translate([r1,0,0])
	circle(r=r2,$fn=polygon_count);
}


// --- Ring Shape -----
module ring( rsize = default_size )
{
echo ("Ring Shape");
difference()
{
doughnut( r1=rsize , r2=(rsize*how_thick));
//cylinder( h=rsize , r1=rsize, r2=rsize , center=true , $fn=polygon_count );
}
}


// --- Arch Shape -----
module arch( arch_size = default_size )
{
echo ("Arch Shape");
difference()
{
rotate([90,0,0]) ring( rsize = arch_size );
translate([0,0,-arch_size*2]) cube(arch_size*4,center=true,$fn=polygon_count);
}
}


// --- Split Arch Shape -----
module split_arch( split_arch_size = default_size )
{
echo ("Split Arch Shape");
difference()
{
rotate([-90,0,0]) arch( arch_size = split_arch_size );
translate([0,0,-split_arch_size*2]) cube(split_arch_size*4,center=true,$fn=polygon_count);
}
}


// --- Chain Link Object -----
module chain_link( link_size = default_size )
{
echo ("Chain Link Object");
union()
{
arch( arch_size = link_size );
split_arch( split_arch_size = link_size );
}
}

