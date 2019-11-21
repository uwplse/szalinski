$fn=20;

//Profondeur
p = 100;

hMax = 46;
hMin = 29;
hDiff2 = (hMax - hMin) /2;

//Epaisseur
e = 2;

Interieur = [
  [ 0, 0, hDiff2        ], //0
  [ p, 0, 0             ], //1
  [ p, 0, hMax          ], //2
  [ 0, 0, hMax -  hDiff2], //3
  [ 0, e, hDiff2        ], //4
  [ p, e, 0             ], //5
  [ p, e, hMax          ], //6
  [ 0, e, hMax - hDiff2]]; //7
  
  
CubeFaces = [
  [4,5,1,0],  // bottom
  [7,6,5,4],  // front
  [3,2,6,7],  // top
  [6,2,1,5],  // right
  [2,3,0,1],  // back
  [3,7,4,0]]; // left

//Insert
polyhedron( Interieur, CubeFaces );

//Gond Fixe
difference(){

    translate([p,0,0]){
        cube([10,e,hMax]);
        
        translate([7.5,-0.5,0]){
            cylinder(hMax,d=5);
        }
    }


    translate([p+3,-3,10]){
        cube([10 ,5,hMax-2*10]);        
    }
    
    translate([p+7.5,-0.5,5]){
        cylinder(hMax,d=2);
    } 
}
//Gond mobile
difference(){
    translate([117.5,0,10]){
        cube([5 ,e,hMax-2*10]);
        translate([2.5,-0.5,0]){
                cylinder(hMax-2*10,d=5);
        }
    }
    translate([120,-0.5,10]){
        cylinder(hMax-2*10,d=2);
    }
}

//Pince appuie fond bas et droite
translate([122.5,-10+2,-140+hMax]){
    difference(){
        cube([2+2+9 ,10,140]);
        translate([2,0,2]){
            cube([9 ,10-2,140]);
            translate([0,0,12]){
                cube([9+2 ,10,140-22]);
            }
        }
        translate([0,0,75]){
            cube([2 ,10,15]);
        }
    }
    translate([-2,0,0]){
        cube([2 ,10,140-hMax]);
    }

}

    translate([140,-127,-19]){
        cube([2 ,129,15]);
        translate([2,0,0]){
            cube([9 ,2,24]);
        }
        translate([0,0,15]){
            cube([2 ,15,5+2]);
        }
        translate([-25+2,0,22]){
            cube([25 ,15,2]);
        }

        translate([11,5,0]){
            rotate([0,270,180]){
                triangle3d(24,5,4);
            }
        }
    }


    
module triangle3d(l,w,h){
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}
 
