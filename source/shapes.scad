
// 2D basic shapes
module inverseQuarterCircle(r) {
    difference() {
        square([2*r,2*r]);
        translate([r,r])circle(r=r);
        translate([r,0])square([r,2*r]);
        translate([0,r])square([2*r,r]);
    }
}


module catenary(length=100, width=5, a = 25, step=1) {
    function f(x) = width-(a*cosh(x/length)-a);
    for (i = [-length/2 + step : step : length/2]) {
        //echo("i = ", i, " f(i) = ", f(i));
        polygon([[i-step,0],[i,0],[i,f(i)],[i-step,f(i-step)]]);
    }
}

module trapezoid(base, top, h) {
    polygon([[0,-base/2],[0,base/2],[h,top/2],[h,-top/2]]);
}

module arc(w=1, r, angle) {
    difference() {
        circle(r=r+w/2);
        circle(r=r-w/2);
        rotate(angle/2)translate([-r-w/2,0])square([r*2+w,r*2+w]);
        rotate(180-angle/2)translate([-r-w/2,0])square([r*2+w,r*2+w]);
    }
}

module wedge(r, angle) {
    difference() {
        circle(r=r);
        rotate(angle/2)translate([-r,0])square([r*2,r*2]);
        rotate(180-angle/2)translate([-r,0])square([r*2,r*2]);
    }
}

// 3D basic shapes

module roundedCube(size = [10,10,10],radius=1) {
    hull() {
        // bottom
        translate([size[0]-radius,size[1]-radius,radius])sphere(r=radius,center=true);
        translate([size[0]-radius,radius,radius])sphere(r=radius,center=true);
        translate([radius,size[1]-radius,radius])sphere(r=radius,center=true);
        translate([radius,radius,radius])sphere(r=radius,center=true);
        // top
        translate([size[0]-radius,size[1]-radius,size[2]-radius])sphere(r=radius,center=true);
        translate([size[0]-radius,radius,size[2]-radius])sphere(r=radius,center=true);
        translate([radius,size[1]-radius,size[2]-radius])sphere(r=radius,center=true);
        translate([radius,radius,size[2]-radius])sphere(r=radius,center=true);

    }
}

module roundedCylinder(d, h,rr=1, fn=$fn) {
    translate([0,0,rr])minkowski() {
        cylinder(d=d-2*rr, h=h-2*rr, $fn=fn);
        sphere(r=rr, center = true);
    }
}

module roundedBox(size = [1,1,1],radius=1) {
    hull() {
        translate([size[0]-radius,size[1]-radius,size[2]/2])cylinder(r=radius,h=size[2],center=true);
        translate([size[0]-radius,radius,size[2]/2])cylinder(r=radius,h=size[2],center=true);
        translate([radius,size[1]-radius,size[2]/2])cylinder(r=radius,h=size[2],center=true);
        translate([radius,radius,size[2]/2])cylinder(r=radius,h=size[2],center=true);
    }
}

