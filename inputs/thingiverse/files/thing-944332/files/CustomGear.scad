

// preview[view:south, tilt:top]

// [Main Parameters]

// What do you want your sprocket to say?
String = "#PROTO"; 

// How big do you want your phrase to be?
LetterSize = 50; 

/* [Other Parameters] */

// This is how tall the letters will be
LetterThickness = 7;

// This is the overall thickness of the sprocket
Thickness = 5;

// This is the size of the inner circle
InnerRadius = 25;
// This is the size of the middle circle
MidRadius = 80;
// This is the size of the overall circle
OuterRadius = 125;
// This is the overall width of the lines used in the gear
LineWidth = 10;
// This is the number of gears around the sprocket
GearCount = 26;

font = "Arial Rounded MT Bold:style=Regular";
StringLength = len(String);

module gear(){
scale = .11;

linear_extrude(height = Thickness)
polygon(points=scale*[[0,0],[60,0],[15, 80],[0,80]], paths=[[0,1,2,3]]);

mirror([1, 0 , 0])
linear_extrude(height = Thickness)
polygon(points=scale*[[0,0],[60,0],[15, 80],[0,80]], paths=[[0,1,2,3]]);
}
    

module letter(l) {
  linear_extrude(height = LetterThickness) {
    text(l, size = LetterSize, font = font, halign = "center", valign = "center", $fn = 16);
  }
}

union(){
    
    difference(){
       
        difference(){
            
            cylinder(h = Thickness, r = MidRadius+LineWidth/2);
            
            cylinder(h = 2*Thickness, r = MidRadius-LineWidth/2);
  
            }
            
        }
        
    for ( i = [0:StringLength-1] ) {
        theta = i*360/StringLength;
        translate([MidRadius*sin(theta), MidRadius*cos(theta), 0]) 
        rotate([0, 0, -theta]) 
        letter(String[i]);
        }
    
        difference(){
        cylinder(h = Thickness, r = OuterRadius);
        cylinder(h = 2*Thickness, r = OuterRadius-LineWidth);
        }
        
        //draw the rays with center removed
        difference(){
            union(){
                cylinder(h = Thickness, r = InnerRadius);  
                for ( i = [0:StringLength-1] ) {
                    theta = i*360/StringLength+180/StringLength;
                    rotate([0, 0, theta])
                    translate([-LineWidth/2,0,0])                  
                    cube([LineWidth,OuterRadius-5,Thickness],center = false);
                  /*  if(  i == ceil((StringLength-1)/2)+1 ){
                        rotate([0, 0, theta])
                        translate([50,0,0])
                        cube(10,10,10);
                        
                        }*/

                    }
                }
                cylinder(h = 2*Thickness, r = InnerRadius-LineWidth);
            }
 
 for (j = [0:GearCount-1]){
     theta = j*360/GearCount;
     rotate([0,0,theta])
     translate([0,OuterRadius-1,0])
     gear();
 }
            
        
 }


