// preview[view:north, tilt:top]

/* [Table] */
// How thick is your table plate?
table_thickness = 27; // [5:50]

/* [Headphone] */
// How height is your Headphones bracket?
headphone_height = 4.5;
// How width is your Headphones bracket?
headphone_widht = 34;

/* [Hidden] */
holder_width = 25;
holder_thikness = 5.5;
holder_lenght = 40;

// Print HeadPhone Holder
HeadPholeHolder();

module HeadPholeHolder(){
    linear_extrude(height = holder_width){
        HeadPholeHolderSideView();
    }
}

module HeadPholeHolderSideView(){
    difference(){
        square ([holder_lenght, holder_thikness * 2 + table_thickness]);
        translate([0, holder_thikness])
            square ([holder_lenght, table_thickness]);
    }
    difference(){
        translate([holder_lenght, 0]){
            square([holder_thikness, holder_thikness * 2 + table_thickness]);
            square([holder_thikness * 2 + headphone_widht, headphone_height + holder_thikness]);
        }
        translate([holder_lenght + holder_thikness, 0]){
            square([headphone_widht, headphone_height]);
        }
    }
    polygon(points=[[holder_lenght + holder_thikness, headphone_height + holder_thikness], 
        [holder_lenght + 2 * holder_thikness + headphone_widht, headphone_height + holder_thikness], 
        [holder_lenght + holder_thikness, holder_thikness * 2 + table_thickness]]);
}