//how many squares on X axis
grid_x = 4;
//how many squares on Y axis
grid_y = 2;
//space between squares (0 for no gap)
linewidth = 1.5; 
//size of each square, don't mess with this if you want it to mesh with OpenForge
gridsize = 25;
gridheight = 2;
//how steep on X
incline_x = 0; 
//how steep on Y
incline_y = 0; 
//random height, for no random use 0 for both
random_min = 0;
random_max = 0;
//minimum height
height = 1;
base_thickness = 7.5;
base_height = 6;
//diameter of magnet hole in mm
magnet_size = 5.6; 
//change between 0 and 1, only matters with incline
gap_style = 1;
//1 to save plastic, 0 no plastic saver
plastic_saver = 0;
//works only with plastic_saver = 1 and generally only with incline, larger the #, smaller bridging, more plastic used.
plastic_saver_thickness = 1;

///////code////////


module terrain ()
{
for (i = [1:1:grid_x])
{
for (U = [1:1:grid_y])
{
single_rand = rands(random_min,random_max,1)[0];
echo(single_rand);
translate([i*(gridsize)-gridsize+0.5*linewidth,U*(gridsize)-gridsize+0.5*linewidth,0])cube([gridsize-linewidth,gridsize-linewidth,height+gridheight+single_rand+incline_x*i+incline_y*U-incline_x-incline_y]);
if (gap_style == 0)
{
    cube([grid_x*(gridsize),grid_y*(gridsize),height]);
}
else
{
    translate([i*(gridsize)-gridsize,U*(gridsize)-gridsize,0])cube([gridsize,gridsize,height+incline_x*i+incline_y*U-incline_x-incline_y+single_rand]);
}
}
}

}

module base ()
{
    difference()
    {
         cube([grid_x*(gridsize),grid_y*(gridsize),base_height]);
        translate([(grid_x*(gridsize))/2,(grid_y*(gridsize))/2,base_height/2])
        {
            cube([grid_x*(gridsize)-base_thickness*2,grid_y*(gridsize)-base_thickness*2,base_height+0.01],center=true);
        }
            for (p = [1:1:grid_y])
    {
    translate([base_thickness/2,p*(gridsize)-gridsize/2,base_height/2+1])
    {
        magnet_hole();
    }
    translate([-1*base_thickness/2+grid_x*gridsize,p*(gridsize)-gridsize/2,base_height/2+1])
    {
        magnet_hole();
    }
        for (p = [1:1:grid_x])
            {
     translate([(p*gridsize)-gridsize/2,base_thickness/2,base_height/2+1])
    {
        magnet_hole();
    }
    translate([p*(gridsize)-gridsize/2,grid_y*(gridsize)-base_thickness/2,base_height/2+1])
    {
        magnet_hole();
    }
    }
}
    }
    
}

module magnet_hole ()
{
    cylinder($fn=40,r=magnet_size/2,h=base_height+0.01,center=true);
    cylinder($fn=40,r=1,h=base_height+4,center=true);
}
if (plastic_saver == 1)
{
    difference()
    {
    terrain ();
            
        {
            for (i = [1:1:grid_x])
            {
            for (U = [1:1:grid_y])
            {
            translate([i*(gridsize)-gridsize+0.5*linewidth+plastic_saver_thickness/2,U*(gridsize)-gridsize+0.5*linewidth+plastic_saver_thickness/2,-.01])cube([gridsize-linewidth-plastic_saver_thickness,gridsize-linewidth-plastic_saver_thickness,gridheight+incline_x*i+incline_y*U-incline_x-incline_y-plastic_saver_thickness-0.5]);
            }
            }
        }
    }
   for (i = [1:1:grid_x])
   {
   for (U = [1:1:grid_y])
   {
       difference()
       {
        cube([grid_x*(gridsize),grid_y*(gridsize),height]);
           translate([base_thickness,base_thickness,-0.01])cube([grid_x*(gridsize)-base_thickness*2,grid_y*(gridsize)-base_thickness*2,base_height+0.01]);
       }
   }
   } 
}
else
{
    terrain();
}
translate([0,grid_y*gridsize+10,0])
{
base();
}
