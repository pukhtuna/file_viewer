import 'dart:io';
import 'package:document_viewer/document_viewer.dart';
import 'package:file_viewer/util/shared_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ViewDocumentScreen extends StatefulWidget {
  final String url;
  const ViewDocumentScreen({required this.url, super.key});

  @override
  State<ViewDocumentScreen> createState() => _ViewDocumentScreenState();
}

class _ViewDocumentScreenState extends State<ViewDocumentScreen> {
  bool isLoading = false;
  final cacheManager = DefaultCacheManager();
  String? filePath;

  Future<String?> downloadFile(String url) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final cachedFile = await cacheManager.getFileFromMemory(url);
      final urlSplitter = url.split('.');
      final fileType = urlSplitter.last;
      if (cachedFile != null) {
        debugPrint('cached file: ${cachedFile.file.path}');
        return cachedFile.file.path;
      } else {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final tempPdfFile = File('${dir.path}/file.$fileType');
          await tempPdfFile.writeAsBytes(response.bodyBytes);
          await cacheManager.putFile(url, response.bodyBytes,
              fileExtension: fileType);
          return tempPdfFile.path;
        } else {
          debugPrint(
              'Error downloading file. Status code: ${response.statusCode}');
          return null;
        }
      }
    } catch (e) {
      debugPrint('Error downloading File: $e');
      return null;
    }
  }

  downloadAndSave(String url) async {
    setState(() {
      isLoading = true;
    });
    filePath = await downloadFile(url);
    Future.delayed(const Duration(seconds: 1), () => setState(() {}));

    if (filePath != null) {
      debugPrint('File downloaded and saved to: $filePath');
    } else {
      debugPrint('Failed to download and save the file.');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    downloadAndSave(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const CustomText(text: 'View Document', fontSize: 22)),
      body: isLoading
          ? showLoading()
          : Padding(
              padding: const EdgeInsets.all(10),
              child: DocumentViewer(filePath: filePath ?? ''),
            ),
    );
  }
}
