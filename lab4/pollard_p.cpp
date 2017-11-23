#include <iostream>
#include <fstream>
#include <functional>
#include <vector>
#include <algorithm>
#include <assert.h>

using namespace std;

inline long long gcd(long long a, long long b) {
  if(!b) return a;
  return gcd(b, a % b);
}

long long solve(long long n, function<long long(long long)>f) {
  long long x_i = 2;
  long long x_2i = f(f(2));
  for(int i = 0; ; ++ i) {
    x_i = f(x_i);
    x_2i = f(f(x_2i));
    long long d = gcd(x_2i - x_i, n);
    if (d > 1 && d < n) {
      return d;
    } else  if(d == n) {
      cerr << "Failure, please try again other function or start point.";
      return -1;
    }
  }
  assert(false); ///should not come this far
}

inline void runTests() {
  const int T = 100;
  srand(time(NULL));
  for(int i = 0; i < T; ++ i) {
    cerr << "Running test #" << i + 1 << "\n";
    long long x = 1LL * rand() * rand();
    cerr << "Factorizing " << x << '\n';
    long long p = solve(x, [](long long x)->long long{return x*x+x+1;});
    assert(p == -1 || x % p == 0);
  }
  cout << "All tests have passed!\n";
}


int main(int argv, char *args[]) {
//  runTests();
  long long  n = 4087;
  string filename = "input.in";
  if(argv > 1) {
    filename = args[1];
  }
  ifstream fin(filename);
  cerr << filename << '\n';
  fin >> n;
  cerr << n << '\n';
  long long prime = solve(n, [](long long x)->long long{return x*x+x+1;});
  cerr << prime << ' ' << n / prime;
  return 0;
}
