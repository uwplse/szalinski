/***********************************************************************
Name ......... : spaceInvaders.scad
Description....: Space Invaders
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/10/15
Licence ...... : GPL
***********************************************************************/

//Dimensions for Space Invaders
//Pixel Size- size of each square
pixelSize = 10;
//Pixel Height- height of each square
pixelHeight = 10;


invaderSelect = 4; //[1:Invader 01, 2:Invader 02, 3:Invader 03, 4: Space Ship, 5: Gun Ship ]

//Matricies to setup the different space invaders
invader01 = [[0,0,1,1,0,0,0,1,1,0,0],
             [0,0,0,1,0,0,0,1,0,0,0],
             [0,0,1,1,1,1,1,1,1,0,0],
             [0,1,1,0,1,1,1,0,1,1,0],
             [1,1,1,1,1,1,1,1,1,1,1],
             [1,0,1,1,1,1,1,1,1,0,1],
             [1,0,1,0,0,0,0,0,1,0,1],
             [0,0,1,1,1,0,1,1,1,0,0]];

invader02 = [[0,0,0,0,0,1,1,0,0,0,0],
             [0,0,0,0,1,1,1,1,0,0,0],
             [0,0,0,1,1,1,1,1,1,0,0],
             [0,0,1,1,0,1,1,0,1,1,0],
             [0,0,1,1,1,1,1,1,1,1,0],
             [0,0,0,0,1,0,0,1,0,0,0],
             [0,0,0,1,1,1,1,1,1,0,0],
             [0,0,1,1,1,0,0,1,1,1,0]];
             
invader03 = [[0,0,0,0,0,1,1,1,1,0,0,0,0,0],
             [0,0,1,1,1,1,1,1,1,1,1,1,0,0],
             [0,1,1,1,1,1,1,1,1,1,1,1,1,0],
             [0,1,1,1,0,0,1,1,0,0,1,1,1,0],
             [0,1,1,1,1,1,1,1,1,1,1,1,1,0],
             [0,0,0,1,1,1,1,1,1,1,1,0,0,0],
             [0,0,1,1,0,0,1,1,0,0,1,1,0,0],
             [0,0,0,1,1,0,0,0,0,1,1,0,0,0]];
             
invader04 = [[0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0],
             [0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0],
             [0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0],
             [0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0],
             [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
             [0,0,1,1,1,0,0,1,1,0,0,1,1,1,0,0],
             [0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0]];
             
invader05 = [[0,0,0,0,0,0,1,0,0,0,0,0,0],
             [0,0,0,0,0,1,1,1,0,0,0,0,0],
             [0,0,0,0,0,1,1,1,0,0,0,0,0],
             [0,0,0,0,0,1,1,1,0,0,0,0,0],
             [0,1,1,1,1,1,1,1,1,1,1,1,0],
             [1,1,1,1,1,1,1,1,1,1,1,1,1],
             [1,1,1,1,1,1,1,1,1,1,1,1,1],
             [1,1,1,1,1,1,1,1,1,1,1,1,1],
             [1,1,1,1,1,1,1,1,1,1,1,1,1]];
                    
             


module pixel()
{
    
    cube(size = [pixelSize, pixelSize, pixelHeight], center = true);
}


module invader()
{
    
    for(i = [0:8])
    {
        for(j = [0:15])
        {
            //invader 01.
            if (invaderSelect ==1)
            {
            if (invader01[i][j] == 1)
            {
                    
            
            translate([pixelSize*i, pixelSize*j,0])
            {
                pixel();
            }
            }
                        
            }
            //invader 2
            if (invaderSelect == 2)
            {
            if (invader02[i][j] == 1)
            {
                    
            
            translate([pixelSize*i, pixelSize*j,0])
            {
                pixel(); 
            }
            }
            }
            //invader 3
            if (invaderSelect == 3)
            {
            //echo(invader01[i][j]);
            if (invader03[i][j] == 1)
            {
                    
            
            translate([pixelSize*i, pixelSize*j,0])
            {
                pixel(); 
            }
            }
            }
            //space ship
            if (invaderSelect == 4)
            {
            
            if (invader04[i][j] == 1)
            {
                    
            
            translate([pixelSize*i, pixelSize*j,0])
            {
                pixel(); 
            }
            }
            }
            
            //Gun ship
            if (invaderSelect == 5)
            {
            if (invader05[i][j] == 1)
            {
                    
            
            translate([pixelSize*i, pixelSize*j,0])
            {
                pixel(); 
            }
            }
            }
            
        }
    }
    
    
    
}
//Show the space invader
invader();