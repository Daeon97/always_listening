# always_listening
When the flutter app is launched, the api calls counter bloc which does all the work.

First it subscribes to the audio stream, collects and appends the audio data. Once it
has determined that the audio is 5 seconds long, it sends the raw audio stream to the
create wav use case that is in charge of creating and storing the wav file locally.
Once the creation of the wav file is complete the file path is then sent to the send audio
wav use case which is in charge of sending the wav file to an endpoint. The result of this
network request is then persisted by hydrated bloc. The UI is notified of subsequent changes
and it rebuilds itself accordingly
