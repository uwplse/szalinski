//Script adapted from http://thomasdiewald.com/blog/?p=561

/* [Main Parameters] */
//May increase processing time
Iterations = 1;//[0:3]

//How far apart the beams are
Spacing = 5;//[3:Extra Tight,4: Tight,5:Normal,7:Wide,10:Extra Wide,15:Extremely Wide]

//% Realative to corners
beam_width = 100;//[1:100]

/* [Randomization] */

//Ignore Main Parameters and randomize. The final model may be different from the preview.
randomized = 0;//[0:No,1:Yes]

minimum_iterations = 0;//[0:3]
maximum_iterations = 3;//[0:3]

minimum_spacing = 3;//[3:Extra Tight,4: Tight,5:Normal,7:Wide,10:Extra Wide,15:Extremely Wide]
maximum_spacing = 10;//[3:Extra Tight,4: Tight,5:Normal,7:Wide,10:Extra Wide,15:Extremely Wide]

minimum_beam_width = 10;//[1:100]
maximum_beam_width = 100;//[1:100]

/* [Hidden] */
if(randomized == 0) //Execute normally if not randomized
drawhilbert(Spacing, Iterations, beam_width);

if(randomized == 1) //Randomize Paramaters
    drawhilbert(rands(minimum_spacing,maximum_spacing,1)[0],floor(rands(minimum_iterations,maximum_iterations + 1,1)[0]),rands(minimum_beam_width,maximum_beam_width,1)[0]);

module drawhilbert(spacing, iterations, beam_width){
flatmult = pow(2,iterations+1);//Used in flatten function
    
size = pow(2,iterations) * spacing/5;//Used for consistent spacing
    
nums = flatten(hilbert(size = size, iterations = iterations),flatmult);//Generates flat array of numbers
    
beam_offset = [1-beam_width/100,1-beam_width/100,1-beam_width/100];//Generates beam offset
    
cubes= [for(a = [0:len(nums)-1]) if(a %3 == 0) [nums[a],nums[a+1],nums[a+2]]];//Changes flat array into array of cube vectors
    
for(a = [0:len(cubes)-2]){
    line(cube1=cubes[a],cube2=cubes[a+1],beam_width = beam_width,beam_offset = beam_offset);
    }//Goes through vector and renders cubes
}
function hilbert(center = [0,0,0], size, iterations, a=0,b=1,c=2,d=3,e=4,f=5,g=6,h=7)=(iterations >= 0)?
     //Recursive logic   
       
        [[hilbert(corner(a,center, size), size*.5, iterations - 1, a,d,e,h,g,f,c,b)],
        [hilbert(corner(b,center, size),size*.5, iterations - 1,a,h,g,b,c,f,e,d)],
        [hilbert(corner(c,center, size),size*.5, iterations - 1,a,h,g,b,c,f,e,d)],
        [hilbert(corner(d,center, size),size*.5, iterations - 1,c,d,a,b,g,h,e,f)],
        [hilbert(corner(e,center, size),size*.5, iterations - 1,c,d,a,b,g,h,e,f)],
        [hilbert(corner(f,center, size),size*.5, iterations - 1,e,d,c,f,g,b,a,h)],
        [hilbert(corner(g,center, size),size*.5, iterations - 1,e,d,c,f,g,b,a,h)],
        [hilbert(corner(h,center, size),size*.5, iterations - 1,g,f,c,b,a,d,e,h)]]:center
    ;

function corner(cnr, center, size) = (cnr == 0)?[center[0] - size,center[1] + size,center[2] - size]:
(cnr == 1)?[center[0] - size,center[1] + size,center[2] + size]:
(cnr == 2)?[center[0] - size,center[1] - size,center[2] + size]:
(cnr == 3)?[center[0] - size,center[1] - size,center[2] - size]:
(cnr == 4)?[center[0] + size,center[1] - size,center[2] - size]:
(cnr == 5)?[center[0] + size,center[1] - size,center[2] + size]:
(cnr == 6)?[center[0] + size,center[1] + size,center[2] + size]:
[center[0] + size,center[1] + size,center[2] - size];//Gets corner value from index, because functions cannot generate an array of corners
    


function flatten(l,i)=(i>0)? flatten([for(a=l) for(b = a) b],i-1):l;//Flattens arrays through recursion


 module line(cube1,cube2,beam_width,beam_offset){//Actual rendering
     translate(cube1)cube(1);//Generates corners
        translate(cube2)cube(1);
    hull(){//Generates beams
        translate(cube1+(beam_offset/2))cube(beam_width/100);
        translate(cube2+(beam_offset/2))cube(beam_width/100);}
}
  