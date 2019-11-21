


PTFE_Outer_Diam=4;
Filament_Width=1.75;
Holder_Thickness=1.5;
Filament_Catch_Length=15;
PTFE_Catch_Length=15;
Total_Height=Filament_Catch_Length+PTFE_Catch_Length+1;
$fn = 64;

union(){

    
    difference()
    {
        // Outer cylinder shell
        cylinder(Total_Height,
                 (PTFE_Outer_Diam/2)+0.75,
                 (PTFE_Outer_Diam/2)+0.75);   
        
        // Hole
        union()                           
        {
            //Filament Catch
            translate([0,0,Filament_Catch_Length])
                cylinder(Filament_Catch_Length,
                         r1=(Filament_Width+0.15)/2,
                         r2=1);
            
            //PTFE Catch
            cylinder( PTFE_Catch_Length,
                      r1 = (PTFE_Outer_Diam+0.25)/2,
                      r2 = (PTFE_Outer_Diam-0.25)/2 );
        }
    }
    
     // Holder
    translate([0,0,Total_Height-Holder_Thickness]) 
        cylinder(Holder_Thickness,
                 PTFE_Outer_Diam,
                 PTFE_Outer_Diam);  
}


