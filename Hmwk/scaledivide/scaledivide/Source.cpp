/*
Dr. Mark E. Lehr
Sept 19th, 2014
Purpose: More efficient technique for calculating a/b and a%b
a/b -> counter contained in r0
a%b -> remainder contained in r1
a -> contained in r2
b -> contained in r3
flag -> r4 to reverse contents of r0 and r1
temp -> r5 temporary memory register for swap
s -> r6 has the present scale 10^
sf -> r7 scale factor = r3*r6 to subtract
factor -> r8 shift factor 10
shift -> r9 Shift test r7*r8
*/
#include <iostream>
using namespace std;

void divMod(int&, int&, int&, int&, int&, int&, int&, int&, int&, int&);
void scale(int&, int&, int&, int&, int&, int&);

int main() {
  // Declare variables a=111, b=5
  int r2 = 22222, r3 = 5, r4 = 0, r5 = 0, r6 = 0, r7 = 0, r8 = 10, r9 = 0, r0 = 0, r1 = r2;
  //Display the result
  cout << "Actual Answer a/b = " << r2 / r3 << endl;
  cout << "Acutal Remainder a%b = " << r2%r3 << endl;
  //Determine the quotient and remainder
  divMod(r2, r3, r4, r5, r6, r7, r8, r9, r0, r1);
  //Display the calculated results
  cout << "Calculated a/b = " << r0 << endl;
  cout << "Calculated a%b = " << r1 << endl;
  //Exit
  return 0;
}

void scale(int &r1, int &r3, int &r8, int &r9, int &r6, int &r7){
  //Until learning to divide/shift this needs to be done
  //on each pass
  r6 = 1;//scale
  r7 = r3*r6;//subtraction factor
  r9 = r7*r8;//next subtraction factor to test
  //Keep shifting scale r6 by 10 
  while (r1>r9){
    r6 *= r8;//scale factor
    r7 = r3*r6;//subtraction factor
    r9 = r7*r8;//next subtraction factor to test
  }
}

//void divMod(int &a,int &b,int &flag,int &q,int &r)
void divMod(int &r2, int &r3, int &r4, int &r5, int &r6,
  int &r7, int &r8, int &r9, int &r0, int &r1){
  //Determine the quotient and remainder
  //Check if the division is even necessary
  if (r1 >= r3){
    //Check the scale r6 by continuously /10 unless r6=0
    do{
      //Until learning to divide/shift this needs to be done
      //on each pass
      scale(r1, r3, r8, r9, r6, r7);
      do{
        r0 += r6;//Increase by scale
        r1 -= r7;//Subtract by b*scale
      } while (r1 >= r7);
    } while (r6>1);
  }
  //Swap if flag is set
  if (r4){ r5 = r0; r0 = r1; r1 = r5; }
}