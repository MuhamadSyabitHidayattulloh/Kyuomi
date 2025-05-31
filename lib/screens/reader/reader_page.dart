import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({super.key});

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  bool _isControlsVisible = true;
  bool _isDarkMode = true;
  bool _isAutoScroll = false;
  double _autoScrollSpeed = 1.0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() => _isControlsVisible = !_isControlsVisible);
  }

  void _toggleAutoScroll() {
    setState(() => _isAutoScroll = !_isAutoScroll);
    if (_isAutoScroll) _startAutoScroll();
  }

  void _startAutoScroll() {
    const duration = Duration(milliseconds: 50);
    Future.doWhile(() async {
      await Future.delayed(duration);
      if (!_isAutoScroll || !mounted) return false;

      final position = _scrollController.position;
      if (position.pixels < position.maxScrollExtent) {
        _scrollController.jumpTo(position.pixels + (_autoScrollSpeed * 2));
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            ListView.builder(
              controller: _scrollController,
              itemCount: 10, // Replace with actual page count
              itemBuilder: (context, index) {
                return Container(
                  height: 500,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      'Page ${index + 1}',
                      style: TextStyle(
                        color: _isDarkMode ? const Color(0xFF303030) : null,
                      ),
                    ),
                  ),
                );
              },
            ),
            if (_isControlsVisible) _buildControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return SafeArea(
      child: Column(
        children: [_buildTopBar(), const Spacer(), _buildBottomBar()],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      color: Colors.black54,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Text(
              'Chapter Title', // Replace with actual chapter title
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(
              _isDarkMode ? LineIcons.sun : LineIcons.moon,
              color: Colors.white,
            ),
            onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(LineIcons.angleLeft, color: Colors.white),
                onPressed: () {
                  // TODO: Previous chapter
                },
              ),
              IconButton(
                icon: Icon(
                  _isAutoScroll ? LineIcons.pause : LineIcons.play,
                  color: Colors.white,
                ),
                onPressed: _toggleAutoScroll,
              ),
              IconButton(
                icon: const Icon(LineIcons.angleRight, color: Colors.white),
                onPressed: () {
                  // TODO: Next chapter
                },
              ),
            ],
          ),
          if (_isAutoScroll) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(LineIcons.clock, color: Colors.white, size: 16),
                  Expanded(
                    child: Slider(
                      value: _autoScrollSpeed,
                      min: 0.5,
                      max: 5.0,
                      divisions: 9,
                      label: _autoScrollSpeed.toString(),
                      onChanged: (value) =>
                          setState(() => _autoScrollSpeed = value),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
