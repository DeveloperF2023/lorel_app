part of 'widgets_imports.dart';

class AudioWidget extends StatefulWidget {
  final String audioUrl;
  const AudioWidget({super.key, required this.audioUrl});

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  PlayerState? _playerState;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  AudioPlayer player = AudioPlayer();

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _initStreams();
  }

  Future<void> _initializePlayer() async {
    try {
      // Load the audio source and ensure it's fully loaded
      await player.setSourceUrl(widget.audioUrl);
      print('Audio Loaded');

      // Listen for when the duration becomes available
      _durationSubscription = player.onDurationChanged.listen((duration) {
        if (duration != Duration.zero && mounted) {
          setState(() {
            _duration = duration; // Update the duration when available
            print(
                'Audio Duration: ${_formatDuration(_duration!)}'); // Debug print
          });
        }
      });

      // Initially, fetch the current position (optional)
      _position = await player.getCurrentPosition() ?? Duration.zero;

      // Ensure to update player state after duration is fetched
      _playerState = player.state;
      print('Player state: $_playerState');
    } catch (e) {
      print('Error initializing audio player: $e');
    }
  }

  void _initStreams() {
    // Listening to the duration of the audio file
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    // Listening to the current position of the audio while it's playing
    _positionSubscription = player.onPositionChanged.listen((position) {
      setState(() => _position = position);
    });

    // Listening to when the audio completes playing
    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    // Listening to the player state (playing, paused, stopped)
    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();

    player.dispose(); // Dispose of the AudioPlayer instance

    super.dispose();
  }

  Future<void> _play() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HelperFunctions.screenHeight(context) * .07.h, // Adjust as needed
      width: HelperFunctions.screenWidth(context) * .7.w, // Adjust as needed
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      _isPlaying ? _pause() : _play();
                    },
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 28.sp,
                    )),
                Expanded(
                  child: SizedBox(
                    height: 28.h,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 8.0), // Adjust size
                        trackHeight: 2.0,
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 20.0),
                      ),
                      child: Slider(
                        min: 0,
                        max: _duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          final duration = _duration;
                          if (duration.inMilliseconds == 0) {
                            return;
                          }
                          final position = value * duration.inMilliseconds;
                          player.seek(Duration(milliseconds: position.round()));
                          setState(() {
                            _position =
                                Duration(milliseconds: position.round());
                          });
                        },
                        value: (_position != Duration.zero &&
                                _duration != Duration.zero &&
                                _position.inMilliseconds > 0 &&
                                _duration.inMilliseconds > 0)
                            ? _position.inMilliseconds /
                                _duration.inMilliseconds
                            : 0.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_formatDuration(_position)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    if (duration.inHours > 0) {
      return '${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}';
    } else {
      return '${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}';
    }
  }
}
