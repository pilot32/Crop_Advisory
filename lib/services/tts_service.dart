//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';


final _logger = Logger();
class TtsService{
  final FlutterTts _tts =  FlutterTts();
  bool _isInitialized = false;
  bool _isSpeaking = false;

  String? _currentMessageId;
  String? _currentText;
  //callbacks for tts events
  void Function(bool isSpeaking)? onSpeakingStateChanged;
  void Function()? onStart;
  void Function()? onComplete;
  void Function()? onCancel;
  
  TtsService(){
    _init();
  }


  Future<void> _init() async {
    try {
      // Configure TTS
      await _tts.setLanguage('en-IN');
      await _tts.setSpeechRate(0.5);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);

      // Set engine if available (better quality on Android)
      // await _tts.setEngine('com.google.android.tts');

      // Listen to state changes
      _tts.setStartHandler(() {
        _isSpeaking = true;
        onStart?.call();
        onSpeakingStateChanged?.call(true);
        _logger.i('TTS started speaking');
      });

      _tts.setCompletionHandler(() {
        _isSpeaking = false;
        _currentMessageId = null;
        _currentText = null;
        onComplete?.call();
        onSpeakingStateChanged?.call(false);
        _logger.i('TTS finished speaking');
      });

      _tts.setCancelHandler(() {
        _isSpeaking = false;
        _currentMessageId = null;
        onCancel?.call();
        onSpeakingStateChanged?.call(false);
        _logger.i('TTS cancelled');
      });

      _tts.setErrorHandler((msg) {
        _isSpeaking = false;
        _currentMessageId = null;
        _logger.e('TTS error: $msg');
        onSpeakingStateChanged?.call(false);
      });

      _isInitialized = true;
      _logger.i('TTS initialized');
    } catch (e) {
      _logger.e('Failed to initialize TTS: $e');
    }
  }

  //fucntion for speaking the message or text lodu 
  Future<void> speak({
    required String text,
    String? messageId,
    String language = 'en-IN',
    }) async {

      //these are the funcion to check if the tts is initialized or not and if the text is empty or not and if the tts is already speaking the same message then stop it otherwise stop the current speking and start the new one
      if(!_isInitialized){await _init();}
      if(text.trim().isEmpty) return;

      if(_isSpeaking && _currentMessageId == messageId){
        await stop();
        return;
      }

      if(_isSpeaking){
        await _tts.stop();
      }

      _currentMessageId=messageId;
      _currentText=text;

      await _tts.setLanguage(language);
      await _tts.speak(text);
    }

    Future<void> stop() async{
      await _tts.stop();
      _isSpeaking = false;;
      _currentMessageId = null;
    }

    Future<void> pause() async{
      await _tts.pause();
      //_isSpeaking = false;
    }

    bool get isSpeaking=> _isSpeaking;

    String? get currenMessageId => _currentMessageId;
    Future<void> setSpeechRate(double rate) async {
    await _tts.setSpeechRate(rate);
  }

  /// Set pitch (0.5 - 2.0, default 1.0)
  Future<void> setPitch(double pitch) async {
    await _tts.setPitch(pitch);
  }

  /// Set volume (0.0 - 1.0, default 1.0)
  Future<void> setVolume(double volume) async {
    await _tts.setVolume(volume);
  }

  /// Set language
  Future<void> setLanguage(String language) async {
    await _tts.setLanguage(language);
  }


  /// Get available languages
  Future<List<String>> getAvailableLanguages() async {
    try {
      final languages = await _tts.getLanguages;
      return languages.cast<String>();
    } catch (e) {
      _logger.e('Error getting languages: $e');
      return ['en-US', 'en-IN', 'hi-IN'];
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _tts.stop();
    _isSpeaking = false;
    _currentMessageId = null;
    _currentText = null;
    onSpeakingStateChanged?.call(false);
  }
}