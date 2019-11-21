//testText = ["Feature me", "Thingiverse"];
testText = ["All human beings are born", "free and equal in dignity and", "rights. They are endowed with", "reason and conscience and", "should act towards one another", "in a spirit of brotherhood."];

dotRadius = 0.5;
charWidth = 3.5;
resolution = 10;
lineHeight = 12;
totalHeight = length(testText)*lineHeight;
//slabX = 50;
slabX = 110;
slabY = totalHeight;

module drawDot(location, dotRadius = 0.5, resolution = 10) {
	translate(location) {
		difference() {
			sphere(dotRadius, $fn = resolution);
			translate([0, 0, -dotRadius])
				cube(dotRadius*2, true);
		}
	}
}

module drawCharacter(charMap, dotRadius = 0.5, resolution = 10) {
	for(i = [0: length(charMap)-1]) {
		drawDot([floor((charMap[i]-1)/3)*dotRadius*3, -(charMap[i]-1)%3*dotRadius*3, 0]);
	}
}

charKeys = ["a", "A", "b", "B", "c", "C", "d", "D", "e", "E", "f", "F", "g", "G", "h", "H", "i", "I", "j", "J", "k", "K", "l", "L", "m", "M", "n", "N", "o", "O", "p", "P", "q", "Q", "r", "R", "s", "S", "t", "T", "u", "U", "v", "V", "w", "W", "x", "X", "y", "Y", "z", "Z", ",", ";", ":", ".", "!", "(", ")", "?", "\"", "*", "'", "-"];
charValues = [[1], [1], [1, 2], [1, 2], [1, 4], [1, 4], [1, 4, 5], [1, 4, 5], [1, 5], [1, 5], [1, 2, 4], [1, 2, 4], [1, 2, 4, 5], [1, 2, 4, 5], [1, 2, 5], [1, 2, 5], [2, 4], [2, 4], [2, 4, 5], [2, 4, 5], [1, 3], [1, 3], [1, 2, 3], [1, 2, 3], [1, 3, 4], [1, 3, 4], [1, 3, 4, 5], [1, 3, 4, 5], [1, 3, 5], [1, 3, 5], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [1, 2, 3, 5], [1, 2, 3, 5], [2, 3, 4], [2, 3, 4], [2, 3, 4, 5], [2, 3, 4, 5], [1, 3, 6], [1, 3, 6], [1, 2, 3, 6], [1, 2, 3, 6], [2, 4, 5, 6], [2, 4, 5, 6], [1, 3, 4, 6], [1, 3, 4, 6], [1, 3, 4, 5, 6], [1, 3, 4, 5, 6], [1, 3, 5, 6], [1, 3, 5, 6], [2], [2, 3], [2, 5], [2, 5, 6], [2, 3, 5], [2, 3, 5, 6], [2, 3, 5, 6], [2, 3, 6], [2, 3, 6], [3, 5], [3], [3, 6]];

module drawText(text, dotRadius = 0.5, charWidth = 3.5, resolution = 10) {
	for(i = [0: length(text)-1]) {
		translate([charWidth*i, 0, 0]) {
			for(j = [0:length(charKeys)]) {
				if(charKeys[j] == text[i]) {
					drawCharacter(charValues[j], dotRadius = 0.5, resolution = 10);
				}
			}
		}
	}
}

translate([0, lineHeight/3, 0])
	cube([slabX, slabY, 1], true);
translate([0, 0, 1]) {
	for(i = [0: length(testText)]) {
		translate([-length(testText[i])*charWidth/2, totalHeight/2-lineHeight*i, 0])
			drawText(testText[i], dotRadius = dotRadius, charWidth = charWidth, resolution = resolution);
	}
}