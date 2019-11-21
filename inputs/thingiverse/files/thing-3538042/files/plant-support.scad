Support_Diameter=140;
Support_Thickness=2.5;
Support_Width=4;
Catch_Diameter=5;
Catch_Opening=0.8*Catch_Diameter;
$fn = 64;
openSCADErr=0.01;


//Generate the main shape of the support
difference()
{
    // Draw a full circle/cylinder of the appropriate dimensions
    cylinder(Support_Thickness,
                Support_Diameter/2,
                Support_Diameter/2);
    
    // Cut-out the interior
    translate( [0,0, -openSCADErr/2] ) 
    cylinder(Support_Thickness + openSCADErr,
                Support_Diameter/2 - Support_Width,
                Support_Diameter/2 - Support_Width);
 
    // Cut one one half of it
    translate( [0,0, -openSCADErr/2] ) 
    translate([-Support_Diameter/2, 0, 0]) 
        cube([Support_Diameter, 
              Support_Diameter/2, 
              Support_Thickness + openSCADErr]);
}

//Left Catch
 place_catch( [ -Support_Diameter/2+Support_Width/2,
                Catch_Diameter/2,
                0]);
//Right Catch
place_catch( [  Support_Diameter/2-Support_Width/2,
                Catch_Diameter/2,
                0]);
//Center Catch
place_catch( [  0,
               -Support_Diameter/2+Support_Width+Catch_Diameter/2,
                0]);


//Function to generate one catch and place it to the given coordinates
module place_catch(catch_postion)
{
    catch_width=Support_Width/2;
    catch_radius=Catch_Diameter/2;
    
    translate(catch_postion)
    {
        rotate([0,0,90]) 
        difference()
            {
                //Start with a circle
                cylinder(Support_Thickness,
                            catch_radius + catch_width,
                            catch_radius + catch_width );
                
                // Cut-out the interior
                translate( [0,0, -openSCADErr/2] ) 
                cylinder(Support_Thickness + openSCADErr,
                            catch_radius,
                            catch_radius);
                
                // Cut the opening using a triangle, so that the circle opening is correct   
                //First we calculate the x,y of one of the tringle points and the slope of
                //the line from the center of the circle to that point
                cut_x=sqrt(pow(catch_radius,2)-pow(Catch_Opening/2,2));
                cut_y=(Catch_Opening)/2;
                slope_abs=cut_y/cut_x;
                //..then we use the slope to draw the points and triange
                translate( [0,0, -openSCADErr/2] ) 
                linear_extrude(Support_Thickness + openSCADErr)
                    polygon([   [0, 0],
                                //[cut_x, cut_y ],    //not actually needed
                                //[cut_x ,-cut_y ],   //not actually needed
                                [catch_radius+catch_width, (catch_radius+catch_width)*slope_abs],
                                [catch_radius+catch_width, -(catch_radius+catch_width)*slope_abs]
                            ], 
                            paths=[[0,1,2]]
                            );

            }
      }   

}