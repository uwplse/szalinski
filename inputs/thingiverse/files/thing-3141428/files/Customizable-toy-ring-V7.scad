//the diameter of the wearers finger in mm
main_internal_diameter=16.7;

ring_type="cs_ellipse";//[cs_pill,cs_ellipse,cs_hemi_ellipse,cs_rounded_hemi_ellipse,cs_rectangle,cs_scallopped_rectangle,cs_rounded_scallopped_rectangle,cs_rounded_rectangle,cs_chamfered_rectangle,cs_half_pill,cs_reverse_hemi_ellipse,cs_reverse_rounded_hemi_ellipse]

//wall to hold the diamond in mm
crown_wall=2.5;

//Plastic diamond diameter in mm (11.6 are the big plastic ones typically available)
stone_target_diameter=11.8; 

/* [Hidden] */

/*!
@brief Customizable toy ring - Remix of "Ring creation script" by Mark Gaffney

@details This OpenSCAD script will generate an etoile style ring (similar to this http://www.tiffany.com/Engagement/Item.aspx?GroupSKU=GRP10009)with a jewel mount for a brilliant (round) cut diamond or similar item.
Most parameters are user selectable as are the ring profile shapes.
This would be ideal for an engagement ring...

@author Mark Gaffney
@version 0.14
@date 2013-02-12

@todo
add option to round edges on crown
make gap between 2 sides of crown slightly smaller than required to exert pressure on sides of jewel to hold it in place for proper tension set performance 
add complete roman font polygons for engraving
implement hidden compartment

@warning
Let the right one in

@note
Changes from previous versions:

0.14
 - 	Replaced deprecated import_stl with import
 - 	Added control variable "generate_jewel", if 0 import the jewel from "brilliant1.stl", else try to generate it on-the-fly (this may cause errors as pointed out by mrchriseyes)
*/
//******Fixed*Variables*******
a_bit=0.01;//something I use to help ensure manifoldness etc. do not change please!
pi=3.1415926535;

stone_girdle_diameter=100;//do not change
stone_table_diameter=53;//do not change
stone_cutlet_diameter=2;//do not change
stone_crown_height=16.2;//do not change
stone_pavillion_depth=43.1;//do not change
stone_girdle_depth=1;//do not change

//*******User*Variables*******
$fn=50; //how smooth and round is it? Bigger numbers mean smoother shapes but take a lot longer to render! Setting this value will also cause how the jewel is rendered to be changed from a proper 57/58 facet round brilliant cut.

//choose features
	with_jewel=0;//0 or 1 for rendering without or with set jewel respectively
	generate_jewel=1;//if 0 import the jewel from "brilliant1.stl", else try to generate it on-the-fly (this may cause errors)
	with_splayed_crown=1;//0 or 1 for rendering without or with a splayed(tapered) crown respectively
	with_bowtie_split=1;//0 or 1 for rendering without or with a bowtie split crown respectively
	with_rectangular_split=0;//0 or 1 for rendering without or with a rectangular split crown respectively

//choose colo(u)rs
	colour_RGBA_stone=[0,0,1,0.15];//colour of the stone in Red, Green, Blue, Opacity where the values can be anything from 0-1
	colour_RGBA_metal=[0.75,0.75,0.75,1];//colour of the metal in Red, Green, Blue, Opacity where the values can be anything from 0-1

//choose ring size
	ring_size_us_can=6.25;//enter US numerical ring size
	ring_size_uk_ie_aus_nz=12.5;//Enter UK numerical ring size, make sure to convert from letters to numbers i.e. a=1, b1/2=2.5, z=26
	ring_size_ind_chn_jpn=11;//Enter India numerical ring size
	ring_size_switz=12.75;//Enter Swiss numerical ring size

