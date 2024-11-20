part of 'widgets_imports.dart';

class ShowDocumentPicked extends StatelessWidget {
  final File pickedFile;
  final void Function() onSend;
  const ShowDocumentPicked(
      {super.key, required this.pickedFile, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context)!.translate("documentPreview")),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: onSend,
          ),
        ],
      ),
      body: pickedFile.path.endsWith(".pdf")
          ? Container(
              child: PDFView(
                filePath: pickedFile.path,
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: false,
                pageFling: true,
                onError: (error) {
                  print(error.toString());
                },
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selected Document:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text("File Name: ${pickedFile.path.split('/').last}"),
                  Text("File Size: ${pickedFile.lengthSync()} bytes"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ),
    );
  }
}
