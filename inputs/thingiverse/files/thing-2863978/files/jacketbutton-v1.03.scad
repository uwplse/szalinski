

$fn=120;

// how tall to make the button (mm)
$buttonheight = 2; 

// how wide to make the button (mm)
$buttondiameter = 30;

// size of the button holes (mm)
$holesize = 2.5;

// distance between holes (mm)
$holeoffset = 2;

// text to put on the button
$buttontext = "NO GUTS - NO GLORY - ";

// higher value is less dense
$textspacing = 17;

// the font size
$textsize = 3.25;

// [square,round]
$beveltype = "round"; 


Button(
    buttonheight = $buttonheight, 
    buttondiameter = $buttondiameter, 
    holesize = $holesize, 
    holeoffset = $holeoffset,
    buttontext = $buttontext,
    textdensity = $textspacing,
    textsize = $textsize,
	beveltype = $beveltype
);




module Button(buttonheight, buttondiameter, holesize, holeoffset, buttontext, textsize, textdensity, beveltype){

    beveldiameter = (1.5 * buttonheight);

    difference() {  // outer difference for button text
        
        difference(){ // difference for button holes
            
            union(){ 
                hull(){
                    // main button cylinder
                    cylinder(h = buttonheight, d = buttondiameter, center = true);             

                    // hull cylinder - pushes up from the center
                    translate([0,0,buttonheight])    
                    cylinder(h=buttonheight / 2.5 , d = (buttondiameter / 2.5) , center = true);
                };

				if(beveltype == "round") {				
					// round outer bevel
					translate([0,0,buttonheight - (beveldiameter / 2)])
					rotate_extrude(convexity = 10)
					translate([buttondiameter/2, 0, 0])
					difference(){
						circle(d = beveldiameter);
						translate([-1 * beveldiameter,-1 * beveldiameter,0])
						square(size = beveldiameter);
					};
				} else if (beveltype == "square") {			
					// square outer bevel
					translate([0,0,buttonheight/2])
					difference(){
						cylinder(h = buttonheight , d = buttondiameter, center = true);    
						cylinder(h = buttonheight , d = buttondiameter - 5, center = true);    
					};
				}
				
            }
            
            // button holes
            translate([holeoffset,holeoffset,0])
                cylinder(h = buttonheight + 20, d = holesize, center = true);
            translate([holeoffset,-1 * holeoffset,0])
                cylinder(h = buttonheight + 20, d = holesize, center = true);
            translate([-1 * holeoffset,holeoffset,0])
                cylinder(h = buttonheight + 20, d = holesize, center = true);
            translate([-1 * holeoffset,-1 * holeoffset,0])
                cylinder(h = buttonheight + 20, d = holesize, center = true);
        };


        // get the approx width of the text: number of char * fontsize
        // approx 9 degrees per letter 

        textradius = (buttondiameter / 2)  - (textsize * 2); //11;

        for(c = [0: 1: len(buttontext) - 1])
        {
            
            // start the angle on the "left" side of the center y
            angle = (textdensity * (c - (len(buttontext) / 2) + 0.5)); 
            
            xcoord = (sin(angle) * textradius);
            ycoord = (cos(angle) * textradius);
            //echo(xcoord  , ycoord);
            
            translate([xcoord,ycoord,0.5]){
                rotate([0,0,(-1)*angle]) {
                    linear_extrude(height=5){
                        text(text=buttontext[c], size=textsize, halign="center", font="Courier New:style=Bold");
                    }
                }
            };    
        };
    }    
};