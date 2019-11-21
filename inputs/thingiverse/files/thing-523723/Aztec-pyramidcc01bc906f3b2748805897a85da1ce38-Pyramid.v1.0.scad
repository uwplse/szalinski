// ****************************************************
//              INCA Pyramid
// By:          Humberto Kelkboom 
// Date:        17 Oct 2014
//
//*****************************************************


//Set the scaling of the Object. Standard it base is 1x1x1
ScaleFactor = 5;

//Set the number of levels of the Pyramid
Nivo = 5 ;


scale([ScaleFactor,ScaleFactor,ScaleFactor])
difference()
{
union() 
{
    for ( i = [1 : Nivo] )
    {
        translate([(i*-1)-0.5,(i*-1)-0.5,Nivo-i]) cube([1+(i*2),1+(i*2),1]);
        
        for(rot=[0:3])
        {
            rotate([0,0,rot*90]) 
            {
                for(tr=[1:4])
                {
                    translate([-0.5,-0.5-i-(1-(0.25*tr)),Nivo-i]) cube([1,(1-(0.25*tr)),0.25*tr]);
                }           

                translate([-0.7,-0.5-i,Nivo-i])
                rotate([180,-90,0]) linear_extrude(height=0.2) polygon([[0,0],[0,1.2],[1.2,0]]);
                
                translate([0.5,-0.5-i,Nivo-i])
                rotate([180,-90,0]) linear_extrude(height=0.2) polygon([[0,0],[0,1.2],[1.2,0]]);
            }
        }       
    }

}
translate([(1*-1)-0.75,(1*-1)-0.75,Nivo]) cube([1.5+(1*2),1.5+(1*2),0.3]);

};
