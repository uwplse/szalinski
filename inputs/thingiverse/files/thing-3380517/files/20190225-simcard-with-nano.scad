// Sim card Holder
// Official sizes....
// full_size=85 x 54 x 0,76 mm
// Mini = 25 x 15 x 0,76 mm
// Micro = 15 x 12 x 0,76 mm
// Nano = 12,3 x 8,8 x 0,67 mm

/*****************
    User config
*****************/

units=12; // How many slots for cards? 
rows=4; // How many Rows you want....
nano=true; // Add nanon slots?

/*****************
    End 
*****************/

border_sim=0.5;
border=2;
holder_ground=4;
nano_width=12.3;
nano_length=8.8;
sim_width=15;
sim_length=12;
sim_height=1;
slotsPerRow=ceil(units/rows); 
echo ("Slots:" ,slotsPerRow);
holder_width=slotsPerRow*(sim_width+border_sim+border)+border;
holder_length=rows*(sim_length+border_sim+border)+border;
units_x=ceil(holder_width/sim_width)-1;
units_y=ceil(holder_length/sim_length)-1;

module sim()
{
    cube([sim_width+border_sim,sim_length+border_sim,sim_height]);
    if(nano)
    {
        translate([1,1,-1])
        cube([nano_width+border_sim,nano_length+border_sim,1]);
    }
}

module sim_with_text(mytext)
{
    sim();
    translate([2,2,0-holder_ground+2])
    {
        linear_extrude(height=6)
        {
            #text(mytext,size=6);
        }
    }
}

difference()
{
    cube([holder_width,holder_length,holder_ground]);
    // Loop through each row
    for(r=[0:rows-1])
    {
        for(a=[1:slotsPerRow])
        {
            coord_x=(a-1)*(sim_width+border)+border;
            translate([coord_x,r*(sim_length+border)+border,holder_ground-sim_height])
        
           sim_with_text(str(a+(r*slotsPerRow)));       
        }
    }
}
