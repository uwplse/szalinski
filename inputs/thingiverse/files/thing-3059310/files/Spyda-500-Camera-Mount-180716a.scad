$fn=50;

hc=5;
cil=34;
cil2=12;
le=40;
br=19;
br2=10;

difference()
{    
    union()
    {
        translate([0,0,0])
            cube([br+0.01,le,hc], center=false);

        translate([br+cil/2,le/2,0])
            cylinder(h=hc,d=cil,center=false);
        
        CubePoints = [
          [br,0,0 ],  //0
          [br+cil/2+1,(le-cil)/2,0 ],  //1
          [br+cil/2+1,cil+(le-cil)/2,0 ],  //2
          [br,le,0 ],  //3
          [br,0,hc ],  //4
          [br+cil/2+1,(le-cil)/2,hc ],  //5
          [br+cil/2+1,cil+(le-cil)/2,hc ],  //6
          [br,le,hc ]]; //7
          
        CubeFaces = [
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3]]; // left
          
        polyhedron( CubePoints, CubeFaces );
    
    };      

    translate([br+cil/2,le/2,2])
        cylinder(h=6,d1=0,d2=12,center=true);
    translate([br+cil/2,le/2,3])
        cylinder(h=6,d=6,center=true);
};
translate([5,0,0])
    rotate([0,-90,0])
        difference()
        {    
            union()
            {
                translate([0,0,0])
                    cube([br2+0.01,le,hc], center=false);

                translate([38,le/2,2.5])
                    cylinder(h=hc,d=cil2,center=true);
                
                CubePoints = [
                  [br2,0,0 ],  //0
                  [39,(le-cil2)/2,0 ],  //1
                  [39,cil2+(le-cil2)/2,0 ],  //2
                  [br2,le,0 ],  //3
                  [br2,0,hc ],  //4
                  [39,(le-cil2)/2,hc ],  //5
                  [39,cil2+(le-cil2)/2,hc ],  //6
                  [br2,le,hc ]]; //7
                  
                CubeFaces = [
                  [0,1,2,3],  // bottom
                  [4,5,1,0],  // front
                  [7,6,5,4],  // top
                  [5,6,2,1],  // right
                  [6,7,3,2],  // back
                  [7,4,0,3]]; // left
                  
                polyhedron( CubePoints, CubeFaces );
            
            };      

            translate([38,le/2,2.5])
                cylinder(h=hc+1,d=3,center=true);
        };
        
translate([19,0,0])
    rotate([0,-90,0])
        difference()
        {    
            union()
            {
                translate([0,0,0])
                    cube([br2+0.01,le,hc], center=false);

                translate([38,le/2,2.5])
                    cylinder(h=hc,d=cil2,center=true);
                
                CubePoints = [
                  [br2,0,0 ],  //0
                  [39,(le-cil2)/2,0 ],  //1
                  [39,cil2+(le-cil2)/2,0 ],  //2
                  [br2,le,0 ],  //3
                  [br2,0,hc ],  //4
                  [39,(le-cil2)/2,hc ],  //5
                  [39,cil2+(le-cil2)/2,hc ],  //6
                  [br2,le,hc ]]; //7
                  
                CubeFaces = [
                  [0,1,2,3],  // bottom
                  [4,5,1,0],  // front
                  [7,6,5,4],  // top
                  [5,6,2,1],  // right
                  [6,7,3,2],  // back
                  [7,4,0,3]]; // left
                  
                polyhedron( CubePoints, CubeFaces );
            
            };      

            translate([38,le/2,2.5])
                cylinder(h=hc+1,d=3,center=true);
        };