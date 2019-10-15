

_x = 60;
_y = 38;
_z = 20;

// modules in library:
module slide_box(x, y, z)

{
    translate ([0,0,z/2])
union (){    
    difference(){
    cube ([x,y,z],true);
        translate ([0,0,3])
    cube ([x-4,y-8,z],true);
    translate ([2,0,z/2-2])
    cube ([x,y-4,5],true);
        }
        
translate ([0,0,z/2+2])        
difference(){
cube ([x,y,4],true);
    translate ([4,0,0])
    cube ([x,y-8,4],true);
}
}
///TOP
translate ([x+5,0,-z/2+4])
union(){
translate ([2,0,z/2-2])
cube ([x-4,y-5,4],true);
translate ([x/2-2,0,z/2])
cube ([4,y-9,7.5],true);
}
}
slide_box (x=_x, y=_y, z=_z);