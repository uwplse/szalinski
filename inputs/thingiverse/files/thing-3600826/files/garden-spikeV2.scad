/*Main parameters*/

//height of plant spike (mm)
height = 1.6; 
//length of plant spike (mm)
length = 120; 
//width of plant spike (mm)
width = 20; 

//main text for tag
tag_text="Plant name here";

//ratio of text stretching in proportion to width
text_stretch_ratio = .5; 



//ratio of text-tag to spike distribution for length
tag_ratio = 0.5; 

//ratio of spike size in proportion to width
spike_tip_ratio = .2; 

//ratio of text height in proportion to height
text_height_ratio = 1.5; 

//ratio of the space between the beginning and end of the spike gap in proportion to spike length
tine_gap_ratio = .8; 

//ratio of the space between 
tine_width_ratio = .2; 






//size of the space between the spikes
tine_width = width * tine_width_ratio;


//length of the tag portion
tag_size = tag_ratio * length;

//length of the spike
spike_length = length - tag_size;

//height of the text on the tag
tag_text_height = text_height_ratio * height;
tag_text_length = tag_size;

text_stretch = width * text_stretch_ratio;

//circle ratio
tag_circle_radius = width * .5;

spike_radius = tag_circle_radius * spike_tip_ratio;

/*
Font size is estimated by phrase length

Note: Text begins to look wonky at <5 letters.
*/

font_size = (1.5 * tag_text_length)/len(tag_text);



difference()
{
    //tag body + spikes
    union()
    {
        //name extrusion
        linear_extrude(tag_text_height)
        {
            resize([0,text_stretch,0])
            translate([tag_text_length/2 + tag_circle_radius/3,0,0])
            text(tag_text,font_size,"Calibri:style=Bold",halign="center",valign = "center");
        }
        
        //tag construction
        linear_extrude(height)
        {
            //bottom circle
            circle(tag_circle_radius,true);
            
            //top circle
            translate([tag_text_length,0,0])
            circle(tag_circle_radius,true);
            
            //main tag body
            translate([tag_text_length/2,0,0])
            square([tag_text_length,width],true);
        }
        
        
        
        //spike construction
        linear_extrude(height)
        {
            //prong 1
            hull()
            {
              //bottom circle clone for hull
              circle(tag_circle_radius,true);
                
              //spike tip 1
              translate([-spike_length,tine_width,0])
              circle(spike_radius,true);
            }
           
           //prong 2
            hull()
            {
              //bottom circle clone for hull
              circle(tag_circle_radius,true);
                
              //spike tip 1
              translate([-spike_length,-tine_width,0])
              circle(spike_radius,true);
            } 
            
          
        }
    }
    
    union()
    {
        //distance between the x axis and a spike
        spike_axis_difference = tine_width - spike_radius;
        gap_length = spike_length * tine_gap_ratio;
        //spike middle cut
        translate([-spike_length + gap_length/2,0,0])
        cube([gap_length,(spike_axis_difference * 2),height*4],true);
        
        translate([0,0,-height*2])
        linear_extrude(height*4)
        {
            translate([-spike_length + gap_length,0,0])
            circle(spike_axis_difference,$fn = 50,true);
        }
        
        
    }
}