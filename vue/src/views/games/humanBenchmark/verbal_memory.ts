import verbal_memory_words from './words.json'
import verbal_memory_paths from './verbal_memory_paths.json'


export function* generateVerbalMemorySequence(): Generator<{ word: string, new: boolean }, null, void> {

  const sequence = (verbal_memory_paths as number[][])
    [Math.floor(Math.random() * (verbal_memory_paths as number[][]).length)];
  const numbers = {
    set: new Set<number>(),
    values: [] as number[],
  };

  for (let round = 0; round < sequence.length; round++) {
    const number = sequence[round];
    let added: number = numbers.values[number];
    const new_added = numbers.set.size <= number;
    while (numbers.set.size <= number) {
      added = Math.floor(Math.random() * (verbal_memory_words.length - 1));
      numbers.set.add(added);
    }
    if (new_added)
      numbers.values.push(added)
    const word = verbal_memory_words[added];

    yield {
      word, new: new_added
    };
  }

  return null;
}
