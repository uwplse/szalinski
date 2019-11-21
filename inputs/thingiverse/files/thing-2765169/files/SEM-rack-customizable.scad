number_x = 4;
number_y = 3;

handle = 1;

outer_rad = 4;
outer_height = 8.3;

inner_rad = 2;
inner_height = 4.2;

thickness = 0.8;

base_width = 13;
base_height = 2;
base_width_handle = 5;

handle_rad_base = 2;
handle_rad_top = 1;
handle_height = 30;

fa = 0.5;
fs = 0.5;

if(handle == 0){
    for (x = [0:number_x-1] ){
        for (y = [0:number_y-1] ){
            translate([x*base_width,y*base_width,0]){
               union(){
                cube([base_width,base_width,base_height]); //base
                translate([base_width/2,base_width/2,base_height], $fa=fa, $fs=fs){
                    difference(){
                        cylinder(r=inner_rad+thickness,h=inner_height);
                        cylinder(r=inner_rad,h=inner_height);
                    }
                    
                    difference(){
                        cylinder(r=outer_rad+thickness,h=outer_height);
                        cylinder(r=outer_rad,h=outer_height);
                    }
                  }
              }
          }
       }
    }
}

if(handle == 1 && number_x%2 == 0){
    union(){
        for (x = [0:(number_x-1)/2] ){
            for (y = [0:number_y-1] ){
            translate([x*base_width,y*base_width,0]){
                cube([base_width,base_width,base_height]); //base
                translate([base_width/2,base_width/2,base_height], $fa=fa, $fs=fs){
                    difference(){
                        cylinder(r=inner_rad+thickness,h=inner_height);
                        cylinder(r=inner_rad,h=inner_height);
                    }
                    
                    difference(){
                        cylinder(r=outer_rad+thickness,h=outer_height);
                        cylinder(r=outer_rad,h=outer_height);
                    }
                  }
              }
           }
        }
        translate([number_x/2*base_width,0,0]){
            cube([base_width_handle,base_width*number_y,base_height]); //base
        }
        translate([number_x/2*base_width+base_width_handle/3,number_y/2*base_width,base_height], $fa=fa, $fs=fs)cylinder(handle_height, handle_rad_base, handle_rad_top, $fa=fa, $fs=fs);
        for (x = [(number_x-1)/2:(number_x-1)] ){
            for (y = [0:number_y-1] ){
                translate([x*base_width+base_width_handle*2,y*base_width,0], $fa=fa, $fs=fs){
                cube([base_width,base_width,base_height]); //base
                translate([base_width/2,base_width/2,base_height]){
                    difference(){
                        cylinder(r=inner_rad+thickness,h=inner_height);
                        cylinder(r=inner_rad,h=inner_height);
                    }
                    
                    difference(){
                        cylinder(r=outer_rad+thickness,h=outer_height);
                        cylinder(r=outer_rad,h=outer_height);
                    }
                  }
              }
           }
        }
    }
}