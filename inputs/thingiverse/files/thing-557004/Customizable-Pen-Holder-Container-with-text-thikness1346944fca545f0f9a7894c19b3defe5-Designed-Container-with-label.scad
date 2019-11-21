use <MCAD/fonts.scad>

/* [Container Measurements] */
radius = 20; //[20:Narrow,25:25,30:Medium,40:Wide]
height = 100; //[100:Small-10cm,150:Medium-15cm,200:Large-20cm,250:Extra Large-25cm,300: Extra Extra Large-30cm]
height_per_layer = 5; //[5,10,15,20,25,50]

/* [Design] */
//How many holes do you want in each layer?
divisions_per_layer = 54;//[6:200]

//if you choose YES as customizable text will be added to the object
do_you_want_some_text_to_be_printed = "YES";//[YES,NO]
//Should be LESS THAN radius(first field in the form) number of characters
text_to_be_printed = "Customize ME!";
text_thickness = 1;//[0.5:100.0]

/* [Hidden] */
$fn=100;
link_radius_inner = radius;
link_width = height_per_layer;
thickness = 5;
number_of_links = divisions_per_layer;
angle_per_link = 360/number_of_links;
rotation_angle = 90 - angle_per_link;
extra_angle = angle_per_link/number_of_links;
no_of_levels = floor(height/height_per_layer);

//for 8 bit font rendering
thisFont=8bit_polyfont();
x_shift=thisFont[0][0];
y_shift=thisFont[0][1];
text=text_to_be_printed;


module linkShape()
{
	intersection()
{
	difference()
	{
		cylinder(link_width,link_radius_inner+thickness,link_radius_inner + thickness, center = true);
		cylinder(link_width+2,link_radius_inner,link_radius_inner, center = true);
	}
	
	cube(link_radius_inner*2);
	rotate(rotation_angle - extra_angle) cube(link_radius_inner*2);
}

}

module extraFillerLayer(r)
{
	difference()
	{
		cylinder(r,link_radius_inner+thickness,link_radius_inner + thickness, center = true);
		cylinder(r+2,link_radius_inner,link_radius_inner, center = true);
	}
}

module layerCuts()
{


	for(i= [1:number_of_links/2])
	{
		
		rotate(angle_per_link*2*i) linkShape();
		
	}
	
	
}

module buildLayers()
{
	
	translate([0,0,-1*height_per_layer/2])
	{
	for(i=[1:no_of_levels])
	{
		rotate(angle_per_link*i) translate([0,0,link_width/2*i]) layerCuts();
		translate([0,0,link_width/2*i]) extraFillerLayer(r=0.5);
	}
	translate([0,0,link_width/2*(no_of_levels+1)]) extraFillerLayer(r=1);
	}
	translate([0,0,1]) cylinder(5,link_radius_inner + thickness,link_radius_inner +thickness, center = true);

}

module display_text_letters(word_offset=20.0,word_height=2.0) {

	if(do_you_want_some_text_to_be_printed=="YES")
	{

	translate([0,0,link_width*no_of_levels/4])	difference()
	{
		cylinder(10,link_radius_inner+thickness,link_radius_inner + thickness, center = true);
		cylinder(12,link_radius_inner,link_radius_inner, center = true);
	}


  color([200/255,200/255,200/255]) translate([0,0,link_width*(no_of_levels/4)-2-1]) for(i=[0:(len(text)-1)]) assign( textHandAngle=(i+1)*360/word_offset, theseIndicies=search(text[i],thisFont[2],1,1) ) 

    rotate(-90+textHandAngle) translate([word_offset,0])
      for( j=[0:(len(theseIndicies)-1)] ) translate([j*x_shift,-y_shift/2]) {
		rotate([90,0,90])
        linear_extrude(height=word_height) polygon(points=thisFont[2][theseIndicies[j]][6][0],paths=thisFont[2][theseIndicies[j]][6][1]);
      }
	}
  
}


buildLayers();
display_text_letters(word_offset=link_radius_inner+thickness-1,word_height=text_thickness);


