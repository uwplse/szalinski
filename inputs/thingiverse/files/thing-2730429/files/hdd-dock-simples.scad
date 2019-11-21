//hard drive dimensions
hddx=102;
hddy=26;

wall_thickness=2;
height=20; //height of walls

number_of_drives = 5;
gap = 10; //gap between drives
gap_brace_height = 10; //height of walls either side of the gaps
endcap=1; //put supports on to stop the drive falling through



hddBay(number_of_drives-1); //do the thing



//the thing:
module hddBay(number)
{
    linear_extrude(height)
    difference()
    {
        //box wot drive fits into
        square([hddx+wall_thickness*2,hddy+wall_thickness*2],center=true);
        square([hddx,hddy],center=true);
        
    }
    
    //flats between the drives
    if(number) translate([0,gap/2+(hddy/2),0]) linear_extrude(1)
        square([hddx,gap-wall_thickness*2],center=true);
    //walls either side of the gaps
    if(number) translate([hddx/2+wall_thickness/2,gap/2+(hddy/2),0]) linear_extrude(gap_brace_height)
        square([wall_thickness,gap-wall_thickness*2],center=true);
    // ^
    if(number) translate([-hddx/2-wall_thickness/2,gap/2+(hddy/2),0]) linear_extrude(gap_brace_height)
        square([wall_thickness,gap-wall_thickness*2],center=true);
    
    //end cap bits to stop the drives falling through
    if(endcap) translate([hddx/2-2,0,0]) linear_extrude(1) square([4,hddy],center=true);
    if(endcap) translate([-hddx/2+2,0,0]) linear_extrude(1) square([4,hddy],center=true);
    
    //because if this wasn't confusing enough, here's some recursion!    
    if(number) translate([0,hddy+gap,0])hddBay(number-1); 
}

