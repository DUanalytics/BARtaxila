/* Objective function */
max: ;

/* Constraints */
Milk: +Chocolate-A +Chocolate-B <= 5;
Choco: +3 Chocolate-A +2 Chocolate-B <= 12;

/* Integer definitions */
int Chocolate-A,Chocolate-B;
