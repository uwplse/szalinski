

// dice size - length of one side (millimeters)
dice_size = 12.0;

// number of dice across width of tray
dice_per_row = 5; // [1:20]

// number of dice 'deep' per row
dice_row_depth = 2; // [1:10]

// number of rows of dice
dice_rows = 10; // [1:30]

// width of wall (millimeters)
wall_width = 3; // [1:0.1:10]

// depth of engraving
engrave_depth = wall_width / 4;

// width of legend (angled section on top)
legend_width = dice_size*0.7;

// added extra space on sides (millimeters) - in case it's too tight
side_fudge = 0.0; // [0:0.01:5]

// *************************************************************
/* [Hidden] */


engrave_box_offset = engrave_depth/sqrt(2);

$fn = 64;

module legend() {
    text_size = legend_width/3;
   // union()
   difference() 
    {
        cube( [ dice_size *dice_rows,   wall_width,  legend_width ] );

        // decorate legend rows
        for ( row = [ 0:dice_rows ] ) {
            row_edge_x = row * dice_size;

            translate( [row_edge_x, 0, 0 ] ) {
                    translate( [0, -(engrave_depth/sqrt(2)), 0] )  {
                            // cut line
                            rotate( [ 0, 0, 45 ] ) {
                                cube( [engrave_depth,engrave_depth,legend_width] );
                            }
                            // add text (dice count)
                            translate( [ -engrave_box_offset-text_size*0.14, engrave_depth, legend_width*0.5 ] ) {
                                rotate( [90, -90, 0 ] )
                                    linear_extrude( height=engrave_depth, convexity = 10 ) {
                                    text( str( row * dice_per_row * dice_row_depth ), 
                                            size=text_size ,
                                            halign="center",
                                            valign="bottom"
                                        );
                                }
                            }
                        }
                }
        }
    }
}

function bit_set(b, n) = floor(n / pow(2, b)) % 2;


module dice_grid_corner( dice ) {
    
    lip_length = max( wall_width*2, wall_width + side_fudge*1.01 );
    difference() 
    //union() 
    {
        union() {
            cube( [dice_size * dice, wall_width, lip_length]  );
            cube( [dice_size * dice, lip_length, wall_width]  );
        }
    
        for ( d = [ 0:dice ] ) {
                row_edge_x = d * dice_size;
                translate( [row_edge_x, 0, 0 ]  ) {
                       translate( [0,0,wall_width-engrave_box_offset] ) {
                            rotate( [ 0, -45, 0 ] ) {
                                cube( [engrave_depth, lip_length, engrave_depth] );
                            }
                            rotate( [ -45, 0, 0 ] ) {
                              //  cube( [wall_width*2,engrave_depth, engrave_depth] );
                            }
                        }
                       translate( [-engrave_box_offset, wall_width, wall_width] ) {
                            rotate( [  0, 0, -45 ] ) {
                               cube( [engrave_depth, engrave_depth, lip_length] );
                            }
                        }
                }
            } 
        }
}

module dice_grid( rows, columns, with_corner = 0 ) {
    echo( "dice_grid ", rows ,  columns ,  with_corner );
    translate( [0,0,-wall_width] )  {
        //union()
        difference() 
        {
            union() {
                cube( [ dice_size *rows,  dice_size * columns, wall_width ] );
                if( bit_set(0, with_corner) ) {
                    echo( "adding bottom corner" );
                        translate( [0,-wall_width,0] ) {
                            dice_grid_corner( rows );
                        }
                }
                if( bit_set(1,with_corner ) ) {
                        echo( "adding left corner" );
                        rotate( [90,0,90] ) {
                            translate( [0,0,-wall_width-engrave_box_offset-side_fudge] ) {
                                dice_grid_corner( columns );
                            }
                        }
                }
                if( bit_set(2,with_corner ) ) {
                        echo( "adding right corner" );
                        translate( [dice_size *rows+wall_width+side_fudge,dice_size *columns, 0] ) {
                            rotate( [90,0,-90] ) {
                                dice_grid_corner( columns );
                            }
                            //cube( [ wall_width, dice_size * columns,wall_width*2]  );
                            //cube( [wall_width*2,dice_size * columns,  wall_width]  );
                        }
                }

            }
            union() {
                // cut column lines
                for( layer = [ 0:columns ] ) {
                    translate( [ 0, dice_size * layer,wall_width] ) {
                        rotate( [ -45, 0,0] ) {
                            cube( [  dice_size * rows, engrave_depth, engrave_depth ] );
                        }
                    }
                }
                
                // cut lines on side wall
                for ( row = [ 0:rows ] ) {
                    row_edge_x = row * dice_size;
                    translate( [row_edge_x, 0, wall_width-engrave_box_offset ] ) {
                        rotate( [ 0, -45, 0 ] ) {
                            cube( [engrave_depth,dice_size*columns,engrave_depth] );
                        }
                    }
                } 
            }
        }
    }
}

module side() {
    dice_grid( dice_rows, dice_row_depth, 1 );
}

module sides() {
    legend_extra = legend_width*sin(45);
    lip_size = dice_size * dice_row_depth;
    union() {
        // right side
        translate( [0,dice_size * dice_per_row+side_fudge,0] ) {
            rotate( [ 90,0,0] ) {
                side();
                translate( [0,dice_size * dice_row_depth,0] ) {
                    rotate( [-135,0,0] ) {
                        legend();
                    }
                }
                    translate( [ 
                dice_size *dice_rows,  0, -wall_width ] ) {
                    linear_extrude(height = wall_width) {
                        polygon( points = [
                                    [0,0], 
                                    [0,lip_size],
                                    [lip_size,0]
                        ] );
                    }
                }
            }
        }
        // left side
        translate( [dice_size * dice_rows,-side_fudge, 0] ) {
            rotate( [-90,180,0] ) {
                side();
                    translate( [ 0,  0, -wall_width ] ) {
                        linear_extrude(height = wall_width) {
                            polygon( points = [
                                    [0,0], 
                                    [0,lip_size],
                                    [-lip_size,0]
                        ] );
                    }
                }
            }
        }
        translate( [0,-legend_extra-side_fudge,dice_size * dice_row_depth + legend_extra] ) {
            rotate( [-135,0,0] ) {
                legend();
            }
        }
        
        
        // bottom lip
        translate( [dice_size * dice_rows,-side_fudge -wall_width, -wall_width] ) {
            cube( [ lip_size, dice_size * dice_per_row + (side_fudge+wall_width)*2, wall_width ] );
        }
        
        // end
        translate( [0, engrave_box_offset, 0] ) {
             rotate( [0,0,90] ) {
                rotate( [90,0,0] ) {
                        dice_grid(  dice_per_row, dice_row_depth, 7 );
                        translate(  [-legend_extra-engrave_box_offset,dice_row_depth * dice_size,-wall_width] ) {
                            cube( [ dice_per_row *dice_size+legend_extra*2, legend_extra,wall_width] );
                        }
                    }
                }
         }
    }
}
    



sides();
dice_grid( dice_rows, dice_per_row );
