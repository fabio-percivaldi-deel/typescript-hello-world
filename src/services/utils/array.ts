/**
 * This function returns all possible combinations of an array.
 *
 * Use carefully, this can be a very expensive operation.
 * O(m^n) where n is the length of the array.
 *
 * Source: https://web.archive.org/web/20140418004051/http://dzone.com/snippets/calculate-all-combinations
 * */
export function combinationGenerator<T>(a: T[], min: number, max: number): T[][] {
  const fn = function (n: number, src: T[], got: T[], all: T[][]) {
    if (n == 0) {
      if (got.length > 0) {
        all[all.length] = got;
      }
      return;
    }
    for (let j = 0; j < src.length; j++) {
      fn(n - 1, src.slice(j + 1), got.concat([src[j]]), all);
    }
    return;
  };

  const all: T[][] = [];
  for (let i = min; i <= max; i++) {
    fn(i, a, [], all);
  }
  return all;
}

export function getCombinationsOfLength<T>(a: T[], length: number): T[][] {
  return combinationGenerator(a, length, length);
}

export function getAllCombinations<T>(a: T[], min = 1): T[][] {
  return combinationGenerator(a, min, a.length);
}

export function minOf<T>(array: T[], property: keyof T): T {
  return array.reduce((min, el) => {
    return el[property] < min[property] ? el : min;
  }, array[0]);
}
