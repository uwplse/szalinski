x_value = 10;

y_value = 5;

linear_extrude(height = 1) polygon([[0,0],[x_value,0],[x_value,y_value],[0,y_value]],[[0,1,2,3]]);