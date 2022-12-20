#include <iostream>

const int MAX_LENGTH = 5000;

long original_numbers[MAX_LENGTH];
long numbers[MAX_LENGTH];
int indexes[MAX_LENGTH];
int length;

void load_numbers() {
  long n;
  length = 0;

  while(std::cin >> n) {
    original_numbers[length] = n;
    length++;
  }
}

void encrypt_numbers(long encryption_key) {
  for(int i=0; i<length; i++) {
    numbers[i] = original_numbers[i] * encryption_key;
    indexes[i] = i;
  }
}

void swap(int idx1, int idx2) {
  idx1 %= length;
  idx2 %= length;

  if(idx1 < 0) idx1 += length;
  if(idx2 < 0) idx2 += length;

  int tmp_idx = indexes[idx1 % length];
  indexes[idx1 % length] = indexes[idx2 % length];
  indexes[idx2 % length] = tmp_idx;

  long tmp_number = numbers[idx1 % length];
  numbers[idx1 % length] = numbers[idx2 % length];
  numbers[idx2 % length] = tmp_number;
}

void move(int original_idx) {
  int idx = 0;
  while(indexes[idx] != original_idx) {
    idx++;
  }

  long number = numbers[idx];
  int d = 0;
  if(number > 0) {
    d = 1;
  } else {
    d = -1;
  }

  long moves = abs(number);
  while(moves > length) {
    long p = moves / length;
    long q = moves % length;

    moves = p + q;
  }

  for(int i=0; i<moves; i++) {
    int next_idx = idx + d;
    swap(idx, next_idx);
    idx = next_idx;
  }
}

int index_of_0() {
  int idx = 0;

  while(numbers[idx] != 0) {
    idx++;
  }

  return idx;
}

long part(long encryption_key, int rounds) {
  encrypt_numbers(encryption_key);

  for(int r=0; r<rounds; r++) {
    for(int i=0; i<length; i++) {
      move(i);
    }
  }

  long res = 0;
  int idx02 = index_of_0();
  for(int i=1000; i<=3000; i += 1000) {
    res += numbers[(idx02 + i) % length];
  }

  return res;
}

long part1() {
  return part(1, 1);
}

long part2() {
  return part(811589153, 10);
}

int main() {
  load_numbers();

  std::cout << part1() << std::endl;
  std::cout << part2() << std::endl;

  return 0;
}
