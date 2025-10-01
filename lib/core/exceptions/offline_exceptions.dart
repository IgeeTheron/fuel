import 'package:fuel/core/exceptions/exceptions.dart';

/// A base class for exceptions related to the app's offline functionality.
///
/// This abstract class extends [AppException] and serves as a common type for
/// catching all errors that occur during offline operations, such as local
/// database interactions or file system access.
///
/// See also:
///  * [DatabaseException], for errors specific to the local database.
///  * [FileStorageException], for file system-related errors.
///  * [DownloadIntegrityException], for issues with downloaded file validity.
abstract class OfflineException extends AppException {
  const OfflineException({required super.message});
}

/// Thrown when an error occurs during an interaction with the local database.
///
/// This exception typically indicates a problem with ObjectBox, such as a failed
/// write operation, a query error, or an issue initializing the database store.
class DatabaseException extends OfflineException {
  const DatabaseException({String? message})
      : super(
          message: message ?? "messages.exceptions.offline.databaseError",
        );
}

/// Thrown when a file system operation (e.g., read, write, delete) fails.
///
/// This is commonly used when trying to save a downloaded book to the device's
/// storage or delete a local file and encountering issues like permission
/// denial or insufficient storage space.
class FileStorageException extends OfflineException {
  const FileStorageException({String? message})
      : super(
          message: message ?? "messages.exceptions.offline.fileStorageError",
        );
}

/// Thrown when a downloaded file fails its integrity check.
///
/// After a file is successfully downloaded, it may be checked for corruption.
/// This exception is raised if the file's checksum (e.g., SHA-256) does not
/// match the expected value, or if the file cannot be parsed as a valid
/// format (e.g., a valid EPUB), indicating a corrupted or incomplete download.
class DownloadIntegrityException extends OfflineException {
  const DownloadIntegrityException({String? message})
      : super(
          message: message ?? "messages.exceptions.offline.downloadIntegrityError",
        );
}
