/* USER PARAMS */


//Interpolation mode. 0 is linear. 1 is trig. 2 is polynomial. 3 is inverse polynomial. Linear will produce a funnel with straight walls, and sharp, angular transition. Trig and polynomial will produce a funnel with curved walls, instead. 
mode = 1;// [0, 1, 2, 3]

//Exponent for mode 2. Larger values = steeper curve. Will break for values less than 1. 1 is equivalent to mode 0, and should be avoided because mode 2 adds some overhead as a price for the flexibility. Your model will generate faster in Mode 1 if you'd be using an exponent of 1!
exponent = 2;

//Model Params.
//unit = mm

//This script works by "gluing together" a bunch of rings. The more rings, the smoother the approximated curves. This parameter saws how tall each ring is, so the bigger the value, the faster your funnel will generate, and the smaller the value, the better the curve quality.
ringHeight = 0.5;//

//This variable controls how smooth the circles are. Make it smaller to make the funnel generate faster, but at lower quality. Min val is 3. Note: this is literally the number of sides the polygon approximating the circle gets, to you can make triangular, square, octagonal, etc funnels by entering the appropriate number.
ringFineness =  256;

//Thickness of model's walls. This thickness goes inward from the outer walls.
thickness = 2;

//Diameter of neck's OUTER contour.
neckDia = 31.5;

//Length of neck. This length is guaranteed to have a diameter of NeckDia.
neckLen = 25;

//Length of transition region. This area will have a changing diameter.
transLen = 50;

//Diameter of mouth's OUTER contour.
mouthDia = 76;

//Depth of Mouth. This area is guaranteed to have a diameter of mouthDia.
mouthDepth = 5;

/* BEGIN CODE */
//Messing with things in here will bork your model unless you know what you're doing
//Move zig
//for great justice!

/*Find a layerheight that results in an exact fit. Necessary to make sure the rate 
  of change of the last piece is continuous w/ other pieces. Lack of this results 
  in the last piece having a greater slope than necessary. This is not usually 
  noticeable, because the last piece is usually very small, but is nevertheless 
  inconvenient if the user wants to generate a model with a large value of ringHeight to 
  save compute time.
  
  First the number of slices is calculated, and adjusted to be an integer. If it
  was already an integer, this does nothing. If it was not an integer, the number
  of layers is increased by one, and the fractional part is removed. Then, realRingHeight 
  is calculated by the number of pieces. Since we add a layer, the new layerheight
  is always at least as precise as what the user wanted.
*/
pieces = transLen/ringHeight + 1 - ((transLen/ringHeight) % 1);
realRingHeight = transLen/(pieces + 1 - (pieces % 1));
$fn =  ringFineness;



union(){
    difference(){
        cylinder(neckLen, r=neckDia/2);
        cylinder(neckLen, r=(neckDia-thickness)/2);
    }

    if(mode == 0){//Linear Funnel
        
        for(i = [0:pieces]){
            
            translate([0,0,realRingHeight*i + neckLen]){
                
                difference(){
					cylinder(realRingHeight, 
                             d1 = (neckDia * (1-i/(pieces+1)) + 
                                   mouthDia * i/(pieces+1)),
                    
                             d2 = (neckDia * (1-(i+1)/(pieces+1)) + 
                                   mouthDia * (i+1)/(pieces+1))
                            );
                    
                    
					cylinder(realRingHeight, 
                             d1 = ((neckDia * (1-i/(pieces+1)) + 
                                    mouthDia * i/(pieces+1))-thickness),
                    
                             d2 = ((neckDia * (1-(i+1)/(pieces+1)) + 
                                    mouthDia * (i+1)/(pieces+1))) - thickness
                            );
				}   
			}
		}  
    }
    
    else if(mode == 1){//Sinusoid
        
        for(i = [0:pieces]){
            

            
            translate([0,0,realRingHeight*i + neckLen]){
                
                difference(){
					cylinder(realRingHeight,
                             d1 = (neckDia * (1-pow(sin(i/(pieces+1) * 90),2)) + mouthDia * pow(sin(i/(pieces+1) * 90),2)),
                             d2 = (neckDia * (1-pow(sin((i+1)/(pieces+1) * 90),2)) + mouthDia * pow(sin((i+1)/(pieces+1) * 90),2))
                             );
					cylinder(realRingHeight,
                             d1 = ((neckDia * (1-pow(sin(i/(pieces+1) * 90),2)) + mouthDia * pow(sin(i/(pieces+1) * 90),2))-thickness),
                             d2 = ((neckDia * (1-pow(sin((i+1)/(pieces+1) * 90),2)) + mouthDia * pow(sin((i+1)/(pieces+1) * 90),2))-thickness)
                    );
				}   
			}
		}  
    }
    
    else if(mode == 2 || mode == 3){//Exponential and inverse exponential
        
        //Convert normal input to inverse if mode 3
        exponent = (mode == 3) ? 1/exponent : exponent;
        
        for(i = [0:pieces]){
            
            translate([0,0,realRingHeight*i + neckLen]){
                
                difference(){
					cylinder(realRingHeight, 
                             d1 = (neckDia * (1-pow(i/(pieces+1),exponent)) + mouthDia * pow(i/(pieces+1),exponent)),
                             d2 = (neckDia * (1-pow((i+1)/(pieces+1),exponent)) + mouthDia * pow((i+1)/(pieces+1),exponent))
                             );
                    
					cylinder(realRingHeight,
                             d1 = ((neckDia * (1-pow(i/(pieces+1),exponent)) + mouthDia * pow(i/(pieces+1),exponent))-thickness),
                             d2 = ((neckDia * (1-pow((i+1)/(pieces+1),exponent)) + mouthDia * pow((i+1)/(pieces+1),exponent))-thickness)
                    );
				}   
			}
		}  
    }
    

    
    
    
    translate([0,0,neckLen + transLen]){
        difference(){
            cylinder(mouthDepth, r=mouthDia/2);
            cylinder(mouthDepth, r=(mouthDia-thickness)/2);
        }
    }
}