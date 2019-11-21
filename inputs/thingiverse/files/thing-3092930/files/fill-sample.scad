//fill_sample

use <fill.scad>

difference(){
    sphere(r=15, $fn=40);
    void_rhombo(size=7, thick=0.5, rep=[5,5,5]);
}



