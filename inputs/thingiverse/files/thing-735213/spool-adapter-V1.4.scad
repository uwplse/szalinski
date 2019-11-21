// 'Customizable Spool Adapter' by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// Version 1.3.1 (c) November 2015
// please refer the complete license here: http://creativecommons.org/licenses/by-sa/3.0/legalcode
//
// V1.4: inner hole fix (see http://www.thingiverse.com/thing:1151473)
// V1.3.1: Bug fixed for latest customizer
// V1.3: Customizer creation failure fixed. Some smaller issues fixed. More slider used. New license cc-by-sa!
// V1.2: part handling optimized
// V1.1a: UI optimized
// V1.1: new star shape

// preview[view:south, tilt:top diagonal]

//to show. This setting is only relevant for preview.
part="right"; //[right:Right,left:Left,straight:Straight,star_right:Star Right,star_left:Star Left]

//depended on the inner and outer diameter, you may also need to change the "Arms" settings to get a perfect working adapter. 
tube_diameter=32; //[0:0.5:75]
spool_diameter=53; //[0:1:150]
height=15; //[0:100]
number_of_arms=5; //[3:10]
function get_number_of_arms() = (part == "straight" && number_of_arms % 2 > 0 ? 1 : 0) + number_of_arms;

/*[Advanced]*/

inner_diameter_backlash=1.0; //[0:0.1:5]
collar_thickness=2.0; //[0:0.5:10]
chamfer_depth=2.0; //[0:0.5:20]
wall=3.0; //[0:0.1:10]

/*[Arms]*/

//I used 2mm on 32/53 Adapter with 6 arms and 2.4mm with 5 arms. It depends on the length.
arm_thickness=2.4; //[0:0.1:5]
//in mm. The adapter should fit tight to the spool, so the outer diameter is enlarged by this value.
arm_compression=1.0; //[0:0.1:5]
// in mm
arm_end_diameter=5.0; //[0:0.5:20]

/*[Expert]*/
quality=80; //[60:Normal,80:Good,100:High]

function get_part_index() = search([part], ["right","left","straight","star_right","star_left"])[0];

/*[Hidden]*/


inner_diameter=tube_diameter+inner_diameter_backlash;
outer_diameter=spool_diameter+arm_compression;

outer_shape=[

    [outer_diameter/2+arm_end_diameter+.1,collar_thickness],
    [outer_diameter/2,collar_thickness],
    [outer_diameter/2,height-chamfer_depth],
    [spool_diameter/2-.5,height+0.01],
    [outer_diameter/2+arm_end_diameter+.1,height+0.01],
];

number=part == "straight"?get_number_of_arms()/2:get_number_of_arms();

arm_degree=360/get_number_of_arms();
degree=360/number;

difference()
{   
    linear_extrude(convexity=20,height=height)
    union()
    {
        if(get_part_index()>2)
        for(a=[0:degree:359])
        hull()
        {
            circle(r=inner_diameter/2+wall,$fn=quality);
            
            rotate([0,0,a])
            translate([cos_arm,0,0])
            circle(r=arm_thickness/2,$fn=arm_thickness*7);
        }
        else
        hull()
        {
            circle(r=inner_diameter/2+wall,$fn=quality);
            
            for(a=[0:degree:359])
            rotate([0,0,a])
            translate([cos_arm,0,0])
            circle(r=arm_thickness/2,$fn=arm_thickness*7);
        }
        
        for(a=[0:degree:359])
        rotate([0,0,a])
        for(i=[0:len(arm_paths[get_part_index()])-2])
        hull()
        for(j=[i:i+1])
        translate(arm_paths[get_part_index()][j])
        circle(r=arm_thickness/2,$fn=arm_thickness*7);
        
        for(a=[0:360/get_number_of_arms():359])
        rotate([0,0,a])
        translate([cos_arm,sin_arm])
        circle(r=arm_end_diameter/2,$fn=arm_end_diameter*7);       
    }
    
    translate([0,0,-1])
    cylinder(r=inner_diameter/2, h=height+2, $fn=quality);

    rotate_extrude(convexity=20,$fn=quality)
    polygon(outer_shape);
}

sin_arm=sin(arm_degree/2)*outer_diameter/2;
cos_arm=cos(arm_degree/2)*outer_diameter/2;
arm_paths=[
    // right
    [
        [cos_arm,0],
        [cos_arm,sin_arm],
    ],
    // left
    [
        [cos_arm,0],
        [cos_arm,-sin_arm],
    ],
    // straight
    [
        [cos_arm,sin_arm],
        [cos_arm,-sin_arm],
    ],
    // right star
    [
        [cos_arm,0],
        [cos_arm,sin_arm],
    ],
    // left star
    [
        [cos_arm,0],
        [cos_arm,-sin_arm],
    ],
];