//choose ring sizing system, comment in one of the lines below depending on which sizing system you are using
//	main_internal_diameter=50;//(mm)the diameter of the wearers finger in mm
//	main_internal_diameter=(ring_size_us_can+14.312)/1.2308;//(US, Canada size to mm ID)the diameter of the wearers finger in mm
//	main_internal_diameter=(ring_size_uk_ie_aus_nz+29.549)/2.5352;//(UK, Ireland, Australia, New Zealand size to mm ID)
//	main_internal_diameter=(ring_size_ind_chn_jpn+34.749)/2.7924;//(India, China, Japan size to mm ID)the diameter of the wearers finger in mm
//	main_internal_diameter=(ring_size_switz+39.561)/3.1314;//(Swiss to mm ID)
//echo ("main_internal_diameter=",main_internal_diameter);

//choose ring band dimensions
	main_wall=2;//difference between ring inner and outer radius
	main_depth=4.34;//how wide the band of the ring is
	main_feature=0.5;//this is the 3rd variable for the cross section, it is not used in simple shapes like rectangular but controls features for other shapes including scallop depth, chamfer length, fillet radius, make sure it is less than half of the smallest of the 2 previous parameters

//choose stone/jewel weight/dimensions
//	stone_target_carat=0.31;
//	stone_target_grammes=stone_target_carat/5;//this doesn't do anything currently but if you want to know what your diamond will weight in grams device its carat weight by 5

//	stone_target_diameter=11.8;//11.6 is the plastic size. // 6.5065412147*pow(stone_target_carat,0.3381325352);//this calculation converts carat weight to girdle diameter in mm using a fitted power curve
//	stone_target_diameter=1.964367652*ln(stone_target_carat) + 6.6289134546;//this calculation converts carat weight to girdle diameter in mm using a fitted log curve
//	stone_target_diameter=4.34;//what girdle diameter of stone do you want in mm

	stone_scale=stone_target_diameter/stone_girdle_diameter;//do not change
	stone_height=stone_scale*(stone_crown_height+stone_girdle_depth+stone_pavillion_depth);//do not change
	stone_diameter=stone_girdle_diameter*stone_scale;
echo (stone_diameter);

//choose crown/fitting/mounting dimensions
	crown_depth=stone_height;//these should really be changed to match the jewel chosen//wait NOW it does!
	crown_external_diameter_outer=crown_wall+stone_diameter;//these should really be changed to match the jewel chosen//wait NOW it does!
	crown_internal_diameter_outer=stone_diameter;//these should really be changed to match the jewel chosen//wait NOW it does!
	crown_internal_diameter_inner=2;//diameter of the hole behind the jewel
	crown_split_w=1;//what width in mm do you want the rectangular shaped crown cutout to be//deprecated for now
	crown_interference=2;//how far into the band the crown sits, this will need to be adjusted depending on the ring cross section chosen

//derived working values (DO NOT CHANGE)
	distance_centre_ring_to_face_crown=(main_internal_diameter+stone_height);
	twice_tangent_value=crown_external_diameter_outer/distance_centre_ring_to_face_crown;
	crown_external_diameter_inner=with_splayed_crown*(twice_tangent_value*(main_internal_diameter+main_wall-crown_interference)) + (abs(with_splayed_crown-1))*crown_external_diameter_outer;

//choose  crown/fitting/mounting cutout features
	bowtie_angle=90;//what angular sweep do you want the bowtie shaped crown cutout to make
	bowtie_length=max(crown_external_diameter_outer,main_depth)+a_bit;
	//bowtie_depth=crown_depth+main_wall+1;
	bowtie_depth=stone_height+1;

//Choose cross section hape for ring band, set one of these lines to 1 the rest to 0 to choose the cross section for the ring band

//	cs_pill=0;
//	cs_ellipse=1;
//	cs_hemi_ellipse=0;
//	cs_rounded_hemi_ellipse=0;
//	cs_rectangle=0;
//	cs_scallopped_rectangle=0;
//	cs_rounded_scallopped_rectangle=0;
//	cs_rounded_rectangle=0;
//	cs_chamfered_rectangle=0;
//	cs_half_pill=0;
//	cs_reverse_hemi_ellipse=0;
//	cs_reverse_rounded_hemi_ellipse=0;
////	cs_half_chamfered_rectangle=0;//not yet implemented



//engraving features
	font_height=2; 
	font_width=2;
	font_spacing=1;
	engraving_depth=1;



