//Joshua Camacho
//CSC 11 midterm C solutions

#include <iostream>
#include <iomanip>

using namespace std;

void mainMenu();
void problem1();
void problem2();
void problem3();

int main(){
  mainMenu();
  cin.ignore();
  cin.get();
  return 0;
}

void mainMenu(){
  short probnum;
  cout << "         Main Menu" << endl;
  cout << "---------------------------" << endl;
  cout << "-Problem (1)" << endl << "-Problem (2)" << endl << "-Problem (3)"
    << endl;
  cout << "Type the number of the problem to go to that problem. Type 0 to exit." << endl;
  cin.clear();
  cin >> probnum;//ask user for problem number
  while (probnum<0 || probnum>6){//don't even try a problem that doesn't exsist Dr. Lehr!
    cout << "Dr. Lehr, please. The only valid problem numbers are from 1 to 6." << endl;
    cin.clear();
    cin >> probnum;
  }
  switch (probnum){
  case 0:
    break;
  case 1:problem1();
    break;
  case 2:problem2();
    break;
  case 3:problem3();
    break;
  }
}


void problem1()
{
  //declare inputs and ask for them
  float hours, payRate;
  cout << "How much do your earn per hour?" << endl;
  cout << "$";
  cin >> payRate;
  cout << endl;
  while (payRate <= 0){
    cout << "I'm sure you earn more than that, please enter an amount greater than 0" << endl;
    cin >> payRate;
  }
  cout << "How many hours did you work?" << endl;
  cin >> hours;
  while (hours <= 0){
    cout << "If you worked 0 or less hours, I'm sure you can figure out in your head what you made. Please enter a number of hours greater than 0" << endl;
    cin >> hours;
  }
  //calulate gross pay
  float gross;
  if (hours <= 40){
    gross = hours*payRate;
  }
  else if (hours>40 && hours <= 55){
    gross = (payRate * 40) + ((hours - 40)*payRate * 2);
  }
  else if (hours>55){
    gross = (payRate * 40) + (payRate * 2 * 15) + ((hours - 55)*payRate * 3);
  }
  //display gross pay
  cout << "Your gross pay is $" << fixed << setprecision(2) << gross << endl;

}

void problem2(){
  char input;
  int hours;
  int bill=0;
  cout << "What package do you have? a b or c\n";
  cin >> input;
  cout << "How many hours did you use the internet?";
  cin >> hours;
  switch (input){
  case 'a':
    bill = 30;
    if (hours > 11 && hours <= 22){
      hours -= 11;
      bill += hours * 3;
    }
    else{
      bill += 11 * 3;
      hours -= 22;
      bill += hours * 6;
    }
    break;
  case 'b':
    bill = 35;
    if (hours > 22 && hours <= 44){
      hours -= 22;
      bill += hours * 2;
    }
    else{
      bill += 22 * 2;
      hours -= 44;
      bill += hours * 4;
    }
    break;
  case 'c':
    bill = 40;
    if (hours > 33 && hours <= 66){
      hours -= 33;
      bill += hours * 1;
    }
    else{
      bill += 33 * 1;
      hours -= 33;
      bill += hours * 2;
    }
    break;
  }
  cout << "Your bill $" << bill << "\n";
}

void problem3(){
  int n;
  cout << "Enter fibonacci term\n";
  cin >> n;
  int p = 0;
  int c = 1;
  int r = 0; // The result is initialized to 0 (undefined). 
  for (int i = 0; i < n; i++)
  {
    r = p + c; // Produce next number in the sequence.
    p = c;     // Save previous number.
    c = r;     // Save current number.
  }
  cout << "The term evaluated was " << r;
};