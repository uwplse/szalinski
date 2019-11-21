//
//*                         *
//*      Demon Horns        *
//* A parametric, recursive *
//*    OpenSCAD script      *
//*                         *
//
// 6/16/2016
//
//

//on each iteration curl in x direction by this much
x_rotation_fudge = 6;

//add this powerful of a sinewave to the x curling
x_sin_pow = 20;

//offset the sinewave by this much (x)
x_sin_offset = 110;

//on each iteration curl in y direction by this much
y_rotation_fudge = 18;

//add this powerful of a sinewave to the y curling
y_cos_pow = 0;

//offset the sinewave by this much (y)
y_cos_offset = 110;

//on each iteration rotate around the z axis by this much
z_rotation_fudge = 14;

//how many segmments up to start the pointed end
point_start = 13;

//length of each segment
segment_length = 6;

//width of each segment
segment_width = 8;

//how much to scale down each segment from the last
big_scale_factor = 0.9875;

//how much to scale down in the tip of the tail
small_scale_factor = 0.8666;

module hell(height, width, depth)
{
    if (depth > 0)
    {
       union()
        {
            //main cylinder
            color([1-0.025*abs(depth-32),1-0.025*abs(depth-32),1-0.025*abs(depth-32)])
            {
                cylinder(h=height*13,r1=(width*8),r2=(width*7.6), $fn=10);
            }
            
            if (depth < point_start)
            {
                //sharp point
                satan(height*(small_scale_factor), width*(small_scale_factor), depth-1);
            }
            else
            { 
                //recurse normally
                satan(height*(big_scale_factor), width*(big_scale_factor), depth-1);
            }
        }
     
    }
}

module satan(height, width, depth)
{
    if (depth > 0)
    {
        translate([0,0,height*8])
        {
            rotate([x_rotation_fudge+x_sin_pow*sin(((depth+x_sin_offset)*height)+20),-y_rotation_fudge+y_cos_pow*cos(((depth+y_cos_offset)*height)+20),-z_rotation_fudge])
            {
              
                hell(height, width, depth);
            }
        
        }
    }
}

module horns()
{
        
    translate([-100,0,0])
    {
        rotate([-20,-20,90])
        {
            hell(segment_length, segment_width, 64);
        }
    }
    translate([100,0,0])
    {
        mirror(v=[1,0,0])
        {
            rotate([-20,-20,90])
           {
                hell(segment_length, segment_width, 64);
            }
        }
    }
    
}

horns();