//********User*Feedback****

echo("stone_height ", stone_height);
echo("stone_target_diameter",stone_target_diameter);
echo("main_internal_diameter ", main_internal_diameter);
if(with_splayed_crown==1) {echo("with_splayed_crown");}
if(with_rectangular_split==1) {echo("with_rectangular_split of width", crown_split_w);}
if(with_bowtie_split==1) {echo("with_bowtie_split of angle ", bowtie_angle);}

//**********Calls************
difference(){//remove gem, cone, trumpet and additional under crown material to match ring inner profile
	union(){//add secondary crown
		difference()
        {//remove bowtie & split
			render() 
                union()
                {//add basicring shape to basic crown shape
                    color(colour_RGBA_metal) 
                        ring_shape(main_internal_diameter, main_depth, main_wall, main_feature);
                    
                    color(colour_RGBA_metal) 
                        ring_crown(main_internal_diameter, main_depth, main_wall, crown_external_diameter_outer, crown_external_diameter_inner, crown_internal_diameter_outer, crown_depth, crown_wall,crown_interference);
                }

                rotate (a=[0,90,0]) 
                    translate(v=[0,0,(main_internal_diameter+bowtie_depth)/2 - 0.5])
                    {//split, bowtie 
                        if(with_rectangular_split==1)
                        {
                            color(colour_RGBA_metal) 
                                cube(size=[crown_external_diameter_outer+a_bit,crown_split_w,bowtie_depth], center=true);//make a rectangular cutout to split the crown
                        }
                        if(with_bowtie_split==1){
                            color(colour_RGBA_metal) 
                                bowtie (bowtie_angle, bowtie_length, bowtie_depth); //make a bowtie shaped cutout to split the crown
                        }
                    }
        }
        
		//secondary crown
//		color(colour_RGBA_metal) ring_crown(main_internal_diameter, main_depth, main_wall, (crown_external_diameter_outer+ crown_external_diameter_inner)/2-(0.6*crown_wall), crown_external_diameter_inner-(0.6*crown_wall), crown_internal_diameter_outer, crown_depth/2, crown_wall,crown_interference);
		color(colour_RGBA_metal) 
            ring_crown(main_internal_diameter, main_depth, main_wall, main_depth, crown_external_diameter_inner-(0.6*crown_wall), crown_internal_diameter_outer, crown_depth/2, crown_wall,crown_interference);
	}
	//engraving
	render() 
        rotate(a=[0,0,130]) 
            color(colour_RGBA_metal) 
                cylindrical_engraving(main_internal_diameter/2, main_depth, main_depth/2, main_depth/2, main_depth/8, main_wall/8, pi, -1);
	//cone
    shorter=bowtie_depth/2;
	rotate (a=[0,90,0]) 
        translate(v=[0,0,(main_internal_diameter+bowtie_depth)/2 - 0.5+shorter/2]) 
            color(colour_RGBA_metal) 
                cylinder (r1=(crown_internal_diameter_inner+crown_internal_diameter_outer)/4, r2=crown_internal_diameter_outer/2, h=bowtie_depth-shorter,center=true, $fs=0.25);//make a cylindrical cutout in the centre of the crown

	//trumpet
	render() 
        rotate (a=[0,90,0]) 
            translate(v=[0,0,(main_internal_diameter+bowtie_depth)/2 - 0.5]) 
                translate(v=[0,0,0.6-bowtie_depth/2]) color(colour_RGBA_metal) 
                   trumpet(2, 0.5, (crown_internal_diameter_inner+2)/2, crown_internal_diameter_inner/2);
    
	//gem shaped seat
	render()    
        rotate (a=[0,90,0]) 
            translate(v=[0,0,(main_internal_diameter/2)+ stone_scale*stone_pavillion_depth]) 
                scale(v=1.07*stone_scale)
                {
                    if (generate_jewel==0)
                    {
                            color(colour_RGBA_metal) 
                                import ("brilliant1.stl", convexity=2); //comment this line in if you want to load the diamond shape from .stl file
                    }
                    else
                    {
                        #render() 
                            color(colour_RGBA_metal) 
                                ring_stone(stone_girdle_diameter, stone_table_diameter, stone_cutlet_diameter, stone_crown_height, stone_pavillion_depth,stone_girdle_depth); //comment this line in if you want to generate the diamond shape in the code
                    }
                }
    
	difference()
    {
        //subtract material from inner surface of crown
		union()
        {
			color(colour_RGBA_metal) 
                cylinder(h=main_depth+a_bit, r=(main_internal_diameter+main_wall)/2, center=true);//make conical hole in crown
            
			translate(v=[0,0,main_depth]) 
                color(colour_RGBA_metal) 
                    cylinder(h=main_depth, r1=(main_internal_diameter+main_wall)/2, r2=(main_internal_diameter+main_wall), center=true);//make conical hole in crown
            
			translate(v=[0,0,-main_depth]) 
                color(colour_RGBA_metal) 
                    cylinder(h=main_depth, r2=(main_internal_diameter+main_wall)/2, r1=(main_internal_diameter+main_wall), center=true);//make conical hole in crown
		}
		
        color(colour_RGBA_metal) 
            ring_shape(main_internal_diameter, main_depth, main_wall, main_feature);// remove material from base of crown to match inside profile of ring
	}

   translate([-main_internal_diameter,-main_internal_diameter,main_depth/2*.95]) cube(main_internal_diameter*2);
   translate([-main_internal_diameter,-main_internal_diameter,-main_internal_diameter*2-main_depth/2*.95]) cube(main_internal_diameter*2);

}


