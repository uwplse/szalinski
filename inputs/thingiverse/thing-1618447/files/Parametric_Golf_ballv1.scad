// Parametric Golf Ball V1
// http://www.thingiverse.com/thing:1618447
// Hacked by
// by infinigrove Squirrel Master 2016 (http://www.thingiverse.com/infinigrove)
//
Golf_Ball_Diameter = 42.7;

Dimple_Diameter = 3.5;

Golf_Ball_Detail = 20; //[10:180]

/* [Hidden] */

golfball_radius = Golf_Ball_Diameter/2;

dimple_radius = Dimple_Diameter/2;


difference() {
    //main sphere for golf ball
  sphere(r=golfball_radius, $fn=Golf_Ball_Detail);
    //top and bottom dimple
   translate([0,0,golfball_radius]) sphere(r=dimple_radius, $fn=Golf_Ball_Detail);
    translate([0,0,-golfball_radius]) sphere(r=dimple_radius, $fn=Golf_Ball_Detail);
    
    //top and bottom row of dimples
    for (t =[15,165]){
        for (s =[0:45:360]){
        dimple_xcord = golfball_radius * cos(s) * sin(t);

        dimple_ycord = golfball_radius * sin(s) * sin(t);

        dimple_zcord = golfball_radius * cos(t);
        
    translate([dimple_xcord,dimple_ycord,dimple_zcord]) sphere(r=dimple_radius, $fn=Golf_Ball_Detail);
        }
    }
    
    //next row of dimples
    for (t =[30,150]){
        for (s =[0:30:360]){
        dimple_xcord = golfball_radius * cos(s) * sin(t);

        dimple_ycord = golfball_radius * sin(s) * sin(t);

        dimple_zcord = golfball_radius * cos(t);
        
    translate([dimple_xcord,dimple_ycord,dimple_zcord]) sphere(r=dimple_radius, $fn=Golf_Ball_Detail);
        }
    }
    
    //next row of dimples
    for (t =[45,135]){
        for (s =[0:20:360]){
        dimple_xcord = golfball_radius * cos(s) * sin(t);

        dimple_ycord = golfball_radius * sin(s) * sin(t);

        dimple_zcord = golfball_radius * cos(t);
        
    translate([dimple_xcord,dimple_ycord,dimple_zcord]) sphere(r=dimple_radius, $fn=Golf_Ball_Detail);
        }
    }
    
    //next row of dimples
    for (t =[60,120]){
        for (s =[0:18:360]){
        dimple_xcord = golfball_radius * cos(s) * sin(t);

        dimple_ycord = golfball_radius * sin(s) * sin(t);

        dimple_zcord = golfball_radius * cos(t);
        
    translate([dimple_xcord,dimple_ycord,dimple_zcord]) sphere(r=dimple_radius, $fn=Golf_Ball_Detail);
        }
    }
    
    //next row of dimples
    for (t =[75,105]){
        for (s =[0:14:360]){
        dimple_xcord = golfball_radius * cos(s) * sin(t);

        dimple_ycord = golfball_radius * sin(s) * sin(t);

        dimple_zcord = golfball_radius * cos(t);
        
    translate([dimple_xcord,dimple_ycord,dimple_zcord]) sphere(r=dimple_radius, $fn=Golf_Ball_Detail);
        }
    }
    
    //middle row of dimples
    for (t =[90]){
        for (s =[0:12:360]){
        dimple_xcord = golfball_radius * cos(s) * sin(t);

        dimple_ycord = golfball_radius * sin(s) * sin(t);

        dimple_zcord = golfball_radius * cos(t);
        
    translate([dimple_xcord,dimple_ycord,dimple_zcord]) sphere(r=dimple_radius, $fn=Golf_Ball_Detail);
        }
    }
   
}

