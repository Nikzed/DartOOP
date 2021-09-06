import 'dart:collection';

class SongInfo {
  String songName;
  String bandName;
  int yearReleased;

  SongInfo(this.songName, this.bandName, this.yearReleased);
}

abstract class SongIterator {
  Iterator createIterator();
}

class SongsOfThe70s implements SongIterator {
  List<SongInfo> bestSongs;

  SongsOfThe70s() {
    bestSongs = <SongInfo>[];
    addSong('Imagine', 'John Lennon', 1971);
    addSong('American Pie', 'Don McLean', 1971);
    addSong('I Will Survive', 'Gloria Gaynor', 1979);
  }

  void addSong(String songName, String bandName, int yearReleased) {
    SongInfo songInfo = SongInfo(songName, bandName, yearReleased);

    bestSongs.add(songInfo);
  }

  @override
  Iterator createIterator() {
    return bestSongs.iterator;
  }
}

class SongsOfThe80s implements SongIterator {
  List<SongInfo> bestSongs;

  SongsOfThe80s() {
    bestSongs = <SongInfo>[];

    addSong('Roam', 'B 52s', 1989);
    addSong('Cruel Summer', 'Bananarama', 1984);
    addSong('Head Over Heels', 'Tears For Fears', 1985);
  }

  // Добавляем информацию о песне и используем инкремент для отображения след элемента

  void addSong(String songName, String bandName, int yearReleased) {
    SongInfo song = SongInfo(songName, bandName, yearReleased);

    bestSongs.add(song);
  }

  @override
  Iterator createIterator() {
    return bestSongs.iterator;
  }
}

class SongsOfThe90s implements SongIterator {
  HashMap<int, SongInfo> bestSongs = HashMap<int, SongInfo>();

  // ключ для индетификации элемента
  int hashKey = 0;

  SongsOfThe90s() {
    addSong('Losing My Religion', 'REM', 1991);
    addSong('Creep', 'Radiohead', 1993);
    addSong('Walk on the Ocean', 'Toad The Wet Sprocket', 1991);
  }

  void addSong(String songName, String bandName, int yearReleased) {
    SongInfo songInfo = SongInfo(songName, bandName, yearReleased);

    bestSongs.putIfAbsent(hashKey, () => songInfo);

    hashKey++;
  }

  @override
  Iterator createIterator() {
    return bestSongs.values.iterator;
  }
}

class DiscJockey {
  SongIterator iter70sSongs;
  SongIterator iter80sSongs;
  SongIterator iter90sSongs;

  DiscJockey(this.iter70sSongs, this.iter80sSongs, this.iter90sSongs);

  void showTheSongs() {
    Iterator songs70s = iter70sSongs.createIterator();
    Iterator songs80s = iter80sSongs.createIterator();
    Iterator songs90s = iter90sSongs.createIterator();

    print('Songs of the 70s');
    printTheSongs(songs70s);

    print('\nSongs of the 80s');
    printTheSongs(songs80s);

    print('\nSongs of the 90s');
    printTheSongs(songs90s);
  }

  void printTheSongs(Iterator iterator) {
    while (iterator.moveNext()) {
      SongInfo songInfo = iterator.current as SongInfo;
      print(songInfo.songName);
      print(songInfo.bandName);
      print(songInfo.yearReleased);
    }
  }
}

void main() {
  SongsOfThe70s songs70s = SongsOfThe70s();
  SongsOfThe80s songs80s = SongsOfThe80s();
  SongsOfThe90s songs90s = SongsOfThe90s();

  DiscJockey madMike = DiscJockey(songs70s, songs80s, songs90s);

  madMike.showTheSongs();
}

// source
// http://www.newthinktank.com/2012/10/iterator-design-pattern-tutorial/
