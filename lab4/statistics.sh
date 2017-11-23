echo "Compiling classic"
g++ -O2 -std=c++11 -pthread -Dhome -Wall classic.cpp -o classic.o
echo "Compiling pollard_p"
g++ -O2 -std=c++11 -pthread -Dhome -Wall pollard_p.cpp -o pollard_p.o

for i in `ls tests`; do
  echo "running test on classic "$i
  time ./classic.o 'tests/'$i
  echo "running test on pollard "$i
  time ./pollard_p.o 'tests/'$i
done

rm classic.o
rm pollard_p.o
