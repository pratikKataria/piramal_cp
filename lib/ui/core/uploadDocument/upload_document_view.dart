import 'package:piramal_channel_partner/ui/core/core_view.dart';
import 'package:piramal_channel_partner/ui/core/signup/model/document_upload_response.dart';

abstract class UploadDocumentView implements CoreView {
  void onDocumentUploaded(DocumentUploadResponse documentUploadResponse);
}
