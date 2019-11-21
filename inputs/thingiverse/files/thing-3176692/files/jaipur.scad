//Jaipur - parametric game box (http://www.thingiverse.com/thing:3176692) by Fupuf is licensed under the Creative Commons - Attribution - Non-Commercial license.
//http://creativecommons.org/licenses/by-nc/3.0/


//Total number of tokens in the game, round up to 10
num_tokens = 60;
//Extra margin for cards (in millimeters)
card_and_token_extra_margin = 1;
extra_margin = card_and_token_extra_margin;

//Thickness of all walls (in millimeters) 
box_wall_thickness =    1.5;
rail_thickness = box_wall_thickness/2;

//Thickness of a single token (in millimeters) 
token_thickness = 1.1;
//Diameter of a single token (in millimeters) 
token_diameter_ = 22.75;
//Number of slots for tokens next to card deck
num_token_pouches = 3;

token_diameter = token_diameter_+ extra_margin;
token_height = (token_thickness * num_tokens + extra_margin) /num_token_pouches;

//Width of cards (in millimeters) 
card_width_ = 57.5;
//Heights of cards (in millimeters) 
card_height_ =  80.0;
//Thickness of entire deck of cards (in millimeters) 
card_stack_thickness = 18.0;

card_width = card_width_+ extra_margin;
card_height = card_height_+ extra_margin;
card_stack_height = card_stack_thickness+ extra_margin*3;

//Extra margin around cards and tokens


box_width = 3*box_wall_thickness + card_width + token_height;
box_height = 2*box_wall_thickness +max(card_height, token_diameter*num_token_pouches+box_wall_thickness*(num_token_pouches-1));
box_depth = box_wall_thickness + max(card_stack_height, token_diameter);

//Generate insert
union(){
insert();
    //Generate handle
    handle_width=box_height/2;
    handle_height=20;
    handle_depth=10;
    translate([-handle_depth/2,box_height/2,handle_height])
    difference(){
    hull(){
    cube([handle_depth,handle_width,1], center=true);
    translate([handle_depth/2,0,-handle_depth])
    cube([1,handle_width,1], center=true);
    }
    cube([handle_depth*0.5,handle_width*0.8,handle_depth*2], center=true);
    }
}


//Generate box
translate([6*box_depth,0,0])
rotate([0,-90,0])
{
    difference(){
    cube([box_width+box_wall_thickness, box_height+2*box_wall_thickness+1,box_depth+2*box_wall_thickness+1]);

    translate([box_wall_thickness,box_wall_thickness+1/4,box_wall_thickness])
    box(box_width, box_height+0.3, box_depth+0.3, rail_thickness);
    translate([box_width/4,box_height/2,box_depth+2*box_wall_thickness])
    linear_extrude(height=1) 
    text("Jaipur", font = "Arial:style=Bold Italic");
       translate([0.5,box_height*0.75,box_depth*0.4])
    rotate([90,0,-90])
    linear_extrude(height=1) 
    text("Jaipur", font = "Arial:style=Bold Italic", center=true);
    }
}

module box(box_width, box_height, box_depth, rail_thickness) {
    union(){
        cube([box_width, box_height,box_depth]);
            
            translate([0,-rail_thickness,box_depth*0.8])
            hull(){
            cube([box_width, box_height+2*rail_thickness,2]);
            translate([0,2*rail_thickness,-2*rail_thickness])
            cube([box_width, box_height-2*rail_thickness,2]);
            }
            }
}

module insert(){
        
    difference() {
        //Box
        box(box_width, box_height, box_depth, rail_thickness);
        //Card insert
        translate([box_wall_thickness,
                   (box_height-card_height)/2,
                   box_depth -card_stack_height ]){
        cube([card_width, card_height, box_height]);
        }
        //Card finger helper
        card_finger_width = card_width/2;
        translate([box_wall_thickness + (card_width-card_finger_width)/2,
                   -box_wall_thickness,
                   box_depth -card_stack_height-2*extra_margin]){
        cube([card_width/2, card_height*2, box_height]);
      }
        //Token insert
        center_offset = 0.5*token_diameter + (box_height - (token_diameter+box_wall_thickness)*num_token_pouches)/2 + box_wall_thickness/2;
        for(offset = [1:num_token_pouches]){
           translate([2*box_wall_thickness + card_width, 
           center_offset + (token_diameter+box_wall_thickness)*(offset-1),
           box_depth - token_diameter - 1.5*extra_margin]){
     
            translate([token_height/2,0,box_depth-token_diameter/2])
            rotate([-90,0,90])
            {
            hull(){
                cylinder (h=token_height, d=token_diameter, center=true, $fn=100);
                translate([0,-20,0])
                cylinder (h=token_height, d=token_diameter, center=true, $fn=100);
                           //[card_width, card_height, box_height]);
            }
            //Token finger helper
            token_finger_width = token_diameter*0.7;
            translate([0,(token_diameter-token_finger_width)/2,0])
            hull(){ 
                cylinder (h=token_height+card_width/2+box_wall_thickness, d=token_finger_width*1.05, center=true, $fn=100);
                translate([0,-20,0])
                cylinder (h=token_height+10+box_wall_thickness, d=token_finger_width, center=true, $fn=100);
                           //[card_width, card_height, box_height]);
            }
            
            }
            
            }
            
            
            
        }
        
    }

}