if(with_jewel==1){
	rotate (a=[0,90,0]) translate(v=[0,0,(main_internal_diameter/2)+ stone_scale*stone_pavillion_depth]) scale(v=1.07*stone_scale){
		if (generate_jewel==0){
			render() color (colour_RGBA_stone) import ("brilliant1.stl", convexity=5);// ring_stone (stone_girdle_diameter, stone_table_diameter, stone_cutlet_diameter, stone_crown_height, stone_pavillion_depth, stone_girdle_depth);
		}else{
			render() color(colour_RGBA_metal) ring_stone(stone_girdle_diameter, stone_table_diameter, stone_cutlet_diameter, stone_crown_height, stone_pavillion_depth,stone_girdle_depth); //comment this line in if you want to generate the diamond shape in the code
		}
	}
}

//color(colour_RGBA_metal) ring_crown(main_internal_diameter, main_depth, main_wall, (crown_external_diameter_outer+ crown_external_diameter_inner)/2-crown_wall/2, crown_external_diameter_inner-crown_wall/2, crown_internal_diameter_outer, crown_depth/2, crown_wall,crown_interference);

//ring_engraving();
//ring_compartment();

//*******Modules************
module ring_shape(ring_internal_diameter, ring_depth, ring_wall, ring_feature){
	rotate_extrude (convexity = 20) translate([(ring_internal_diameter)/2, 0, 0]){
		if(ring_type=="cs_pill"){
			echo("Pill Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			pill_shape (ring_depth, ring_wall);
		}
		if(ring_type=="cs_ellipse"){
			echo("Ellipse Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			ellipse_shape (ring_depth, ring_wall);
		}
		if(ring_type=="cs_hemi_ellipse"){
			echo("Hemi Ellipse Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			hemi_ellipse_shape (ring_depth, ring_wall);
		}
		if (ring_type=="cs_rounded_hemi_ellipse"){
			echo("Rounded Hemi Ellipse Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			rounded_hemi_ellipse_shape (ring_depth, ring_wall, ring_feature);
		}
		if(ring_type=="cs_rectangle"){
			echo("Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			rectangle_shape (ring_depth, ring_wall);
		}
		if(ring_type=="cs_scallopped_rectangle"){
			echo("Scallopped Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			scallopped_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		if(ring_type=="cs_rounded_scallopped_rectangle"){
			echo("Rounded Scallopped Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			rounded_scallopped_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		if(ring_type=="cs_rounded_rectangle"){
			echo("Rounded Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			rounded_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		if(ring_type=="cs_chamfered_rectangle"){
			echo("Chamfered Rectangle Shaped Cross Section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			chamfered_rectangle_shape (ring_depth, ring_wall, ring_feature);
		}
		if(ring_type=="cs_half_pill"){
			echo("Half Pill Shaped Cross Section, depth",  ring_depth, "wall",ring_wall);
			half_pill_shape (ring_depth, ring_wall);
		}
		if(ring_type=="cs_reverse_hemi_ellipse"){
			translate (v=[ring_wall,0,0]) rotate(a=[0,0,180]) hemi_ellipse_shape (ring_depth, ring_wall);	
		}
		if(ring_type=="cs_reverse_rounded_hemi_ellipse"){
			translate (v=[ring_wall,0,0]) rotate(a=[0,0,180]) rounded_hemi_ellipse_shape (ring_depth, ring_wall, ring_feature);
		}

		// if(cs_half_chamfered_rectangle==1){
			// echo("chamfered rectangle shaped cross section, depth",  ring_depth, "wall",ring_wall,"feature", ring_feature);
			// chamfered_rectangle_shape (ring_depth, ring_wall, ring_feature);
		// }
	}
}

module ring_crown(ring_internal_diameter, ring_depth, ring_wall, crown_external_diameter_outer, crown_external_diameter_inner, crown_internal_diameter, crown_depth, crown_wall,crown_interference){
	translate(v=[(ring_internal_diameter/2)+ring_wall-crown_interference,0,0]) rotate(a=90, v=[0,1,0]) cylinder(h=crown_depth, r2=crown_external_diameter_outer/2, r1=crown_external_diameter_inner/2, center=false);
//ring_shape(crown_internal_diameter, crown_depth, crown_wall);
//referring back to another module causes crash it seems
}

module ring_stone(stone_girdle_diameter, stone_table_diameter, stone_cutlet_diameter, stone_crown_depth, stone_pavillion_depth, stone_girdle_depth){

	difference(){
		union(){//this gives the rough main shape (from v0.1)
			rotate (a=180/8, v=[0,0,1]) translate (v=[0,0,stone_girdle_depth/2]) cylinder (r1=stone_girdle_diameter/2, r2=stone_table_diameter/2, h=stone_crown_depth, center=false,  $fa=360/8);//crown (top)
			rotate (a=180/8, v=[0,0,1]) translate (v=[0,0,0]) cylinder (r=stone_girdle_diameter/2, h=stone_girdle_depth+0.1, center=true, $fa=360/16); //girdle (middle)
			rotate (a=180/8, v=[0,0,1]) rotate(a=180, v=[1,0,0]) translate (v=[0,0,stone_girdle_depth/2]) cylinder (r1=stone_girdle_diameter/2, r2=stone_cutlet_diameter/2, h=stone_pavillion_depth, center=false, $fa=360/8);//pavillion (bottom) first cut
		}
		difference(){
			translate (v=[0,0,0.1-(stone_pavillion_depth/2+stone_girdle_depth/2)]) cylinder (r=(stone_girdle_diameter/cos(22.5))/2, h=stone_pavillion_depth/2 + stone_girdle_depth + stone_crown_depth +a_bit, center=false, $fa=360/16);
			union(){//this gives the rough main shape (from v0.1)
				translate (v=[0,0,stone_girdle_depth/2]) cylinder (r1=(stone_girdle_diameter*cos(22.5))/2, r2=((stone_girdle_diameter+stone_table_diameter)*cos(11.25)/4)*(cos(11.25) + (sin(11.25) * tan(11.25))), h=stone_crown_depth/2, center=false,  $fa=360/16);//crown (top) second cut (+16 faces)
				translate (v=[0,0,stone_girdle_depth/2+stone_crown_depth/2]) rotate(a=360/8, v=[0,0,1]) cylinder (r1=(stone_girdle_diameter+stone_table_diameter)/cos(22.5)/4, r2=(stone_table_diameter*cos(22.5)/2), h=stone_crown_depth/2, center=false,  $fa=360/8);//crown (top) third cut (+8 faces)
				translate (v=[0,0,0]) cylinder (r=stone_girdle_diameter*cos(22.5)/2, h=stone_girdle_depth+0.1, center=true, $fa=360/16); //girdle (middle)
				rotate(a=180, v=[1,0,0]) translate (v=[0,0,stone_girdle_depth/2]) cylinder (r1=(stone_girdle_diameter*cos(22.5))/2, r2=((stone_girdle_diameter+stone_cutlet_diameter)*cos(11.25)/4)*(cos(11.25) + (sin(11.25) * tan(11.25))), h=stone_pavillion_depth/2, center=false, $fa=360/16);//pavillion (bottom) second cut (+16 faces)
			}
		}
	}
}

module bowtie(bowtie_angle, bowtie_length, bowtie_depth){
	union()for (i=[90,270]){
		rotate(a=[0,0,i])	linear_extrude(height = bowtie_depth, center = true, convexity = 10){
			polygon(points=[[0,0], [0.5*bowtie_length*sin(bowtie_angle/2),bowtie_length/2], [-0.5*bowtie_length*sin(bowtie_angle/2),bowtie_length/2]], paths=[[0,1,2]]);
		}
	}
}

//************Ring_Cross_Setion_Modules**************

module pill_shape (pill_l, pill_b){
	translate(v=[pill_b/2,0,0]){
		translate (v=[0,-(pill_l-pill_b)/2,0]) circle (r=pill_b/2, center=true);
		square (size=[pill_b, pill_l-pill_b], center=true);
		translate (v=[0,(pill_l-pill_b)/2,0]) circle(r=pill_b/2, center=true);
	}
}

module ellipse_shape (ellipse_x, ellipse_y){
	translate(v=[ellipse_y/2,0,0]) scale(v=[ellipse_y,ellipse_x]) circle(r=0.5,$fn=50, center=true);
}
module hemi_ellipse_shape(hemi_ellipse_x,hemi_ellipse_y){
	scale(v=[2*hemi_ellipse_y,hemi_ellipse_x]) difference () { 
		circle(r=0.5,$fn=20, center=true);
		translate (v=[-1.5,0,0]) square (size=3, center=true);
	}
}
module rectangle_shape (rectangle_x, rectangle_y){
	translate(v=[rectangle_y/2,0,0]) square(size=[rectangle_y, rectangle_x], center=true);
}

module scallopped_rectangle_shape (scallopped_rectangle_y, scallopped_rectangle_x, scallopped_rectangle_z){
	difference (){
		rectangle_shape (scallopped_rectangle_y, scallopped_rectangle_x);
		translate(v=[scallopped_rectangle_x,0,0]) rotate(a=[0,0,180]) hemi_ellipse_shape(scallopped_rectangle_y,scallopped_rectangle_z);
	}
}

module rounded_scallopped_rectangle_shape (rounded_scallopped_rectangle_y, rounded_scallopped_rectangle_x, rounded_scallopped_rectangle_z){
	minkowski(){
		translate(v=[rounded_scallopped_rectangle_z,0,0]) difference (){
			rectangle_shape (rounded_scallopped_rectangle_y-2*rounded_scallopped_rectangle_z, rounded_scallopped_rectangle_x-2*rounded_scallopped_rectangle_z);
			translate(v=[rounded_scallopped_rectangle_x-2*rounded_scallopped_rectangle_z,0,0]) rotate(a=[0,0,180]) hemi_ellipse_shape(rounded_scallopped_rectangle_y-2*rounded_scallopped_rectangle_z,rounded_scallopped_rectangle_z);
		}
	circle(r=rounded_scallopped_rectangle_z, $fn=20);
	}
}

module rounded_hemi_ellipse_shape(rounded_ellipse_x, rounded_ellipse_y, rounded_ellipse_z){
	translate(v=[rounded_ellipse_z,0,0]){
		minkowski(){
			hemi_ellipse_shape(rounded_ellipse_x-2*rounded_ellipse_z,rounded_ellipse_y-2*rounded_ellipse_z);
			circle(r=rounded_ellipse_z, $fn=20);
		}
	}
}

module rounded_rectangle_shape(rounded_rectangle_y, rounded_rectangle_x, rounded_rectangle_z){
	translate(v=[rounded_rectangle_x/2,rounded_rectangle_z,0]){
		minkowski(){
			square(size=[rounded_rectangle_x-2*rounded_rectangle_z,rounded_rectangle_y-2*rounded_rectangle_z], center=true);
			circle(r=rounded_rectangle_z, $fn=20);
		}
	}
}

module chamfered_rectangle_shape(chamfered_rectangle_y, chamfered_rectangle_x, chamfered_rectangle_z){
	translate(v=[chamfered_rectangle_x/2,-sin(45)*chamfered_rectangle_z,0]){
		minkowski(){
			square(size=[chamfered_rectangle_x-2*sin(45)*chamfered_rectangle_z,chamfered_rectangle_y-2*sin(45)*chamfered_rectangle_z],center=true);
			rotate (a=[0,0,45]) square (size=chamfered_rectangle_z);
		}
	}
}

module trumpet(trumpet_depth, trumpet_flange, trumpet_diameter_big, trumpet_diameter_small){
translate (v=[0,0,trumpet_depth/2]) rotate(a=[0,180,0]) difference(){
		cylinder(h=trumpet_depth,r=trumpet_diameter_big, center=false);
		rotate_extrude (convexity = 10) translate ([trumpet_diameter_big, 0, 0]) ellipse ((trumpet_diameter_big-trumpet_diameter_small),(trumpet_depth-trumpet_flange));
	}
}

module ellipse(r1,r2){
	scale(v=[r1,r2]){
		circle(r=1);
	}
}

module half_pill_shape (pill_l, pill_b){
	translate(v=[-pill_b,0,0]) difference (){
		pill_shape(pill_l,2*pill_b);
		square (size=[2*pill_b,pill_l], center=true);
	}
}

//****************************engraving modules*********
module cylindrical_engraving(cylinder_radius, cylinder_height, font_height, font_width, font_spacing, engraving_depth, pi, text_direction){ 
//	rotate(a=[90,0,0]) translate(v=[0,0,text_direction*cylinder_radius]){
//		scale(v=[font_width,font_height,1])polygon_jp_katakana_ga(engraving_depth);
//	}
//	rotate(a=[90,0,text_direction*180/pi*((font_width+font_spacing)/cylinder_radius)]) translate(v=[0,0,text_direction*cylinder_radius]){
//		scale(v=[font_width,font_height,1]) polygon_jp_katakana_u(engraving_depth);
//	}
//	rotate(a=[90,0,3*text_direction*180/pi*((font_width+font_spacing)/cylinder_radius)]) translate(v=[0,0,text_direction*cylinder_radius]){
//		scale(v=[font_width,font_height,1])polygon_jp_katakana_ga(engraving_depth);
//	}
//	rotate(a=[90,0,4*text_direction*180/pi*((font_width+font_spacing)/cylinder_radius)]) translate(v=[0,0,text_direction*cylinder_radius]){
//		scale(v=[font_width,font_height,1]) polygon_jp_katakana_u(engraving_depth);
//	}
}

module polygon_jp_katakana_ga(extrude_height){
linear_extrude(height=2*extrude_height, center=true) scale(v=[1/18,1/18,0]) translate(v=[-9,-9,0]) polygon(points = [[0,0],[2,11],[-1,11],[0,13],[2,13],[2,15],[5,15],[4,13],[12,13],[13,12],[13,11],[11,0],[9,0],[11,11],[4,11],[2,0],[14,18],[12,18],[13,15],[15,18],[16,15],[17,18]] 
,paths = [
[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],[16,17,18],[19,20,21]]
);

}

module polygon_jp_katakana_u(extrude_height){
linear_extrude(height=2*extrude_height, center=true) scale(v=[1/15,1/17,0]) translate(v=[-7.5,-8.5,0]) polygon(points = [[0,11],[0,14],[6,14],[5,17],[8,17],[8,14],[14,14],[14,10],[13,6],[10,2],[5,0],[5,1],[9,4],[11,7],[12,11],[12,12],[2,12],[2,9],[-1,9],[0,10]] 
,paths = [
[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]]
);
}