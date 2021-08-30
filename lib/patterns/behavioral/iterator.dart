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

  // ArrayList holds SongInfo objects

  List<SongInfo> bestSongs;

  SongsOfThe70s() {
    bestSongs = <SongInfo>[];
    addSong("Imagine", "John Lennon", 1971);
    addSong("American Pie", "Don McLean", 1971);
    addSong("I Will Survive", "Gloria Gaynor", 1979);
  }

  // Add a SongInfo object to the end of the ArrayList

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

  // Create an array of SongInfo Objects

  List<SongInfo> bestSongs;

  // Used to increment to the next position in the array

  int arrayValue = 0;

  SongsOfThe80s() {
    bestSongs = <SongInfo>[];

    addSong("Roam", "B 52s", 1989);
    addSong("Cruel Summer", "Bananarama", 1984);
    addSong("Head Over Heels", "Tears For Fears", 1985);
  }

  // Add a SongInfo Object to the array and increment to the next position

  void addSong(String songName, String bandName, int yearReleased) {
    SongInfo song = SongInfo(songName, bandName, yearReleased);

    bestSongs.add(song);

    arrayValue++;
  }

  // NEW By adding this method I'll be able to treat all
  // collections the same

  @override
  Iterator createIterator() {
    return bestSongs.iterator;
  }

}

class SongsOfThe90s implements SongIterator {

  // Create a Hashtable with an int as a key and SongInfo
  // Objects

  HashMap<int, SongInfo> bestSongs = HashMap<int, SongInfo>();

  // Will increment the Hashtable key

  int hashKey = 0;

  SongsOfThe90s() {
    addSong("Losing My Religion", "REM", 1991);
    addSong("Creep", "Radiohead", 1993);
    addSong("Walk on the Ocean", "Toad The Wet Sprocket", 1991);
  }

  // Add a new SongInfo Object to the Hashtable and then increment
  // the Hashtable key


  void addSong(String songName, String bandName, int yearReleased) {
    SongInfo songInfo = SongInfo(songName, bandName, yearReleased);

    bestSongs.putIfAbsent(hashKey, () => songInfo);

    hashKey++;
  }

  // This is replaced by the Iterator
  // Return a Hashtable full of SongInfo Objects

  HashMap<int, SongInfo> getBestSongs() {
    return bestSongs;
  }

  // NEW By adding this method I'll be able to treat all
  // collections the same

  @override
  Iterator createIterator() {
    // TODO Auto-generated method stub
    return bestSongs.values.iterator;
  }

}
 class DiscJockey {

  SongsOfThe70s songs70s;
  SongsOfThe80s songs80s;
  SongsOfThe90s songs90s;

  // NEW Passing in song iterators

  SongIterator iter70sSongs;
  SongIterator iter80sSongs;
  SongIterator iter90sSongs;

  /* OLD WAY
	public DiscJockey(SongsOfThe70s newSongs70s, SongsOfThe80s newSongs80s, SongsOfThe90s newSongs90s) {

		songs70s = newSongs70s;
		songs80s = newSongs80s;
		songs90s = newSongs90s;

	}
	*/

  // NEW WAY Initialize the iterators


  DiscJockey(this.iter70sSongs, this.iter80sSongs, this.iter90sSongs);

  void showTheSongs(){

    // Because the SongInfo Objects are stored in different
    // collections everything must be handled on an individual
    // basis. This is BAD!

    List aL70sSongs = songs70s.bestSongs;

    print('Songs of the 70s\n');

    for(int i=0; i < aL70sSongs.length; i++){

      // Пример пользы строгого приведения типов
      SongInfo bestSongs = aL70sSongs.take(i) as SongInfo;

      print(bestSongs.songName);
      print(bestSongs.bandName);
      print('${bestSongs.yearReleased}\n');

    }

    List<SongInfo> array80sSongs = songs80s.bestSongs;

    print("Songs of the 80s\n");

    for(int j=0; j < array80sSongs.length; j++){

      SongInfo bestSongs = array80sSongs[j];

      print(bestSongs.songName);
      print(bestSongs.bandName);
      print('${bestSongs.yearReleased}\n');

    }

    HashMap<int, SongInfo> ht90sSongs = songs90s.getBestSongs();

    print('Songs of the 90s\n');

    ht90sSongs.forEach((key, value) {
      SongInfo e = value;

      print(e.songName);
      print(e.bandName);
      print('${e.yearReleased}\n');

    });

  }

  // Now that I can treat everything as an Iterator it cleans up
  // the code while allowing me to treat all collections as 1

  void showTheSongs2(){

    print("NEW WAY WITH ITERATOR\n");

    Iterator Songs70s = iter70sSongs.createIterator();
    Iterator Songs80s = iter80sSongs.createIterator();
    Iterator Songs90s = iter90sSongs.createIterator();

    print("Songs of the 70s\n");
    printTheSongs(Songs70s);

    print("Songs of the 80s\n");
    printTheSongs(Songs80s);

    print("Songs of the 90s\n");
    printTheSongs(Songs90s);

  }

  void printTheSongs(Iterator iterator){

    //SOURSE
    // http://www.newthinktank.com/2012/10/iterator-design-pattern-tutorial/

    // iterator
    //
    while(iterator.moveNext()){
      SongInfo songInfo = iterator.current as SongInfo;
      print(songInfo.songName);
      print(songInfo.bandName);
      print(songInfo.yearReleased);
    }

  }

}

void main (){
  SongsOfThe70s songs70s = SongsOfThe70s();
  SongsOfThe80s songs80s = SongsOfThe80s();
  SongsOfThe90s songs90s = SongsOfThe90s();

  DiscJockey madMike = DiscJockey(songs70s, songs80s, songs90s);

  // madMike.showTheSongs();

  madMike.showTheSongs2();
}