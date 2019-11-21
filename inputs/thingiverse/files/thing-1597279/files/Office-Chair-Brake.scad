////////////////////////////
// VARIABLES



/* [Wheel] */

//Wheel Diameter
wheelDiameter = 55;

wheelRadius = wheelDiameter/2;

//Thickness of Entire Wheel Structure
wheelThickness = 54;

//Space Between Wheels
wheelSpace = 22;


/* [Brake] */

//Height of Brake
boxHeight = 20;

boxThickness = wheelThickness+1;

//Brake Floor Thickness
boxBottomThickness = 2;

//Approx Groove Size for Inner Brace
innerBraceGroove = 35;


/* [Hidden] */
$fn=120;


////////////////////////////
// RENDER
intersection()
{
    //ROUNDED CORNER
    translate([boxThickness/2,wheelDiameter,-((wheelThickness+1)*(17/32))]) rotate([90,0,0]) cylinder(r=wheelThickness+1, h=wheelDiameter);
    
    union()
    {
        translate ([((wheelThickness+1)/2)-(wheelSpace/2),0,(wheelDiameter/2)])
        //INNER BRACE
        difference()
        {
            //BRACE
            translate([0,wheelDiameter/2,0]) rotate([0,90,0]) 
                cylinder(h=wheelSpace, d=wheelDiameter);
                        
            union()
            {
                //Brace Top Subtraction
                translate([-(wheelThickness/2) + (wheelSpace/2) ,0,boxHeight-(wheelRadius)]) 
                    cube([wheelThickness, wheelDiameter+1, wheelDiameter - boxHeight]);
                //Brace Groove Subtraction
                translate([-.1,wheelDiameter/2,0]) rotate([0,90,0]) cylinder(h=wheelSpace+1, d=innerBraceGroove);
             }
        }
        
        //MAIN BLOCK
        difference()
        {
        
            cube([boxThickness,wheelDiameter,boxHeight]);
            
            rotate([0,90,0])
             translate([-(wheelDiameter/2+boxBottomThickness),wheelDiameter/2,-.1])
         cylinder (h=wheelThickness+2, d=wheelDiameter);
            
            
        }
    }
}
////////////////////////////
// MODULES

