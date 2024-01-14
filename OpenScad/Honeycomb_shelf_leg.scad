/**
 * Customisable Honeycomb Shelf Legs
 * License: Creative Commons - Attribution
 * Author: https://www.printables.com/@samster395
 * URL: https://www.printables.com/model/713986
 */

depth = 185; // Shelf Depth
height = 180; // Bottom of shelf height, total height will be this + shelf thickness + wall thickness
thickness = 20; // Leg Thickness
wallthick = 2; // Wall Thickness
gaph = 16; // Shelf Thickness
hexdia = 30; // Hexagon Diameter, lower for more hexagons
screw_holes = true;
screwdia = 4; // Screw Diameter

difference() {

linear_extrude(thickness) {
	honeycomb(depth, height, hexdia, wallthick);
    
    square([depth,wallthick]); // Bottom Wall
    
    rotate(90) // Left Wall
        square([height + wallthick + gaph, wallthick]);
    
    translate([0,height - wallthick,0]) // Shelf Support Wall
        square([depth,wallthick]);
    
    translate([0,height + gaph,0]) // Top Wall
        square([depth,wallthick]);
    
    translate([depth+wallthick,0,0]) // Right Wall
        rotate(90) 
            square([height + wallthick + gaph, wallthick]);
}

render(convexity = 2){ // Fixes issues with preview

if (screw_holes){
    translate([depth / 4 * 3,height + gaph + 5,thickness / 2])
        rotate ([90,0,0])
                cylinder (h = 10, r=screwdia / 2, center = false, $fn=100);
    
    translate([depth / 4 * 1,height + gaph + 5,thickness / 2])
        rotate ([90,0,0])
                cylinder (h = 10, r=screwdia / 2, center = false, $fn=100);
}

}

}

/**
 * Honeycomb library
 * License: Creative Commons - Attribution
 * Copyright: Gael Lafond 2017
 * URL: https://www.thingiverse.com/thing:2484395
 *
 * Inspired from:
 *   https://www.thingiverse.com/thing:1763704
 */

// a single filled hexagon
module hexagon(l)  {
	circle(d=l, $fn=6);
}

// parametric honeycomb  
module honeycomb(x, y, dia, wall)  {
	// Diagram
	//          ______     ___
	//         /     /\     |
	//        / dia /  \    | smallDia
	//       /     /    \  _|_
	//       \          /   ____ 
	//        \        /   / 
	//     ___ \______/   / 
	// wall |            /
	//     _|_  ______   \
	//         /      \   \
	//        /        \   \
	//                 |---|
	//                   projWall
	//
	smallDia = dia * cos(30);
	projWall = wall * cos(30);

	yStep = smallDia + wall;
	xStep = dia*3/2 + projWall*2;

	difference()  {
		square([x, y]);

		// Note, number of step+1 to ensure the whole surface is covered
		for (yOffset = [0:yStep:y+yStep], xOffset = [0:xStep:x+xStep]) {
			translate([xOffset, yOffset]) {
				hexagon(dia);
			}
			translate([xOffset + dia*3/4 + projWall, yOffset + (smallDia+wall)/2]) {
				hexagon(dia);
			}
		}
	}
}