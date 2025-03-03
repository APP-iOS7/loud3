import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path_provider/path_provider.dart';

Future<void> downloadVideo(String videoId, YoutubeExplode yt) async {
  // 비디오 스트림 가져오기
  var manifest = await yt.videos.streamsClient.getManifest(VideoId(videoId));
  var audioStreamInfo = manifest.audioOnly.first;

  // 저장할 경로 설정
  var dir = await getApplicationDocumentsDirectory();
  var audioFile = File('${dir.path}audio.mp4');
  print(dir);
  print(audioFile);

  // 오디오 다운로드
  var audioStream = yt.videos.streamsClient.get(audioStreamInfo);
  var audioFileStream = audioFile.openWrite();
  await audioStream.pipe(audioFileStream);
  await audioFileStream.flush();
  await audioFileStream.close();

  print("비디오와 오디오 다운로드 완료!");
}

Future<void> readAudioFile() async {
  // 앱 전용 저장소 경로 가져오기
  var directory = await getApplicationDocumentsDirectory();

  // 읽을 파일 경로
  var filePath = '${directory.path}/audio.mp4';

  // 파일 존재 여부 확인
  var file = File(filePath);

  if (await file.exists()) {
    // 오디오 파일을 바이트 배열로 읽기
    var fileBytes = await file.readAsBytes();

    // 오디오 파일 처리 예시 (여기서는 바이트 배열의 크기를 출력)
    print('파일 크기: ${fileBytes.length} bytes');
    print('파일 읽어드리기 : ${fileBytes.toString()}');
  } else {
    print('파일이 존재하지 않습니다.');
  }
}

Future<void> playSoundinFile(AudioPlayer audioPlayer) async {
  // 앱 전용 저장소 경로 가져오기
  var directory = await getApplicationDocumentsDirectory();

  // 읽을 파일 경로
  var filePath = '${directory.path}/audio.mp4';

  // 파일 존재 여부 확인
  var file = File(filePath);

  if (await file.exists()) {
    // 오디오 파일을 just_audio로 실행하기( 둘 다 사용하지 못함 하나만 사용해야 합니다)
    // await audioPlayer.setFilePath(file.path);

    // 로컬 파일 경로를 AudioSource.file로 로드합니다.
    final audioSource = AudioSource.file(
      file.path,
      tag: MediaItem(
        id: '1', // 고유 ID
        album: "Album Name", // 앨범 이름
        title: "Song Title", // 곡 제목
        artUri: Uri.parse(
          'https://img.youtube.com/vi/2A8G_VsQqDI/hqdefault.jpg',
        ), // 앨범 아트 이미지
      ),
    );

    await audioPlayer.setAudioSource(audioSource);

    await audioPlayer.play();
  } else {
    print('파일이 존재하지 않습니다.');
  }
}

Future<void> pauseSoundinFile(AudioPlayer audioPlayer) async {
  // 앱 전용 저장소 경로 가져오기
  var directory = await getApplicationDocumentsDirectory();

  // 읽을 파일 경로
  var filePath = '${directory.path}/audio.mp4';

  // 파일 존재 여부 확인
  var file = File(filePath);

  if (await file.exists()) {
    // 오디오 파일을 just_audio로 실행하기
    await audioPlayer.setFilePath(file.path);

    await audioPlayer.pause();
  } else {
    print('파일이 존재하지 않습니다.');
  }
}
