import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class RecordPage extends StatefulWidget {
  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late RecorderController recorderController;

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000;
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    await recorderController.record();
  }

  Future<void> stopRecording() async {
    final path = await recorderController.stop();
    print("Recording saved at: $path");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Waveform Recorder")),
      body: Column(
        children: [
          SizedBox(
            height: 100,  
            child: AudioWaveforms(
              enableGesture: false,
              size: Size(double.infinity, 100),
              recorderController: recorderController,
              waveStyle: WaveStyle(
                extendWaveform: true,
                showMiddleLine: false,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: startRecording, child: Text("Start")),
              SizedBox(width: 20),
              ElevatedButton(onPressed: stopRecording, child: Text("Stop")),
            ],
          )
        ],
      ),
    );
  }
}
