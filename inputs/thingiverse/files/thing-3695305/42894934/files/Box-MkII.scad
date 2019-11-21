//-------------------------------------
// Title:             Box MkII
// Version:        1.0.0
// Date:            2019-05-23
// Designer:      Steve Cooper
//-------------------------------------
//
// Tolerance will need to be amended depending on how accurate the printer is and also how tight a fit is required.  Default values work quite well for my setup.

/* [Box Structure] */
// Which one would you like to see?
part = "insert"; // [box:Box Only,lid:Lid Only,insert:Insert only,boxandlid:Box and Lid,All:All 3]
//width of whole main box
x = 200;
//depth of whole main box
y = 150;
//height of whole main box
z = 60;
//thickness of outside edge (needs to be thick enough for lip)
edge = 2;
lipw = edge/2;

/* [Lid Details] */
//height of lip
liph = 10;
//Additional internal height above lip
lidaddheight = 0;
//tolerance of the lip join - this is tolerance on each edge
tol = 0.4;
piecetol = tol /2;  //Apply equal tolerance to lid and box

/* [Compartments] */
//Number of x compartments
comp_x = 2;
//Number of y compartments
comp_y = 2;
//Percentage Height of compartments
comp_perc = 40; //[1:1:100]
//Width of compartment borders
comp_border=1.2;

/* [Insert] */
//Number of x compartments in insert
insert_comp_x = 2;
//Number of y compartments in insert
insert_comp_y = 2;
//Percentage Height of insert compared to base
insert_perc = 30; //[1:1:100]
//Width of insert borders
insert_border=1.2;
//Width of insert dividers
insert_divider=1.2;
//clearance for insert - this is tolerance on each edge
insert_tolerance=0.8;


/* [Hidden] */
//used to give clean rendering
epsilon = 0.01;
//Adjust box to get true whole box dimensions
boxz = z - (edge+lidaddheight);
//Internal x and y dimensions for compartments
intx = x-2*edge;
intstepx = intx / comp_x;
inty = y-2*edge;
intstepy = inty /comp_y;
intz = (boxz-edge)*(comp_perc/100);
//Internals for insert
insertx= intx-2*insert_tolerance;
insertstepx = (insertx-2*insert_border)/insert_comp_x;
inserty= inty-2*insert_tolerance;
insertstepy = (inserty-2*insert_border)/insert_comp_y;
insertz=(boxz-edge)*(insert_perc/100);


module box(){
difference() 
    {
        union()
        {   
            translate(v=[0,0,0]) 
                {
                    cube(size=[x,y,boxz-liph], center=false);
                }
            translate(v=[lipw+piecetol,lipw+piecetol,0]) 
                {
                    cube(size=[x-(2*(lipw+piecetol)),y-(2*(lipw+piecetol)),boxz], center=false);
                }
        }
        translate(v=[edge,edge,edge]) 
            {
                cube(size=[x-(edge*2),y-(edge*2),boxz-edge+epsilon], center=false);
            }
    }
    
    if (comp_x>1){
        for (i=[1:comp_x-1]){
            translate([(intstepx*i)+edge-comp_border/2,edge,edge])
            cube(size=[comp_border,inty,intz]);
        }
        }
    if (comp_y>1){        
        for (i=[1:comp_y-1]){
            translate([edge,(intstepy*i)+edge-comp_border/2,edge])
            cube(size=[intx,comp_border,intz]);
        }
        }        

    
}

module lid(){
difference()
    {
        //main lid
        translate(v=[0,0,0]) 
                {
                    cube(size=[x,y,liph+edge+lidaddheight], center=false);
                }
       //additional height cutout
       translate(v=[edge,edge,edge]) 
            {
                cube(size=[x-(2*edge),y-(2*edge),lidaddheight+epsilon], center=false);
            }                
         //lip cutout   
         translate(v=[edge-lipw-piecetol,edge-lipw-piecetol,edge+lidaddheight]) 
            {
                cube(size=[x-2*(lipw-piecetol),y-2*(lipw-piecetol),liph+epsilon], center=false);
            }
        }
    }
    
    
module insert(){
difference() 
    {
            translate(v=[0,0,0]) 
                {
                    cube(size=[insertx,inserty,insertz], center=false);
                }
        translate(v=[insert_border,insert_border,insert_border]) 
            {
                cube(size=[insertx-(insert_border*2),inserty-(insert_border*2),insertz-insert_border+epsilon], center=false);
            }
    }
    
    if (insert_comp_x>1){
        for (i=[1:insert_comp_x-1]){
            translate([(insertstepx*i)+insert_border-insert_divider/2,insert_border,0])
            cube(size=[insert_divider,inserty-2*insert_border,insertz]);
        }
        }
    if (insert_comp_y>1){        
        for (i=[1:insert_comp_y-1]){
            translate([insert_border,(insertstepy*i)+insert_border-insert_divider/2,0])
            cube(size=[insertx-2*insert_border,insert_divider,insertz]);
        }
        }     
    
}    

module print_part() {
	if (part == "box") {
		box();
	} else if (part == "lid") {
		lid();
	} else if (part == "insert") {
		insert();
    } else if (part == "boxandlid") {
		box();
        translate([0,-y-5,0]) lid();
	} else {  //all
		box();
        translate([0,-y-5,0]) lid();
        translate([x+5,0,0]) insert();
	}
}

print_part();
