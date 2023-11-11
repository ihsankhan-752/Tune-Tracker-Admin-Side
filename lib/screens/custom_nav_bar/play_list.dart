import 'package:flick_admin_panel/providers/loading_provider.dart';
import 'package:flick_admin_panel/services/playlist_services.dart';
import 'package:flick_admin_panel/theme/app_text.dart';
import 'package:flick_admin_panel/theme/colors.dart';
import 'package:flick_admin_panel/widget/custom_input.dart';
import 'package:flick_admin_panel/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  TextEditingController spotifyLinkController = TextEditingController();
  TextEditingController spotifyDescriptionController = TextEditingController();
  TextEditingController youtubeLinkController = TextEditingController();
  TextEditingController youtubeDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loadingController = Provider.of<LoadingProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              SizedBox(
                height: 60,
                width: 150,
                child: Image.asset('assets/images/logo.png'),
              ),
              Divider(color: AppColors.mainColor, thickness: 1),
              const SizedBox(height: 20),
              CustomTextInput(title: 'spotify Link', controller: spotifyLinkController),
              const SizedBox(height: 20),
              CustomTextInput(title: 'Description', controller: spotifyDescriptionController),
              const SizedBox(height: 15),
              loadingController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PrimaryButton(
                      title: AppText.uploadSpotifyPlaylist,
                      onTap: () async {
                        await PlayListServices().uploadSpotifyLink(
                          context: context,
                          spotifyLink: spotifyLinkController.text,
                          description: spotifyDescriptionController.text,
                        );
                        setState(() {
                          spotifyLinkController.clear();
                          spotifyDescriptionController.clear();
                        });
                      },
                    ),
              const SizedBox(height: 20),
              Divider(color: AppColors.mainColor, thickness: 1),
              const SizedBox(height: 20),
              CustomTextInput(title: "Youtube Video Link", controller: youtubeLinkController),
              const SizedBox(height: 20),
              CustomTextInput(title: "Description", controller: youtubeDescriptionController),
              const SizedBox(height: 10),
              loadingController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PrimaryButton(
                      title: AppText.uploadYoutubeVideo,
                      onTap: () async {
                        await PlayListServices().uploadYoutubeLink(
                          context: context,
                          youtubeLink: youtubeLinkController.text,
                          description: youtubeDescriptionController.text,
                        );
                        setState(() {
                          youtubeLinkController.clear();
                          youtubeDescriptionController.clear();
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
