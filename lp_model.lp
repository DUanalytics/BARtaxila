/* Maximize Number Of Users */

/* Objective function */
max: +0.004 Adword +0.005 Facebook +0.0067 Email +0.01 Affiliated;

/* Constraints */
facebook&Adword: +Adword +Facebook <= 600000;
total budget: +Adword +Facebook +Email +Affiliated <= 1000000;
LTV: +4 Adword +1.5 Facebook -1.33 Email -4 Affiliated >= 0;

/* Variable bounds */
Adword >= 250000;
Facebook >= 200000;
Email >= 75000;
Affiliated >= 50000;
