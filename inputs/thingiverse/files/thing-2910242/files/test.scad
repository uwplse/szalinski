// CSG.scad - Basic example of CSG usage

w =  15; 
h =  9.9;

translate([-24,0,0]) {
   render(convexity = 1) difference(){
        cube(w, center=true);
        sphere(h);
    }
}

