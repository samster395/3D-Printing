/* [General Settings] */

// Inner width in mm
innerWidth = 46;

// Strap width in mm, defines height of mount
strapWidth = 25;

// Strap thickness of the left Strap in mm
strap1Thickness = 0.5;
// Strap thickness of the right Strap in mm
strap2Thickness = 0.5;

// Size of the left opening in mm
opening1 = 4;
// Size of the right opening in mm
opening2 = 4;

// Share of height (may look odd with very small or very big values)
opening1Position = 0.8; // [0:0.01:1]
opening2Position = 0.8; // [0:0.01:1]

// Clip depth in mm
depth = 4;
// Enable Text
text = true;
textLine1 = "BIFFY";
textLine2 = "CLYRO";
textLine3 = "";
// Defines how far text is from left
textMargin = 18; // Left side text margin
// Font Size
fontSize = 5;
// Enable SVG
svg = false;
svg_file = "sign-of-the-horns.svg";
// SVG Scale
svgScale = 0.1;// [0:0.01:1]
// SVG Location
svgLocation = [7, 6, 0];
// [17.5, 0, 0] middle

/* [Print settings] */

// Wall thickness of the clip in mm
thickness = 3;

// Imprecision margin in mm
margin = 1;

// Start with a small value to preview, increase just before rendering
resolution = 15;

/* [Hidden] */
$fn = resolution;
strapHoleHeight = strapWidth * margin;
strapHole1Width = strap1Thickness * margin + thickness;
strapHole2Width = strap2Thickness * margin + thickness;
innerHeight = strapWidth + 2 * margin;
outerWidth = innerWidth + strapHole1Width + strapHole2Width + (thickness * 2);
outerHeight = thickness + innerHeight;

echo (textMargin);

use <stencilla.ttf>

Ymiddle = outerHeight / 2;
Xmiddle = outerWidth / 2;

//echo (Xmiddle);

difference(){

    makeouter();
    render(convexity = 2){ // Fixes issues with preview
    if(text){
    linear_extrude(4){
        translate([textMargin, Ymiddle + 8 - (fontSize/2), 0]) {
            text(textLine1, fontSize, font = "stencilla");
        }
        translate([textMargin,Ymiddle - (fontSize/2) , 0]) {
            text(textLine2, fontSize, font = "stencilla");
        }
        translate([textMargin, Ymiddle - 8 - (fontSize/2), 0]) {
            text(textLine3, fontSize, font = "stencilla");
        }
    }
    }
    if(svg){
        translate(svgLocation) {
            svg(4);
        }
    }
    }
}

module svg(height) {
    linear_extrude(height = height) {
        scale(svgScale)
        import(svg_file);
    }
}

module makeouter() {
	strap2Thickness =   strap2Thickness == 0 ? strap1Thickness : strap2Thickness;
	opening2 = opening2 == 0 ? opening1 : opening2;
	
	opening1Height = opening1 * margin;
	opening2Height = opening2 * margin;
	
	placeOpening1 = thickness + (innerHeight - opening1Height) * (1 - opening1Position);
	placeOpening2 = thickness + (innerHeight - opening2Height) * (1 - opening2Position);

	difference() {
		difference() {
			cube([outerWidth, outerHeight, depth]);
			union() {
				//translate([-thickness/2,0,0]) {
					//vRoundPlus(outerHeight, depth, thickness);
				//}
				//translate([outerWidth + thickness/2,0,0]) {
					//mirror([1,0,0]) {
					//	vRoundPlus(outerHeight, depth, thickness);
					//}
				//}
				//hRoundPlus(outerWidth, depth, thickness);
				//translate([0,outerHeight,0]) {
					//mirror([0,1,0]) {
					//	hRoundPlus(outerWidth, depth, thickness);
					//}
				//}
				translate([thickness/2,thickness/2,0]) {
					cutEdge(depth, thickness,180);
				}
				translate([outerWidth - thickness/2,thickness/2,0]) {
					cutEdge(depth, thickness,270);
				}
				translate([outerWidth - thickness/2,outerHeight - thickness/2,0]) {
					cutEdge(depth, thickness,0);
				}
				translate([thickness/2,outerHeight - thickness/2,0]) {
					cutEdge(depth, thickness,90);
				}
			}				
		}
		union() {
			translate([thickness,thickness - 0.5,0]) {
				strapHole(strapHole1Width, strapHoleHeight, depth, thickness);
			}
			translate([outerWidth - strapHole2Width - thickness,thickness - 0.5,0]) {
				strapHole(strapHole2Width, strapHoleHeight, depth, thickness);
			}
			makeOpenings(outerHeight, outerWidth, placeOpening1, placeOpening2, opening1, opening2, opening1Height, opening2Height, depth, thickness);
		}
	}
}

module strapHole(strapHoleWidth, strapHoleHeight, depth, thickness) {
	
