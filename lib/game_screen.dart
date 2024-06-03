import 'package:flutter/material.dart';
import 'word_list.dart';
import 'congratulation_screen.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String word = '';
  String displayWord = '';
  String description = '';
  int lives = 6;
  List<String> guessedLetters = [];
  Set<String> pressedLetters = {};

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  String normalizeWord(String word) {
    return word
        .replaceAll('ã', 'a')
        .replaceAll('á', 'a')
        .replaceAll('â', 'a')
        .replaceAll('é', 'e')
        .replaceAll('ê', 'e')
        .replaceAll('í', 'i')
        .replaceAll('õ', 'o')
        .replaceAll('ó', 'o')
        .replaceAll('ô', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ç', 'c');
  }

  String normalizeLetter(String letter) {
    return letter
        .replaceAll('ã', 'a')
        .replaceAll('á', 'a')
        .replaceAll('â', 'a')
        .replaceAll('é', 'e')
        .replaceAll('ê', 'e')
        .replaceAll('í', 'i')
        .replaceAll('õ', 'o')
        .replaceAll('ó', 'o')
        .replaceAll('ô', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ç', 'c');
  }

  void startNewGame() {
    final randomIndex = (wordList.keys.toList()..shuffle()).first;
    setState(() {
      word = normalizeWord(randomIndex.toUpperCase());
      description = wordList[randomIndex]!;
      displayWord = '_' * word.length;
      lives = 6;
      guessedLetters = [];
      pressedLetters = {};
    });
  }

  void guessLetter(String letter) {
    setState(() {
      letter = letter.toUpperCase();
      String normalizedLetter = normalizeLetter(letter);
      String normalizedWord = normalizeWord(word);

      if (normalizedWord.contains(normalizedLetter)) {
        for (int i = 0; i < word.length; i++) {
          if (normalizeLetter(word[i]) == normalizedLetter) {
            displayWord = displayWord.substring(0, i) + word[i] + displayWord.substring(i + 1);
          }
        }
      } else {
        lives--;
      }
      pressedLetters.add(letter);
      if (!guessedLetters.contains(letter)) {
        guessedLetters.add(letter);
      }
      if (displayWord == word) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CongratulationsScreen(
              word: word, // Pass the correct word here
              description: description,
              onPlayAgain: () {
                Navigator.pop(context); // Sair da tela de parabéns
                startNewGame(); // Reiniciar o jogo
              },
            ),
          ),
        );
      } else if (lives == 0) {
        showDialog(
          context: context,
          barrierDismissible: false, // Impede que o pop-up seja fechado clicando fora dele
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Você perdeu!', style: TextStyle(color: Colors.black)),
            content: Text('A palavra era: $word', style: TextStyle(color: Colors.black)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  startNewGame(); // Reiniciar o jogo
                },
                child: Text('Tentar Novamente', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        );
      }
    });
  }

IconData getEmotionIcon() {
  switch (lives) {
    case 6:
      return Icons.sentiment_very_satisfied;
    case 5:
      return Icons.sentiment_satisfied;
    case 4:
      return Icons.sentiment_neutral;
    case 3:
      return Icons.sentiment_dissatisfied;
    case 2:
      return Icons.sentiment_very_dissatisfied;
    case 1:
      return Icons.sentiment_very_dissatisfied_sharp; // Ícone de chorar
    case 0:
      return Icons.sentiment_very_dissatisfied_outlined; // Ícone de chorar
    default:
      return Icons.sentiment_very_dissatisfied;
  }
}

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(getEmotionIcon(), color: Colors.white),
            SizedBox(width: 10),
            Text('Forca do Oceano'),
          ],
        ),
        backgroundColor: Color(0xFF006994),
      ),
      body: Container(
        color: Color.fromARGB(255, 1, 81, 112),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenHeight * 0.4,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      getEmotionIcon(),
                      size: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Text(
                      displayWord.split('').join(' '),
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        letterSpacing: 4.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Vidas restantes: $lives',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('').map((letter) {
                  bool isGuessed = guessedLetters.contains(letter);
                  bool isPressed = pressedLetters.contains(letter);
                  return ElevatedButton(
                    onPressed: isPressed ? null : () => guessLetter(letter),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isGuessed ? Colors.grey : Color.fromARGB(255, 0, 135, 189),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                    ),
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
