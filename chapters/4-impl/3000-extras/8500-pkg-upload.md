
# Upload packages {#sec:8500-pkg-upload}

A user should be able to send multiple `POST /v1/resources/:resource_id/pkg` requests, each creating a blank "draft".

Once a file is uploaded by the client and is in memory, we check the MIME
type of the uploaded file. If the file is not of the "application/zip"
MIME type, we return a "415 Unsupported Media Type" and discard the
data.

We then check the ZIP in memory using the following heuristics:

- TODO

Once we've verified that the ZIP is safe, we upload to a storage
service using the `gocloud.dev/blob` library (a Go package).

> "Blobs are a common abstraction for storing unstructured data on
> Cloud storage services and accessing them via HTTP. This guide shows
> how to work with blobs in the Go CDK." [@BlobGoCDK]

This is useful as it is a generic backend for various file storage
services, including support for Google Cloud Storage, Amazon S3, Azure
Blob Service, and of course Local Storage. This makes the website
scalable and resilient as we can rely on one of those services doing
backups for us, and also use them to deliver stuff for us. Less
bandwidth. But we can still use Local Storage when sysadmins are testing
or if they would prefer to use local storage (if they do not want to pay
for an external service)

This library gives us safety as it converts filenames to
something safe. This means that we don't have to worry about malicious
filenames when storing files locally.

The filename `../test` is stored as `..__0x2f__test`. This is
secure.

However, gocloud allows filenames to contain forward slashes (creating a
subfolder). Although we could ensure that our filename has no directory
separators, we chose to force filenames to be stored as `pkg$ID.zip`
(such as `pkg6.zip`).

This additionally means that we don't need to write code to delete old
packages when reuploading a file (during initial package creation,
when in draft state). We can just rely on this library replacing the
blob with the new file.

We only need to delete the files when packages are deleted!

When implementing this we tried to use `io.Copy` to copy from the input
file to the bucket writer, but we could not do this. So we refactored our
initial code and chose to use "`io.TeeReader` to duplicate the stream" [@GoHowRead].

> "TeeReader returns a Reader that writes to w what it reads from r. All
> reads from r performed through it are matched with corresponding
> writes to w. There is no internal buffering - the write must complete
> before the read completes. Any error encountered while writing is
> reported as a read error." [@IoTeeReaderGo]

We realised that `TeeReader` returns an `io.Reader` which does not implement
`io.ReaderAt`, so in the end we chose to use `ioutil.ReadAll` to read the
entire file into a byte slice (`[]bytes`). This means that we don't need to
use `io.Copy`, and can produce a `io.ReaderAt` for the `archive/zip` library using
`bytes.NewReader` — this function returns a `bytes.Reader` which _does__ implement
`io.ReaderAt`. Note that we must also "have sufficient memory for handling [the] zip file" [@GoGolangUnzip].

<!-- Once an actual package has been uploaded the user can choose to publish it, changing the package from the "draft" state to the "pending_review" state.
 -->

[Listing @lst:complex-rxjs-result] shows our most complex use of the RxJS library.

```typescript
createPackage(blob: Blob): Observable<PackageID> {
  return this.resource$.pipe(
    switchMap(r => this.resources.createPackage(r.author_id, r.id, blob)),
    map(event => this.getUploadEventMessage(event)),
    tap(message => console.log(message.ok, message.description, message.value)),
    first(msg => msg.ok),
    map(msg => msg.value),
    catchError((err: HttpErrorResponse) => {
      let reason = 'Something went wrong';
      if (err.status !== INTERNAL_SERVER_ERROR) {
        reason = err.error.message;
      }
      this.alerts.setAlert(reason);
      return throwError(reason);
    })
  );
}
```
: `ResourceViewService.createPackage` creates a new package for the resource currently being viewed. {#lst:complex-rxjs-result}