	translate([0, 0, -1]) {
		difference() {
			//cube([strapHoleWidth, strapHoleHeight, depth + 2]);
            roundedcube([strapHoleWidth, strapHoleHeight, depth + 2], false, 2, "z");
			union() {
				vRoundMinus(strapHoleHeight, depth, thickness);
				translate([strapHoleWidth,0,0]) {
					vRoundMinus(strapHoleHeight, depth, thickness);
				}
				hRoundMinus(strapHoleWidth, depth, thickness);
				translate([0,strapHoleHeight,0]) {
					hRoundMinus(strapHoleWidth, depth, thickness);
				}
			}
		}
	}
}

module opening(opening, openingHeight, depth, thickness) {
	
	translate([-1, -thickness/2, -1]) {
		difference() {
			cube([thickness + 2, openingHeight + thickness, depth + 2]);
			translate([thickness/2 + 1,0,1]) {
				pillar(depth, thickness);
				translate([0,openingHeight + thickness,0]) {
					pillar(depth, thickness);
				}
			}
		}
	}
}

module makeOpenings(outerHeight, outerWidth, placeOpening1, placeOpening2, opening1, opening2, opening1Height, opening2Height, depth, thickness) {
	difference() {
		union() {
			translate([0,placeOpening1,0]) {
				opening(opening1, opening1Height, depth, thickness);
			}
			translate([outerWidth - thickness,placeOpening2,0]) {
				opening(opening2, opening2Height, depth, thickness);
			}
		}
		translate([thickness/2,-1,-2]) {
			cube([outerWidth - thickness,thickness + 1,depth + 4]);
		}
		translate([thickness/2,outerHeight - thickness,-2]) {
			cube([outerWidth - thickness,thickness + 1,depth + 4]);
		}
	}
}

module vRoundPlus(y, z, thickness) {
	translate([-1,-1,-1]) {
		difference() {
			cube([thickness + 1, y + 2, z + 2]);
			translate([thickness + 1,0,thickness/2 + 1]) {
				rotate([-90,0,0]) {
					cylinder(d=thickness, h=y + 2);
				}
			}
			translate([thickness + 1,0,depth + 1 - thickness/2]) {
				rotate([-90,0,0]) {
					cylinder(d=thickness, h=y + 2);
				}
			}
			translate([thickness/2 + 1,0,thickness/2 + 1]) {
				cube([thickness/2,y + 2,z - thickness]);
			}
		}
	}
}

module hRoundPlus(x, z, thickness) {
	translate([-1,-thickness/2 -1,-1]) {
		difference() {
			cube([x + 2, thickness + 1, z + 2]);
			translate([0,thickness + 1,thickness/2 + 1]) {
				rotate([0,90,0]) {
					cylinder(d=thickness, h=x + 2);
				}
			}
			translate([0,thickness + 1,depth + 1 - thickness/2]) {
				rotate([0,90,0]) {
					cylinder(d=thickness, h=x + 2);
				}
			}
			translate([0,thickness/2 + 1,thickness/2 + 1]) {
				cube([x + 2, thickness/2,z - thickness]);
			}
		}
	}
}

module vRoundMinus(y, z, thickness) {
	translate([0,-1,thickness/2 + 1]) {
		rotate([-90,0,0]) {
			//cylinder(d=thickness, h=y + 2);
		}
	}
	translate([0,-1,depth + 1 - thickness/2]) {
		rotate([-90,0,0]) {
			//cylinder(d=thickness, h=y + 2);
		}
	}
	translate([-thickness/2,-1,thickness/2 + 1]) {
		//cube([thickness,y + 2,z - thickness]);
	}
}

module hRoundMinus(x, z, thickness) {
	translate([-1,0,thickness/2 + 1]) {
		rotate([0,90,0]) {
			//cylinder(d=thickness, h=x + 2);
		}
	}
	translate([-1,0,depth + 1 - thickness/2]) {
		rotate([0,90,0]) {
			//cylinder(d=thickness, h=x + 2);
		}
	}
	translate([-1,-thickness/2,thickness/2 + 1]) {
		//cube([x + 2,thickness,z - thickness]);
	}
}

module cutEdge(depth, thickness, rotation) {
	rotate([0,0,rotation]) {
		difference() {
			translate([0,0,-1]) {
				cube([thickness,thickness,depth+2]);
			}
			pillar(depth, thickness);
		}
	}
}

module pillar(depth, thickness) {
	union() {
		translate([0,0,0]) {
			cylinder(d=thickness, h=depth);
			//sphere(d=thickness);
		}
		//translate([0,0,depth-thickness/2]) {
			//sphere(d=thickness);
		//}
	}
}

// Taken from here: https://gist.github.com/groovenectar/92174cb1c98c1089347e & https://danielupshaw.com/openscad-rounded-corners/
module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}