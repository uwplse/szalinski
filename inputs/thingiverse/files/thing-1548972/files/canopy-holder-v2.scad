// ********  Canopy Holder **********
// compatible to MPX Cularis / Easyglider
//     Henning Stöcklein 8.5.2016
//     free for non-commercial use
// ******************************

/* [User parameters] */
// Cylinder Outer Radius (MPX:4.5)
r_cyl = 6.0 ; // [5:0.1:7]

// Hole Radius (MPX:3.5)
r_hole = 3.6 ; // [3.3:0.1:4.5]

// Bar length (MPX:20)
blen = 25 ; // [18:0.2:25]

// Bar height (MPX:2.3)
bheight = 2.3 ; // [2:0.1:3]

// Bar width (MPX:10)
bwid = 12 ; // [10:0.2:15]

// Sawtooth length (MPX:8)
sawlen = 10 ; // [8:0.2:15]

// Sawtooth height (MPX:1.0]
sawdep = 1.3 ; // [1.0:0.1:2.0]

// Sawtooth width (MPX:10)
sawwid = 10 ; // [8.0:0.2:15]

// Weight reduction slot?
r_redhole = 1.5 ; // [0:None, 1:Very small, 1.5:Small, 2:Medium, 3:Big]

//******* End of user defined parameters *******

module canopy() 
{
  difference ()
  {
    hull ()
    {  
        translate ([0,0,0]) cube ([bwid,0.1,bheight]) ;
        translate ([0,blen-2*r_cyl,0]) cube ([bwid,0.1,bheight]) ;
        translate ([bwid/2,blen,0]) cylinder (r1=r_cyl-0.7 , r2=r_cyl, h=0.7, $fn=50) ;
        translate ([bwid/2,blen,bheight-0.4]) cylinder (r1=r_cyl, r2=r_cyl-0.5, h=0.5, $fn=50) ;
    }
    translate ([bwid/2,blen,-1]) cylinder (r=r_hole, h=4, $fn=50) ;
    
    // Fasen am Loch
    translate ([bwid/2,blen,bheight-0.3]) cylinder (r1=r_hole, r2=r_hole+1, h=1, $fn=50) ;
    translate ([bwid/2,blen,-0.4]) cylinder (r2=r_hole, r1=r_hole+1, h=1, $fn=50) ;
    
    // Create array of sawtooth steps
    for (i= [0:2:sawlen])
      translate ([-0.1,-0.1,sawdep-1.0]) hull()
      {
        translate ([(bwid-sawwid)/2,i,1.0]) cube ([sawwid,0.1,0.1]) ;
        translate ([(bwid-sawwid)/2,i,bheight]) cube ([sawwid,bheight,0.1]) ;       
      }

    // 1st sawtooth always cuts the complete width 
    translate ([-0.1,-0.1,sawdep-1.0]) hull() 
    {
      translate ([-0.1,0,1.0]) cube ([20,0.1,0.1]) ;
      translate ([-0.1,0,bheight]) cube ([20,bheight,0.1]) ;       
    }
    
    // Weight reduction hole in sawtooth area
    hull()
    {
        translate ([bwid/2,bwid/3+r_redhole,0]) cylinder (r=r_redhole, h=10, center=true, $fn=20) ;
        translate ([bwid/2,blen-2*r_cyl-r_hole,0]) cylinder (r=r_redhole, h=10, center=true, $fn=20) ;
    } // hull
  } // diff
} // module

canopy () ;
