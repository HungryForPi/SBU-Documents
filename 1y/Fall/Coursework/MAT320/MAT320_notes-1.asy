if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="MAT320_notes-1";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

defaultpen(fontsize(10pt));
unitsize(1cm);
size(8cm); // set a reasonable default
usepackage("amsmath");
usepackage("amssymb");
settings.tex="pdflatex";
settings.outformat="pdf";
// Replacement for olympiad+cse5 which is not standard
import geometry;
// recalibrate fill and filldraw for conics
void filldraw(picture pic = currentpicture, conic g, pen fillpen=defaultpen, pen drawpen=defaultpen)
{ filldraw(pic, (path) g, fillpen, drawpen); }
void fill(picture pic = currentpicture, conic g, pen p=defaultpen)
{ filldraw(pic, (path) g, p); }
// some geometry
pair foot(pair P, pair A, pair B) { return foot(triangle(A,B,P).VC); }
pair orthocenter(pair A, pair B, pair C) { return orthocentercenter(A,B,C); }
pair centroid(pair A, pair B, pair C) { return (A+B+C)/3; }
// cse5 abbreviations
path CP(pair P, pair A) { return circle(P, abs(A-P)); }
path CR(pair P, real r) { return circle(P, r); }
pair IP(path p, path q) { return intersectionpoints(p,q)[0]; }
pair OP(path p, path q) { return intersectionpoints(p,q)[1]; }
path Line(pair A, pair B, real a=0.6, real b=a) { return (a*(A-B)+A)--(b*(B-A)+B); }
// cse5 more useful functions
picture CC() {
picture p=rotate(0)*currentpicture;
currentpicture.erase();
return p;
}
pair MP(Label s, pair A, pair B = plain.S, pen p = defaultpen) {
Label L = s;
L.s = "$"+s.s+"$";
label(L, A, B, p);
return A;
}
pair Drawing(Label s = "", pair A, pair B = plain.S, pen p = defaultpen) {
dot(MP(s, A, B, p), p);
return A;
}
path Drawing(path g, pen p = defaultpen, arrowbar ar = None) {
draw(g, p, ar);
return g;
}

unitsize(1.15cm);
draw((1.2,0)..(0,2)..(-1.2,0)..(0,-2)..cycle);
draw((6.2,0)..(5,2)..(3.8,0)..(5,-2)..cycle);
pair x = (0.3,0.5);
filldraw((0.3,0.08)..(0.6,0.2)..(0.72,0.37)..(0.3,1.5)..(-0.6,1.3)..(-0.4,0.2)..cycle,green+opacity(0.2),dashed);
filldraw(circle(x,0.35),red+opacity(0.3),dashed);
dot("$x$", x, dir(90));
pair fx = (4.8, -.3);
filldraw(circle(fx,0.7),green+opacity(0.2),dashed);
filldraw((5.1,-.34)..(4.8,-0.1)..(4.5,0.2)..(4.4,-0.2)..(5.2,-0.7)..cycle,red+opacity(0.3),dashed);
dot("$f(x)$", fx, dir(90),fontsize(9));
draw((0.7,0.5)..(2.5,0.3)..(4.3,-0.2),EndArrow(5));

label("$B_X(x,\delta)$",x+(0,0.3),dir(100),fontsize(7.5));
label("$B_Y(f(x),\varepsilon)$",fx-(0,0.7),dir(-80),fontsize(7.5));
label("$f^{-1}(U)$",(0,2),dir(90),fontsize(11));
label("$U$",(5,2),dir(90),fontsize(11));
label("$f$",(2.5,0.3),dir(90));
label("$f^{-1}$",(2.5,0.15),dir(-90));

draw((0.8,0.35)..(2.5,0.15)..(4.05,-0.28),BeginArrow(5));
label("$f^{-1}(B_Y(f(x),\varepsilon))$",(0,0.1),dir(-90),fontsize(7.5));
