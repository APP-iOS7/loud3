import 'package:flutter/material.dart';
import 'package:youtube_scrape_api/models/video.dart';
import 'package:youtube_scrape_api/youtube_scrape_api.dart';

class YoutubeSearchScreen extends StatefulWidget {
  const YoutubeSearchScreen({super.key});

  @override
  State<YoutubeSearchScreen> createState() => _YoutubeSearchScreenState();
}

class _YoutubeSearchScreenState extends State<YoutubeSearchScreen> {
  final TextEditingController _queryController = TextEditingController();
  Future<List<Video>>? videos;
  @override
  void initState() {
    super.initState();
    videos = serachYoutube(query: "멜론 검색");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _queryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "듣고 싶은 음악을 선택해주세요",
                  labelText: "검색",
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: videos,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("문제가 있습니다.. ${snapshot.error}"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Video video = snapshot.data[index];
                        return ListTile(
                          title: Text(video.title!),
                          subtitle: Text(video.uploadDate!),
                          leading: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(video.thumbnails!.first.url!),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Video>> serachYoutube({required String query}) async {
    YoutubeDataApi youtubeAPI = YoutubeDataApi();
    List<Video> videoResult = await youtubeAPI.fetchSearchVideo(query);

    for (var element in videoResult) {
      Video video = element;
      print('Video :  $video');
    }
    return videoResult;
  }
}
