
List<int> convertWeekdaysToNumbers(List<String> weekdays) {
  Map<String, int> weekdayMapping = {
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6,
    'Sunday': 7,
  };

  return weekdays.map((weekday) => weekdayMapping[weekday]!).toList();
}

int findNearestValidDay(List<int> availableDays, int today) {
  Iterable<int> filteredNumbers =
      availableDays.where((number) => number >= today);
  List<int> sortedNumbers = filteredNumbers.toList()..sort();
  // If there are no numbers greater than or equal to p, return null
  if (sortedNumbers.isEmpty) {
    int minDay = findMinimum(availableDays);
    minDay = 6 - (2 * today);
    print(minDay);
    print("got here");
    return minDay;
  }
  // Find the nearest number to p
  int nearestNumber = sortedNumbers.first;
  for (int number in sortedNumbers) {
    if ((number - today) < (nearestNumber - today)) {
      nearestNumber = number;
    } else {
      // As the numbers are sorted, if the difference increases, we can break the loop
      break;
    }
  }

  return nearestNumber;
}

int findMinimum(List<int> numbers) {
  if (numbers.isEmpty) {
    throw ArgumentError('The list cannot be empty.');
  }

  int minimum = numbers.first;
  for (int number in numbers) {
    if (number < minimum) {
      minimum = number;
    }
  }

  return minimum;
}
