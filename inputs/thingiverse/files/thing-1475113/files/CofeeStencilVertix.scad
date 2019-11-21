// Load a 100x100 pixel image.(images will be stretched to fit) Simple, high contrast images work best. Make sure to click the Invert Colors checkbox!
image_file = "c:\\Logo\\symbol_vertix_K_neg_cropped_100x100.png"; // [image_surface100x100]
height = 1.5;
radius = 50;
handle_radius = 10;
image_width = 40;
image_length = 40;


assembly();
module assembly(){
    difference(){
        union(){
               cylinder (r=radius, h=height);
               translate([-50,0,0]) {scale ([2,1,1]) cylinder (r=handle_radius, h=height);}
        }
        scale([(image_width)/100,(image_length)/100,height+1]) surface(file=image_file, center=true);
        
    };
    };