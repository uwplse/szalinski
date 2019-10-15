//CUSTOMIZER VARIABLES

// attachment rod diameter, in mm
rod_diameter= 7.7;  // [2:0.1:20]

// attachment rod covered length in clip, in mm
rod_length= 5.5;  // [2:0.1:40]

// attachment rod height off table, in mm
rod_height= 14.2;  // [2:0.1:40]

// attachment rod space on either side, in mm
rod_side_margin= 2.0;  // [1:1:20]

// attachment rod extra length, in mm
rod_length_margin= 2.0;  // [1:1:20]

// beam clip height margin, in mm
clip_margin= 2;   // [1:20]

// Openbeam bolt diameter, in mm
bolt_diameter= 3.0;    // [2:0.1:20]

// Openbeam size, in mm
openrail_size= 15;   // [10:50]

//CUSTOMIZER VARIABLES END


// Sanity checks
if( rod_diameter <= 0
   || bolt_diameter <= 0 
   || openrail_size <= 0 )
{
    echo("<B>Error: Missing important parameters</B>");
}


main_depth= max( rod_diameter,bolt_diameter ) + 2*rod_side_margin;
main_height= max( openrail_size+clip_margin, rod_height+rod_side_margin );

// our object, translated and rotated to be flat on xy plane for easy STL generation
translate([0,0,main_height-openrail_size/2])
  rotate ([90,0,0])
    alignment_clip();

module alignment_clip(){

    main_width= openrail_size+rod_length_margin+rod_length;
    bolt_rad= (bolt_diameter+1)/2;
    rod_rad= (rod_diameter+0.2)/2;

    difference(){

      // the main block
      translate([(main_width-openrail_size)/2,-(main_height/2)+(openrail_size/2),0])
        cube([main_width,main_height,main_depth],center = true);

      // subtract the space used by the openbeam
      translate([-openrail_size/2-1,-openrail_size/2,-(main_depth/2)-2])
        cube([openrail_size+1, openrail_size+1, main_depth+5]);

      // bolt hole for attaching to beam
      translate([0,-3,0])
        rotate([90,0,0])
          cylinder(main_height+2,bolt_rad,bolt_rad);

      // rod hole/slot
      translate([main_width-rod_length-openrail_size/2,-rod_height+rod_rad+openrail_size/2,0])
        rotate([0,90,0])
          cylinder(rod_length+2,rod_rad,rod_rad);
      translate([main_width-rod_length-openrail_size/2,-rod_height+rod_rad+openrail_size/2,-rod_rad])
        cube([rod_length+2,rod_height-rod_rad+2,2*rod_rad]);
       
    }
}
