// u clip by stephan hafiz
ClipInnerWidth = 34;
ClipInnerHight = 30;
ClipThikiness = 5;
ClipHigh = 20;

color ("red") linear_extrude (ClipHigh)
polygon(points=[[0,0],[ClipThikiness-ClipThikiness/10,0],[ClipThikiness,ClipThikiness],
		[ClipThikiness,ClipInnerHight],[ClipThikiness+ClipInnerWidth,ClipInnerHight],[ClipThikiness+ClipInnerWidth,ClipThikiness],[ClipThikiness+ClipInnerWidth+ClipThikiness/10,0],
		[ClipThikiness+ClipInnerWidth+ClipThikiness,0], [ClipThikiness+ClipInnerWidth+ClipThikiness,ClipInnerHight+ClipThikiness],[0,ClipInnerHight+ClipThikiness]
	     ]);