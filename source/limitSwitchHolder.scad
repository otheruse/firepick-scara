include <configuration.scad>
include <shapes.scad>



module rodClamp(rod_dia = 8) {
    height=8;
    width = rod_dia + 9;
    length=rod_dia + 14;

    support_height=5;
    tol=0.1;
    
    difference() {
        union() {
            // clamp
            translate([-width/2,-length/2,0]) roundedCube(size=[width,length,height]);
            // support
            roundedCylinder(d=rod_dia + 4,h=height+support_height);
        }

        // rod hole
        cylinder(r=rod_dia/2+tol,h=height+support_height+2*tol);

        // clamp space
        translate([(-rod_dia-tol)/2,rod_dia/4,0-tol]) cube(size=[rod_dia+tol,length+tol,height+support_height + 2*tol]);
        translate([-rod_dia,rod_dia/4,height]) cube(size=[rod_dia*2,12/2+tol,support_height+2*tol]);

        // screw hole
        translate([-width/2-tol,rod_dia/2+2,height/2]) rotate([0,90,0]) cylinder(d=m3_dia,h=width+2*tol);
        // nut space
        translate([-width/2-tol,rod_dia/2+2,height/2]) rotate([0,90,0]) rotate([0,0,30]) cylinder(r=m3_dia,h=1.3,$fn=6);
    }
}

module limitSwitchBase() {
    height=8;

    support_height=5;
    tol=0.1;
    
    difference() {
        // plate
        translate([-5,-1,0])roundedCube([10,28,height]);
        // space for back-side electronics
        translate([-5+1.5,7,height-1])roundedCube([7,13,height]);   
        // screw holes
        hull() {
            translate([0,1.5,0])cylinder(d=m3_dia, h=height);
            translate([0,5.5,0])cylinder(d=m3_dia, h=height);
        }
        hull() {
            translate([0,21.5,0])cylinder(d=m3_dia, h=height);
            translate([0,24.5,0])cylinder(d=m3_dia, h=height);
        }
        // nuts
        hull() {
            translate([0,0,0])rotate([0,0,30])cylinder(d=m3_nut_dia, h=m3_nut_height, $fn=6);
            translate([0,26,0])rotate([0,0,30])cylinder(d=m3_nut_dia, h=m3_nut_height, $fn=6);
        }

    }
    // print support
    color([1,0,0,1]) 
    {
        hull() {
            translate([0,3,m3_nut_height])cylinder(d=m3_nut_dia, h=print_layer_height);
        translate([0,23,m3_nut_height])cylinder(d=m3_nut_dia, h=print_layer_height);
        }
    }
}

module limitSwitch() {
    difference() {
        union() {
            translate([1,2,0]) {
                // limit switch
                cube([25.5,6,4.5]);
                translate([6.3,0,0])cube([4.5, 6, 11]);
                translate([13.9,0,0])cube([4.5, 6, 11]);
            }
            //pcb
            cube([36,10,1.5]);
        }
        // screw holes
        translate([3.75,5,-1])cylinder(d=3.3, h=6);
        translate([22.75,5,-1])cylinder(d=3.3, h=6);
    }
}
module limitSwitchHolderL(rod_dia = 8) {
    rotate([0,0,180])rodClamp(rod_dia = rod_dia);
    translate([-5,9,0])difference() {
        roundedCube(size=[10, 7, 8]);
        translate([5,7,0])rotate([0,0,30])cylinder(d=m3_nut_dia,h=m3_nut_height,$fn=6);
        translate([5,7,0])rotate([0,0,30])cylinder(d=m3_dia,h=10);
    }
    translate([0,15,0])limitSwitchBase();
    %rotate([0,0,90])translate([15,-5,8])limitSwitch();
}

module limitSwitchHolderP(rod_dia = 8) {
    rotate([0,0,180])rodClamp(rod_dia = rod_dia);
    translate([-8.5,9,0])difference() {
        roundedCube([17,11,8]);
//        cube(size=[15, 2.5, 8]);
//        translate([5,9,0])rotate([0,0,30])cylinder(r=m3_dia,h=m3_nut_height,$fn=6);
    }
    translate([0,17.5,0]) {
        translate([13,5,0])rotate([0,0,90])limitSwitchBase();
        %translate([-13.5,0,8])limitSwitch();
    }
}


//$fs=0.3;
//$fa=3;
//limitSwitchBase();
//translate([0,20,0])rodClamp(rod_dia = 8);
//limitSwitchHolderP();
//limitSwitch();
//limitSwitchHolderL();
